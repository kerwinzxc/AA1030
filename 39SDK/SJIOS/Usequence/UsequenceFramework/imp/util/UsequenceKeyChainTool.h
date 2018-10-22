

#ifndef UsequenceKeyChainTool_h
#define UsequenceKeyChainTool_h
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface UsequenceKeyChainTool : NSObject


+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



+ (NSString *)readKeychainValue:(NSString *)sKey;



+ (void)deleteKeychainValue:(NSString *)sKey;


@end

#endif 
