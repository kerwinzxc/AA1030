
#import "UsequenceWebInterface.h"
#import "UsequenceWebApi.h"
#import "UsequenceSdkImp.h"
#import "UsequenceSdkMd5.h"
#import "UsequenceProgressHUD.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"

#pragma mark private method

#define Usequence_SERVER_API_URL1 @"https://www.3"  //release
#define Usequence_SERVER_API_URL2 @"9sdk.com/"  //release

//#define Usequence_SERVER_API_URL1 @"https://sdk.3"  //sandbox
//#define Usequence_SERVER_API_URL2 @"9sdk.com/"  //sandbox

#define Usequence_AD_SERVER_API_URL1 @"https://newapi.3"
#define Usequence_AD_SERVER_API_URL2 @"975ad.com/game/index/index/"

#define Usequence_SMRZ_URL1 @"https://ju"
#define Usequence_SMRZ_URL2 @"hes"
#define Usequence_SMRZ_URL3 @"dk.3"
#define Usequence_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

//#define Usequence_SMRZ_URL1 @"https://sandbox."
//#define Usequence_SMRZ_URL2 @"juhe."
//#define Usequence_SMRZ_URL3 @"3"
//#define Usequence_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

@implementation UsequenceWebInterface

+(UsequenceWebInterface*)sharedInstance
{
    static __strong UsequenceWebInterface * g_UsequenceSdkImp = nil;
    if (g_UsequenceSdkImp == nil)
    {
        g_UsequenceSdkImp = [UsequenceWebInterface alloc];
    }
    
    return g_UsequenceSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", Usequence_SERVER_API_URL1, Usequence_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlUsequenceWithController:(NSString *)controller andUsequenceParamDictionary:(NSDictionary *)paramDictionary
{
    
    self.realUsequenceURL = [[NSString alloc] initWithFormat:@"%@", [self validateUrl]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.realUsequenceURL, controller];
    NSURL *url = [NSURL URLWithString:urlString];
    
    for (NSString *key in paramDictionary)
    {
        url = [url appendQueryKey:key andValue:[NSString stringWithFormat:@"%@", [paramDictionary valueForKey:key]]];
    }
    
    return url;
}




//手机是否注册过
-(void)checkUsequencePhoneRegist:(NSString*)phoneUsequence
        successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
            failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/checkphoneregister" andUsequenceParamDictionary:nil];
    NSString * imei = [UsequenceSdkImp getUsequenceIdfa];
    NSString * channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString * client_id = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneUsequence forKey:@"phone"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];

}

//手机注册接口
-(void)phoneUsequenceRegist:(NSString*)phoneUsequence
          passwordUsequence:(NSString*)passwordUsequence
        verifyCodeUsequence:(NSString*)verifyCodeUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/phoneregister" andUsequenceParamDictionary:nil];
    NSString * imei = [UsequenceSdkImp getUsequenceIdfa];
    NSString * channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString * client_id = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,passwordUsequence,phoneUsequence,verifyCodeUsequence];
    NSString * sign = [UsequenceSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneUsequence forKey:@"phone"];
    [bodyDictionary setValue:verifyCodeUsequence forKey:@"token"];
    [bodyDictionary setValue:passwordUsequence forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}

//手机注册发送验证码接口
-(void)phoneUsequenceRegistVerify:(NSString*)phoneUsequence
         successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
             failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/fastregisterphone" andUsequenceParamDictionary:nil];
    NSString * imei = [UsequenceSdkImp getUsequenceIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phoneUsequence forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];

    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
    
}


//手机登录接口
-(void)phoneUsequenceLogin:(NSString*)phoneUsequence
         passwordUsequence:(NSString*)passwordUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/phonelogin" andUsequenceParamDictionary:nil];
    NSString * imei = [UsequenceSdkImp getUsequenceIdfa];
    NSString * channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString * client_id = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,passwordUsequence,phoneUsequence];
    NSString * sign = [UsequenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneUsequence forKey:@"phone"];
    [bodyDictionary setValue:passwordUsequence forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}


