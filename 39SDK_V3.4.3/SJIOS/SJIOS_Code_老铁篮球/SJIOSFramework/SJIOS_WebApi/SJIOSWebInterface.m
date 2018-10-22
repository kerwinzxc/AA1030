
#import "SJIOSWebInterface.h"
#import "SJIOSWebApi.h"
#import "SJIOSSdkImp.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSProgressHUD.h"

#pragma mark private method

#define SJIOS_SERVER_API_URL1 @"https://www.3"  //release
#define SJIOS_SERVER_API_URL2 @"9sdk.com/"  //release

//#define SJIOS_SERVER_API_URL1 @"https://sdk.3"  //sandbox
//#define SJIOS_SERVER_API_URL2 @"9sdk.com/"  //sandbox

#define SJIOS_AD_SERVER_API_URL1 @"https://newapi.3"
#define SJIOS_AD_SERVER_API_URL2 @"975ad.com/game/index/index/"

#define SJIOS_SMRZ_URL1 @"https://ju"
#define SJIOS_SMRZ_URL2 @"hes"
#define SJIOS_SMRZ_URL3 @"dk.3"
#define SJIOS_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

//#define SJIOS_SMRZ_URL1 @"https://sandbox."
//#define SJIOS_SMRZ_URL2 @"juhe."
//#define SJIOS_SMRZ_URL3 @"3"
//#define SJIOS_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

@implementation SJIOSWebInterface

+(SJIOSWebInterface*)sharedInstance
{
    static __strong SJIOSWebInterface * g_SJIOSSdkImp = nil;
    if (g_SJIOSSdkImp == nil)
    {
        g_SJIOSSdkImp = [SJIOSWebInterface alloc];
    }
    
    return g_SJIOSSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", SJIOS_SERVER_API_URL1, SJIOS_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlSJIOSWithController:(NSString *)controller andSJIOSParamDictionary:(NSDictionary *)paramDictionary
{
    
    self.realSJIOSURL = [[NSString alloc] initWithFormat:@"%@", [self validateUrl]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.realSJIOSURL, controller];
    NSURL *url = [NSURL URLWithString:urlString];
    
    for (NSString *key in paramDictionary)
    {
        url = [url appendQueryKey:key andValue:[NSString stringWithFormat:@"%@", [paramDictionary valueForKey:key]]];
    }
    
    return url;
}




//手机是否注册过
-(void)checkSJIOSPhoneRegist:(NSString*)phoneSJIOS
        successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
            failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/checkphoneregister" andSJIOSParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getSJIOSIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString * client_id = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneSJIOS forKey:@"phone"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];

}

//手机注册接口
-(void)phoneSJIOSRegist:(NSString*)phoneSJIOS
          passwordSJIOS:(NSString*)passwordSJIOS
        verifyCodeSJIOS:(NSString*)verifyCodeSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/phoneregister" andSJIOSParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getSJIOSIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString * client_id = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,passwordSJIOS,phoneSJIOS,verifyCodeSJIOS];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneSJIOS forKey:@"phone"];
    [bodyDictionary setValue:verifyCodeSJIOS forKey:@"token"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}

//手机注册发送验证码接口
-(void)phoneSJIOSRegistVerify:(NSString*)phoneSJIOS
         successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
             failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/fastregisterphone" andSJIOSParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getSJIOSIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phoneSJIOS forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];

    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
    
}


//手机登录接口
-(void)phoneSJIOSLogin:(NSString*)phoneSJIOS
         passwordSJIOS:(NSString*)passwordSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/phonelogin" andSJIOSParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getSJIOSIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString * client_id = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,passwordSJIOS,phoneSJIOS];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneSJIOS forKey:@"phone"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}


-(void)checkSJIOSUpdate:(NSString*)client_idSJIOS
          bundleIdSJIOS:(NSString*)bundleIdSJIOS
           versionSJIOS:(NSString*)versionSJIOS
            deviceSJIOS:(NSString*)deviceSJIOS
        sourceCodeSJIOS:(NSString*)sourceCodeSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"update/check_update" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_idSJIOS forKey:@"client_id"];
    [bodyDictionary setValue:bundleIdSJIOS forKey:@"bundleId"];
    [bodyDictionary setValue:versionSJIOS forKey:@"version"];
    [bodyDictionary setValue:deviceSJIOS forKey:@"device"];
    [bodyDictionary setValue:sourceCodeSJIOS forKey:@"sourceCode"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];

}

