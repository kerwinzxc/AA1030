
#import "QroughtWebInterface.h"
#import "QroughtWebApi.h"
#import "QroughtSdkImp.h"
#import "QroughtSdkMd5.h"
#import "QroughtProgressHUD.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"

#pragma mark private method

#define Qrought_SERVER_API_URL1 @"https://www.3"  //release
#define Qrought_SERVER_API_URL2 @"9sdk.com/"  //release

//#define Qrought_SERVER_API_URL1 @"https://sdk.3"  //sandbox
//#define Qrought_SERVER_API_URL2 @"9sdk.com/"  //sandbox

#define Qrought_AD_SERVER_API_URL1 @"https://newapi.3"
#define Qrought_AD_SERVER_API_URL2 @"975ad.com/game/index/index/"

#define Qrought_SMRZ_URL1 @"https://ju"
#define Qrought_SMRZ_URL2 @"hes"
#define Qrought_SMRZ_URL3 @"dk.3"
#define Qrought_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

//#define Qrought_SMRZ_URL1 @"https://sandbox."
//#define Qrought_SMRZ_URL2 @"juhe."
//#define Qrought_SMRZ_URL3 @"3"
//#define Qrought_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

@implementation QroughtWebInterface

+(QroughtWebInterface*)sharedInstance
{
    static __strong QroughtWebInterface * g_QroughtSdkImp = nil;
    if (g_QroughtSdkImp == nil)
    {
        g_QroughtSdkImp = [QroughtWebInterface alloc];
    }
    
    return g_QroughtSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", Qrought_SERVER_API_URL1, Qrought_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlQroughtWithController:(NSString *)controller andQroughtParamDictionary:(NSDictionary *)paramDictionary
{
    
    self.realQroughtURL = [[NSString alloc] initWithFormat:@"%@", [self validateUrl]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.realQroughtURL, controller];
    NSURL *url = [NSURL URLWithString:urlString];
    
    for (NSString *key in paramDictionary)
    {
        url = [url appendQueryKey:key andValue:[NSString stringWithFormat:@"%@", [paramDictionary valueForKey:key]]];
    }
    
    return url;
}




//手机是否注册过
-(void)checkQroughtPhoneRegist:(NSString*)phoneQrought
        successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
            failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/checkphoneregister" andQroughtParamDictionary:nil];
    NSString * imei = [QroughtSdkImp getQroughtIdfa];
    NSString * channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString * client_id = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneQrought forKey:@"phone"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];

}

//手机注册接口
-(void)phoneQroughtRegist:(NSString*)phoneQrought
          passwordQrought:(NSString*)passwordQrought
        verifyCodeQrought:(NSString*)verifyCodeQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/phoneregister" andQroughtParamDictionary:nil];
    NSString * imei = [QroughtSdkImp getQroughtIdfa];
    NSString * channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString * client_id = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,passwordQrought,phoneQrought,verifyCodeQrought];
    NSString * sign = [QroughtSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneQrought forKey:@"phone"];
    [bodyDictionary setValue:verifyCodeQrought forKey:@"token"];
    [bodyDictionary setValue:passwordQrought forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}

//手机注册发送验证码接口
-(void)phoneQroughtRegistVerify:(NSString*)phoneQrought
         successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
             failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/fastregisterphone" andQroughtParamDictionary:nil];
    NSString * imei = [QroughtSdkImp getQroughtIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phoneQrought forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];

    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
    
}


//手机登录接口
-(void)phoneQroughtLogin:(NSString*)phoneQrought
         passwordQrought:(NSString*)passwordQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/phonelogin" andQroughtParamDictionary:nil];
    NSString * imei = [QroughtSdkImp getQroughtIdfa];
    NSString * channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString * client_id = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,passwordQrought,phoneQrought];
    NSString * sign = [QroughtSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneQrought forKey:@"phone"];
    [bodyDictionary setValue:passwordQrought forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}


-(void)checkQroughtUpdate:(NSString*)client_idQrought
          bundleIdQrought:(NSString*)bundleIdQrought
           versionQrought:(NSString*)versionQrought
            deviceQrought:(NSString*)deviceQrought
        sourceCodeQrought:(NSString*)sourceCodeQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"update/check_update" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_idQrought forKey:@"client_id"];
    [bodyDictionary setValue:bundleIdQrought forKey:@"bundleId"];
    [bodyDictionary setValue:versionQrought forKey:@"version"];
    [bodyDictionary setValue:deviceQrought forKey:@"device"];
    [bodyDictionary setValue:sourceCodeQrought forKey:@"sourceCode"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];

}

