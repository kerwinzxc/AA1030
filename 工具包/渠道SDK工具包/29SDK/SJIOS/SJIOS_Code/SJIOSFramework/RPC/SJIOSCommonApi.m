
#import "SJIOSCommonApi.h"
#import "SJIOSRPC.h"
#import "SJIOSSdkImp.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSProgressHUD.h"

#pragma mark private method

#define SJIOS_SERVER_API_URL1 @"http://www.3"  //release
#define SJIOS_SERVER_API_URL2 @"9sdk.com/"  //release

#define SJIOS_AD_SERVER_API_URL1 @"http://newapi.3"
#define SJIOS_AD_SERVER_API_URL2 @"975ad.com:8080/game/index/index/"

@implementation SJIOSCommonApi

+(SJIOSCommonApi*)sharedInstance
{
    static __strong SJIOSCommonApi * g_SJIOSSdkImp = nil;
    if (g_SJIOSSdkImp == nil)
    {
        g_SJIOSSdkImp = [SJIOSCommonApi alloc];
    }
    
    return g_SJIOSSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", SJIOS_SERVER_API_URL1, SJIOS_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlSJIOSWithController:(NSString *)controller andParamDictionary:(NSDictionary *)paramDictionary
{
    
    self.realURL = [[NSString alloc] initWithFormat:@"%@", [self validateUrl]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.realURL, controller];
    NSURL *url = [NSURL URLWithString:urlString];
    
    for (NSString *key in paramDictionary)
    {
        url = [url appendQueryKey:key andValue:[NSString stringWithFormat:@"%@", [paramDictionary valueForKey:key]]];
    }
    
    return url;
}




//手机是否注册过
-(void)checkSJIOSPhoneRegist:(NSString*)phone
        completionBlock:(SJIOS_VSD_BLOCK)completionBlock
            failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/checkphoneregister" andParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] channel];
    NSString * client_id = [[SJIOSSdkImp sharedInstance] appKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];

}

//手机注册接口
-(void)phoneSJIOSRegist:(NSString*)phone
          password:(NSString*)password
        verifyCode:(NSString*)verifyCode
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/phoneregister" andParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] channel];
    NSString * client_id = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,password,phone,verifyCode];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:verifyCode forKey:@"token"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

//手机注册发送验证码接口
-(void)phoneSJIOSRegistVerify:(NSString*)phone
         completionBlock:(SJIOS_VSD_BLOCK)completionBlock
             failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/fastregisterphone" andParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];

    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
    
}


//手机登录接口
-(void)phoneSJIOSLogin:(NSString*)phone
         password:(NSString*)password
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/phonelogin" andParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] channel];
    NSString * client_id = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,password,phone];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


-(void)checkSJIOSUpdate:(NSString*)client_id
          bundleId:(NSString*)bundleId
           version:(NSString*)version
            device:(NSString*)device
        sourceCode:(NSString*)sourceCode
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"update/check_update" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:bundleId forKey:@"bundleId"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:device forKey:@"device"];
    [bodyDictionary setValue:sourceCode forKey:@"sourceCode"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];

}

- (void)SJIOSinstall:(NSString*)appId
   imeiOfDevice:(NSString*)imei
        channel:(NSString*)channel
          model:(NSString*)model
             os:(NSString*)os
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
    failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"data/install" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appId forKey:@"app_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:model forKey:@"model"];
    [bodyDictionary setValue:os forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)newadSJIOSinstall:dataEncode
                sign:sign
     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
         failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", SJIOS_AD_SERVER_API_URL1, SJIOS_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncode forKey:@"data"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


-(void)bindSJIOSRegister:(NSString*) username
           password:(NSString*)password
       bindUsername:(NSString*) bindUsername
    completionBlock:(SJIOS_VSD_BLOCK)completionBlock
        failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/bind_username" andParamDictionary:nil];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, password, username, clientId, bindUsername];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsername forKey:@"username"];
    [bodyDictionary setValue:username forKey:@"bind_username"];
    [bodyDictionary setValue:password forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
    
}
- (void)normalSJIOSRegister:(NSString*)username
              password:(NSString*)password
       completionBlock:(SJIOS_VSD_BLOCK)completionBlock
           failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/register" andParamDictionary:nil];
    
    NSString * imei = [SJIOSSdkImp getIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] channel];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] version];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, password, username];
    NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}

