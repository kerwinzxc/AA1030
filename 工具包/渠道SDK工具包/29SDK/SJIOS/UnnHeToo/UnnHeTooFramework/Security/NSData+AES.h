

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密
- (NSData *)AES256EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密

@end
