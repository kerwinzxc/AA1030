

#ifndef QroughtKeyChainTool_h
#define QroughtKeyChainTool_h
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface QroughtKeyChainTool : NSObject


+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



+ (NSString *)readKeychainValue:(NSString *)sKey;



+ (void)deleteKeychainValue:(NSString *)sKey;


@end

#endif 
