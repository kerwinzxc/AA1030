

#ifndef SJIOSKeyChainTool_h
#define SJIOSKeyChainTool_h
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SJIOSKeyChainTool : NSObject


+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



+ (NSString *)readKeychainValue:(NSString *)sKey;



+ (void)deleteKeychainValue:(NSString *)sKey;


@end

#endif 