- (void)SJIOSinstall:(NSString*)appIdSJIOS
   imeiOfDeviceSJIOS:(NSString*)imeiSJIOS
        channelSJIOS:(NSString*)channelSJIOS
          modelSJIOS:(NSString*)modelSJIOS
             osSJIOS:(NSString*)osSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
    failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"data/install" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdSJIOS forKey:@"app_id"];
    [bodyDictionary setValue:imeiSJIOS forKey:@"imei"];
    [bodyDictionary setValue:imeiSJIOS forKey:@"idfa"];
    [bodyDictionary setValue:channelSJIOS forKey:@"channel"];
    [bodyDictionary setValue:modelSJIOS forKey:@"model"];
    [bodyDictionary setValue:osSJIOS forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}

- (void)SJIOSsendHeart:(NSString*)userid
{
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
            NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"data/heart" andSJIOSParamDictionary:nil];
            
            NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
            [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];
            [bodyDictionary setValue:userid forKey:@"user_id"];
            [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
            
            [SJIOSWebApi requestPostSJIOSUrl:url
                           bodyDictionarySJIOS:bodyDictionary
                          successCallbackSJIOS:^(NSDictionary *dictionary, NSDictionary *headers){
                              NSLog(@"SJIOSsendHeart dictionary : %@", dictionary);
                          }
                              failCallbackSJIOS:^(NSError * error) {
                                  
                              }];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });
    
    
    
}

- (void)getSJIOSAntiFlag:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    
    NSString  *str = [NSString stringWithFormat:@"%@%@%@%@%@",SJIOS_SMRZ_URL1, SJIOS_SMRZ_URL2,SJIOS_SMRZ_URL3,SJIOS_SMRZ_URL4, [[SJIOSSdkImp sharedInstance] getSJIOSPackageId]];
    NSURL *url = [NSURL URLWithString:str];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
                   bodyDictionarySJIOS:nil
                  successCallbackSJIOS:successCallbackSJIOS
                      failCallbackSJIOS:failCallbackSJIOS];
}


- (void)newadSJIOSinstall:dataEncodeSJIOS
                signSJIOS:signSJIOS
     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", SJIOS_AD_SERVER_API_URL1, SJIOS_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncodeSJIOS forKey:@"data"];
    [bodyDictionary setValue:signSJIOS forKey:@"sign"];
    
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}


-(void)bindSJIOSRegister:(NSString*) usernameSJIOS
           passwordSJIOS:(NSString*)passwordSJIOS
       bindUsernameSJIOS:(NSString*) bindUsernameSJIOS
    successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
        failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/bind_username" andSJIOSParamDictionary:nil];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, passwordSJIOS, usernameSJIOS, clientId, bindUsernameSJIOS];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:usernameSJIOS forKey:@"bind_username"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
    
}
- (void)normalSJIOSRegister:(NSString*)usernameSJIOS
              passwordSJIOS:(NSString*)passwordSJIOS
       successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
           failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/register" andSJIOSParamDictionary:nil];
    
    NSString * imei = [SJIOSSdkImp getSJIOSIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] getSJIOSVersion];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordSJIOS, usernameSJIOS];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}

- (void)fastSJIOSRegisterSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/fast_register_v04" andSJIOSParamDictionary:nil];
    NSString * imei = [[SJIOSSdkImp sharedInstance] getSJIOSImei];
    NSString * channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] getSJIOSVersion];
     NSString *idfa=[SJIOSSdkImp getSJIOSIdfa];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@idfa%@imei%@",
                          privateKey, channel, clientId, idfa,imei];
      NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
     [bodyDictionary setValue:idfa forKey:@"idfa"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}



- (void)loginSJIOS:(NSString*)usernameSJIOS
     passwordSJIOS:(NSString*)passwordSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/login" andSJIOSParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getSJIOSIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] getSJIOSVersion];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordSJIOS, usernameSJIOS];
     NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}

-(void) getSJIOSAccessTokenSJIOS:(NSString *)codeSJIOS
       successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
           failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/token" andSJIOSParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:codeSJIOS forKey:@"code"];
    [bodyDictionary setValue:SJIOS_SDK_VERSION forKey:@"version"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                     failCallbackSJIOS:failCallbackSJIOS];
}

-(void) getSJIOSUserId:(NSString *)accesstokenSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/me" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstokenSJIOS forKey:@"access_token"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];

}

-(void)checkPSJIOSyTypeUrl:(SJIOS_VSD_BLOCK)successCallbackSJIOS
             failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:a andSJIOSParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}

-(void)SJIOSSdkSJIOSCheck:(NSString *)orSJIOSderId
         descriptionSJIOS:(NSString *)descriptionSJIOS
     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:a andSJIOSParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orSJIOSderId forKey:@"orderid"];
    [bodyDictionary setValue:descriptionSJIOS forKey:@"description"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}