- (void)Qroughtinstall:(NSString*)appIdQrought
   imeiOfDeviceQrought:(NSString*)imeiQrought
        channelQrought:(NSString*)channelQrought
          modelQrought:(NSString*)modelQrought
             osQrought:(NSString*)osQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
    failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"data/install" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdQrought forKey:@"app_id"];
    [bodyDictionary setValue:imeiQrought forKey:@"imei"];
    [bodyDictionary setValue:imeiQrought forKey:@"idfa"];
    [bodyDictionary setValue:channelQrought forKey:@"channel"];
    [bodyDictionary setValue:modelQrought forKey:@"model"];
    [bodyDictionary setValue:osQrought forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}

- (void)QroughtsendHeart:(NSString*)userid
{
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
            NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"data/heart" andQroughtParamDictionary:nil];
            
            NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
            [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];
            [bodyDictionary setValue:userid forKey:@"user_id"];
            [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
            
            [QroughtWebApi requestPostQroughtUrl:url
                           bodyDictionaryQrought:bodyDictionary
                          successCallbackQrought:^(NSDictionary *dictionary, NSDictionary *headers){
                              NSLog(@"QroughtsendHeart dictionary : %@", dictionary);
                          }
                              failCallbackQrought:^(NSError * error) {
                                  
                              }];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });
    
    
    
}

- (void)getQroughtAntiFlag:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    
    NSString  *str = [NSString stringWithFormat:@"%@%@%@%@%@",Qrought_SMRZ_URL1, Qrought_SMRZ_URL2,Qrought_SMRZ_URL3,Qrought_SMRZ_URL4, [[QroughtSdkImp sharedInstance] getQroughtPackageId]];
    NSURL *url = [NSURL URLWithString:str];
    
    [QroughtWebApi requestPostQroughtUrl:url
                   bodyDictionaryQrought:nil
                  successCallbackQrought:successCallbackQrought
                      failCallbackQrought:failCallbackQrought];
}


- (void)newadQroughtinstall:dataEncodeQrought
                signQrought:signQrought
     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", Qrought_AD_SERVER_API_URL1, Qrought_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncodeQrought forKey:@"data"];
    [bodyDictionary setValue:signQrought forKey:@"sign"];
    
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}


-(void)bindQroughtRegister:(NSString*) usernameQrought
           passwordQrought:(NSString*)passwordQrought
       bindUsernameQrought:(NSString*) bindUsernameQrought
    successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
        failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/bind_username" andQroughtParamDictionary:nil];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * clientId = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, passwordQrought, usernameQrought, clientId, bindUsernameQrought];
    NSString * sign = [QroughtSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsernameQrought forKey:@"username"];
    [bodyDictionary setValue:usernameQrought forKey:@"bind_username"];
    [bodyDictionary setValue:passwordQrought forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
    
}
- (void)normalQroughtRegister:(NSString*)usernameQrought
              passwordQrought:(NSString*)passwordQrought
       successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
           failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/register" andQroughtParamDictionary:nil];
    
    NSString * imei = [QroughtSdkImp getQroughtIdfa];
    NSString * channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString * clientId = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * version = [[QroughtSdkImp sharedInstance] getQroughtVersion];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordQrought, usernameQrought];
    NSString * sign = [QroughtSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:passwordQrought forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}

- (void)fastQroughtRegisterQrought:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/fast_register_v04" andQroughtParamDictionary:nil];
    NSString * imei = [[QroughtSdkImp sharedInstance] getQroughtImei];
    NSString * channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString * clientId = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * version = [[QroughtSdkImp sharedInstance] getQroughtVersion];
     NSString *idfa=[QroughtSdkImp getQroughtIdfa];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@idfa%@imei%@",
                          privateKey, channel, clientId, idfa,imei];
      NSString * sign = [QroughtSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
     [bodyDictionary setValue:idfa forKey:@"idfa"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}



- (void)loginQrought:(NSString*)usernameQrought
     passwordQrought:(NSString*)passwordQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/login" andQroughtParamDictionary:nil];
    NSString * imei = [QroughtSdkImp getQroughtIdfa];
    NSString * channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString * clientId = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * version = [[QroughtSdkImp sharedInstance] getQroughtVersion];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordQrought, usernameQrought];
     NSString * sign = [QroughtSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:passwordQrought forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}

-(void) getQroughtAccessTokenQrought:(NSString *)codeQrought
       successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
           failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/token" andQroughtParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:codeQrought forKey:@"code"];
    [bodyDictionary setValue:Qrought_SDK_VERSION forKey:@"version"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                     failCallbackQrought:failCallbackQrought];
}

-(void) getQroughtUserId:(NSString *)accesstokenQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/me" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstokenQrought forKey:@"access_token"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];

}

-(void)checkPQroughtyTypeUrl:(Qrought_VSD_BLOCK)successCallbackQrought
             failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:a andQroughtParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}

