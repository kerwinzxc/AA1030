
#import "RersistenceWebInterface.h"
#import "RersistenceWebApi.h"
#import "RersistenceSdkImp.h"
#import "RersistenceSdkMd5.h"
#import "RersistenceProgressHUD.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"

#pragma mark private method

#define Rersistence_SERVER_API_URL1 @"https://www.3"  //release
#define Rersistence_SERVER_API_URL2 @"9sdk.com/"  //release

//#define Rersistence_SERVER_API_URL1 @"https://sdk.3"  //sandbox
//#define Rersistence_SERVER_API_URL2 @"9sdk.com/"  //sandbox

#define Rersistence_AD_SERVER_API_URL1 @"https://newapi.3"
#define Rersistence_AD_SERVER_API_URL2 @"975ad.com/game/index/index/"

#define Rersistence_SMRZ_URL1 @"https://ju"
#define Rersistence_SMRZ_URL2 @"hes"
#define Rersistence_SMRZ_URL3 @"dk.3"
#define Rersistence_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

//#define Rersistence_SMRZ_URL1 @"https://sandbox."
//#define Rersistence_SMRZ_URL2 @"juhe."
//#define Rersistence_SMRZ_URL3 @"3"
//#define Rersistence_SMRZ_URL4 @"975ad.com/Api/Data/anti_addiction/package_id/"

@implementation RersistenceWebInterface

+(RersistenceWebInterface*)sharedInstance
{
    static __strong RersistenceWebInterface * g_RersistenceSdkImp = nil;
    if (g_RersistenceSdkImp == nil)
    {
        g_RersistenceSdkImp = [RersistenceWebInterface alloc];
    }
    
    return g_RersistenceSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", Rersistence_SERVER_API_URL1, Rersistence_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlRersistenceWithController:(NSString *)controller andRersistenceParamDictionary:(NSDictionary *)paramDictionary
{
    
    self.realRersistenceURL = [[NSString alloc] initWithFormat:@"%@", [self validateUrl]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.realRersistenceURL, controller];
    NSURL *url = [NSURL URLWithString:urlString];
    
    for (NSString *key in paramDictionary)
    {
        url = [url appendQueryKey:key andValue:[NSString stringWithFormat:@"%@", [paramDictionary valueForKey:key]]];
    }
    
    return url;
}




//手机是否注册过
-(void)checkRersistencePhoneRegist:(NSString*)phoneRersistence
        successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
            failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/checkphoneregister" andRersistenceParamDictionary:nil];
    NSString * imei = [RersistenceSdkImp getRersistenceIdfa];
    NSString * channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString * client_id = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneRersistence forKey:@"phone"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];

}

//手机注册接口
-(void)phoneRersistenceRegist:(NSString*)phoneRersistence
          passwordRersistence:(NSString*)passwordRersistence
        verifyCodeRersistence:(NSString*)verifyCodeRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/phoneregister" andRersistenceParamDictionary:nil];
    NSString * imei = [RersistenceSdkImp getRersistenceIdfa];
    NSString * channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString * client_id = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,passwordRersistence,phoneRersistence,verifyCodeRersistence];
    NSString * sign = [RersistenceSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneRersistence forKey:@"phone"];
    [bodyDictionary setValue:verifyCodeRersistence forKey:@"token"];
    [bodyDictionary setValue:passwordRersistence forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}

//手机注册发送验证码接口
-(void)phoneRersistenceRegistVerify:(NSString*)phoneRersistence
         successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
             failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/fastregisterphone" andRersistenceParamDictionary:nil];
    NSString * imei = [RersistenceSdkImp getRersistenceIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phoneRersistence forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];

    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
    
}


//手机登录接口
-(void)phoneRersistenceLogin:(NSString*)phoneRersistence
         passwordRersistence:(NSString*)passwordRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/phonelogin" andRersistenceParamDictionary:nil];
    NSString * imei = [RersistenceSdkImp getRersistenceIdfa];
    NSString * channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString * client_id = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,passwordRersistence,phoneRersistence];
    NSString * sign = [RersistenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phoneRersistence forKey:@"phone"];
    [bodyDictionary setValue:passwordRersistence forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}


