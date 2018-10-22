

#ifndef RersistenceKeyChainTool_h
#define RersistenceKeyChainTool_h
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface RersistenceKeyChainTool : NSObject


+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



+ (NSString *)readKeychainValue:(NSString *)sKey;



+ (void)deleteKeychainValue:(NSString *)sKey;


@end

#endif 