-(void)checkUsequenceUpdate:(NSString*)client_idUsequence
          bundleIdUsequence:(NSString*)bundleIdUsequence
           versionUsequence:(NSString*)versionUsequence
            deviceUsequence:(NSString*)deviceUsequence
        sourceCodeUsequence:(NSString*)sourceCodeUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"update/check_update" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_idUsequence forKey:@"client_id"];
    [bodyDictionary setValue:bundleIdUsequence forKey:@"bundleId"];
    [bodyDictionary setValue:versionUsequence forKey:@"version"];
    [bodyDictionary setValue:deviceUsequence forKey:@"device"];
    [bodyDictionary setValue:sourceCodeUsequence forKey:@"sourceCode"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];

}

- (void)Usequenceinstall:(NSString*)appIdUsequence
   imeiOfDeviceUsequence:(NSString*)imeiUsequence
        channelUsequence:(NSString*)channelUsequence
          modelUsequence:(NSString*)modelUsequence
             osUsequence:(NSString*)osUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
    failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"data/install" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdUsequence forKey:@"app_id"];
    [bodyDictionary setValue:imeiUsequence forKey:@"imei"];
    [bodyDictionary setValue:imeiUsequence forKey:@"idfa"];
    [bodyDictionary setValue:channelUsequence forKey:@"channel"];
    [bodyDictionary setValue:modelUsequence forKey:@"model"];
    [bodyDictionary setValue:osUsequence forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}

- (void)UsequencesendHeart:(NSString*)userid
{
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
            NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"data/heart" andUsequenceParamDictionary:nil];
            
            NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
            [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];
            [bodyDictionary setValue:userid forKey:@"user_id"];
            [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
            
            [UsequenceWebApi requestPostUsequenceUrl:url
                           bodyDictionaryUsequence:bodyDictionary
                          successCallbackUsequence:^(NSDictionary *dictionary, NSDictionary *headers){
                              NSLog(@"UsequencesendHeart dictionary : %@", dictionary);
                          }
                              failCallbackUsequence:^(NSError * error) {
                                  
                              }];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });
    
    
    
}

- (void)getUsequenceAntiFlag:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    
    NSString  *str = [NSString stringWithFormat:@"%@%@%@%@%@",Usequence_SMRZ_URL1, Usequence_SMRZ_URL2,Usequence_SMRZ_URL3,Usequence_SMRZ_URL4, [[UsequenceSdkImp sharedInstance] getUsequencePackageId]];
    NSURL *url = [NSURL URLWithString:str];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
                   bodyDictionaryUsequence:nil
                  successCallbackUsequence:successCallbackUsequence
                      failCallbackUsequence:failCallbackUsequence];
}


- (void)newadUsequenceinstall:dataEncodeUsequence
                signUsequence:signUsequence
     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", Usequence_AD_SERVER_API_URL1, Usequence_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncodeUsequence forKey:@"data"];
    [bodyDictionary setValue:signUsequence forKey:@"sign"];
    
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}


-(void)bindUsequenceRegister:(NSString*) usernameUsequence
           passwordUsequence:(NSString*)passwordUsequence
       bindUsernameUsequence:(NSString*) bindUsernameUsequence
    successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
        failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/bind_username" andUsequenceParamDictionary:nil];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * clientId = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, passwordUsequence, usernameUsequence, clientId, bindUsernameUsequence];
    NSString * sign = [UsequenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsernameUsequence forKey:@"username"];
    [bodyDictionary setValue:usernameUsequence forKey:@"bind_username"];
    [bodyDictionary setValue:passwordUsequence forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
    
}
- (void)normalUsequenceRegister:(NSString*)usernameUsequence
              passwordUsequence:(NSString*)passwordUsequence
       successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
           failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/register" andUsequenceParamDictionary:nil];
    
    NSString * imei = [UsequenceSdkImp getUsequenceIdfa];
    NSString * channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString * clientId = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * version = [[UsequenceSdkImp sharedInstance] getUsequenceVersion];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordUsequence, usernameUsequence];
    NSString * sign = [UsequenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:passwordUsequence forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}

