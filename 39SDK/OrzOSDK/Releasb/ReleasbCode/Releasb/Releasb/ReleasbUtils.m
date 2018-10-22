

#import "ReleasbUtils.h"
#import "ReleasbProgressHUD.h"
#import "ReleasbBranch.h"
#import "ReleasbReachability.h"

#define Releasb_SERVER_URL1 @"https://j"
#define Releasb_SERVER_URL2 @"uhesdk.3"
#define Releasb_SERVER_URL3 @"975ad.com"

//#define Releasb_SERVER_URL1 @"https://sandbox.j"
//#define Releasb_SERVER_URL2 @"uhe.3"
//#define Releasb_SERVER_URL3 @"975ad.com"

//#define Releasb_SERVER_URL @"http://sandbox.j+u+he.3+9+7+5ad.com" //sandbox

#define Releasb_APP_SECRET1 @"juh"
#define Releasb_APP_SECRET2 @"esdk_3"
#define Releasb_APP_SECRET3 @"975ad_com"


@interface ReleasbUtils()

@property (nonatomic ,strong) NSString *Releasb_username;
@property (nonatomic ,strong) NSString *Releasb_userid;
@property (nonatomic ,strong) NSString *Releasb_password;
@property (nonatomic,strong) NSString *Releasb_token;

@property (nonatomic,strong) NSString *Releasb_channel_userid;

@property (nonatomic,strong) NSString *Releasb_channel_id;

@property (nonatomic,strong) ReleasbProgressHUD *Releasb_process;

@end

@implementation ReleasbUtils

+(ReleasbUtils*)getSharedInstance
{
    static __strong ReleasbUtils * targetUtils = nil;
    if (targetUtils == nil)
    {
        targetUtils = [ReleasbUtils alloc];
        
    }
    
    return targetUtils;
}

-(void) showReleasbToastMsg:(NSString *)text view:(UIView *)view{
    if (_Releasb_process==nil) {
        _Releasb_process = [[ReleasbProgressHUD alloc] initWithView:view];
    }
    [view addSubview:_Releasb_process];
    _Releasb_process.labelText = text;
    _Releasb_process.labelFont=[UIFont systemFontOfSize:11];
    _Releasb_process.mode = ReleasbProgressHUDModeCustomView;
    _Releasb_process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_Releasb_process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [_Releasb_process removeFromSuperview];
    }];
    
    
}


-(void)setReleasbUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token{
    self.Releasb_username = [[NSString alloc] initWithFormat:@"%@", username];
    self.Releasb_userid = [[NSString alloc] initWithFormat:@"%@", userid];
    self.Releasb_password = [[NSString alloc] initWithFormat:@"%@", password];
    self.Releasb_token = [[NSString alloc] initWithFormat:@"%@", token];
}

-(NSString *)getReleasbUserId{
    if(self.Releasb_userid != NULL){
        return self.Releasb_userid;
    }else{
        return NULL;
    }
}

-(NSString *)getChannelUserId{
    if(self.Releasb_channel_userid != NULL){
        return self.Releasb_channel_userid;
    }else{
        return NULL;
    }
}

-(NSString *)getReleasbNetIsp{
    //获取本机运营商名称
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    //当前手机所属运营商名称
    
    NSString *mobile = [[NSString alloc] init];
    
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    
    if (!carrier.isoCountryCode) {
        
        mobile = @"无运营商";
        
    }else{
        
        mobile = [carrier carrierName];
    }
    
    return mobile;
}

-(NSString *)getReleasbNetworktype{
    ReleasbReachability *reachability   = [ReleasbReachability reachabilityWithHostName:@"www.apple.com"];
    ReleasbNetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"wifi";
    switch (internetStatus) {
        case ReleasbReachableViaWiFi:
            net = @"wifi";
            break;
            
        case ReleasbReachableViaWWAN:
            net = @"3G/4G";
            break;
            
        case ReleasbNotReachable:
            net = @"notReachable";
            
        default:
            net = @"unknown";
            break;
    }
    
    return net;
}


-(NSString *)getReleasbSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

-(NSString*)getReleasbIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

-(NSString*)getReleasbIdfv{
    if([self readKeychainValue:Releasb_KEYCHAIN_IDFV] == NULL){
        [self saveKeychainValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] key:Releasb_KEYCHAIN_IDFV];
        return [self readKeychainValue:Releasb_KEYCHAIN_IDFV];
    }else{
        return [self readKeychainValue:Releasb_KEYCHAIN_IDFV];
    }
}

-(NSString *)getReleasbUUID{
    if([self readKeychainValue:Releasb_KEYCHAIN_UUID] == NULL){
        [self saveKeychainValue:[[NSUUID UUID] UUIDString] key:Releasb_KEYCHAIN_UUID];
        return [self readKeychainValue:Releasb_KEYCHAIN_UUID];
    }else{
        return [self readKeychainValue:Releasb_KEYCHAIN_UUID];
    }
}

-(NSString*)getReleasbInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"apple_INSTALL_FLAG_%@", [self getReleasbBundleId]];
    NSLog(@"TAG = %@", TAG);
    if([self readKeychainValue:TAG] == NULL){
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [self readKeychainValue:TAG]);
        return [self readKeychainValue:TAG];
    }
}

