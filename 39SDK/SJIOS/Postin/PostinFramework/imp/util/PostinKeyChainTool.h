

#ifndef PostinKeyChainTool_h
#define PostinKeyChainTool_h
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface PostinKeyChainTool : NSObject


+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



+ (NSString *)readKeychainValue:(NSString *)sKey;



+ (void)deleteKeychainValue:(NSString *)sKey;


@end

#endif 
