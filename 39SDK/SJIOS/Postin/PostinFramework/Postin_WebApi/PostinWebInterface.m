
#import "PostinWebInterface.h"
#import "PostinWebApi.h"
#import "PostinSdkImp.h"
#import "PostinSdkMd5.h"
#import "PostinProgressHUD.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"

#pragma mark private method

#define Postin_SERVER_API_URL1 @"https://www.3"  //release
#define Postin_SERVER_API_URL2 @"9sdk.com/"  //release

//#define Postin_SERVER_API_URL1 @"https://sdk.3"  //sandbox
//#define Postin_SERVER_API_URL2 @"9sdk.com/"  //sandbox

#define Postin_AD_SERVER_API_URL1 @"https://newapi.3"
#define Postin_AD_SERVER_API_URL2 @"975ad.com/game/index/index/"

#define Postin_SMRZ_URL1 @"https://ju"
#define Postin_SMRZ_URL2 @"hes"
#define Postin_SMRZ_URL3 @"dk.3"
#define Postin_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

//#define Postin_SMRZ_URL1 @"https://sandbox."
//#define Postin_SMRZ_URL2 @"juhe."
//#define Postin_SMRZ_URL3 @"3"
//#define Postin_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

@implementation PostinWebInterface

+(PostinWebInterface*)sharedInstance
{
    static __strong PostinWebInterface * g_PostinSdkImp = nil;
    if (g_PostinSdkImp == nil)
    {
        g_PostinSdkImp = [PostinWebInterface alloc];
    }
    
    return g_PostinSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", Postin_SERVER_API_URL1, Postin_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlPostinWithController:(NSString *)controller andPostinParamDictionary:(NSDictionary *)paramDictionary
{
    
    self.realPostinURL = [[NSString alloc] initWithFormat:@"%@", [self validateUrl]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.realPostinURL, controller];
    NSURL *url = [NSURL URLWithString:urlString];
    
    for (NSString *key in paramDictionary)
    {
        url = [url appendQueryKey:key andValue:[NSString stringWithFormat:@"%@", [paramDictionary valueForKey:key]]];
    }
    
    return url;
}




//手机是否注册过
-(void)checkPostinPhoneRegist:(NSString*)phonePostin
        successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
            failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/checkphoneregister" andPostinParamDictionary:nil];
    NSString * imei = [PostinSdkImp getPostinIdfa];
    NSString * channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString * client_id = [[PostinSdkImp sharedInstance] getPostinAppKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phonePostin forKey:@"phone"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];

}

//手机注册接口
-(void)phonePostinRegist:(NSString*)phonePostin
          passwordPostin:(NSString*)passwordPostin
        verifyCodePostin:(NSString*)verifyCodePostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/phoneregister" andPostinParamDictionary:nil];
    NSString * imei = [PostinSdkImp getPostinIdfa];
    NSString * channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString * client_id = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,passwordPostin,phonePostin,verifyCodePostin];
    NSString * sign = [PostinSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phonePostin forKey:@"phone"];
    [bodyDictionary setValue:verifyCodePostin forKey:@"token"];
    [bodyDictionary setValue:passwordPostin forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}

//手机注册发送验证码接口
-(void)phonePostinRegistVerify:(NSString*)phonePostin
         successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
             failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/fastregisterphone" andPostinParamDictionary:nil];
    NSString * imei = [PostinSdkImp getPostinIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phonePostin forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];

    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
    
}


//手机登录接口
-(void)phonePostinLogin:(NSString*)phonePostin
         passwordPostin:(NSString*)passwordPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/phonelogin" andPostinParamDictionary:nil];
    NSString * imei = [PostinSdkImp getPostinIdfa];
    NSString * channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString * client_id = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,passwordPostin,phonePostin];
    NSString * sign = [PostinSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phonePostin forKey:@"phone"];
    [bodyDictionary setValue:passwordPostin forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}


-(void)checkPostinUpdate:(NSString*)client_idPostin
          bundleIdPostin:(NSString*)bundleIdPostin
           versionPostin:(NSString*)versionPostin
            devicePostin:(NSString*)devicePostin
        sourceCodePostin:(NSString*)sourceCodePostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"update/check_update" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_idPostin forKey:@"client_id"];
    [bodyDictionary setValue:bundleIdPostin forKey:@"bundleId"];
    [bodyDictionary setValue:versionPostin forKey:@"version"];
    [bodyDictionary setValue:devicePostin forKey:@"device"];
    [bodyDictionary setValue:sourceCodePostin forKey:@"sourceCode"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];

}