-(NSString *)getReleasbMac{
    return @"";
}

-(NSString *)getReleasbPhoneUserName{
    return [[UIDevice currentDevice] name];
}//获取手机别名


-(NSString *)getReleasbDeviceName{
    return [[UIDevice currentDevice] systemName];
}//获取设备名称

-(NSString *)getReleasbDeviceModel{
    // 需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return platform;
    //return [[UIDevice currentDevice] model];
}//获取手机型号

-(NSString *)getReleasbLocalPhoneModel{
    return [[UIDevice currentDevice] localizedModel];
}//获取地方型号（国际化区域名称）

-(NSString *)getReleasbBundleId{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

-(NSString *)getReleasbAppName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

-(NSString *)getReleasbAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

-(NSString *)getReleasbAppBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

-(NSString *)getReleasbVersion{
    return Releasb_SDK_VERSION;
}

-(NSString *)getReleasbChannelSdkVersion{
    return [[ReleasbBranch getSharedInstance] getReleasbChannelSdkVersion];
}

-(NSString *)getReleasbInfoPlist_PackageId{
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ReleasbParams"];
    
    return [dict objectForKey:@"Releasb_GamePackageID"];
}

-(Boolean)getReleasbInfoPlist_Landscape{
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ReleasbParams"];
    
    if([[dict objectForKey:@"Releasb_Landscape"] boolValue] == YES){
        NSLog(@"6");
        return YES;
    }else{
        NSLog(@"!6");
        return NO;
    }
}

- (NSMutableDictionary *)getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

- (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey{
    NSMutableDictionary * keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:sValue] forKey:(__bridge_transfer id)kSecValueData];
    
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    
}

- (NSString *)readKeychainValue:(NSString *)sKey
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {

        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    
    return ret;
}
- (void)deleteKeychainValue:(NSString *)sKey {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:sKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}


-(NSString *)Releasb_md5:(NSString *)str{
    {
        const char *original_str = [str UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(original_str, strlen(original_str), result);
        NSMutableString *hash = [NSMutableString string];
        for (int i = 0; i < 16; i++)
            [hash appendFormat:@"%02X", result[i]];
        return [hash lowercaseString];
    }
}

-(void) sendHttpRequest:(NSDictionary *)httpParams toReleasbServer:(NSString *)requestPath responseHandler:(ReleasbRequestCallback)handler showProgess:(Boolean)showprogress
{
    
    NSLog(@"%@ dic = %@", requestPath, httpParams);
    ReleasbProgressHUD* progressHUD = nil;

    
    if (showprogress)
    {
        UIView* view = [[ReleasbBranch getSharedInstance] getReleasbCurrentView];
        if (view)
        {
            
            progressHUD = [ReleasbProgressHUD showHUDAddedTo:view animated:YES];
        }
    }
    
    NSString *cc = [NSString stringWithFormat:@"%@%@%@", Releasb_SERVER_URL1,Releasb_SERVER_URL2, Releasb_SERVER_URL3];
    
    NSURL* url = [NSURL URLWithString:requestPath relativeToURL:[NSURL URLWithString:cc]].absoluteURL;
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString* strParams = [self encodeHttpParams:httpParams encode:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         
         if (progressHUD != nil)
         {
             progressHUD.removeFromSuperViewOnHide = YES;
             [progressHUD hide:YES];
         }
         
         if (connectionError != nil || !data || [data length] == 0)
         {
             handler(response, nil, connectionError);
         }
         else
         {
             NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
             
             if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)
             {
                 NSError* error = nil;
                 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 handler(response, json, error);
             }
             else
             {
                 handler(response, nil, nil);
             }
         }
     }];
}

// 序列化http请求参数
-(NSString*) encodeHttpParams:(NSDictionary*)params encode:(NSStringEncoding)encoding
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

-(NSString *)getReleasbSecret{
    NSString *sec = [NSString stringWithFormat:@"%@%@%@", Releasb_APP_SECRET1, Releasb_APP_SECRET2, Releasb_APP_SECRET3];
    return sec;
}