-(void)checkRersistenceUpdate:(NSString*)client_idRersistence
          bundleIdRersistence:(NSString*)bundleIdRersistence
           versionRersistence:(NSString*)versionRersistence
            deviceRersistence:(NSString*)deviceRersistence
        sourceCodeRersistence:(NSString*)sourceCodeRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"update/check_update" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_idRersistence forKey:@"client_id"];
    [bodyDictionary setValue:bundleIdRersistence forKey:@"bundleId"];
    [bodyDictionary setValue:versionRersistence forKey:@"version"];
    [bodyDictionary setValue:deviceRersistence forKey:@"device"];
    [bodyDictionary setValue:sourceCodeRersistence forKey:@"sourceCode"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];

}

- (void)Rersistenceinstall:(NSString*)appIdRersistence
   imeiOfDeviceRersistence:(NSString*)imeiRersistence
        channelRersistence:(NSString*)channelRersistence
          modelRersistence:(NSString*)modelRersistence
             osRersistence:(NSString*)osRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
    failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"data/install" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdRersistence forKey:@"app_id"];
    [bodyDictionary setValue:imeiRersistence forKey:@"imei"];
    [bodyDictionary setValue:imeiRersistence forKey:@"idfa"];
    [bodyDictionary setValue:channelRersistence forKey:@"channel"];
    [bodyDictionary setValue:modelRersistence forKey:@"model"];
    [bodyDictionary setValue:osRersistence forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}

- (void)RersistencesendHeart:(NSString*)userid
{
    //发送心跳包
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        while (TRUE) {
            NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"data/heart" andRersistenceParamDictionary:nil];
            
            NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
            [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];
            [bodyDictionary setValue:userid forKey:@"user_id"];
            [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
            
            [RersistenceWebApi requestPostRersistenceUrl:url
                           bodyDictionaryRersistence:bodyDictionary
                          successCallbackRersistence:^(NSDictionary *dictionary, NSDictionary *headers){
                              NSLog(@"RersistencesendHeart dictionary : %@", dictionary);
                          }
                              failCallbackRersistence:^(NSError * error) {
                                  
                              }];
            [NSThread sleepForTimeInterval:300.0f];
        }
        
    });
    
    
    
}

- (void)getRersistenceAntiFlag:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    
    NSString  *str = [NSString stringWithFormat:@"%@%@%@%@%@",Rersistence_SMRZ_URL1, Rersistence_SMRZ_URL2,Rersistence_SMRZ_URL3,Rersistence_SMRZ_URL4, [[RersistenceSdkImp sharedInstance] getRersistencePackageId]];
    NSURL *url = [NSURL URLWithString:str];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
                   bodyDictionaryRersistence:nil
                  successCallbackRersistence:successCallbackRersistence
                      failCallbackRersistence:failCallbackRersistence];
}


- (void)newadRersistenceinstall:dataEncodeRersistence
                signRersistence:signRersistence
     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", Rersistence_AD_SERVER_API_URL1, Rersistence_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncodeRersistence forKey:@"data"];
    [bodyDictionary setValue:signRersistence forKey:@"sign"];
    
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}


-(void)bindRersistenceRegister:(NSString*) usernameRersistence
           passwordRersistence:(NSString*)passwordRersistence
       bindUsernameRersistence:(NSString*) bindUsernameRersistence
    successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
        failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/bind_username" andRersistenceParamDictionary:nil];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * clientId = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, passwordRersistence, usernameRersistence, clientId, bindUsernameRersistence];
    NSString * sign = [RersistenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsernameRersistence forKey:@"username"];
    [bodyDictionary setValue:usernameRersistence forKey:@"bind_username"];
    [bodyDictionary setValue:passwordRersistence forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
    
}
- (void)normalRersistenceRegister:(NSString*)usernameRersistence
              passwordRersistence:(NSString*)passwordRersistence
       successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
           failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/register" andRersistenceParamDictionary:nil];
    
    NSString * imei = [RersistenceSdkImp getRersistenceIdfa];
    NSString * channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString * clientId = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * version = [[RersistenceSdkImp sharedInstance] getRersistenceVersion];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordRersistence, usernameRersistence];
    NSString * sign = [RersistenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:passwordRersistence forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}