- (void)fastUsequenceRegisterUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/fast_register_v04" andUsequenceParamDictionary:nil];
    NSString * imei = [[UsequenceSdkImp sharedInstance] getUsequenceImei];
    NSString * channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString * clientId = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * version = [[UsequenceSdkImp sharedInstance] getUsequenceVersion];
     NSString *idfa=[UsequenceSdkImp getUsequenceIdfa];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@idfa%@imei%@",
                          privateKey, channel, clientId, idfa,imei];
      NSString * sign = [UsequenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
     [bodyDictionary setValue:idfa forKey:@"idfa"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}



- (void)loginUsequence:(NSString*)usernameUsequence
     passwordUsequence:(NSString*)passwordUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/login" andUsequenceParamDictionary:nil];
    NSString * imei = [UsequenceSdkImp getUsequenceIdfa];
    NSString * channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString * clientId = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * version = [[UsequenceSdkImp sharedInstance] getUsequenceVersion];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordUsequence, usernameUsequence];
     NSString * sign = [UsequenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:passwordUsequence forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}

-(void) getUsequenceAccessTokenUsequence:(NSString *)codeUsequence
       successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
           failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/token" andUsequenceParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:codeUsequence forKey:@"code"];
    [bodyDictionary setValue:Usequence_SDK_VERSION forKey:@"version"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                     failCallbackUsequence:failCallbackUsequence];
}

-(void) getUsequenceUserId:(NSString *)accesstokenUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/me" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstokenUsequence forKey:@"access_token"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];

}

-(void)checkPUsequenceyTypeUrl:(Usequence_VSD_BLOCK)successCallbackUsequence
             failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:a andUsequenceParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}

-(void)UsequenceSdkUsequenceCheck:(NSString *)orUsequencederId
         descriptionUsequence:(NSString *)descriptionUsequence
     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:a andUsequenceParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orUsequencederId forKey:@"orderid"];
    [bodyDictionary setValue:descriptionUsequence forKey:@"description"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}

- (void)logoutUsequence:(NSString*)usernameUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
   failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"oauth2/logout" andUsequenceParamDictionary:nil];
    
    NSString * clientId = [[UsequenceSdkImp sharedInstance] getUsequenceAppKey];
    NSString * privateKey = [[UsequenceSdkImp sharedInstance] getUsequenceAppPrivateKey];
    NSString * version = [[UsequenceSdkImp sharedInstance] getUsequenceVersion];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, usernameUsequence];
        NSString * sign = [UsequenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}


- (void)createOrUsequenceder:(NSString*)accessTokenUsequence
             userIdUsequence:(NSString*)userIdUsequence
        productNameUsequence:(NSString*)productNameUsequence
          productIdUsequence:(NSString*)productIdUsequence
            accountUsequence:(NSInteger)accountUsequence
         appOrderIdUsequence:(NSString*)appOrderIdUsequence
            appNameUsequence:(NSString*)appNameUsequence
           clientIdUsequence:(NSString*)clientIdUsequence
            gatewayUsequence:(NSInteger)gatewayUsequence
            channelUsequence:(NSString*)channelUsequence
          orderTypeUsequence:(NSString*)orderTypeUsequence
              extraUsequence:(NSString*)extraUsequence
             extendUsequence:(NSString*)extendUsequence
               signUsequence:(NSString*)signUsequence
    successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
        failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:a andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:userIdUsequence forKey:@"user_id"];
    [bodyDictionary setValue:productNameUsequence forKey:@"product_name"];
    [bodyDictionary setValue:productIdUsequence forKey:@"product_id"];
    [bodyDictionary setValue:[[NSString alloc] initWithFormat:@"%ld", (long)accountUsequence] forKey:@"account"];
    [bodyDictionary setValue:appOrderIdUsequence forKey:@"app_order_id"];
    [bodyDictionary setValue:appNameUsequence forKey:@"app_name"];
    [bodyDictionary setValue:clientIdUsequence forKey:@"client_id"];
    [bodyDictionary setValue:[NSString stringWithFormat:@"%ld", (long)gatewayUsequence] forKey:@"gateway"];
    [bodyDictionary setValue:channelUsequence forKey:@"channel"];
    [bodyDictionary setValue:orderTypeUsequence forKey:@"order_type"];
    [bodyDictionary setValue:extraUsequence forKey:@"extra"];
    [bodyDictionary setValue:extendUsequence forKey:@"extend"];
    [bodyDictionary setValue:signUsequence forKey:@"sign"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"gamename"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:Usequence_SDK_VERSION forKey:@"version"];
    
    [bodyDictionary setValue:self.server_idUsequence forKey:@"server_id"];
    [bodyDictionary setValue:self.role_idUsequence forKey:@"role_id"];
    [bodyDictionary setValue:self.role_nameUsequence forKey:@"role_name"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}

