

#import <Foundation/Foundation.h>
#import "UsequenceGTMDefines.h"


@interface UsequenceGTMBase64 : NSObject

+(NSData *)encodeData:(NSData *)data;


+(NSData *)decodeData:(NSData *)data;


+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;


+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;


+(NSString *)stringByEncodingData:(NSData *)data;


+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;


+(NSData *)decodeString:(NSString *)string;



@end