- (void)logoutSJIOS:(NSString*)usernameSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
   failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"oauth2/logout" andSJIOSParamDictionary:nil];
    
    NSString * clientId = [[SJIOSSdkImp sharedInstance] getSJIOSAppKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] getSJIOSAppPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] getSJIOSVersion];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, usernameSJIOS];
        NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}


- (void)createOrSJIOSder:(NSString*)accessTokenSJIOS
             userIdSJIOS:(NSString*)userIdSJIOS
        productNameSJIOS:(NSString*)productNameSJIOS
          productIdSJIOS:(NSString*)productIdSJIOS
            accountSJIOS:(NSInteger)accountSJIOS
         appOrderIdSJIOS:(NSString*)appOrderIdSJIOS
            appNameSJIOS:(NSString*)appNameSJIOS
           clientIdSJIOS:(NSString*)clientIdSJIOS
            gatewaySJIOS:(NSInteger)gatewaySJIOS
            channelSJIOS:(NSString*)channelSJIOS
          orderTypeSJIOS:(NSString*)orderTypeSJIOS
              extraSJIOS:(NSString*)extraSJIOS
             extendSJIOS:(NSString*)extendSJIOS
               signSJIOS:(NSString*)signSJIOS
    successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
        failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:a andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:userIdSJIOS forKey:@"user_id"];
    [bodyDictionary setValue:productNameSJIOS forKey:@"product_name"];
    [bodyDictionary setValue:productIdSJIOS forKey:@"product_id"];
    [bodyDictionary setValue:[[NSString alloc] initWithFormat:@"%ld", (long)accountSJIOS] forKey:@"account"];
    [bodyDictionary setValue:appOrderIdSJIOS forKey:@"app_order_id"];
    [bodyDictionary setValue:appNameSJIOS forKey:@"app_name"];
    [bodyDictionary setValue:clientIdSJIOS forKey:@"client_id"];
    [bodyDictionary setValue:[NSString stringWithFormat:@"%ld", (long)gatewaySJIOS] forKey:@"gateway"];
    [bodyDictionary setValue:channelSJIOS forKey:@"channel"];
    [bodyDictionary setValue:orderTypeSJIOS forKey:@"order_type"];
    [bodyDictionary setValue:extraSJIOS forKey:@"extra"];
    [bodyDictionary setValue:extendSJIOS forKey:@"extend"];
    [bodyDictionary setValue:signSJIOS forKey:@"sign"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"gamename"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [bodyDictionary setValue:SJIOS_SDK_VERSION forKey:@"version"];
    
    [bodyDictionary setValue:self.server_idSJIOS forKey:@"server_id"];
    [bodyDictionary setValue:self.role_idSJIOS forKey:@"role_id"];
    [bodyDictionary setValue:self.role_nameSJIOS forKey:@"role_name"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}

- (void)checkSJIOSMail:(NSString*)accessTokenSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/check_email" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}

- (void)bindSJIOSMail:(NSString*)accessTokenSJIOS
           emailSJIOS:(NSString*)emailSJIOS
 successSJIOSCallback:(SJIOS_VSD_BLOCK)successSJIOSCallback
     failSJIOSCallback:(SJIOS_VE_BLOCK)failSJIOSCallback
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/bind_email" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:emailSJIOS forKey:@"email"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successSJIOSCallback
            failCallbackSJIOS:failSJIOSCallback];
}


- (void)checkSJIOSPhone:(NSString*)accessTokenSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/check_phone" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}


-(void)bindSJIOSPhone:(NSString*)accessTokenSJIOS
            phoneSJIOS:(NSString*)phoneSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/bind_phone" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:phoneSJIOS forKey:@"phone"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}


- (void)checkSJIOSIdentify:(NSString*)accessTokenSJIOS
      successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
          failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/identity_check" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}

- (void)startSJIOSIdentify:(NSString*)accessTokenSJIOS
                 nameSJIOS:(NSString*)nameSJIOS
       identifyNumberSJIOS:(NSString*)identifyNumberSJIOS
      successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
          failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/identity" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:nameSJIOS forKey:@"name"];
    [bodyDictionary setValue:identifyNumberSJIOS forKey:@"identity"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"app_id"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}


- (void)confirmSJIOSPhone:(NSString*)accessTokenSJIOS
              verifySJIOS:(NSString*)verifySJIOS
     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/active_phone" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:verifySJIOS forKey:@"verify"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}


- (void)changeSJIOSPasswordByPhone:(NSString*)usernameSJIOS
              successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/cp_phone" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}
- (void)changeSJIOSPasswordByEmail:(NSString*)usernameSJIOS
              successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/cp_email" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}


