

#import "UsequenceWebApi.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"




@implementation UsequenceWebApi



+ (void)requestPostUsequenceUrl:(NSURL *)requestPathUsequence
           bodyDictionaryUsequence:(NSDictionary *)httpParamsUsequence
          successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
              failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    
    NSLog(@"%@ dic = %@", [[requestPathUsequence absoluteString] substringFromIndex:17], httpParamsUsequence);
    
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:requestPathUsequence];
    
    NSString* strParams = [self encodeHttpUsequenceParams:httpParamsUsequence encode:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         if (connectionError != nil || !data || [data length] == 0)
         {
             failCallbackUsequence(connectionError);
         }
         else
         {
             NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
             
             if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)
             {
                 NSError* error = nil;
                 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
                 NSLog(@"responseString:%@\n",json);
                 successCallbackUsequence(json, NULL);
             }
             else
             {
                 failCallbackUsequence(connectionError);
             }
         }
     }];
}

+(NSString*) encodeHttpUsequenceParams:(NSDictionary*)params encode:(NSStringEncoding)encoding
{
    NSMutableArray* paramsArray = [NSMutableArray array];
    
    for (NSString* key in params) {
        id value = [params valueForKey:key];
        
        NSString* strValue = nil;
        
        if ([value isKindOfClass:[NSDictionary class]] ||
            [value isKindOfClass:[NSArray class]] ||
            [value isKindOfClass:[NSData class]] ||
            [value isKindOfClass:[NSSet class]])
        {
            NSError* err = nil;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:value options:kNilOptions error:&err];
            strValue = [[NSString alloc] initWithData:jsonData encoding:encoding];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            strValue = value;
        }
        else
        {
            strValue = [value description];
        }
        
        static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
        static NSString * const kAFCharactersToLeaveUnescapedInQueryStringPairKey = @"[].";
        
        NSString* strKey = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                  kCFAllocatorDefault,
                                                                                                  (__bridge CFStringRef)key,
                                                                                                  (__bridge CFStringRef)kAFCharactersToLeaveUnescapedInQueryStringPairKey,
                                                                                                  (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
        
        strValue = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                          kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)strValue,
                                                                                          NULL,
                                                                                          (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString,
                                                                                          CFStringConvertNSStringEncodingToEncoding(encoding));
        
        [paramsArray addObject:[NSString stringWithFormat:@"%@=%@", strKey, strValue]];
    }
    
    return [paramsArray componentsJoinedByString:@"&"];
}


@end