-(void)QroughtSdkQroughtCheck:(NSString *)orQroughtderId
         descriptionQrought:(NSString *)descriptionQrought
     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:a andQroughtParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orQroughtderId forKey:@"orderid"];
    [bodyDictionary setValue:descriptionQrought forKey:@"description"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}

- (void)logoutQrought:(NSString*)usernameQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
   failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"oauth2/logout" andQroughtParamDictionary:nil];
    
    NSString * clientId = [[QroughtSdkImp sharedInstance] getQroughtAppKey];
    NSString * privateKey = [[QroughtSdkImp sharedInstance] getQroughtAppPrivateKey];
    NSString * version = [[QroughtSdkImp sharedInstance] getQroughtVersion];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, usernameQrought];
        NSString * sign = [QroughtSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}


- (void)createOrQroughtder:(NSString*)accessTokenQrought
             userIdQrought:(NSString*)userIdQrought
        productNameQrought:(NSString*)productNameQrought
          productIdQrought:(NSString*)productIdQrought
            accountQrought:(NSInteger)accountQrought
         appOrderIdQrought:(NSString*)appOrderIdQrought
            appNameQrought:(NSString*)appNameQrought
           clientIdQrought:(NSString*)clientIdQrought
            gatewayQrought:(NSInteger)gatewayQrought
            channelQrought:(NSString*)channelQrought
          orderTypeQrought:(NSString*)orderTypeQrought
              extraQrought:(NSString*)extraQrought
             extendQrought:(NSString*)extendQrought
               signQrought:(NSString*)signQrought
    successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
        failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:a andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:userIdQrought forKey:@"user_id"];
    [bodyDictionary setValue:productNameQrought forKey:@"product_name"];
    [bodyDictionary setValue:productIdQrought forKey:@"product_id"];
    [bodyDictionary setValue:[[NSString alloc] initWithFormat:@"%ld", (long)accountQrought] forKey:@"account"];
    [bodyDictionary setValue:appOrderIdQrought forKey:@"app_order_id"];
    [bodyDictionary setValue:appNameQrought forKey:@"app_name"];
    [bodyDictionary setValue:clientIdQrought forKey:@"client_id"];
    [bodyDictionary setValue:[NSString stringWithFormat:@"%ld", (long)gatewayQrought] forKey:@"gateway"];
    [bodyDictionary setValue:channelQrought forKey:@"channel"];
    [bodyDictionary setValue:orderTypeQrought forKey:@"order_type"];
    [bodyDictionary setValue:extraQrought forKey:@"extra"];
    [bodyDictionary setValue:extendQrought forKey:@"extend"];
    [bodyDictionary setValue:signQrought forKey:@"sign"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"gamename"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [bodyDictionary setValue:Qrought_SDK_VERSION forKey:@"version"];
    
    [bodyDictionary setValue:self.server_idQrought forKey:@"server_id"];
    [bodyDictionary setValue:self.role_idQrought forKey:@"role_id"];
    [bodyDictionary setValue:self.role_nameQrought forKey:@"role_name"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}

- (void)checkQroughtMail:(NSString*)accessTokenQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/check_email" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}

- (void)bindQroughtMail:(NSString*)accessTokenQrought
           emailQrought:(NSString*)emailQrought
 successQroughtCallback:(Qrought_VSD_BLOCK)successQroughtCallback
     failQroughtCallback:(Qrought_VE_BLOCK)failQroughtCallback
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/bind_email" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:emailQrought forKey:@"email"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successQroughtCallback
            failCallbackQrought:failQroughtCallback];
}


- (void)checkQroughtPhone:(NSString*)accessTokenQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/check_phone" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}


-(void)bindQroughtPhone:(NSString*)accessTokenQrought
            phoneQrought:(NSString*)phoneQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/bind_phone" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:phoneQrought forKey:@"phone"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}


- (void)checkQroughtIdentify:(NSString*)accessTokenQrought
      successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
          failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/identity_check" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}

- (void)startQroughtIdentify:(NSString*)accessTokenQrought
                 nameQrought:(NSString*)nameQrought
       identifyNumberQrought:(NSString*)identifyNumberQrought
      successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
          failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/identity" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:nameQrought forKey:@"name"];
    [bodyDictionary setValue:identifyNumberQrought forKey:@"identity"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"app_id"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}


- (void)confirmQroughtPhone:(NSString*)accessTokenQrought
              verifyQrought:(NSString*)verifyQrought
     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/active_phone" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:verifyQrought forKey:@"verify"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}


- (void)changeQroughtPasswordByPhone:(NSString*)usernameQrought
              successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/cp_phone" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}
- (void)changeQroughtPasswordByEmail:(NSString*)usernameQrought
              successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/cp_email" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}