- (void)Postininstall:(NSString*)appIdPostin
   imeiOfDevicePostin:(NSString*)imeiPostin
        channelPostin:(NSString*)channelPostin
          modelPostin:(NSString*)modelPostin
             osPostin:(NSString*)osPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
    failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"data/install" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdPostin forKey:@"app_id"];
    [bodyDictionary setValue:imeiPostin forKey:@"imei"];
    [bodyDictionary setValue:imeiPostin forKey:@"idfa"];
    [bodyDictionary setValue:channelPostin forKey:@"channel"];
    [bodyDictionary setValue:modelPostin forKey:@"model"];
    [bodyDictionary setValue:osPostin forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}

- (void)PostinsendHeart:(NSString*)userid
{
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
            NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"data/heart" andPostinParamDictionary:nil];
            
            NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
            [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];
            [bodyDictionary setValue:userid forKey:@"user_id"];
            [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
            
            [PostinWebApi requestPostPostinUrl:url
                           bodyDictionaryPostin:bodyDictionary
                          successCallbackPostin:^(NSDictionary *dictionary, NSDictionary *headers){
                              NSLog(@"PostinsendHeart dictionary : %@", dictionary);
                          }
                              failCallbackPostin:^(NSError * error) {
                                  
                              }];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });
    
    
    
}

- (void)getPostinAntiFlag:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    
    NSString  *str = [NSString stringWithFormat:@"%@%@%@%@%@",Postin_SMRZ_URL1, Postin_SMRZ_URL2,Postin_SMRZ_URL3,Postin_SMRZ_URL4, [[PostinSdkImp sharedInstance] getPostinPackageId]];
    NSURL *url = [NSURL URLWithString:str];
    
    [PostinWebApi requestPostPostinUrl:url
                   bodyDictionaryPostin:nil
                  successCallbackPostin:successCallbackPostin
                      failCallbackPostin:failCallbackPostin];
}


- (void)newadPostininstall:dataEncodePostin
                signPostin:signPostin
     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", Postin_AD_SERVER_API_URL1, Postin_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncodePostin forKey:@"data"];
    [bodyDictionary setValue:signPostin forKey:@"sign"];
    
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}


-(void)bindPostinRegister:(NSString*) usernamePostin
           passwordPostin:(NSString*)passwordPostin
       bindUsernamePostin:(NSString*) bindUsernamePostin
    successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
        failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/bind_username" andPostinParamDictionary:nil];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * clientId = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, passwordPostin, usernamePostin, clientId, bindUsernamePostin];
    NSString * sign = [PostinSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsernamePostin forKey:@"username"];
    [bodyDictionary setValue:usernamePostin forKey:@"bind_username"];
    [bodyDictionary setValue:passwordPostin forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
    
}
- (void)normalPostinRegister:(NSString*)usernamePostin
              passwordPostin:(NSString*)passwordPostin
       successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
           failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/register" andPostinParamDictionary:nil];
    
    NSString * imei = [PostinSdkImp getPostinIdfa];
    NSString * channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString * clientId = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * version = [[PostinSdkImp sharedInstance] getPostinVersion];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordPostin, usernamePostin];
    NSString * sign = [PostinSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:passwordPostin forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}

- (void)fastPostinRegisterPostin:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/fast_register_v04" andPostinParamDictionary:nil];
    NSString * imei = [[PostinSdkImp sharedInstance] getPostinImei];
    NSString * channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString * clientId = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * version = [[PostinSdkImp sharedInstance] getPostinVersion];
     NSString *idfa=[PostinSdkImp getPostinIdfa];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@idfa%@imei%@",
                          privateKey, channel, clientId, idfa,imei];
      NSString * sign = [PostinSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
     [bodyDictionary setValue:idfa forKey:@"idfa"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}



- (void)loginPostin:(NSString*)usernamePostin
     passwordPostin:(NSString*)passwordPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/login" andPostinParamDictionary:nil];
    NSString * imei = [PostinSdkImp getPostinIdfa];
    NSString * channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString * clientId = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * version = [[PostinSdkImp sharedInstance] getPostinVersion];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordPostin, usernamePostin];
     NSString * sign = [PostinSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:passwordPostin forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}

-(void) getPostinAccessTokenPostin:(NSString *)codePostin
       successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
           failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/token" andPostinParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:codePostin forKey:@"code"];
    [bodyDictionary setValue:Postin_SDK_VERSION forKey:@"version"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                     failCallbackPostin:failCallbackPostin];
}

-(void) getPostinUserId:(NSString *)accesstokenPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/me" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstokenPostin forKey:@"access_token"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];

}

-(void)checkPPostinyTypeUrl:(Postin_VSD_BLOCK)successCallbackPostin
             failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:a andPostinParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}

