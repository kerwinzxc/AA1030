

#import "RersistenceSdkMd5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation RersistenceSdkMd5

+(NSString*)md5:(NSString*)md5HexDigest;
{
    const char *original_str = [md5HexDigest UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

@end