- (void)checkUsequenceMail:(NSString*)accessTokenUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/check_email" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}

- (void)bindUsequenceMail:(NSString*)accessTokenUsequence
           emailUsequence:(NSString*)emailUsequence
 successUsequenceCallback:(Usequence_VSD_BLOCK)successUsequenceCallback
     failUsequenceCallback:(Usequence_VE_BLOCK)failUsequenceCallback
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/bind_email" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:emailUsequence forKey:@"email"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successUsequenceCallback
            failCallbackUsequence:failUsequenceCallback];
}


- (void)checkUsequencePhone:(NSString*)accessTokenUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/check_phone" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}


-(void)bindUsequencePhone:(NSString*)accessTokenUsequence
            phoneUsequence:(NSString*)phoneUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/bind_phone" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:phoneUsequence forKey:@"phone"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}


- (void)checkUsequenceIdentify:(NSString*)accessTokenUsequence
      successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
          failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/identity_check" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}

- (void)startUsequenceIdentify:(NSString*)accessTokenUsequence
                 nameUsequence:(NSString*)nameUsequence
       identifyNumberUsequence:(NSString*)identifyNumberUsequence
      successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
          failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/identity" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:nameUsequence forKey:@"name"];
    [bodyDictionary setValue:identifyNumberUsequence forKey:@"identity"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"app_id"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}


- (void)confirmUsequencePhone:(NSString*)accessTokenUsequence
              verifyUsequence:(NSString*)verifyUsequence
     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/active_phone" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:verifyUsequence forKey:@"verify"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}


- (void)changeUsequencePasswordByPhone:(NSString*)usernameUsequence
              successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/cp_phone" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}
- (void)changeUsequencePasswordByEmail:(NSString*)usernameUsequence
              successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/cp_email" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}


- (void)confirmchangeUsequencePasswordByPhone:(NSString*)usernameUsequence
                            passwordUsequence:(NSString*)passwordUsequence
                              verifyUsequence:(NSString*)verifyUsequence
                     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/ccp_phone" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:passwordUsequence forKey:@"password"];
    [bodyDictionary setValue:verifyUsequence forKey:@"verify"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
         bodyDictionaryUsequence:bodyDictionary
        successCallbackUsequence:successCallbackUsequence
            failCallbackUsequence:failCallbackUsequence];
}
- (void)confirmUsequenceChangePasswordByEmail:(NSString*)usernameUsequence
                            passwordUsequence:(NSString*)passwordUsequence
                              verifyUsequence:(NSString*)verifyUsequence
                     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/ccp_email" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameUsequence forKey:@"username"];
    [bodyDictionary setValue:passwordUsequence forKey:@"password"];
    [bodyDictionary setValue:verifyUsequence forKey:@"verify"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}





