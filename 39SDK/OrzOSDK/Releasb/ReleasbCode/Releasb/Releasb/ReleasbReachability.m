
 
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
 
#import <CoreFoundation/CoreFoundation.h>
 
#import "ReleasbReachability.h"
 
#pragma mark IPv6 Support

 
 
NSString *ReleasbkReachabilityChangedNotification = @"kNetworkReachabilityChangedNotification";
 
 
#pragma mark - Supporting functions
 
#define kShouldPrintReachabilityFlags 1
 
static void PrintReachabilityFlags(SCNetworkReachabilityFlags flags, const char* comment)
{
#if kShouldPrintReachabilityFlags
 
    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c %s\n",
          (flags & kSCNetworkReachabilityFlagsIsWWAN)               ? 'W' : '-',
          (flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
 
          (flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
          (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
          (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
          (flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
          (flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-',
          comment
          );
#endif
}
 
 
static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
#pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject*) info isKindOfClass: [ReleasbReachability class]], @"info was wrong class in ReachabilityCallback");
 
    ReleasbReachability* noteObject = (__bridge ReleasbReachability *)info;

    [[NSNotificationCenter defaultCenter] postNotificationName: ReleasbkReachabilityChangedNotification object: noteObject];
}
 
 
#pragma mark - Reachability implementation
 
@implementation ReleasbReachability
{
    SCNetworkReachabilityRef _reachabilityRef;
}
 
+ (instancetype)reachabilityWithHostName:(NSString *)hostName
{
    ReleasbReachability* returnValue = NULL;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    if (reachability != NULL)
    {
        returnValue= [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
        }
        else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}
 
 
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);
 
    ReleasbReachability* returnValue = NULL;
 
    if (reachability != NULL)
    {
        returnValue = [[self alloc] init];
        if (returnValue != NULL)
        {
            returnValue->_reachabilityRef = reachability;
        }
        else {
            CFRelease(reachability);
        }
    }
    return returnValue;
}
 
 
+ (instancetype)reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    return [self reachabilityWithAddress: (const struct sockaddr *) &zeroAddress];
}
 
#pragma mark reachabilityForLocalWiFi

 
 
 
#pragma mark - Start and stop notifier
 
- (BOOL)startNotifier
{
    BOOL returnValue = NO;
    SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
 
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, &context))
    {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            returnValue = YES;
        }
    }
    
    return returnValue;
}
 
 
- (void)stopNotifier
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}
 
 
- (void)dealloc
{
    [self stopNotifier];
    if (_reachabilityRef != NULL)
    {
        CFRelease(_reachabilityRef);
    }
}
 
 
#pragma mark - Network Flag Handling
 
- (ReleasbNetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    PrintReachabilityFlags(flags, "networkStatusForFlags");
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {

        return ReleasbNotReachable;
    }
 
    ReleasbNetworkStatus returnValue = ReleasbNotReachable;
 
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {

        returnValue = ReleasbReachableViaWiFi;
    }
 
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {

 
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
 
            returnValue = ReleasbReachableViaWiFi;
        }
    }
 
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {

        returnValue = ReleasbReachableViaWWAN;
    }
    
    return returnValue;
}
 
 
- (BOOL)connectionRequired
{

    SCNetworkReachabilityFlags flags;
 
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    }
 
    return NO;
}
 
 
- (ReleasbNetworkStatus)currentReachabilityStatus
{

    ReleasbNetworkStatus returnValue = ReleasbNotReachable;
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        returnValue = [self networkStatusForFlags:flags];
    }
    
    return returnValue;
}
 
 
@end
