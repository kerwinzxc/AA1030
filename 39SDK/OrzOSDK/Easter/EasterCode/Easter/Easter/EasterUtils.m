

#import "EasterUtils.h"
#import "EasterProgressHUD.h"
#import "EasterBranch.h"
#import "EasterReachability.h"

#define Easter_SERVER_URL1 @"https://j"
#define Easter_SERVER_URL2 @"uhesdk.3"
#define Easter_SERVER_URL3 @"975ad.com"

//#define Easter_SERVER_URL1 @"https://sandbox.j"
//#define Easter_SERVER_URL2 @"uhe.3"
//#define Easter_SERVER_URL3 @"975ad.com"

//#define Easter_SERVER_URL @"http://sandbox.j+u+he.3+9+7+5ad.com" //sandbox

#define Easter_APP_SECRET1 @"juh"
#define Easter_APP_SECRET2 @"esdk_3"
#define Easter_APP_SECRET3 @"975ad_com"


@interface EasterUtils()

@property (nonatomic ,strong) NSString *Easter_username;
@property (nonatomic ,strong) NSString *Easter_userid;
@property (nonatomic ,strong) NSString *Easter_password;
@property (nonatomic,strong) NSString *Easter_token;

@property (nonatomic,strong) NSString *Easter_channel_userid;

@property (nonatomic,strong) NSString *Easter_channel_id;

@property (nonatomic,strong) EasterProgressHUD *Easter_process;

@end

@implementation EasterUtils

+(EasterUtils*)getSharedInstance
{
    static __strong EasterUtils * targetUtils = nil;
    if (targetUtils == nil)
    {
        targetUtils = [EasterUtils alloc];
        
    }
    
    return targetUtils;
}

-(void) showEasterToastMsg:(NSString *)text view:(UIView *)view{
    if (_Easter_process==nil) {
        _Easter_process = [[EasterProgressHUD alloc] initWithView:view];
    }
    [view addSubview:_Easter_process];
    _Easter_process.labelText = text;
    _Easter_process.labelFont=[UIFont systemFontOfSize:11];
    _Easter_process.mode = EasterProgressHUDModeCustomView;
    _Easter_process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_Easter_process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [_Easter_process removeFromSuperview];
    }];
    
    
}


-(void)setEasterUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token{
    self.Easter_username = [[NSString alloc] initWithFormat:@"%@", username];
    self.Easter_userid = [[NSString alloc] initWithFormat:@"%@", userid];
    self.Easter_password = [[NSString alloc] initWithFormat:@"%@", password];
    self.Easter_token = [[NSString alloc] initWithFormat:@"%@", token];
}

-(NSString *)getEasterUserId{
    if(self.Easter_userid != NULL){
        return self.Easter_userid;
    }else{
        return NULL;
    }
}

-(NSString *)getChannelUserId{
    if(self.Easter_channel_userid != NULL){
        return self.Easter_channel_userid;
    }else{
        return NULL;
    }
}

-(NSString *)getEasterNetIsp{
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

-(NSString *)getEasterNetworktype{
    EasterReachability *reachability   = [EasterReachability reachabilityWithHostName:@"www.apple.com"];
    EasterNetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"wifi";
    switch (internetStatus) {
        case EasterReachableViaWiFi:
            net = @"wifi";
            break;
            
        case EasterReachableViaWWAN:
            net = @"3G/4G";
            break;
            
        case EasterNotReachable:
            net = @"notReachable";
            
        default:
            net = @"unknown";
            break;
    }
    
    return net;
}


-(NSString *)getEasterSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

-(NSString*)getEasterIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

-(NSString*)getEasterIdfv{
    if([self readKeychainValue:Easter_KEYCHAIN_IDFV] == NULL){
        [self saveKeychainValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] key:Easter_KEYCHAIN_IDFV];
        return [self readKeychainValue:Easter_KEYCHAIN_IDFV];
    }else{
        return [self readKeychainValue:Easter_KEYCHAIN_IDFV];
    }
}

-(NSString *)getEasterUUID{
    if([self readKeychainValue:Easter_KEYCHAIN_UUID] == NULL){
        [self saveKeychainValue:[[NSUUID UUID] UUIDString] key:Easter_KEYCHAIN_UUID];
        return [self readKeychainValue:Easter_KEYCHAIN_UUID];
    }else{
        return [self readKeychainValue:Easter_KEYCHAIN_UUID];
    }
}