- (void)fastSJIOSRegister:(SJIOS_VSD_BLOCK)completionBlock
         failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/fast_register_v04" andParamDictionary:nil];
    NSString * imei = [[SJIOSSdkImp sharedInstance] imei];
    NSString * channel = [[SJIOSSdkImp sharedInstance] channel];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] version];
     NSString *idfa=[SJIOSSdkImp getIdfa];
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
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}



- (void)login:(NSString*)username
     password:(NSString*)password
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
  failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/login" andParamDictionary:nil];
    NSString * imei = [SJIOSSdkImp getIdfa];
    NSString * channel = [[SJIOSSdkImp sharedInstance] channel];
    NSString * clientId = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] version];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, password, username];
     NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

-(void) getSJIOSAccessToken:(NSString *)code
       completionBlock:(SJIOS_VSD_BLOCK)completionBlock
           failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/token" andParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] appKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] appSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:code forKey:@"code"];
    [bodyDictionary setValue:SJIOS_SDK_VERSION forKey:@"version"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                     failedBlock:failedBlock];
}

-(void) getSJIOSUserId:(NSString *)accesstoken
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/me" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstoken forKey:@"access_token"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];

}

-(void)checkPSJIOSyTypeUrl:(SJIOS_VSD_BLOCK)completionBlock
             failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:a andParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] appId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

-(void)SJIOSSdkPyCheck:(NSString *)orderId
         description:(NSString *)description
     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
         failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:a andParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orderId forKey:@"orderid"];
    [bodyDictionary setValue:description forKey:@"description"];
    [bodyDictionary setValue:[[SJIOSSdkImp sharedInstance] appId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

- (void)logout:(NSString*)username
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
   failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"oauth2/logout" andParamDictionary:nil];
    
    NSString * clientId = [[SJIOSSdkImp sharedInstance] appKey];
    NSString * privateKey = [[SJIOSSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[SJIOSSdkImp sharedInstance] version];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, username];
        NSString * sign = [SJIOSSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)createOrSJIOSder:(NSString*)accessToken
             userId:(NSString*)userId
        productName:(NSString*)productName
          productId:(NSString*)productId
            account:(NSInteger)account
         appOrderId:(NSString*)appOrderId
            appName:(NSString*)appName
           clientId:(NSString*)clientId
            gateway:(NSInteger)gateway
            channel:(NSString*)channel
          orderType:(NSString*)orderType
              extra:(NSString*)extra
             extend:(NSString*)extend
               sign:(NSString*)sign
    completionBlock:(SJIOS_VSD_BLOCK)completionBlock
        failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:a andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:userId forKey:@"user_id"];
    [bodyDictionary setValue:productName forKey:@"product_name"];
    [bodyDictionary setValue:productId forKey:@"product_id"];
    [bodyDictionary setValue:[[NSString alloc] initWithFormat:@"%ld", (long)account] forKey:@"account"];
    [bodyDictionary setValue:appOrderId forKey:@"app_order_id"];
    [bodyDictionary setValue:appName forKey:@"app_name"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:[NSString stringWithFormat:@"%ld", (long)gateway] forKey:@"gateway"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:orderType forKey:@"order_type"];
    [bodyDictionary setValue:extra forKey:@"extra"];
    [bodyDictionary setValue:extend forKey:@"extend"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"gamename"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    [bodyDictionary setValue:SJIOS_SDK_VERSION forKey:@"version"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}

- (void)checkSJIOSMail:(NSString*)accessToken
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/check_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}

- (void)bindSJIOSMail:(NSString*)accessToken
           email:(NSString*)email
 completionBlock:(SJIOS_VSD_BLOCK)completionBlock
     failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/bind_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:email forKey:@"email"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)checkSJIOSPhone:(NSString*)accessToken
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/check_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


-(void)bindSJIOSPhone:(NSString*)accessToken
            phone:(NSString*)phone
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/bind_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)checkSJIOSIdentify:(NSString*)accessToken
      completionBlock:(SJIOS_VSD_BLOCK)completionBlock
          failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/identity_check" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

