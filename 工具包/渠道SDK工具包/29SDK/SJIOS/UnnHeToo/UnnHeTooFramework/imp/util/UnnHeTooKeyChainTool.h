

#ifndef UnnHeTooKeyChainTool_h
#define UnnHeTooKeyChainTool_h
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface UnnHeTooKeyChainTool : NSObject


+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



+ (NSString *)readKeychainValue:(NSString *)sKey;



+ (void)deleteKeychainValue:(NSString *)sKey;


@end

#endif 
