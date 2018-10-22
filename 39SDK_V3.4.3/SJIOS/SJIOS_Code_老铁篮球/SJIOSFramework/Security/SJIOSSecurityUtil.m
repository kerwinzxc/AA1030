

#import "SJIOSSecurityUtil.h"
#import "SJIOSGTMBase64.h"
#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "SJIOSWebInterface.h"
#import "SJIOSSdkImp.h"

@implementation SJIOSSecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [SJIOSGTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [SJIOSGTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
} 

+ (NSString*)encodeBase64Data:(NSData *)data {
	data = [SJIOSGTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
	data = [SJIOSGTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAES256Data:(NSString*)string
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES256EncryptWithKey:[[SJIOSSdkImp sharedInstance] gameKey] gIv:[[SJIOSSdkImp sharedInstance] gameIV]];
    Byte *testByte = (Byte *)[encryptedData bytes];
    //返回进行base64进行转码的加密字符串
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAES256Data:(NSString *)string
{
    //base64解密
    NSData *decodeBase64Data=[SJIOSGTMBase64 decodeString:string];
    //使用密码对data进行解密
    NSData *decryData = [decodeBase64Data AES256DecryptWithKey:[[SJIOSSdkImp sharedInstance] gameKey] gIv:[[SJIOSSdkImp sharedInstance] gameIV]];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAESData:(NSString*)string{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:[[SJIOSSdkImp sharedInstance] gameKey] gIv:[[SJIOSSdkImp sharedInstance] gameIV]];
    //返回进行base64进行转码的加密字符串
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAESData:(NSString *)string
{
    //base64解密
    NSData *decodeBase64Data=[SJIOSGTMBase64 decodeString:string];
    //使用密码对data进行解密
    NSData *decryData = [decodeBase64Data AES128DecryptWithKey:[[SJIOSSdkImp sharedInstance] gameKey] gIv:[[SJIOSSdkImp sharedInstance] gameIV]];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}


#pragma mark - sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}




+ (NSString*) UrlEncode:(NSString*) string{
    NSString *outputStr = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                              (CFStringRef)string,
                                                                              NULL,
                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",                                                                              kCFStringEncodingUTF8);
    if(outputStr) return outputStr;
    return @"";
}
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=( NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}



@end