-(void)postReleasbActiveData{
    
    
    if([[self getReleasbInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postReleasbActiveData");
        return;
    }else{
        NSLog(@"never postReleasbActiveData");
    }

    
    
    NSString *unsignStr = [[NSString alloc] initWithFormat:@"device_name=%@&idfa=%@&idfv=%@&imei=&mac=%@&package_id=%@&platform=1&uuid=%@&version=%@%@", [self getReleasbDeviceModel], [self getReleasbIdfa], [self getReleasbIdfv], [self getReleasbMac], [self getReleasbInfoPlist_PackageId], [self getReleasbUUID], [self getReleasbSystemVersion], [self getReleasbSecret]];
   // NSLog(@"unsignStr = %@", unsignStr);
    NSString *sign = [self Releasb_md5:unsignStr];
    NSLog(@"sign = %@", sign);
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [data setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [data setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [data setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [data setValue:[self getReleasbUUID] forKey:@"uuid"];
    [data setValue:@"" forKey:@"imei"];
    [data setValue:[self getReleasbMac] forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:[self getReleasbSystemVersion] forKey:@"version"];
    [data setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [data setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [data setValue:[self getReleasbAppName] forKey:@"app_name"];
    [data setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [data setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    [data setValue:[self getReleasbVersion] forKey:ssss];
    [data setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [data setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [data setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    [data setValue:sign forKey:@"sign"];
    
    [self sendHttpRequest:data toReleasbServer:@"/api/client/active" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        if (err)
        {
            NSLog(@"postReleasbActiveData Error: %@", err);
        }
        else
        {
            
            NSDictionary*  json= (NSDictionary*)data;
            NSLog(@"postReleasbActiveData: %@", json);
            NSString *TAG = [[NSString alloc] initWithFormat:@"apple_INSTALL_FLAG_%@", [self getReleasbBundleId]];
            [self saveKeychainValue:@"installed" key:TAG];
        }

        

    } showProgess:NO];

}

-(void)sendReleasbHeartData{
    
    
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
           // NSString *str = [NSString stringWithFormat:@"%@%@%@", Releasb_APP_SECRET1, Releasb_APP_SECRET2, Releasb_APP_SECRET3];
            NSString *unsignStr = [[NSString alloc] initWithFormat:@"package_id=%@&user_id=%@%@", [self getReleasbInfoPlist_PackageId], [self getReleasbUserId], [self getReleasbSecret]];
            NSString *sign = [self Releasb_md5:unsignStr];
            
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
            [dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
            [dic setValue:self.Releasb_userid forKey:@"user_id"];
            [dic setValue:sign forKey:@"sign"];
            
            [self sendHttpRequest:dic toReleasbServer:@"/api/client/heart_log" responseHandler:^(NSURLResponse *response, id data, NSError *err){
                NSLog(@"heart_log : %@", (NSDictionary*)data);
            } showProgess:NO];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });


}


-(void)postReleasbGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    //NSString *str = [NSString stringWithFormat:@"%@%@%@", Releasb_APP_SECRET1, Releasb_APP_SECRET2, Releasb_APP_SECRET3];
    
    NSString *unsignStr = [[NSString alloc] initWithFormat:@"device_name=%@&idfa=%@&idfv=%@&imei=&mac=%@&package_id=%@&platform=1&role_create_time=%@&role_id=%@&role_level=%@&role_name=%@&server_id=%@&server_name=%@&user_id=%@&uuid=%@&version=%@%@", [self getReleasbDeviceModel], [self getReleasbIdfa], [self getReleasbIdfv], [self getReleasbMac], [self getReleasbInfoPlist_PackageId], [data objectForKey:Releasb_ROLE_CREATE_TIME], [data objectForKey:Releasb_ROLE_ID], [data objectForKey:Releasb_ROLE_LEVEL], [data objectForKey:Releasb_ROLE_NAME], [data objectForKey:Releasb_SERVER_ID], [data objectForKey:Releasb_SERVER_NAME], [self getReleasbUserId], [self getReleasbUUID], [self getReleasbSystemVersion], [self getReleasbSecret]];
   // NSLog(@"unsignStr = %@", unsignStr);
    NSString *sign = [self Releasb_md5:unsignStr];
    NSLog(@"sign = %@", sign);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [dic setValue:self.Releasb_userid forKey:@"user_id"];
    
    [dic setValue:[data objectForKey:Releasb_SERVER_ID] forKey:@"server_id"];
    [dic setValue:[data objectForKey:Releasb_SERVER_NAME] forKey:@"server_name"];
    [dic setValue:[data objectForKey:Releasb_ROLE_ID] forKey:@"role_id"];
    [dic setValue:[data objectForKey:Releasb_ROLE_NAME] forKey:@"role_name"];
    [dic setValue:[data objectForKey:Releasb_ROLE_LEVEL] forKey:@"role_level"];
    [dic setValue:[data objectForKey:Releasb_ROLE_CREATE_TIME] forKey:@"role_create_time"];
    
    [dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [dic setValue:[self getReleasbUUID] forKey:@"uuid"];
    [dic setValue:@"" forKey:@"imei"];
    [dic setValue:[self getReleasbMac] forKey:@"mac"];
    [dic setValue:@"1" forKey:@"platform"];
    [dic setValue:[self getReleasbSystemVersion] forKey:@"version"];
    [dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [dic setValue:[self getReleasbAppName] forKey:@"app_name"];
    [dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    
    [dic setValue:[self getReleasbVersion] forKey:ssss];
    [dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    [dic setValue:sign forKey:@"sign"];

    NSString *urlparam = nil;
    if([dataPoint isEqualToString:Releasb_SUBMIT_CHOOSE_SERVER]){
        urlparam = @"/api/client/chooseserver";
    }else if([dataPoint isEqualToString:Releasb_SUBMIT_CHOOSE_ROLE]){
        urlparam = @"/api/client/chooserole";
    }else if([dataPoint isEqualToString:Releasb_SUBMIT_ROLE_CREATE]){
        urlparam = @"/api/client/create_role";
    }else if([dataPoint isEqualToString:Releasb_SUBMIT_ROLE_ENTERSERVER]){
        urlparam = @"/api/client/game_login";
    }else if([dataPoint isEqualToString:Releasb_SUBMIT_ROLE_LEVELUP]){
        urlparam = @"/api/client/levelup";
    }
    
    [self sendHttpRequest:dic toReleasbServer:urlparam responseHandler:^(NSURLResponse *response, id data, NSError *err){
        if (err)
        {
            NSLog(@"%@ Error: %@", urlparam, err);
        }
        else
        {
            if(data != NULL){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"%@: %@", urlparam, json);
                NSDictionary* jsonFieldData = [json valueForKey:@"data"];
            }
        }
        
        
        
    } showProgess:NO];
}

-(void)requestReleasbNotice:(ReleasbRequestCallback)result{
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [data setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [data setValue:[self getReleasbAppName] forKey:@"app_name"];
    [data setValue:[self getReleasbSystemVersion] forKey:@"version"];
    [data setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [data setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [data setValue:[self getReleasbVersion] forKey:ssss];
    [data setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    
    [self sendHttpRequest:data toReleasbServer:@"/api/data/get_notice" responseHandler:result showProgess:YES];
}

-(void)requestReleasbServerStatus:(ReleasbInitCallback)result{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [data setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [data setValue:[self getReleasbAppName] forKey:@"app_name"];
    [data setValue:[self getReleasbAppVersion] forKey:@"version"];
    [data setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [data setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [data setValue:[self getReleasbVersion] forKey:ssss];
    [data setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    
    
    [self sendHttpRequest:data toReleasbServer:@"/api/data/get_cp_channel" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        if (err)
        {
            // code=-2  msg=get server status failed serverid=null
            result(@{@"code":@"-2",@"msg":@"get server status failed 1!",@"serverid":@"", @"channel_id":@""});
            self.Releasb_channel_id = @"";

        }
        else
        {
            if(data != nil){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"requestReleasbServerStatus: %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    
                    // code=0   msg=init success  serverid=xxx
                    result(@{@"code":@"0",@"msg":@"init success!",@"serverid":[jsonFieldData objectForKey:@"cp_channel_id"], @"channel_id":[jsonFieldData objectForKey:@"channel_id"]});
                    self.Releasb_channel_id = [jsonFieldData objectForKey:@"channel_id"];
                    
                }else{
                    result(@{@"code":@"-2",@"msg":[json objectForKey:@"message"],@"serverid":@"", @"channel_id":@""});
                    self.Releasb_channel_id = @"";
                }
            }else{
                
                result(@{@"code":@"-1000",@"msg":@"data from server is null",@"serverid":@"", @"channel_id":@""});
                self.Releasb_channel_id = @"";
            }
        }
        
    } showProgess:YES];
}

-(void)getReleasbLoginAccessToken:(NSDictionary *)dic result:(ReleasbRequestCallback)result{
    
    NSString* channel_extends =[NSString stringWithFormat:@"{\"channel_uid\":\"%@\",\"channel_username\":\"%@\",\"channel_token\":\"%@\",\"channel_deviceid\":\"%@\"}",[dic objectForKey:@"channel_uid"],[dic objectForKey:@"channel_username"],[dic objectForKey:@"channel_token"],[dic objectForKey:@"channel_deviceid"]];
    
    //NSString *str = [NSString stringWithFormat:@"%@%@%@", Releasb_APP_SECRET1, Releasb_APP_SECRET2, Releasb_APP_SECRET3];

    NSString *getAccesstokenToken_unsignStr = [[NSString alloc] initWithFormat:@"channel_extends=%@&device_name=%@&idfa=%@&idfv=%@&imei=&mac=%@&package_id=%@&platform=1&uuid=%@&version=%@%@", channel_extends, [self getReleasbDeviceModel], [self getReleasbIdfa], [self getReleasbIdfv], [self getReleasbMac], [self getReleasbInfoPlist_PackageId], [self getReleasbUUID], [self getReleasbSystemVersion], [self getReleasbSecret]];
    //NSLog(@"getAccesstokenToken_unsignStr = %@", getAccesstokenToken_unsignStr);
    NSString *sign = [self Releasb_md5:getAccesstokenToken_unsignStr];
    NSLog(@"getAccesstokenToken_sign = %@", sign);
    
    NSMutableDictionary *token_dic = [NSMutableDictionary dictionary];
    [token_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [token_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [token_dic setValue:channel_extends forKey:@"channel_extends"];
    [token_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [token_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [token_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
    [token_dic setValue:@"" forKey:@"imei"];
    [token_dic setValue:[self getReleasbMac] forKey:@"mac"];
    [token_dic setValue:@"1" forKey:@"platform"];
    [token_dic setValue:[self getReleasbSystemVersion] forKey:@"version"];
    [token_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [token_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [token_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
    [token_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [token_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [token_dic setValue:[self getReleasbVersion] forKey:ssss];
    [token_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [token_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [token_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    [token_dic setValue:sign forKey:@"sign"];
    
    [self sendHttpRequest:token_dic toReleasbServer:@"/api/oauth/access_token" responseHandler:result showProgess:YES];
}


-(void)getReleasbLoginInfo:(NSDictionary *)dic result:(ReleasbLoginCallback)result{
    
    [self getReleasbLoginAccessToken:dic result:^(NSURLResponse *response, id data, NSError *err){
        if (err)
        {
            NSLog(@"/api/oauth/access_token Error: %@", err);
            result(@{@"code":@"-2",@"msg":@"get token failed 1"});
        }
        else
        {
            if(data != nil){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"/api/oauth/access_token : %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){//获取access token成功,接下来获取userinfo
                    
                    //判断是否进入防沉迷
                    if([self.Releasb_channel_id intValue] == 18){
                        if([[json objectForKey:@"code"] intValue] == 500003){
                            //您当日累计在线游戏时间已经达到3小时，请绑定身份证信息
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                                [[ReleasbBranch getSharedInstance] doReleasbChannelRealNameRegister:1 callback:^(NSString *res){
                                    
                                }];
                            }];
                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                            }];
                            [alert addAction:defaultAction];
                            [alert addAction:cancelAction];
                            [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        }else if([[json objectForKey:@"code"] intValue] == 500004){
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    
                            }];
                            [alert addAction:defaultAction];
                            [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        }else if([[json objectForKey:@"code"] intValue] == 500005){
                            //您当日累计在线游戏时间没达到3小时，请绑定身份证信息
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"实名认证提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                                [[ReleasbBranch getSharedInstance] doReleasbChannelRealNameRegister:1 callback:^(NSString *res){
                                    
                                }];
                            }];
                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                            }];
                            [alert addAction:defaultAction];
                            [alert addAction:cancelAction];
                            [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    
                    
                    NSMutableDictionary *userinfo_dic = [NSMutableDictionary dictionary];
                    [userinfo_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
                    [userinfo_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
                    [userinfo_dic setValue:[jsonFieldData objectForKey:@"access_token"] forKey:@"access_token"];
                    [userinfo_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
                    [userinfo_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
                    [userinfo_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
                    [userinfo_dic setValue:@"" forKey:@"imei"];
                    [userinfo_dic setValue:[self getReleasbMac] forKey:@"mac"];
                    [userinfo_dic setValue:@"1" forKey:@"platform"];
                    [userinfo_dic setValue:[self getReleasbSystemVersion] forKey:@"version"];
                    [userinfo_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
                    [userinfo_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
                    [userinfo_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
                    [userinfo_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
                    [userinfo_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
                    
                    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
                    [userinfo_dic setValue:[self getReleasbVersion] forKey:ssss];
                    [userinfo_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
                    [userinfo_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
                    [userinfo_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
                    [self sendHttpRequest:userinfo_dic toReleasbServer:@"/api/oauth/user_info" responseHandler:^(NSURLResponse *response, id data, NSError *err){
                        
                        if (err)
                        {
                            NSLog(@"/api/oauth/user_info Error: %@", err);
                            result(@{@"code":@"-3",@"msg":@"get userinfo failed"});
                        }
                        else
                        {
                            if(data != nil){
                                NSDictionary* json1 = (NSDictionary*)data;
                                NSLog(@"/api/oauth/user_info : %@", json1);
                                if([[json1 objectForKey:@"success"] integerValue] == 1){//获取userinfo成功
                                    NSDictionary* jsonFieldData1 = [json1 valueForKey:@"data"];

                                    //登陆成功后，需要检测用户是否在白单内
                                    [self checkUserAccess:jsonFieldData1 loginCallback:result];
                                    
                                    [self setReleasbUserInfo:[jsonFieldData1 objectForKey:@"username"] userid:[jsonFieldData1 objectForKey:@"id"] password:nil token:[jsonFieldData objectForKey:@"access_token"]];
                                    
                                }else{
                                    result(@{@"code":@"-3",@"msg":[json1 objectForKey:@"message"]});
                                }
                            }else{
                                result(@{@"code":@"-1000",@"msg":@"data from server is null"});
                            }
                        }
                        
                    } showProgess:YES];
                }else{//获取access token失败   success = false
                   // NSLog(@"防拉人设置1");
                    //防拉人设置
                    if([[json objectForKey:@"code"] intValue] == 500107){
                       // NSLog(@"防拉人设置2");
//                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
//
//                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//
//                        }];
//                        [alert addAction:defaultAction];
//                        [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        [[ReleasbUtils getSharedInstance] showReleasbToastMsg:[json objectForKey:@"message"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
                    }
                    //end 防拉人设置
                    result(@{@"code":[NSString stringWithFormat:@"%d", [[json objectForKey:@"code"] intValue]],@"msg":[json objectForKey:@"message"]});
                }
            }else{
                result(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
    }];
    
}


-(void)checkUserAccess:(NSDictionary *)userinfo loginCallback:(ReleasbLoginCallback)loginCallback{
    NSMutableDictionary *access_dic = [NSMutableDictionary dictionary];
    [access_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [access_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [access_dic setValue:[userinfo objectForKey:@"id"] forKey:@"user_id"];
    [access_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [access_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [access_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
    [access_dic setValue:@"" forKey:@"imei"];
    [access_dic setValue:[self getReleasbMac] forKey:@"mac"];
    [access_dic setValue:@"1" forKey:@"platform"];
    [access_dic setValue:[self getReleasbAppVersion] forKey:@"version"];
    [access_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [access_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [access_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
    [access_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [access_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [access_dic setValue:[self getReleasbVersion] forKey:ssss];
    [access_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [access_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [access_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    [self sendHttpRequest:access_dic toReleasbServer:@"/api/data/allow_login" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        
        if (err)
        {
            NSLog(@"/api/data/allow_login Error: %@", err);
            //code=-4,msg=not allow login
            loginCallback(@{@"code":@"-4",@"msg":@"not allow login"});
        }
        else
        {
            if(data != nil){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"/api/data/allow_login : %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){//获取access token成功
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    if([[jsonFieldData objectForKey:@"allow_login"] integerValue] == 1){
                        self.Releasb_channel_userid = [[NSString alloc] initWithFormat:@"%@", [userinfo objectForKey:@"channel_uid"]];
                        
                        NSString *ssss1 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_userid"];
                        NSString *ssss2 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_token"];
                        NSString *ssss3 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_username"];
                        NSString *ssss4 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_nickname"];
                        loginCallback(@{@"code":@"0",
                                        @"msg":@"login success",
                                        ssss1:[userinfo objectForKey:@"id"],
                                        ssss2:self.Releasb_token,
                                        ssss3:[userinfo objectForKey:@"username"],
                                        ssss4:[userinfo objectForKey:@"nickname"],
                                        @"channel_userid":[userinfo objectForKey:@"channel_uid"],
                                        @"channel_id":[userinfo objectForKey:@"channel_id"],
                                        @"channel_name":[userinfo objectForKey:@"channel_name"]
                                        });
                        
                        
                    }else{
                        loginCallback(@{@"code":@"-4",@"msg":[jsonFieldData objectForKey:@"message"]});
                    }
                }else{
                    loginCallback(@{@"code":@"-4",@"msg":[json objectForKey:@"message"]});
                }
            }else{
                loginCallback(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
        
    } showProgess:YES];
}

-(void)doReleasbLogout:(ReleasbLogoutCallback)result{
    
    NSMutableDictionary *logout_dic = [NSMutableDictionary dictionary];
    [logout_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [logout_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_userid"];
    [logout_dic setValue:[self getReleasbUserId] forKey:ssss];
    [logout_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [logout_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [logout_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
    [logout_dic setValue:@"" forKey:@"imei"];
    [logout_dic setValue:[self getReleasbMac] forKey:@"mac"];
    [logout_dic setValue:@"1" forKey:@"platform"];
    [logout_dic setValue:[self getReleasbSystemVersion] forKey:@"version"];
    [logout_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [logout_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [logout_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
    [logout_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [logout_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss1 = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [logout_dic setValue:[self getReleasbVersion] forKey:ssss1];
    [logout_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [logout_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [logout_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    [self sendHttpRequest:logout_dic toReleasbServer:@"/api/oauth/logout" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        
        if (err)
        {
            NSLog(@"/api/oauth/logout Error: %@", err);
            
            result(@{@"code":@"-2",@"msg":@"sdk logout failed"});
        }
        else
        {
            if(data != nil){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"/api/oauth/logout : %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){//获取access token成功
                   // NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    result(@{@"code":@"0",@"msg":@"logout success"});
                    
                }else{
                    result(@{@"code":@"-2",@"msg":[json objectForKey:@"message"]});
                }
            }else{
                result(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
        
    } showProgess:YES];
}


-(void)doReleasbCreateOder:(NSDictionary *)param buildReleasbodcb:(ReleasbCreateOderCallback)buildReleasbodcb{
    [self getReleasbAibbeReleasbCar:^(NSURLResponse *response, id data, NSError *err){
        
        if (err)
        {
            NSLog(@"/api/data/get_ Error: %@", err);
            
            buildReleasbodcb(@{@"code":@"-1",@"msg":@"sdk get type failed"});
        }
        else
        {
            
            if(data != NULL){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"/api/data/get_ : %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    
                    NSMutableDictionary *buildReleasbodcb_dic = [NSMutableDictionary dictionary];
                    [buildReleasbodcb_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
                    [buildReleasbodcb_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
                    [buildReleasbodcb_dic setValue:[self getReleasbUserId] forKey:@"user_id"];
                    [buildReleasbodcb_dic setValue:self.Releasb_channel_userid forKey:@"channel_userid"];
                    [buildReleasbodcb_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
                    [buildReleasbodcb_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
                    [buildReleasbodcb_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
                    [buildReleasbodcb_dic setValue:@"" forKey:@"imei"];
                    [buildReleasbodcb_dic setValue:[self getReleasbMac] forKey:@"mac"];
                    [buildReleasbodcb_dic setValue:@"1" forKey:@"platform"];
                    [buildReleasbodcb_dic setValue:[self getReleasbSystemVersion] forKey:@"version"];
                    [buildReleasbodcb_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
                    [buildReleasbodcb_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
                    [buildReleasbodcb_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
                    [buildReleasbodcb_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
                    [buildReleasbodcb_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
                    
                    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
                    [buildReleasbodcb_dic setValue:[self getReleasbVersion] forKey:ssss];
                    [buildReleasbodcb_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
                    [buildReleasbodcb_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
                    [buildReleasbodcb_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
                    
                    NSString *a = [[NSString alloc] initWithFormat:@"cp_o%@", @"rder_id"];
                    
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_CP_ORDERID] forKey:a];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_PRODUCT_PRICE] forKey:@"money"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_PRODUCT_NAME] forKey:@"unix_name"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_PRODUCT_ID] forKey:@"product_id"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_GOODS_NUM] forKey:@"product_num"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_PRODUCT_DESC] forKey:@"product_desc"];
                    if([param objectForKey:Releasb_IOS_EXTRA] == NULL){
                        [buildReleasbodcb_dic setValue:@"" forKey:@"extends"];
                    }else{
                        [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_EXTRA] forKey:@"extends"];
                    }
                    
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_ROLE_ID] forKey:@"role_id"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_ROLE_NAME] forKey:@"role_name"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_ROLE_LEVEL] forKey:@"role_level"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_SERVER_ID] forKey:@"server_id"];
                    [buildReleasbodcb_dic setValue:[param objectForKey:Releasb_IOS_SERVER_NAME] forKey:@"server_name"];
                    
                    NSString *b = [[NSString alloc] initWithFormat:@"/api/o%@", @"rder/create"];
                    [self sendHttpRequest:buildReleasbodcb_dic toReleasbServer:b responseHandler:^(NSURLResponse *res, id resdata, NSError *reserr){
                        if(reserr){
                            buildReleasbodcb(@{@"code":@"-2",@"msg":@"sdk create oder failed"});
                        }else{
                            
                            if(resdata != NULL){
                                NSDictionary *createoder_res = (NSDictionary*)resdata;
                                NSLog(@"/api/oder/create : %@", createoder_res);
                                if([[createoder_res objectForKey:@"success"] integerValue] == 1){
                                    if([self.Releasb_channel_id intValue] == 18){
                                        if([[createoder_res objectForKey:@"code"] intValue] == 500003){
                                            
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[createoder_res objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [[ReleasbBranch getSharedInstance] doReleasbChannelRealNameRegister:2 callback:^(NSString *res){
                                                    [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                                }];
                                                
                                                
                                            }];
                                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                            }];
                                            [alert addAction:defaultAction];
                                            [alert addAction:cancelAction];
                                            [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                                        }else if([[createoder_res objectForKey:@"code"] intValue] == 500004){
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[createoder_res objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                            }];
                                            [alert addAction:defaultAction];
                                            [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                                        }else if([[createoder_res objectForKey:@"code"] intValue] == 500005){
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"实名认证提醒" message:[createoder_res objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [[ReleasbBranch getSharedInstance] doReleasbChannelRealNameRegister:2 callback:^(NSString *res){
                                                    [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                                }];
                                                
                                                
                                            }];
                                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                            }];
                                            [alert addAction:defaultAction];
                                            [alert addAction:cancelAction];
                                            [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
                                        }else{
                                            [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                        }
                                    }else{
                                        [self ReleasbContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildReleasbodcb:buildReleasbodcb];
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }else{
                                    buildReleasbodcb(@{@"code":[createoder_res objectForKey:@"code"],@"msg":[createoder_res objectForKey:@"message"]});

                                }
                            }else{
                                buildReleasbodcb(@{@"code":@"-1000",@"msg":@"data from server is null"});
                            }
                        }
                    } showProgess:YES];
                    

                    
                }else{
                    buildReleasbodcb(@{@"code":@"-1",@"msg":[json objectForKey:@"message"]});
                    
                }
            }else{
                buildReleasbodcb(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
    }];
}

-(void)ReleasbContinueRegcharg:(NSDictionary *)createoder_res
                            param:(NSDictionary *)param
                            jsonFieldData:(NSDictionary *)jsonFieldData
            buildReleasbodcb:(ReleasbCreateOderCallback)buildReleasbodcb{
    NSDictionary* createoder_data = [createoder_res valueForKey:@"data"];
    
    //创建订单成功，获取到订单号，下一步：获取真实商品id
    NSMutableDictionary *product_dic = [NSMutableDictionary dictionary];
    [product_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [product_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [product_dic setValue:[param objectForKey:Releasb_IOS_PRODUCT_ID] forKey:@"zgipakm"];
    [self sendHttpRequest:product_dic toReleasbServer:@"/api/data/zgipakm" responseHandler:^(NSURLResponse *res1, id resdata1, NSError *reserr1){
        if(reserr1){
            buildReleasbodcb(@{@"code":@"-3",@"msg":@"ssss sdk get productid failed"});
            
        }else{
            if(resdata1 != NULL){
                NSDictionary *product_res = (NSDictionary*)resdata1;
                NSLog(@"/api/data/zgipakm : %@", product_res);
                if([[product_res objectForKey:@"success"] integerValue] == 1){
                    
                    NSString *c = [[NSString alloc] initWithFormat:@"o%@", @"rder_id"];
                    NSString *d = [NSString stringWithFormat:@"%@%@%@", @"xia", @"om", @"imi"];
                    buildReleasbodcb(@{@"code":@"0",
                                   @"msg":@"create oder success",
                                   @"oder_id":[createoder_data objectForKey:c],
                                   @"AibbeReleasbCar":[jsonFieldData objectForKey:@"wwlhxh"],
                                   @"AibbeReleasbBBS":[jsonFieldData objectForKey:@"wwlhxhName"],
                                   @"product_id":[product_res objectForKey:@"data"],
                                   @"BusForReleasbMiss":[createoder_data objectForKey:d]
                                   });
                }else{
                    buildReleasbodcb(@{@"code":@"-3",@"msg":[product_res objectForKey:@"message"]});
                    
                }
            }else{
                buildReleasbodcb(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
    } showProgess:YES];
}

-(void)getReleasbAibbeReleasbCar:(ReleasbRequestCallback)callBack{
    NSMutableDictionary *RegcgReleasbLeiXing_dic = [NSMutableDictionary dictionary];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbUserId] forKey:@"user_id"];
    [RegcgReleasbLeiXing_dic setValue:self.Releasb_channel_userid forKey:@"channel_userid"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
    [RegcgReleasbLeiXing_dic setValue:@"" forKey:@"imei"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbMac] forKey:@"mac"];
    [RegcgReleasbLeiXing_dic setValue:@"1" forKey:@"platform"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbAppVersion] forKey:@"version"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbVersion] forKey:ssss];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [RegcgReleasbLeiXing_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    
    [self sendHttpRequest:RegcgReleasbLeiXing_dic toReleasbServer:@"/api/data/get_wwlhxh" responseHandler:callBack showProgess:YES];
}

-(void)doReleasbCheckUpdate:(ReleasbCheckUpdateCallback)result{
    NSMutableDictionary *checkupdate_dic = [NSMutableDictionary dictionary];
    [checkupdate_dic setValue:[self getReleasbInfoPlist_PackageId] forKey:@"package_id"];
    [checkupdate_dic setValue:[self getReleasbBundleId] forKey:@"bundleid"];
    [checkupdate_dic setValue:[self getReleasbAppVersion] forKey:@"version"];
    [checkupdate_dic setValue:[self getReleasbIdfa] forKey:@"idfa"];
    [checkupdate_dic setValue:[self getReleasbIdfv] forKey:@"idfv"];
    [checkupdate_dic setValue:[self getReleasbUUID] forKey:@"uuid"];
    [checkupdate_dic setValue:@"" forKey:@"imei"];
    [checkupdate_dic setValue:[self getReleasbMac] forKey:@"mac"];
    [checkupdate_dic setValue:@"1" forKey:@"platform"];
    [checkupdate_dic setValue:[self getReleasbDeviceModel] forKey:@"device_name"];
    [checkupdate_dic setValue:[self getReleasbPhoneUserName] forKey:@"device_user_name"];
    [checkupdate_dic setValue:[self getReleasbAppName] forKey:@"app_name"];
    [checkupdate_dic setValue:[self getReleasbAppVersion] forKey:@"app_version"];
    [checkupdate_dic setValue:[self getReleasbAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [checkupdate_dic setValue:[self getReleasbVersion] forKey:ssss];
    [checkupdate_dic setValue:[self getReleasbChannelSdkVersion] forKey:@"channel_version"];
    [checkupdate_dic setValue:[self getReleasbNetIsp] forKey:@"net_isp"];
    [checkupdate_dic setValue:[self getReleasbNetworktype] forKey:@"net_status"];
    
    [self sendHttpRequest:checkupdate_dic toReleasbServer:@"/api/data/force_update" responseHandler:^(NSURLResponse *res, id resdata, NSError *reserr){
        if(reserr){
            result(@{@"code":@"-1",@"message":@"check update failed"});
        }else{
            if(resdata != NULL){
                NSDictionary *checkupdate_res = (NSDictionary*)resdata;
                NSLog(@"/api/data/force_update : %@", checkupdate_res);
                NSDictionary *checkupdate_data = [checkupdate_res objectForKey:@"data"];
                if([[checkupdate_res objectForKey:@"success"] integerValue] == 1){
                    result(@{@"code":@"0",
                             @"message":[checkupdate_res objectForKey:@"message"],
                             @"content":[checkupdate_data objectForKey:@"update_content"],
                             @"title":[checkupdate_data objectForKey:@"update_title"],
                             @"url":[checkupdate_data objectForKey:@"update_url"]
                             });
                }else{
                    result(@{@"code":@"-1",@"message":[checkupdate_res objectForKey:@"message"]});
                }
            }else{
                result(@{@"code":@"-1000",@"message":@"data from server is null"});
            }
        }
    } showProgess:YES];
}

-(void)doReleasbPostAction:(NSDictionary *)httpParams toReleasbServer:(NSString *)requestPath responseHandler:(ReleasbRequestCallback)handler showProgess:(Boolean)showprogress{
    [self sendHttpRequest:httpParams toReleasbServer:requestPath responseHandler:handler showProgess:showprogress];
}
@end

