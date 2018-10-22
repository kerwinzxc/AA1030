
#import <Foundation/Foundation.h>

@interface PostinSecurityUtil : NSObject

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string;
//将带密码的data转成string
+ (NSString*)decryptAESData:(NSString*)string;

//将string转成带密码的data
+ (NSString*)encryptAES256Data:(NSString*)string;
//将带密码的data转成string
+ (NSString*)decryptAES256Data:(NSString*)string;

+ (NSString *)getSha256String:(NSString *)srcString;


+ (NSString*) UrlEncode:(NSString*) string;

@end