-(NSString*)getEasterInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"apple_INSTALL_FLAG_%@", [self getEasterBundleId]];
    NSLog(@"TAG = %@", TAG);
    if([self readKeychainValue:TAG] == NULL){
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [self readKeychainValue:TAG]);
        return [self readKeychainValue:TAG];
    }
}

-(NSString *)getEasterMac{
    return @"";
}

-(NSString *)getEasterPhoneUserName{
    return [[UIDevice currentDevice] name];
}//获取手机别名


-(NSString *)getEasterDeviceName{
    return [[UIDevice currentDevice] systemName];
}//获取设备名称

-(NSString *)getEasterDeviceModel{
    // 需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return platform;
    //return [[UIDevice currentDevice] model];
}//获取手机型号

-(NSString *)getEasterLocalPhoneModel{
    return [[UIDevice currentDevice] localizedModel];
}//获取地方型号（国际化区域名称）

-(NSString *)getEasterBundleId{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

-(NSString *)getEasterAppName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

-(NSString *)getEasterAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

-(NSString *)getEasterAppBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

-(NSString *)getEasterVersion{
    return Easter_SDK_VERSION;
}

-(NSString *)getEasterChannelSdkVersion{
    return [[EasterBranch getSharedInstance] getEasterChannelSdkVersion];
}

-(NSString *)getEasterInfoPlist_PackageId{
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EasterParams"];
    
    return [dict objectForKey:@"Easter_GamePackageID"];
}

-(Boolean)getEasterInfoPlist_Landscape{
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EasterParams"];
    
    if([[dict objectForKey:@"Easter_Landscape"] boolValue] == YES){
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


-(NSString *)Easter_md5:(NSString *)str{
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

-(void) sendHttpRequest:(NSDictionary *)httpParams toEasterServer:(NSString *)requestPath responseHandler:(EasterRequestCallback)handler showProgess:(Boolean)showprogress
{
    
    NSLog(@"%@ dic = %@", requestPath, httpParams);
    EasterProgressHUD* progressHUD = nil;

    
    if (showprogress)
    {
        UIView* view = [[EasterBranch getSharedInstance] getEasterCurrentView];
        if (view)
        {
            
            progressHUD = [EasterProgressHUD showHUDAddedTo:view animated:YES];
        }
    }
    
    NSString *cc = [NSString stringWithFormat:@"%@%@%@", Easter_SERVER_URL1,Easter_SERVER_URL2, Easter_SERVER_URL3];
    
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

-(NSString *)getEasterSecret{
    NSString *sec = [NSString stringWithFormat:@"%@%@%@", Easter_APP_SECRET1, Easter_APP_SECRET2, Easter_APP_SECRET3];
    return sec;
}

-(void)postEasterActiveData{
    
    
    if([[self getEasterInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postEasterActiveData");
        return;
    }else{
        NSLog(@"never postEasterActiveData");
    }

    
    
    NSString *unsignStr = [[NSString alloc] initWithFormat:@"device_name=%@&idfa=%@&idfv=%@&imei=&mac=%@&package_id=%@&platform=1&uuid=%@&version=%@%@", [self getEasterDeviceModel], [self getEasterIdfa], [self getEasterIdfv], [self getEasterMac], [self getEasterInfoPlist_PackageId], [self getEasterUUID], [self getEasterSystemVersion], [self getEasterSecret]];
   // NSLog(@"unsignStr = %@", unsignStr);
    NSString *sign = [self Easter_md5:unsignStr];
    NSLog(@"sign = %@", sign);
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [data setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [data setValue:[self getEasterIdfa] forKey:@"idfa"];
    [data setValue:[self getEasterIdfv] forKey:@"idfv"];
    [data setValue:[self getEasterUUID] forKey:@"uuid"];
    [data setValue:@"" forKey:@"imei"];
    [data setValue:[self getEasterMac] forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:[self getEasterSystemVersion] forKey:@"version"];
    [data setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [data setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [data setValue:[self getEasterAppName] forKey:@"app_name"];
    [data setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [data setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    [data setValue:[self getEasterVersion] forKey:ssss];
    [data setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [data setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [data setValue:[self getEasterNetworktype] forKey:@"net_status"];
    [data setValue:sign forKey:@"sign"];
    
    [self sendHttpRequest:data toEasterServer:@"/api/client/active" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        if (err)
        {
            NSLog(@"postEasterActiveData Error: %@", err);
        }
        else
        {
            
            NSDictionary*  json= (NSDictionary*)data;
            NSLog(@"postEasterActiveData: %@", json);
            NSString *TAG = [[NSString alloc] initWithFormat:@"apple_INSTALL_FLAG_%@", [self getEasterBundleId]];
            [self saveKeychainValue:@"installed" key:TAG];
        }

        

    } showProgess:NO];

}

-(void)sendEasterHeartData{
    
    
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
           // NSString *str = [NSString stringWithFormat:@"%@%@%@", Easter_APP_SECRET1, Easter_APP_SECRET2, Easter_APP_SECRET3];
            NSString *unsignStr = [[NSString alloc] initWithFormat:@"package_id=%@&user_id=%@%@", [self getEasterInfoPlist_PackageId], [self getEasterUserId], [self getEasterSecret]];
            NSString *sign = [self Easter_md5:unsignStr];
            
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            [dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
            [dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
            [dic setValue:self.Easter_userid forKey:@"user_id"];
            [dic setValue:sign forKey:@"sign"];
            
            [self sendHttpRequest:dic toEasterServer:@"/api/client/heart_log" responseHandler:^(NSURLResponse *response, id data, NSError *err){
                NSLog(@"heart_log : %@", (NSDictionary*)data);
            } showProgess:NO];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });


}


-(void)postEasterGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    //NSString *str = [NSString stringWithFormat:@"%@%@%@", Easter_APP_SECRET1, Easter_APP_SECRET2, Easter_APP_SECRET3];
    
    NSString *unsignStr = [[NSString alloc] initWithFormat:@"device_name=%@&idfa=%@&idfv=%@&imei=&mac=%@&package_id=%@&platform=1&role_create_time=%@&role_id=%@&role_level=%@&role_name=%@&server_id=%@&server_name=%@&user_id=%@&uuid=%@&version=%@%@", [self getEasterDeviceModel], [self getEasterIdfa], [self getEasterIdfv], [self getEasterMac], [self getEasterInfoPlist_PackageId], [data objectForKey:Easter_ROLE_CREATE_TIME], [data objectForKey:Easter_ROLE_ID], [data objectForKey:Easter_ROLE_LEVEL], [data objectForKey:Easter_ROLE_NAME], [data objectForKey:Easter_SERVER_ID], [data objectForKey:Easter_SERVER_NAME], [self getEasterUserId], [self getEasterUUID], [self getEasterSystemVersion], [self getEasterSecret]];
   // NSLog(@"unsignStr = %@", unsignStr);
    NSString *sign = [self Easter_md5:unsignStr];
    NSLog(@"sign = %@", sign);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [dic setValue:self.Easter_userid forKey:@"user_id"];
    
    [dic setValue:[data objectForKey:Easter_SERVER_ID] forKey:@"server_id"];
    [dic setValue:[data objectForKey:Easter_SERVER_NAME] forKey:@"server_name"];
    [dic setValue:[data objectForKey:Easter_ROLE_ID] forKey:@"role_id"];
    [dic setValue:[data objectForKey:Easter_ROLE_NAME] forKey:@"role_name"];
    [dic setValue:[data objectForKey:Easter_ROLE_LEVEL] forKey:@"role_level"];
    [dic setValue:[data objectForKey:Easter_ROLE_CREATE_TIME] forKey:@"role_create_time"];
    
    [dic setValue:[self getEasterIdfa] forKey:@"idfa"];
    [dic setValue:[self getEasterIdfv] forKey:@"idfv"];
    [dic setValue:[self getEasterUUID] forKey:@"uuid"];
    [dic setValue:@"" forKey:@"imei"];
    [dic setValue:[self getEasterMac] forKey:@"mac"];
    [dic setValue:@"1" forKey:@"platform"];
    [dic setValue:[self getEasterSystemVersion] forKey:@"version"];
    [dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [dic setValue:[self getEasterAppName] forKey:@"app_name"];
    [dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    
    [dic setValue:[self getEasterVersion] forKey:ssss];
    [dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
    [dic setValue:sign forKey:@"sign"];

    NSString *urlparam = nil;
    if([dataPoint isEqualToString:Easter_SUBMIT_CHOOSE_SERVER]){
        urlparam = @"/api/client/chooseserver";
    }else if([dataPoint isEqualToString:Easter_SUBMIT_CHOOSE_ROLE]){
        urlparam = @"/api/client/chooserole";
    }else if([dataPoint isEqualToString:Easter_SUBMIT_ROLE_CREATE]){
        urlparam = @"/api/client/create_role";
    }else if([dataPoint isEqualToString:Easter_SUBMIT_ROLE_ENTERSERVER]){
        urlparam = @"/api/client/game_login";
    }else if([dataPoint isEqualToString:Easter_SUBMIT_ROLE_LEVELUP]){
        urlparam = @"/api/client/levelup";
    }
    
    [self sendHttpRequest:dic toEasterServer:urlparam responseHandler:^(NSURLResponse *response, id data, NSError *err){
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

-(void)requestEasterNotice:(EasterRequestCallback)result{
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [data setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [data setValue:[self getEasterAppName] forKey:@"app_name"];
    [data setValue:[self getEasterSystemVersion] forKey:@"version"];
    [data setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [data setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [data setValue:[self getEasterVersion] forKey:ssss];
    [data setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    
    [self sendHttpRequest:data toEasterServer:@"/api/data/get_notice" responseHandler:result showProgess:YES];
}

-(void)requestEasterServerStatus:(EasterInitCallback)result{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [data setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [data setValue:[self getEasterAppName] forKey:@"app_name"];
    [data setValue:[self getEasterAppVersion] forKey:@"version"];
    [data setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [data setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [data setValue:[self getEasterVersion] forKey:ssss];
    [data setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    
    
    [self sendHttpRequest:data toEasterServer:@"/api/data/get_cp_channel" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        if (err)
        {
            // code=-2  msg=get server status failed serverid=null
            result(@{@"code":@"-2",@"msg":@"get server status failed 1!",@"serverid":@"", @"channel_id":@""});
            self.Easter_channel_id = @"";

        }
        else
        {
            if(data != nil){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"requestEasterServerStatus: %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    
                    // code=0   msg=init success  serverid=xxx
                    result(@{@"code":@"0",@"msg":@"init success!",@"serverid":[jsonFieldData objectForKey:@"cp_channel_id"], @"channel_id":[jsonFieldData objectForKey:@"channel_id"]});
                    self.Easter_channel_id = [jsonFieldData objectForKey:@"channel_id"];
                    
                }else{
                    result(@{@"code":@"-2",@"msg":[json objectForKey:@"message"],@"serverid":@"", @"channel_id":@""});
                    self.Easter_channel_id = @"";
                }
            }else{
                
                result(@{@"code":@"-1000",@"msg":@"data from server is null",@"serverid":@"", @"channel_id":@""});
                self.Easter_channel_id = @"";
            }
        }
        
    } showProgess:YES];
}

-(void)getEasterLoginAccessToken:(NSDictionary *)dic result:(EasterRequestCallback)result{
    
    NSString* channel_extends =[NSString stringWithFormat:@"{\"channel_uid\":\"%@\",\"channel_username\":\"%@\",\"channel_token\":\"%@\",\"channel_deviceid\":\"%@\"}",[dic objectForKey:@"channel_uid"],[dic objectForKey:@"channel_username"],[dic objectForKey:@"channel_token"],[dic objectForKey:@"channel_deviceid"]];
    
    //NSString *str = [NSString stringWithFormat:@"%@%@%@", Easter_APP_SECRET1, Easter_APP_SECRET2, Easter_APP_SECRET3];

    NSString *getAccesstokenToken_unsignStr = [[NSString alloc] initWithFormat:@"channel_extends=%@&device_name=%@&idfa=%@&idfv=%@&imei=&mac=%@&package_id=%@&platform=1&uuid=%@&version=%@%@", channel_extends, [self getEasterDeviceModel], [self getEasterIdfa], [self getEasterIdfv], [self getEasterMac], [self getEasterInfoPlist_PackageId], [self getEasterUUID], [self getEasterSystemVersion], [self getEasterSecret]];
    //NSLog(@"getAccesstokenToken_unsignStr = %@", getAccesstokenToken_unsignStr);
    NSString *sign = [self Easter_md5:getAccesstokenToken_unsignStr];
    NSLog(@"getAccesstokenToken_sign = %@", sign);
    
    NSMutableDictionary *token_dic = [NSMutableDictionary dictionary];
    [token_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [token_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [token_dic setValue:channel_extends forKey:@"channel_extends"];
    [token_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
    [token_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
    [token_dic setValue:[self getEasterUUID] forKey:@"uuid"];
    [token_dic setValue:@"" forKey:@"imei"];
    [token_dic setValue:[self getEasterMac] forKey:@"mac"];
    [token_dic setValue:@"1" forKey:@"platform"];
    [token_dic setValue:[self getEasterSystemVersion] forKey:@"version"];
    [token_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [token_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [token_dic setValue:[self getEasterAppName] forKey:@"app_name"];
    [token_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [token_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [token_dic setValue:[self getEasterVersion] forKey:ssss];
    [token_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [token_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [token_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
    [token_dic setValue:sign forKey:@"sign"];
    
    [self sendHttpRequest:token_dic toEasterServer:@"/api/oauth/access_token" responseHandler:result showProgess:YES];
}


-(void)getEasterLoginInfo:(NSDictionary *)dic result:(EasterLoginCallback)result{
    
    [self getEasterLoginAccessToken:dic result:^(NSURLResponse *response, id data, NSError *err){
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
                    if([self.Easter_channel_id intValue] == 18){
                        if([[json objectForKey:@"code"] intValue] == 500003){
                            //您当日累计在线游戏时间已经达到3小时，请绑定身份证信息
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                                [[EasterBranch getSharedInstance] doEasterChannelRealNameRegister:1 callback:^(NSString *res){
                                    
                                }];
                            }];
                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                            }];
                            [alert addAction:defaultAction];
                            [alert addAction:cancelAction];
                            [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        }else if([[json objectForKey:@"code"] intValue] == 500004){
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    
                            }];
                            [alert addAction:defaultAction];
                            [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        }else if([[json objectForKey:@"code"] intValue] == 500005){
                            //您当日累计在线游戏时间没达到3小时，请绑定身份证信息
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"实名认证提醒" message:[json objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                                [[EasterBranch getSharedInstance] doEasterChannelRealNameRegister:1 callback:^(NSString *res){
                                    
                                }];
                            }];
                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                //响应事件
                            }];
                            [alert addAction:defaultAction];
                            [alert addAction:cancelAction];
                            [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    
                    
                    NSMutableDictionary *userinfo_dic = [NSMutableDictionary dictionary];
                    [userinfo_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
                    [userinfo_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
                    [userinfo_dic setValue:[jsonFieldData objectForKey:@"access_token"] forKey:@"access_token"];
                    [userinfo_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
                    [userinfo_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
                    [userinfo_dic setValue:[self getEasterUUID] forKey:@"uuid"];
                    [userinfo_dic setValue:@"" forKey:@"imei"];
                    [userinfo_dic setValue:[self getEasterMac] forKey:@"mac"];
                    [userinfo_dic setValue:@"1" forKey:@"platform"];
                    [userinfo_dic setValue:[self getEasterSystemVersion] forKey:@"version"];
                    [userinfo_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
                    [userinfo_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
                    [userinfo_dic setValue:[self getEasterAppName] forKey:@"app_name"];
                    [userinfo_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
                    [userinfo_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
                    
                    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
                    [userinfo_dic setValue:[self getEasterVersion] forKey:ssss];
                    [userinfo_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
                    [userinfo_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
                    [userinfo_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
                    [self sendHttpRequest:userinfo_dic toEasterServer:@"/api/oauth/user_info" responseHandler:^(NSURLResponse *response, id data, NSError *err){
                        
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
                                    
                                    [self setEasterUserInfo:[jsonFieldData1 objectForKey:@"username"] userid:[jsonFieldData1 objectForKey:@"id"] password:nil token:[jsonFieldData objectForKey:@"access_token"]];
                                    
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
//                        [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                        [[EasterUtils getSharedInstance] showEasterToastMsg:[json objectForKey:@"message"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
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


-(void)checkUserAccess:(NSDictionary *)userinfo loginCallback:(EasterLoginCallback)loginCallback{
    NSMutableDictionary *access_dic = [NSMutableDictionary dictionary];
    [access_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [access_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [access_dic setValue:[userinfo objectForKey:@"id"] forKey:@"user_id"];
    [access_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
    [access_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
    [access_dic setValue:[self getEasterUUID] forKey:@"uuid"];
    [access_dic setValue:@"" forKey:@"imei"];
    [access_dic setValue:[self getEasterMac] forKey:@"mac"];
    [access_dic setValue:@"1" forKey:@"platform"];
    [access_dic setValue:[self getEasterAppVersion] forKey:@"version"];
    [access_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [access_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [access_dic setValue:[self getEasterAppName] forKey:@"app_name"];
    [access_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [access_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [access_dic setValue:[self getEasterVersion] forKey:ssss];
    [access_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [access_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [access_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
    [self sendHttpRequest:access_dic toEasterServer:@"/api/data/allow_login" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        
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
                        self.Easter_channel_userid = [[NSString alloc] initWithFormat:@"%@", [userinfo objectForKey:@"channel_uid"]];
                        
                        NSString *ssss1 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_userid"];
                        NSString *ssss2 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_token"];
                        NSString *ssss3 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_username"];
                        NSString *ssss4 = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_nickname"];
                        loginCallback(@{@"code":@"0",
                                        @"msg":@"login success",
                                        ssss1:[userinfo objectForKey:@"id"],
                                        ssss2:self.Easter_token,
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

-(void)doEasterLogout:(EasterLogoutCallback)result{
    
    NSMutableDictionary *logout_dic = [NSMutableDictionary dictionary];
    [logout_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [logout_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uh", @"e_userid"];
    [logout_dic setValue:[self getEasterUserId] forKey:ssss];
    [logout_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
    [logout_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
    [logout_dic setValue:[self getEasterUUID] forKey:@"uuid"];
    [logout_dic setValue:@"" forKey:@"imei"];
    [logout_dic setValue:[self getEasterMac] forKey:@"mac"];
    [logout_dic setValue:@"1" forKey:@"platform"];
    [logout_dic setValue:[self getEasterSystemVersion] forKey:@"version"];
    [logout_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [logout_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [logout_dic setValue:[self getEasterAppName] forKey:@"app_name"];
    [logout_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [logout_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss1 = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [logout_dic setValue:[self getEasterVersion] forKey:ssss1];
    [logout_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [logout_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [logout_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
    [self sendHttpRequest:logout_dic toEasterServer:@"/api/oauth/logout" responseHandler:^(NSURLResponse *response, id data, NSError *err){
        
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


-(void)doEasterCreateOder:(NSDictionary *)param buildEasterodcb:(EasterCreateOderCallback)buildEasterodcb{
    [self getEasterAibbeEasterCar:^(NSURLResponse *response, id data, NSError *err){
        
        if (err)
        {
            NSLog(@"/api/data/get_ Error: %@", err);
            
            buildEasterodcb(@{@"code":@"-1",@"msg":@"sdk get type failed"});
        }
        else
        {
            
            if(data != NULL){
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"/api/data/get_ : %@", json);
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    
                    NSMutableDictionary *buildEasterodcb_dic = [NSMutableDictionary dictionary];
                    [buildEasterodcb_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
                    [buildEasterodcb_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
                    [buildEasterodcb_dic setValue:[self getEasterUserId] forKey:@"user_id"];
                    [buildEasterodcb_dic setValue:self.Easter_channel_userid forKey:@"channel_userid"];
                    [buildEasterodcb_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
                    [buildEasterodcb_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
                    [buildEasterodcb_dic setValue:[self getEasterUUID] forKey:@"uuid"];
                    [buildEasterodcb_dic setValue:@"" forKey:@"imei"];
                    [buildEasterodcb_dic setValue:[self getEasterMac] forKey:@"mac"];
                    [buildEasterodcb_dic setValue:@"1" forKey:@"platform"];
                    [buildEasterodcb_dic setValue:[self getEasterSystemVersion] forKey:@"version"];
                    [buildEasterodcb_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
                    [buildEasterodcb_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
                    [buildEasterodcb_dic setValue:[self getEasterAppName] forKey:@"app_name"];
                    [buildEasterodcb_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
                    [buildEasterodcb_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
                    
                    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
                    [buildEasterodcb_dic setValue:[self getEasterVersion] forKey:ssss];
                    [buildEasterodcb_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
                    [buildEasterodcb_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
                    [buildEasterodcb_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
                    
                    NSString *a = [[NSString alloc] initWithFormat:@"cp_o%@", @"rder_id"];
                    
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_CP_ORDERID] forKey:a];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_PRODUCT_PRICE] forKey:@"money"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_PRODUCT_NAME] forKey:@"unix_name"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_PRODUCT_ID] forKey:@"product_id"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_GOODS_NUM] forKey:@"product_num"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_PRODUCT_DESC] forKey:@"product_desc"];
                    if([param objectForKey:Easter_IOS_EXTRA] == NULL){
                        [buildEasterodcb_dic setValue:@"" forKey:@"extends"];
                    }else{
                        [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_EXTRA] forKey:@"extends"];
                    }
                    
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_ROLE_ID] forKey:@"role_id"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_ROLE_NAME] forKey:@"role_name"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_ROLE_LEVEL] forKey:@"role_level"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_SERVER_ID] forKey:@"server_id"];
                    [buildEasterodcb_dic setValue:[param objectForKey:Easter_IOS_SERVER_NAME] forKey:@"server_name"];
                    
                    NSString *b = [[NSString alloc] initWithFormat:@"/api/o%@", @"rder/create"];
                    [self sendHttpRequest:buildEasterodcb_dic toEasterServer:b responseHandler:^(NSURLResponse *res, id resdata, NSError *reserr){
                        if(reserr){
                            buildEasterodcb(@{@"code":@"-2",@"msg":@"sdk create oder failed"});
                        }else{
                            
                            if(resdata != NULL){
                                NSDictionary *createoder_res = (NSDictionary*)resdata;
                                NSLog(@"/api/oder/create : %@", createoder_res);
                                if([[createoder_res objectForKey:@"success"] integerValue] == 1){
                                    if([self.Easter_channel_id intValue] == 18){
                                        if([[createoder_res objectForKey:@"code"] intValue] == 500003){
                                            
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[createoder_res objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [[EasterBranch getSharedInstance] doEasterChannelRealNameRegister:2 callback:^(NSString *res){
                                                    [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                                }];
                                                
                                                
                                            }];
                                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                            }];
                                            [alert addAction:defaultAction];
                                            [alert addAction:cancelAction];
                                            [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                                        }else if([[createoder_res objectForKey:@"code"] intValue] == 500004){
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[createoder_res objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                            }];
                                            [alert addAction:defaultAction];
                                            [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                                        }else if([[createoder_res objectForKey:@"code"] intValue] == 500005){
                                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"实名认证提醒" message:[createoder_res objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"实名认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [[EasterBranch getSharedInstance] doEasterChannelRealNameRegister:2 callback:^(NSString *res){
                                                    [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                                }];
                                                
                                                
                                            }];
                                            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                //响应事件
                                                [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                            }];
                                            [alert addAction:defaultAction];
                                            [alert addAction:cancelAction];
                                            [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
                                        }else{
                                            [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                        }
                                    }else{
                                        [self EasterContinueRegcharg:createoder_res param:param jsonFieldData:jsonFieldData buildEasterodcb:buildEasterodcb];
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }else{
                                    buildEasterodcb(@{@"code":[createoder_res objectForKey:@"code"],@"msg":[createoder_res objectForKey:@"message"]});

                                }
                            }else{
                                buildEasterodcb(@{@"code":@"-1000",@"msg":@"data from server is null"});
                            }
                        }
                    } showProgess:YES];
                    

                    
                }else{
                    buildEasterodcb(@{@"code":@"-1",@"msg":[json objectForKey:@"message"]});
                    
                }
            }else{
                buildEasterodcb(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
    }];
}

-(void)EasterContinueRegcharg:(NSDictionary *)createoder_res
                            param:(NSDictionary *)param
                            jsonFieldData:(NSDictionary *)jsonFieldData
            buildEasterodcb:(EasterCreateOderCallback)buildEasterodcb{
    NSDictionary* createoder_data = [createoder_res valueForKey:@"data"];
    
    //创建订单成功，获取到订单号，下一步：获取真实商品id
    NSMutableDictionary *product_dic = [NSMutableDictionary dictionary];
    [product_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [product_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [product_dic setValue:[param objectForKey:Easter_IOS_PRODUCT_ID] forKey:@"zgipakm"];
    [self sendHttpRequest:product_dic toEasterServer:@"/api/data/zgipakm" responseHandler:^(NSURLResponse *res1, id resdata1, NSError *reserr1){
        if(reserr1){
            buildEasterodcb(@{@"code":@"-3",@"msg":@"ssss sdk get productid failed"});
            
        }else{
            if(resdata1 != NULL){
                NSDictionary *product_res = (NSDictionary*)resdata1;
                NSLog(@"/api/data/zgipakm : %@", product_res);
                if([[product_res objectForKey:@"success"] integerValue] == 1){
                    
                    NSString *c = [[NSString alloc] initWithFormat:@"o%@", @"rder_id"];
                    NSString *d = [NSString stringWithFormat:@"%@%@%@", @"xia", @"om", @"imi"];
                    buildEasterodcb(@{@"code":@"0",
                                   @"msg":@"create oder success",
                                   @"oder_id":[createoder_data objectForKey:c],
                                   @"AibbeEasterCar":[jsonFieldData objectForKey:@"wwlhxh"],
                                   @"AibbeEasterBBS":[jsonFieldData objectForKey:@"wwlhxhName"],
                                   @"product_id":[product_res objectForKey:@"data"],
                                   @"BusForEasterMiss":[createoder_data objectForKey:d]
                                   });
                }else{
                    buildEasterodcb(@{@"code":@"-3",@"msg":[product_res objectForKey:@"message"]});
                    
                }
            }else{
                buildEasterodcb(@{@"code":@"-1000",@"msg":@"data from server is null"});
            }
        }
    } showProgess:YES];
}

-(void)getEasterAibbeEasterCar:(EasterRequestCallback)callBack{
    NSMutableDictionary *RegcgEasterLeiXing_dic = [NSMutableDictionary dictionary];
    [RegcgEasterLeiXing_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterUserId] forKey:@"user_id"];
    [RegcgEasterLeiXing_dic setValue:self.Easter_channel_userid forKey:@"channel_userid"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterUUID] forKey:@"uuid"];
    [RegcgEasterLeiXing_dic setValue:@"" forKey:@"imei"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterMac] forKey:@"mac"];
    [RegcgEasterLeiXing_dic setValue:@"1" forKey:@"platform"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterAppVersion] forKey:@"version"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterAppName] forKey:@"app_name"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterVersion] forKey:ssss];
    [RegcgEasterLeiXing_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [RegcgEasterLeiXing_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
    
    [self sendHttpRequest:RegcgEasterLeiXing_dic toEasterServer:@"/api/data/get_wwlhxh" responseHandler:callBack showProgess:YES];
}

-(void)doEasterCheckUpdate:(EasterCheckUpdateCallback)result{
    NSMutableDictionary *checkupdate_dic = [NSMutableDictionary dictionary];
    [checkupdate_dic setValue:[self getEasterInfoPlist_PackageId] forKey:@"package_id"];
    [checkupdate_dic setValue:[self getEasterBundleId] forKey:@"bundleid"];
    [checkupdate_dic setValue:[self getEasterAppVersion] forKey:@"version"];
    [checkupdate_dic setValue:[self getEasterIdfa] forKey:@"idfa"];
    [checkupdate_dic setValue:[self getEasterIdfv] forKey:@"idfv"];
    [checkupdate_dic setValue:[self getEasterUUID] forKey:@"uuid"];
    [checkupdate_dic setValue:@"" forKey:@"imei"];
    [checkupdate_dic setValue:[self getEasterMac] forKey:@"mac"];
    [checkupdate_dic setValue:@"1" forKey:@"platform"];
    [checkupdate_dic setValue:[self getEasterDeviceModel] forKey:@"device_name"];
    [checkupdate_dic setValue:[self getEasterPhoneUserName] forKey:@"device_user_name"];
    [checkupdate_dic setValue:[self getEasterAppName] forKey:@"app_name"];
    [checkupdate_dic setValue:[self getEasterAppVersion] forKey:@"app_version"];
    [checkupdate_dic setValue:[self getEasterAppBuildVersion] forKey:@"app_build_version"];
    
    NSString *ssss = [[NSString alloc] initWithFormat:@"j%@%@", @"uhes", @"dk_version"];
    [checkupdate_dic setValue:[self getEasterVersion] forKey:ssss];
    [checkupdate_dic setValue:[self getEasterChannelSdkVersion] forKey:@"channel_version"];
    [checkupdate_dic setValue:[self getEasterNetIsp] forKey:@"net_isp"];
    [checkupdate_dic setValue:[self getEasterNetworktype] forKey:@"net_status"];
    
    [self sendHttpRequest:checkupdate_dic toEasterServer:@"/api/data/force_update" responseHandler:^(NSURLResponse *res, id resdata, NSError *reserr){
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

-(void)doEasterPostAction:(NSDictionary *)httpParams toEasterServer:(NSString *)requestPath responseHandler:(EasterRequestCallback)handler showProgess:(Boolean)showprogress{
    [self sendHttpRequest:httpParams toEasterServer:requestPath responseHandler:handler showProgess:showprogress];
}
@end