-(void)PostinSdkPostinCheck:(NSString *)orPostinderId
         descriptionPostin:(NSString *)descriptionPostin
     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:a andPostinParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orPostinderId forKey:@"orderid"];
    [bodyDictionary setValue:descriptionPostin forKey:@"description"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}

- (void)logoutPostin:(NSString*)usernamePostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
   failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"oauth2/logout" andPostinParamDictionary:nil];
    
    NSString * clientId = [[PostinSdkImp sharedInstance] getPostinAppKey];
    NSString * privateKey = [[PostinSdkImp sharedInstance] getPostinAppPrivateKey];
    NSString * version = [[PostinSdkImp sharedInstance] getPostinVersion];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, usernamePostin];
        NSString * sign = [PostinSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}


- (void)createOrPostinder:(NSString*)accessTokenPostin
             userIdPostin:(NSString*)userIdPostin
        productNamePostin:(NSString*)productNamePostin
          productIdPostin:(NSString*)productIdPostin
            accountPostin:(NSInteger)accountPostin
         appOrderIdPostin:(NSString*)appOrderIdPostin
            appNamePostin:(NSString*)appNamePostin
           clientIdPostin:(NSString*)clientIdPostin
            gatewayPostin:(NSInteger)gatewayPostin
            channelPostin:(NSString*)channelPostin
          orderTypePostin:(NSString*)orderTypePostin
              extraPostin:(NSString*)extraPostin
             extendPostin:(NSString*)extendPostin
               signPostin:(NSString*)signPostin
    successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
        failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:a andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:userIdPostin forKey:@"user_id"];
    [bodyDictionary setValue:productNamePostin forKey:@"product_name"];
    [bodyDictionary setValue:productIdPostin forKey:@"product_id"];
    [bodyDictionary setValue:[[NSString alloc] initWithFormat:@"%ld", (long)accountPostin] forKey:@"account"];
    [bodyDictionary setValue:appOrderIdPostin forKey:@"app_order_id"];
    [bodyDictionary setValue:appNamePostin forKey:@"app_name"];
    [bodyDictionary setValue:clientIdPostin forKey:@"client_id"];
    [bodyDictionary setValue:[NSString stringWithFormat:@"%ld", (long)gatewayPostin] forKey:@"gateway"];
    [bodyDictionary setValue:channelPostin forKey:@"channel"];
    [bodyDictionary setValue:orderTypePostin forKey:@"order_type"];
    [bodyDictionary setValue:extraPostin forKey:@"extra"];
    [bodyDictionary setValue:extendPostin forKey:@"extend"];
    [bodyDictionary setValue:signPostin forKey:@"sign"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"gamename"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [bodyDictionary setValue:Postin_SDK_VERSION forKey:@"version"];
    
    [bodyDictionary setValue:self.server_idPostin forKey:@"server_id"];
    [bodyDictionary setValue:self.role_idPostin forKey:@"role_id"];
    [bodyDictionary setValue:self.role_namePostin forKey:@"role_name"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}

- (void)checkPostinMail:(NSString*)accessTokenPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/check_email" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}

- (void)bindPostinMail:(NSString*)accessTokenPostin
           emailPostin:(NSString*)emailPostin
 successPostinCallback:(Postin_VSD_BLOCK)successPostinCallback
     failPostinCallback:(Postin_VE_BLOCK)failPostinCallback
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/bind_email" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:emailPostin forKey:@"email"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successPostinCallback
            failCallbackPostin:failPostinCallback];
}


- (void)checkPostinPhone:(NSString*)accessTokenPostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/check_phone" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}


-(void)bindPostinPhone:(NSString*)accessTokenPostin
            phonePostin:(NSString*)phonePostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/bind_phone" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:phonePostin forKey:@"phone"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}


- (void)checkPostinIdentify:(NSString*)accessTokenPostin
      successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
          failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/identity_check" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}

- (void)startPostinIdentify:(NSString*)accessTokenPostin
                 namePostin:(NSString*)namePostin
       identifyNumberPostin:(NSString*)identifyNumberPostin
      successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
          failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/identity" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:namePostin forKey:@"name"];
    [bodyDictionary setValue:identifyNumberPostin forKey:@"identity"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"app_id"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}


- (void)confirmPostinPhone:(NSString*)accessTokenPostin
              verifyPostin:(NSString*)verifyPostin
     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/active_phone" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:verifyPostin forKey:@"verify"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}


- (void)changePostinPasswordByPhone:(NSString*)usernamePostin
              successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/cp_phone" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}
- (void)changePostinPasswordByEmail:(NSString*)usernamePostin
              successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/cp_email" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}