- (void)fastRersistenceRegisterRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/fast_register_v04" andRersistenceParamDictionary:nil];
    NSString * imei = [[RersistenceSdkImp sharedInstance] getRersistenceImei];
    NSString * channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString * clientId = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * version = [[RersistenceSdkImp sharedInstance] getRersistenceVersion];
     NSString *idfa=[RersistenceSdkImp getRersistenceIdfa];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@idfa%@imei%@",
                          privateKey, channel, clientId, idfa,imei];
      NSString * sign = [RersistenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
     [bodyDictionary setValue:idfa forKey:@"idfa"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}



- (void)loginRersistence:(NSString*)usernameRersistence
     passwordRersistence:(NSString*)passwordRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/login" andRersistenceParamDictionary:nil];
    NSString * imei = [RersistenceSdkImp getRersistenceIdfa];
    NSString * channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString * clientId = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * version = [[RersistenceSdkImp sharedInstance] getRersistenceVersion];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, passwordRersistence, usernameRersistence];
     NSString * sign = [RersistenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:passwordRersistence forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}

-(void) getRersistenceAccessTokenRersistence:(NSString *)codeRersistence
       successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
           failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/token" andRersistenceParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:codeRersistence forKey:@"code"];
    [bodyDictionary setValue:Rersistence_SDK_VERSION forKey:@"version"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                     failCallbackRersistence:failCallbackRersistence];
}

-(void) getRersistenceUserId:(NSString *)accesstokenRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/me" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstokenRersistence forKey:@"access_token"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];

}

-(void)checkPRersistenceyTypeUrl:(Rersistence_VSD_BLOCK)successCallbackRersistence
             failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:a andRersistenceParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}

-(void)RersistenceSdkRersistenceCheck:(NSString *)orRersistencederId
         descriptionRersistence:(NSString *)descriptionRersistence
     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:a andRersistenceParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orRersistencederId forKey:@"orderid"];
    [bodyDictionary setValue:descriptionRersistence forKey:@"description"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}

- (void)logoutRersistence:(NSString*)usernameRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
   failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"oauth2/logout" andRersistenceParamDictionary:nil];
    
    NSString * clientId = [[RersistenceSdkImp sharedInstance] getRersistenceAppKey];
    NSString * privateKey = [[RersistenceSdkImp sharedInstance] getRersistenceAppPrivateKey];
    NSString * version = [[RersistenceSdkImp sharedInstance] getRersistenceVersion];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, usernameRersistence];
        NSString * sign = [RersistenceSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}


