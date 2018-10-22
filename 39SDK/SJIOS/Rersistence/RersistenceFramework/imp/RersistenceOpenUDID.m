

#if __has_feature(objc_arc)
#error This file uses the classic non-ARC retain/release model; hints below... 

#endif

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"

#import "RersistenceOpenUDID.h"
#import <CommonCrypto/CommonDigest.h>
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <UIKit/UIPasteboard.h>
#import <UIKit/UIKit.h>
#else
#import <AppKit/NSPasteboard.h>
#endif

#define OpenUDIDLog(fmt, ...)


static NSString * kOpenUDIDSessionCache = nil;
static NSString * const kOpenUDIDDescription = @"OpenUDID_with_iOS6_Support";
static NSString * const kOpenUDIDKey = @"OpenUDID";
static NSString * const kOpenUDIDSlotKey = @"OpenUDID_slot";
static NSString * const kOpenUDIDAppUIDKey = @"OpenUDID_appUID";
static NSString * const kOpenUDIDTSKey = @"OpenUDID_createdTS";
static NSString * const kOpenUDIDOOTSKey = @"OpenUDID_optOutTS";
static NSString * const kOpenUDIDDomain = @"org.OpenUDID";
static NSString * const kOpenUDIDSlotPBPrefix = @"org.OpenUDID.slot.";
static int const kOpenUDIDRedundancySlots = 100;

@interface RersistenceOpenUDID (Private)
+ (void) _setDict:(id)dict forPasteboard:(id)pboard;
+ (NSMutableDictionary*) _getDictFromPasteboard:(id)pboard;
+ (NSString*) _generateFreshOpenUDID;
@end

@implementation RersistenceOpenUDID


+ (void) _setDict:(id)dict forPasteboard:(id)pboard {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR		
    [pboard setData:[NSKeyedArchiver archivedDataWithRootObject:dict] forPasteboardType:kOpenUDIDDomain];
#else
    [pboard setData:[NSKeyedArchiver archivedDataWithRootObject:dict] forType:kOpenUDIDDomain];
#endif
}


+ (NSMutableDictionary*) _getDictFromPasteboard:(id)pboard {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR	
    id item = [pboard dataForPasteboardType:kOpenUDIDDomain];
#else
	id item = [pboard dataForType:kOpenUDIDDomain];
#endif	
    if (item) {
        @try{
            item = [NSKeyedUnarchiver unarchiveObjectWithData:item];
        } @catch(NSException* e) {
            OpenUDIDLog(@"Unable to unarchive item %@ on pasteboard!", [pboard name]);
            item = nil;
        }
    }

    return [NSMutableDictionary dictionaryWithDictionary:(item == nil || [item isKindOfClass:[NSDictionary class]]) ? item : nil];
}

+ (NSString*) _generateFreshOpenUDID {
    
    NSString* _openUDID = nil;
    

#if TARGET_OS_IPHONE	

#endif
    

    if (_openUDID==nil) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
        const char *cStr = CFStringGetCStringPtr(cfstring,CFStringGetFastestEncoding(cfstring));
        unsigned char result[16];
        CC_MD5( cStr, strlen(cStr), result );
        CFRelease(uuid);
        CFRelease(cfstring);

        _openUDID = [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%08x",
                result[0], result[1], result[2], result[3], 
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15],
                     (NSUInteger)(arc4random() % NSUIntegerMax)];  
    }


    return _openUDID;
}


+ (NSString*) value {
    return [RersistenceOpenUDID valueWithError:nil];
}