-(void)getUsequenceHistoryUserNameByImei:(NSString *)imeiUsequence
                           idfaUsequence:(NSString *)idfaUsequence
                successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                    failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/getHistoryUserNameByImei" andUsequenceParamDictionary:nil];
    NSMutableDictionary *bodyDictionar=[NSMutableDictionary dictionary];
    
    if([idfaUsequence containsString:@"-"]){
        if([[idfaUsequence stringByReplacingOccurrencesOfString:@"-" withString:@""] containsString:@"000000"]){
            [bodyDictionar setValue:imeiUsequence forKey:@"imei"];
        }else{
            [bodyDictionar setValue:idfaUsequence forKey:@"imei"];
        }
    }else{
        [bodyDictionar setValue:idfaUsequence forKey:@"imei"];
    }
    
    [UsequenceWebApi requestPostUsequenceUrl:url bodyDictionaryUsequence:bodyDictionar successCallbackUsequence:successCallbackUsequence failCallbackUsequence:failCallbackUsequence];
    
}




-(void)changeUsequencePasswordWithTokenUsequence:(NSString *)accessTokenUsequence
                   oldPasswordUsequence:(NSString *)oldPasswordUsequence
                   newPasswordUsequence:(NSString *)newPasswordUsequence
               successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                   failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence {
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"user/change_password" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenUsequence forKey:@"access_token"];
    [bodyDictionary setValue:oldPasswordUsequence forKey:@"old_password"];
    [bodyDictionary setValue:newPasswordUsequence forKey:@"new_password"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}




-(void)getUsequenceSupport:(NSString *)appIdUsequence
        onSuccessUsequence:(Usequence_VSD_BLOCK)successBlockUsequence
         onFailedUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSURL *url = [[UsequenceWebInterface sharedInstance] getUrlUsequenceWithController:@"game/support" andUsequenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdUsequence forKey:@"app_id"];
    [bodyDictionary setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:bodyDictionary
            successCallbackUsequence:successBlockUsequence
                failCallbackUsequence:failCallbackUsequence];
}
-(void)loadingUsequence:(NSMutableDictionary*) paramUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
   failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence
{
    NSURL *url =[[UsequenceWebInterface sharedInstance]getUrlUsequenceWithController:@"data/loading" andUsequenceParamDictionary:nil];
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:paramUsequence
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}



-(void)createUsequence:(NSMutableDictionary*) paramUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    NSURL *url =[[UsequenceWebInterface sharedInstance]getUrlUsequenceWithController:@"data/create_role" andUsequenceParamDictionary:nil];
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:paramUsequence
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];}






-(void)levelupUsequence:(NSMutableDictionary*) paramUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
 failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence{
    
    self.server_idUsequence = [[NSString alloc] initWithFormat:@"%@", [paramUsequence objectForKey:@"server_id"]];
    self.role_idUsequence = [[NSString alloc] initWithFormat:@"%@", [paramUsequence objectForKey:@"role_id"]];
    self.role_nameUsequence = [[NSString alloc] initWithFormat:@"%@", [paramUsequence objectForKey:@"role_name"]];
    NSURL *url =[[UsequenceWebInterface sharedInstance]getUrlUsequenceWithController:@"data/level" andUsequenceParamDictionary:nil];
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:paramUsequence
            successCallbackUsequence:successCallbackUsequence
                failCallbackUsequence:failCallbackUsequence];
}
-(void)erroUsequence:(NSMutableDictionary*) param
successCallback:(Usequence_VSD_BLOCK)successCallback
failCallback:(Usequence_VE_BLOCK)failCallback{
    NSURL *url =[[UsequenceWebInterface sharedInstance]getUrlUsequenceWithController:@"data/error" andUsequenceParamDictionary:nil];
    [UsequenceWebApi requestPostUsequenceUrl:url
             bodyDictionaryUsequence:param
            successCallbackUsequence:successCallback
                failCallbackUsequence:failCallback];
}


@end