- (void)createOrRersistenceder:(NSString*)accessTokenRersistence
             userIdRersistence:(NSString*)userIdRersistence
        productNameRersistence:(NSString*)productNameRersistence
          productIdRersistence:(NSString*)productIdRersistence
            accountRersistence:(NSInteger)accountRersistence
         appOrderIdRersistence:(NSString*)appOrderIdRersistence
            appNameRersistence:(NSString*)appNameRersistence
           clientIdRersistence:(NSString*)clientIdRersistence
            gatewayRersistence:(NSInteger)gatewayRersistence
            channelRersistence:(NSString*)channelRersistence
          orderTypeRersistence:(NSString*)orderTypeRersistence
              extraRersistence:(NSString*)extraRersistence
             extendRersistence:(NSString*)extendRersistence
               signRersistence:(NSString*)signRersistence
    successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
        failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:a andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:userIdRersistence forKey:@"user_id"];
    [bodyDictionary setValue:productNameRersistence forKey:@"product_name"];
    [bodyDictionary setValue:productIdRersistence forKey:@"product_id"];
    [bodyDictionary setValue:[[NSString alloc] initWithFormat:@"%ld", (long)accountRersistence] forKey:@"account"];
    [bodyDictionary setValue:appOrderIdRersistence forKey:@"app_order_id"];
    [bodyDictionary setValue:appNameRersistence forKey:@"app_name"];
    [bodyDictionary setValue:clientIdRersistence forKey:@"client_id"];
    [bodyDictionary setValue:[NSString stringWithFormat:@"%ld", (long)gatewayRersistence] forKey:@"gateway"];
    [bodyDictionary setValue:channelRersistence forKey:@"channel"];
    [bodyDictionary setValue:orderTypeRersistence forKey:@"order_type"];
    [bodyDictionary setValue:extraRersistence forKey:@"extra"];
    [bodyDictionary setValue:extendRersistence forKey:@"extend"];
    [bodyDictionary setValue:signRersistence forKey:@"sign"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"gamename"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:Rersistence_SDK_VERSION forKey:@"version"];
    
    [bodyDictionary setValue:self.server_idRersistence forKey:@"server_id"];
    [bodyDictionary setValue:self.role_idRersistence forKey:@"role_id"];
    [bodyDictionary setValue:self.role_nameRersistence forKey:@"role_name"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}

- (void)checkRersistenceMail:(NSString*)accessTokenRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/check_email" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}

- (void)bindRersistenceMail:(NSString*)accessTokenRersistence
           emailRersistence:(NSString*)emailRersistence
 successRersistenceCallback:(Rersistence_VSD_BLOCK)successRersistenceCallback
     failRersistenceCallback:(Rersistence_VE_BLOCK)failRersistenceCallback
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/bind_email" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:emailRersistence forKey:@"email"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successRersistenceCallback
            failCallbackRersistence:failRersistenceCallback];
}


- (void)checkRersistencePhone:(NSString*)accessTokenRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/check_phone" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}


-(void)bindRersistencePhone:(NSString*)accessTokenRersistence
            phoneRersistence:(NSString*)phoneRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/bind_phone" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:phoneRersistence forKey:@"phone"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}


- (void)checkRersistenceIdentify:(NSString*)accessTokenRersistence
      successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
          failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/identity_check" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}

- (void)startRersistenceIdentify:(NSString*)accessTokenRersistence
                 nameRersistence:(NSString*)nameRersistence
       identifyNumberRersistence:(NSString*)identifyNumberRersistence
      successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
          failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/identity" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:nameRersistence forKey:@"name"];
    [bodyDictionary setValue:identifyNumberRersistence forKey:@"identity"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [bodyDictionary setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"app_id"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}


- (void)confirmRersistencePhone:(NSString*)accessTokenRersistence
              verifyRersistence:(NSString*)verifyRersistence
     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/active_phone" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:verifyRersistence forKey:@"verify"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}


- (void)changeRersistencePasswordByPhone:(NSString*)usernameRersistence
              successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/cp_phone" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}
- (void)changeRersistencePasswordByEmail:(NSString*)usernameRersistence
              successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/cp_email" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}


- (void)confirmchangeRersistencePasswordByPhone:(NSString*)usernameRersistence
                            passwordRersistence:(NSString*)passwordRersistence
                              verifyRersistence:(NSString*)verifyRersistence
                     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/ccp_phone" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:passwordRersistence forKey:@"password"];
    [bodyDictionary setValue:verifyRersistence forKey:@"verify"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
         bodyDictionaryRersistence:bodyDictionary
        successCallbackRersistence:successCallbackRersistence
            failCallbackRersistence:failCallbackRersistence];
}
- (void)confirmRersistenceChangePasswordByEmail:(NSString*)usernameRersistence
                            passwordRersistence:(NSString*)passwordRersistence
                              verifyRersistence:(NSString*)verifyRersistence
                     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/ccp_email" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:usernameRersistence forKey:@"username"];
    [bodyDictionary setValue:passwordRersistence forKey:@"password"];
    [bodyDictionary setValue:verifyRersistence forKey:@"verify"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}