+ (NSString*) valueWithError:(NSError **)error {

    if (kOpenUDIDSessionCache!=nil) {
        if (error!=nil)
            *error = [NSError errorWithDomain:kOpenUDIDDomain
                                         code:kOpenUDIDErrorNone
                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"OpenUDID in cache from first call",@"description", nil]];
        return kOpenUDIDSessionCache;
    }
    
  	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    

    NSString * appUID = [defaults objectForKey:kOpenUDIDAppUIDKey];
    if(appUID == nil)
    {

        CFUUIDRef uuid = CFUUIDCreate(NULL);
        appUID = (NSString *) CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        [appUID autorelease];
    }
  
    NSString* openUDID = nil;
    NSString* myRedundancySlotPBid = nil;
    NSDate* optedOutDate = nil;
    BOOL optedOut = NO;
    BOOL saveLocalDictToDefaults = NO;
    BOOL isCompromised = NO;
    

    id localDict = [defaults objectForKey:kOpenUDIDKey];
    if ([localDict isKindOfClass:[NSDictionary class]]) {
        localDict = [NSMutableDictionary dictionaryWithDictionary:localDict];
        openUDID = [localDict objectForKey:kOpenUDIDKey];
        myRedundancySlotPBid = [localDict objectForKey:kOpenUDIDSlotKey];
        optedOutDate = [localDict objectForKey:kOpenUDIDOOTSKey];
        optedOut = optedOutDate!=nil;
        OpenUDIDLog(@"localDict = %@",localDict);
    }
    

    NSString* availableSlotPBid = nil;
    NSMutableDictionary* frequencyDict = [NSMutableDictionary dictionaryWithCapacity:kOpenUDIDRedundancySlots];
    for (int n=0; n<kOpenUDIDRedundancySlots; n++) {
        NSString* slotPBid = [NSString stringWithFormat:@"%@%d",kOpenUDIDSlotPBPrefix,n];
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        UIPasteboard* slotPB = [UIPasteboard pasteboardWithName:slotPBid create:NO];
#else
        NSPasteboard* slotPB = [NSPasteboard pasteboardWithName:slotPBid];
#endif
        OpenUDIDLog(@"SlotPB name = %@",slotPBid);
        if (slotPB==nil) {
            
            if (availableSlotPBid==nil) availableSlotPBid = slotPBid;
        } else {
            NSDictionary* dict = [RersistenceOpenUDID _getDictFromPasteboard:slotPB];
            NSString* oudid = [dict objectForKey:kOpenUDIDKey];
            OpenUDIDLog(@"SlotPB dict = %@",dict);
            if (oudid==nil) {
                
                if (availableSlotPBid==nil) availableSlotPBid = slotPBid;
            } else {
                
                int count = [[frequencyDict valueForKey:oudid] intValue];
                [frequencyDict setObject:[NSNumber numberWithInt:++count] forKey:oudid];
            }

            NSString* gid = [dict objectForKey:kOpenUDIDAppUIDKey];
            if (gid!=nil && [gid isEqualToString:appUID]) {

                if (optedOut) {
                    optedOutDate = [dict objectForKey:kOpenUDIDOOTSKey];
                    optedOut = optedOutDate!=nil;   
                }
            }
        }
    }
    

    NSArray* arrayOfUDIDs = [frequencyDict keysSortedByValueUsingSelector:@selector(compare:)];
    NSString* mostReliableOpenUDID = (arrayOfUDIDs!=nil && [arrayOfUDIDs count]>0)? [arrayOfUDIDs lastObject] : nil;
    OpenUDIDLog(@"Freq Dict = %@\nMost reliable %@",frequencyDict,mostReliableOpenUDID);

    if (openUDID==nil) {        
        if (mostReliableOpenUDID==nil) {

            openUDID = [RersistenceOpenUDID _generateFreshOpenUDID];
        } else {
 
            openUDID = mostReliableOpenUDID;
        }

        if (localDict==nil) { 
            localDict = [NSMutableDictionary dictionaryWithCapacity:4];
            [localDict setObject:openUDID forKey:kOpenUDIDKey];
            [localDict setObject:appUID forKey:kOpenUDIDAppUIDKey];
            [localDict setObject:[NSDate date] forKey:kOpenUDIDTSKey];
            if (optedOut) [localDict setObject:optedOutDate forKey:kOpenUDIDTSKey];
            saveLocalDictToDefaults = YES;
        }
    }
    else {

        if (mostReliableOpenUDID!=nil && ![mostReliableOpenUDID isEqualToString:openUDID])
            isCompromised = YES;
    }
    

    OpenUDIDLog(@"Available Slot %@ Existing Slot %@",availableSlotPBid,myRedundancySlotPBid);
    if (availableSlotPBid!=nil && (myRedundancySlotPBid==nil || [availableSlotPBid isEqualToString:myRedundancySlotPBid])) {
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        UIPasteboard* slotPB = [UIPasteboard pasteboardWithName:availableSlotPBid create:YES];
        [slotPB setPersistent:YES];
#else
        NSPasteboard* slotPB = [NSPasteboard pasteboardWithName:availableSlotPBid];
#endif
        

        if (localDict) {
            [localDict setObject:availableSlotPBid forKey:kOpenUDIDSlotKey];
            saveLocalDictToDefaults = YES;
        }

        if (openUDID && localDict)
            [RersistenceOpenUDID _setDict:localDict forPasteboard:slotPB];
    }


    if (localDict && saveLocalDictToDefaults)
        [defaults setObject:localDict forKey:kOpenUDIDKey];


    if (optedOut) {
        if (error!=nil) *error = [NSError errorWithDomain:kOpenUDIDDomain
                                                     code:kOpenUDIDErrorOptedOut
                                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Application with unique id %@ is opted-out from OpenUDID as of %@",appUID,optedOutDate],@"description", nil]];
            
        kOpenUDIDSessionCache = [[NSString stringWithFormat:@"%040x",0] retain];
        return kOpenUDIDSessionCache;
    }


    if (error!=nil) {
        if (isCompromised)
            *error = [NSError errorWithDomain:kOpenUDIDDomain
                                         code:kOpenUDIDErrorCompromised
                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Found a discrepancy between stored OpenUDID (reliable) and redundant copies; one of the apps on the device is most likely corrupting the OpenUDID protocol",@"description", nil]];
        else
            *error = [NSError errorWithDomain:kOpenUDIDDomain
                                         code:kOpenUDIDErrorNone
                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"OpenUDID succesfully retrieved",@"description", nil]];
    }
    kOpenUDIDSessionCache = [openUDID retain];
    return kOpenUDIDSessionCache;
}

+ (void) setOptOut:(BOOL)optOutValue {

    [RersistenceOpenUDID value];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    id dict = [defaults objectForKey:kOpenUDIDKey];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    } else {
        dict = [NSMutableDictionary dictionaryWithCapacity:2];
    }

    if (optOutValue)
        [dict setObject:[NSDate date] forKey:kOpenUDIDOOTSKey];
    else
        [dict removeObjectForKey:kOpenUDIDOOTSKey];

    [defaults setObject:dict forKey:kOpenUDIDKey];
    
    OpenUDIDLog(@"Local dict after opt-out = %@",dict);
    
    kOpenUDIDSessionCache = nil;
    
}

@end