- (void)confirmchangeSJIOSPasswordByPhone:(NSString*)usernameSJIOS
                            passwordSJIOS:(NSString*)passwordSJIOS
                              verifySJIOS:(NSString*)verifySJIOS
                     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/ccp_phone" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"password"];
    [bodyDictionary setValue:verifySJIOS forKey:@"verify"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
         bodyDictionarySJIOS:bodyDictionary
        successCallbackSJIOS:successCallbackSJIOS
            failCallbackSJIOS:failCallbackSJIOS];
}
- (void)confirmSJIOSChangePasswordByEmail:(NSString*)usernameSJIOS
                            passwordSJIOS:(NSString*)passwordSJIOS
                              verifySJIOS:(NSString*)verifySJIOS
                     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/ccp_email" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameSJIOS forKey:@"username"];
    [bodyDictionary setValue:passwordSJIOS forKey:@"password"];
    [bodyDictionary setValue:verifySJIOS forKey:@"verify"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}





-(void)getSJIOSHistoryUserNameByImei:(NSString *)imeiSJIOS
                           idfaSJIOS:(NSString *)idfaSJIOS
                successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                    failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/getHistoryUserNameByImei" andSJIOSParamDictionary:nil];
    NSMutableDictionary *bodyDictionar=[NSMutableDictionary dictionary];
    
    if([idfaSJIOS containsString:@"-"]){
        if([[idfaSJIOS stringByReplacingOccurrencesOfString:@"-" withString:@""] containsString:@"000000"]){
            [bodyDictionar setValue:imeiSJIOS forKey:@"imei"];
        }else{
            [bodyDictionar setValue:idfaSJIOS forKey:@"imei"];
        }
    }else{
        [bodyDictionar setValue:idfaSJIOS forKey:@"imei"];
    }
    
    [SJIOSWebApi requestPostSJIOSUrl:url bodyDictionarySJIOS:bodyDictionar successCallbackSJIOS:successCallbackSJIOS failCallbackSJIOS:failCallbackSJIOS];
    
}




-(void)changeSJIOSPasswordWithTokenSJIOS:(NSString *)accessTokenSJIOS
                   oldPasswordSJIOS:(NSString *)oldPasswordSJIOS
                   newPasswordSJIOS:(NSString *)newPasswordSJIOS
               successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                   failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS {
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"user/change_password" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenSJIOS forKey:@"access_token"];
    [bodyDictionary setValue:oldPasswordSJIOS forKey:@"old_password"];
    [bodyDictionary setValue:newPasswordSJIOS forKey:@"new_password"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}




-(void)getSJIOSSupport:(NSString *)appIdSJIOS
        onSuccessSJIOS:(SJIOS_VSD_BLOCK)successBlockSJIOS
         onFailedSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSURL *url = [[SJIOSWebInterface sharedInstance] getUrlSJIOSWithController:@"game/support" andSJIOSParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdSJIOS forKey:@"app_id"];
    [bodyDictionary setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:bodyDictionary
            successCallbackSJIOS:successBlockSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}
-(void)loadingSJIOS:(NSMutableDictionary*) paramSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
   failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS
{
    NSURL *url =[[SJIOSWebInterface sharedInstance]getUrlSJIOSWithController:@"data/loading" andSJIOSParamDictionary:nil];
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:paramSJIOS
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}



-(void)createSJIOS:(NSMutableDictionary*) paramSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    NSURL *url =[[SJIOSWebInterface sharedInstance]getUrlSJIOSWithController:@"data/create_role" andSJIOSParamDictionary:nil];
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:paramSJIOS
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];}






-(void)levelupSJIOS:(NSMutableDictionary*) paramSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
 failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS{
    
    self.server_idSJIOS = [[NSString alloc] initWithFormat:@"%@", [paramSJIOS objectForKey:@"server_id"]];
    self.role_idSJIOS = [[NSString alloc] initWithFormat:@"%@", [paramSJIOS objectForKey:@"role_id"]];
    self.role_nameSJIOS = [[NSString alloc] initWithFormat:@"%@", [paramSJIOS objectForKey:@"role_name"]];
    NSURL *url =[[SJIOSWebInterface sharedInstance]getUrlSJIOSWithController:@"data/level" andSJIOSParamDictionary:nil];
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:paramSJIOS
            successCallbackSJIOS:successCallbackSJIOS
                failCallbackSJIOS:failCallbackSJIOS];
}
-(void)erroSJIOS:(NSMutableDictionary*) param
successCallback:(SJIOS_VSD_BLOCK)successCallback
failCallback:(SJIOS_VE_BLOCK)failCallback{
    NSURL *url =[[SJIOSWebInterface sharedInstance]getUrlSJIOSWithController:@"data/error" andSJIOSParamDictionary:nil];
    [SJIOSWebApi requestPostSJIOSUrl:url
             bodyDictionarySJIOS:param
            successCallbackSJIOS:successCallback
                failCallbackSJIOS:failCallback];
}


@end