- (void)confirmchangeQroughtPasswordByPhone:(NSString*)usernameQrought
                            passwordQrought:(NSString*)passwordQrought
                              verifyQrought:(NSString*)verifyQrought
                     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/ccp_phone" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:passwordQrought forKey:@"password"];
    [bodyDictionary setValue:verifyQrought forKey:@"verify"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
         bodyDictionaryQrought:bodyDictionary
        successCallbackQrought:successCallbackQrought
            failCallbackQrought:failCallbackQrought];
}
- (void)confirmQroughtChangePasswordByEmail:(NSString*)usernameQrought
                            passwordQrought:(NSString*)passwordQrought
                              verifyQrought:(NSString*)verifyQrought
                     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/ccp_email" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameQrought forKey:@"username"];
    [bodyDictionary setValue:passwordQrought forKey:@"password"];
    [bodyDictionary setValue:verifyQrought forKey:@"verify"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}





-(void)getQroughtHistoryUserNameByImei:(NSString *)imeiQrought
                           idfaQrought:(NSString *)idfaQrought
                successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                    failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/getHistoryUserNameByImei" andQroughtParamDictionary:nil];
    NSMutableDictionary *bodyDictionar=[NSMutableDictionary dictionary];
    
    if([idfaQrought containsString:@"-"]){
        if([[idfaQrought stringByReplacingOccurrencesOfString:@"-" withString:@""] containsString:@"000000"]){
            [bodyDictionar setValue:imeiQrought forKey:@"imei"];
        }else{
            [bodyDictionar setValue:idfaQrought forKey:@"imei"];
        }
    }else{
        [bodyDictionar setValue:idfaQrought forKey:@"imei"];
    }
    
    [QroughtWebApi requestPostQroughtUrl:url bodyDictionaryQrought:bodyDictionar successCallbackQrought:successCallbackQrought failCallbackQrought:failCallbackQrought];
    
}




-(void)changeQroughtPasswordWithTokenQrought:(NSString *)accessTokenQrought
                   oldPasswordQrought:(NSString *)oldPasswordQrought
                   newPasswordQrought:(NSString *)newPasswordQrought
               successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                   failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought {
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"user/change_password" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenQrought forKey:@"access_token"];
    [bodyDictionary setValue:oldPasswordQrought forKey:@"old_password"];
    [bodyDictionary setValue:newPasswordQrought forKey:@"new_password"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}




-(void)getQroughtSupport:(NSString *)appIdQrought
        onSuccessQrought:(Qrought_VSD_BLOCK)successBlockQrought
         onFailedQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSURL *url = [[QroughtWebInterface sharedInstance] getUrlQroughtWithController:@"game/support" andQroughtParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdQrought forKey:@"app_id"];
    [bodyDictionary setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:bodyDictionary
            successCallbackQrought:successBlockQrought
                failCallbackQrought:failCallbackQrought];
}
-(void)loadingQrought:(NSMutableDictionary*) paramQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
   failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought
{
    NSURL *url =[[QroughtWebInterface sharedInstance]getUrlQroughtWithController:@"data/loading" andQroughtParamDictionary:nil];
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:paramQrought
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}



-(void)createQrought:(NSMutableDictionary*) paramQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    NSURL *url =[[QroughtWebInterface sharedInstance]getUrlQroughtWithController:@"data/create_role" andQroughtParamDictionary:nil];
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:paramQrought
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];}






-(void)levelupQrought:(NSMutableDictionary*) paramQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
 failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought{
    
    self.server_idQrought = [[NSString alloc] initWithFormat:@"%@", [paramQrought objectForKey:@"server_id"]];
    self.role_idQrought = [[NSString alloc] initWithFormat:@"%@", [paramQrought objectForKey:@"role_id"]];
    self.role_nameQrought = [[NSString alloc] initWithFormat:@"%@", [paramQrought objectForKey:@"role_name"]];
    NSURL *url =[[QroughtWebInterface sharedInstance]getUrlQroughtWithController:@"data/level" andQroughtParamDictionary:nil];
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:paramQrought
            successCallbackQrought:successCallbackQrought
                failCallbackQrought:failCallbackQrought];
}
-(void)erroQrought:(NSMutableDictionary*) param
successCallback:(Qrought_VSD_BLOCK)successCallback
failCallback:(Qrought_VE_BLOCK)failCallback{
    NSURL *url =[[QroughtWebInterface sharedInstance]getUrlQroughtWithController:@"data/error" andQroughtParamDictionary:nil];
    [QroughtWebApi requestPostQroughtUrl:url
             bodyDictionaryQrought:param
            successCallbackQrought:successCallback
                failCallbackQrought:failCallback];
}


@end
