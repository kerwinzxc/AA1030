

#import "PostinWebApi.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"




@implementation PostinWebApi



+ (void)requestPostPostinUrl:(NSURL *)requestPathPostin
           bodyDictionaryPostin:(NSDictionary *)httpParamsPostin
          successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
              failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    
    NSLog(@"%@ dic = %@", [[requestPathPostin absoluteString] substringFromIndex:17], httpParamsPostin);
    
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:requestPathPostin];
    
    NSString* strParams = [self encodeHttpPostinParams:httpParamsPostin encode:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         if (connectionError != nil || !data || [data length] == 0)
         {
             failCallbackPostin(connectionError);
         }
         else
         {
             NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
             
             if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)
             {
                 NSError* error = nil;
                 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
                 NSLog(@"responseString:%@\n",json);
                 successCallbackPostin(json, NULL);
             }
             else
             {
                 failCallbackPostin(connectionError);
             }
         }
     }];
}

+(NSString*) encodeHttpPostinParams:(NSDictionary*)params encode:(NSStringEncoding)encoding
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