-(void)getRersistenceHistoryUserNameByImei:(NSString *)imeiRersistence
                           idfaRersistence:(NSString *)idfaRersistence
                successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                    failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/getHistoryUserNameByImei" andRersistenceParamDictionary:nil];
    NSMutableDictionary *bodyDictionar=[NSMutableDictionary dictionary];
    
    if([idfaRersistence containsString:@"-"]){
        if([[idfaRersistence stringByReplacingOccurrencesOfString:@"-" withString:@""] containsString:@"000000"]){
            [bodyDictionar setValue:imeiRersistence forKey:@"imei"];
        }else{
            [bodyDictionar setValue:idfaRersistence forKey:@"imei"];
        }
    }else{
        [bodyDictionar setValue:idfaRersistence forKey:@"imei"];
    }
    
    [RersistenceWebApi requestPostRersistenceUrl:url bodyDictionaryRersistence:bodyDictionar successCallbackRersistence:successCallbackRersistence failCallbackRersistence:failCallbackRersistence];
    
}




-(void)changeRersistencePasswordWithTokenRersistence:(NSString *)accessTokenRersistence
                   oldPasswordRersistence:(NSString *)oldPasswordRersistence
                   newPasswordRersistence:(NSString *)newPasswordRersistence
               successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                   failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence {
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"user/change_password" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessTokenRersistence forKey:@"access_token"];
    [bodyDictionary setValue:oldPasswordRersistence forKey:@"old_password"];
    [bodyDictionary setValue:newPasswordRersistence forKey:@"new_password"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}




-(void)getRersistenceSupport:(NSString *)appIdRersistence
        onSuccessRersistence:(Rersistence_VSD_BLOCK)successBlockRersistence
         onFailedRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSURL *url = [[RersistenceWebInterface sharedInstance] getUrlRersistenceWithController:@"game/support" andRersistenceParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appIdRersistence forKey:@"app_id"];
    [bodyDictionary setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:bodyDictionary
            successCallbackRersistence:successBlockRersistence
                failCallbackRersistence:failCallbackRersistence];
}
-(void)loadingRersistence:(NSMutableDictionary*) paramRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
   failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence
{
    NSURL *url =[[RersistenceWebInterface sharedInstance]getUrlRersistenceWithController:@"data/loading" andRersistenceParamDictionary:nil];
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:paramRersistence
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}



-(void)createRersistence:(NSMutableDictionary*) paramRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    NSURL *url =[[RersistenceWebInterface sharedInstance]getUrlRersistenceWithController:@"data/create_role" andRersistenceParamDictionary:nil];
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:paramRersistence
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];}






-(void)levelupRersistence:(NSMutableDictionary*) paramRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
 failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence{
    
    self.server_idRersistence = [[NSString alloc] initWithFormat:@"%@", [paramRersistence objectForKey:@"server_id"]];
    self.role_idRersistence = [[NSString alloc] initWithFormat:@"%@", [paramRersistence objectForKey:@"role_id"]];
    self.role_nameRersistence = [[NSString alloc] initWithFormat:@"%@", [paramRersistence objectForKey:@"role_name"]];
    NSURL *url =[[RersistenceWebInterface sharedInstance]getUrlRersistenceWithController:@"data/level" andRersistenceParamDictionary:nil];
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:paramRersistence
            successCallbackRersistence:successCallbackRersistence
                failCallbackRersistence:failCallbackRersistence];
}
-(void)erroRersistence:(NSMutableDictionary*) param
successCallback:(Rersistence_VSD_BLOCK)successCallback
failCallback:(Rersistence_VE_BLOCK)failCallback{
    NSURL *url =[[RersistenceWebInterface sharedInstance]getUrlRersistenceWithController:@"data/error" andRersistenceParamDictionary:nil];
    [RersistenceWebApi requestPostRersistenceUrl:url
             bodyDictionaryRersistence:param
            successCallbackRersistence:successCallback
                failCallbackRersistence:failCallback];
}


@end