- (void)startSJIOSIdentify:(NSString*)accessToken
                 name:(NSString*)name
       identifyNumber:(NSString*)identifyNumber
      completionBlock:(SJIOS_VSD_BLOCK)completionBlock
          failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/identity" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:name forKey:@"name"];
    [bodyDictionary setValue:identifyNumber forKey:@"identity"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


- (void)confirmSJIOSPhone:(NSString*)accessToken
              verify:(NSString*)verify
     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
         failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/active_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:verify forKey:@"verify"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)changeSJIOSPasswordByPhone:(NSString*)username
              completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                  failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/cp_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}
- (void)changeSJIOSPasswordByEmail:(NSString*)username
              completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                  failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/cp_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


- (void)confirmchangeSJIOSPasswordByPhone:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                         failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/ccp_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:verify forKey:@"verify"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}
- (void)confirmSJIOSChangePasswordByEmail:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                         failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/ccp_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:verify forKey:@"verify"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}





-(void)getSJIOSHistoryUserNameByImei:(NSString *)imei
                           idfa:(NSString *)idfa
                completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                    failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/getHistoryUserNameByImei" andParamDictionary:nil];
    NSMutableDictionary *bodyDictionar=[NSMutableDictionary dictionary];
    
    if([idfa containsString:@"-"]){
        if([[idfa stringByReplacingOccurrencesOfString:@"-" withString:@""] containsString:@"000000"]){
            [bodyDictionar setValue:imei forKey:@"imei"];
        }else{
            [bodyDictionar setValue:idfa forKey:@"imei"];
        }
    }else{
        [bodyDictionar setValue:idfa forKey:@"imei"];
    }
    
    [SJIOSRPC requestPostSJIOSUrl:url bodyDictionary:bodyDictionar completionBlock:completionBlock failedBlock:failedBlock];
    
}




-(void)changeSJIOSPasswordWithToken:(NSString *)accessToken
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
               completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                   failedBlock:(SJIOS_VE_BLOCK)failedBlock {
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"user/change_password" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:oldPassword forKey:@"old_password"];
    [bodyDictionary setValue:newPassword forKey:@"new_password"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}




-(void)getSJIOSSupport:(NSString *)appId
        onSuccess:(SJIOS_VSD_BLOCK)successBlock
         onFailed:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url = [[SJIOSCommonApi sharedInstance] getUrlSJIOSWithController:@"game/support" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appId forKey:@"app_id"];
    [bodyDictionary setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:successBlock
                failedBlock:failedBlock];
}
-(void)loadingSJIOS:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
   failedBlock:(SJIOS_VE_BLOCK)failedBlock
{
    NSURL *url =[[SJIOSCommonApi sharedInstance]getUrlSJIOSWithController:@"data/loading" andParamDictionary:nil];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}



-(void)createSJIOS:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
  failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url =[[SJIOSCommonApi sharedInstance]getUrlSJIOSWithController:@"data/create_role" andParamDictionary:nil];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];}




-(void)login:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
 failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url =[[SJIOSCommonApi sharedInstance]getUrlSJIOSWithController:@"data/login" andParamDictionary:nil];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];}









-(void)loginSJIOSout:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
    failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url =[[SJIOSCommonApi sharedInstance]getUrlSJIOSWithController:@"data/logout" andParamDictionary:nil];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

-(void)level:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
 failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url =[[SJIOSCommonApi sharedInstance]getUrlSJIOSWithController:@"data/level" andParamDictionary:nil];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}
-(void)erroSJIOS:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
failedBlock:(SJIOS_VE_BLOCK)failedBlock{
    NSURL *url =[[SJIOSCommonApi sharedInstance]getUrlSJIOSWithController:@"data/error" andParamDictionary:nil];
    [SJIOSRPC requestPostSJIOSUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}



+(void) showSJIOSToast:(UIView*) view text:(NSString*) message
{
    SJIOSProgressHUD *hud = [SJIOSProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide =YES;
    hud.mode = SJIOSProgressHUDModeCustomView;
    hud.labelText = message;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [hud hide:YES afterDelay:2];
}
@end