- (void)confirmchangePostinPasswordByPhone:(NSString*)usernamePostin
                            passwordPostin:(NSString*)passwordPostin
                              verifyPostin:(NSString*)verifyPostin
                     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/ccp_phone" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:passwordPostin forKey:@"password"];
    [bodyDictionary setValue:verifyPostin forKey:@"verify"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
         bodyDictionaryPostin:bodyDictionary
        successCallbackPostin:successCallbackPostin
            failCallbackPostin:failCallbackPostin];
}
- (void)confirmPostinChangePasswordByEmail:(NSString*)usernamePostin
                            passwordPostin:(NSString*)passwordPostin
                              verifyPostin:(NSString*)verifyPostin
                     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/ccp_email" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernamePostin forKey:@"username"];
    [bodyDictionary setValue:passwordPostin forKey:@"password"];
    [bodyDictionary setValue:verifyPostin forKey:@"verify"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}





-(void)getPostinHistoryUserNameByImei:(NSString *)imeiPostin
                           idfaPostin:(NSString *)idfaPostin
                successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                    failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/getHistoryUserNameByImei" andPostinParamDictionary:nil];
    NSMutableDictionary *bodyDictionar=[NSMutableDictionary dictionary];
    
    if([idfaPostin containsString:@"-"]){
        if([[idfaPostin stringByReplacingOccurrencesOfString:@"-" withString:@""] containsString:@"000000"]){
            [bodyDictionar setValue:imeiPostin forKey:@"imei"];
        }else{
            [bodyDictionar setValue:idfaPostin forKey:@"imei"];
        }
    }else{
        [bodyDictionar setValue:idfaPostin forKey:@"imei"];
    }
    
    [PostinWebApi requestPostPostinUrl:url bodyDictionaryPostin:bodyDictionar successCallbackPostin:successCallbackPostin failCallbackPostin:failCallbackPostin];
    
}




-(void)changePostinPasswordWithTokenPostin:(NSString *)accessTokenPostin
                   oldPasswordPostin:(NSString *)oldPasswordPostin
                   newPasswordPostin:(NSString *)newPasswordPostin
               successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                   failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin {
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"user/change_password" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenPostin forKey:@"access_token"];
    [bodyDictionary setValue:oldPasswordPostin forKey:@"old_password"];
    [bodyDictionary setValue:newPasswordPostin forKey:@"new_password"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}




-(void)getPostinSupport:(NSString *)appIdPostin
        onSuccessPostin:(Postin_VSD_BLOCK)successBlockPostin
         onFailedPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSURL *url = [[PostinWebInterface sharedInstance] getUrlPostinWithController:@"game/support" andPostinParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdPostin forKey:@"app_id"];
    [bodyDictionary setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:bodyDictionary
            successCallbackPostin:successBlockPostin
                failCallbackPostin:failCallbackPostin];
}
-(void)loadingPostin:(NSMutableDictionary*) paramPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
   failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin
{
    NSURL *url =[[PostinWebInterface sharedInstance]getUrlPostinWithController:@"data/loading" andPostinParamDictionary:nil];
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:paramPostin
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}



-(void)createPostin:(NSMutableDictionary*) paramPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    NSURL *url =[[PostinWebInterface sharedInstance]getUrlPostinWithController:@"data/create_role" andPostinParamDictionary:nil];
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:paramPostin
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];}






-(void)levelupPostin:(NSMutableDictionary*) paramPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
 failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin{
    
    self.server_idPostin = [[NSString alloc] initWithFormat:@"%@", [paramPostin objectForKey:@"server_id"]];
    self.role_idPostin = [[NSString alloc] initWithFormat:@"%@", [paramPostin objectForKey:@"role_id"]];
    self.role_namePostin = [[NSString alloc] initWithFormat:@"%@", [paramPostin objectForKey:@"role_name"]];
    NSURL *url =[[PostinWebInterface sharedInstance]getUrlPostinWithController:@"data/level" andPostinParamDictionary:nil];
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:paramPostin
            successCallbackPostin:successCallbackPostin
                failCallbackPostin:failCallbackPostin];
}
-(void)erroPostin:(NSMutableDictionary*) param
successCallback:(Postin_VSD_BLOCK)successCallback
failCallback:(Postin_VE_BLOCK)failCallback{
    NSURL *url =[[PostinWebInterface sharedInstance]getUrlPostinWithController:@"data/error" andPostinParamDictionary:nil];
    [PostinWebApi requestPostPostinUrl:url
             bodyDictionaryPostin:param
            successCallbackPostin:successCallback
                failCallbackPostin:failCallback];
}


@end
