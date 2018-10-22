
#import "UnnHeTooCommonApi.h"
#import "UnnHeTooRPC.h"
#import "UnnHeTooSdkImp.h"
#import "UnnHeTooSdkMd5.h"
#import "UnnHeTooProgressHUD.h"

#pragma mark private method

#define UnnHeToo_SERVER_API_URL1 @"http://www.3"  //release
#define UnnHeToo_SERVER_API_URL2 @"9sdk.com/"  //release

#define UnnHeToo_AD_SERVER_API_URL1 @"http://newapi.3"
#define UnnHeToo_AD_SERVER_API_URL2 @"975ad.com:8080/game/index/index/"

@implementation UnnHeTooCommonApi

+(UnnHeTooCommonApi*)sharedInstance
{
    static __strong UnnHeTooCommonApi * g_UnnHeTooSdkImp = nil;
    if (g_UnnHeTooSdkImp == nil)
    {
        g_UnnHeTooSdkImp = [UnnHeTooCommonApi alloc];
    }
    
    return g_UnnHeTooSdkImp;
}

-(NSString *) validateUrl{

    NSString *uuu = [NSString stringWithFormat:@"%@%@", UnnHeToo_SERVER_API_URL1, UnnHeToo_SERVER_API_URL2];
    return uuu;

    
}


- (NSURL *)getUrlUnnHeTooWithController:(NSString *)controller andParamDictionary:(NSDictionary *)paramDictionary
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
-(void)checkUnnHeTooPhoneRegist:(NSString*)phone
        completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
            failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/checkphoneregister" andParamDictionary:nil];
    NSString * imei = [UnnHeTooSdkImp getIdfa];
    NSString * channel = [[UnnHeTooSdkImp sharedInstance] channel];
    NSString * client_id = [[UnnHeTooSdkImp sharedInstance] appKey];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];

}

//手机注册接口
-(void)phoneUnnHeTooRegist:(NSString*)phone
          password:(NSString*)password
        verifyCode:(NSString*)verifyCode
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/phoneregister" andParamDictionary:nil];
    NSString * imei = [UnnHeTooSdkImp getIdfa];
    NSString * channel = [[UnnHeTooSdkImp sharedInstance] channel];
    NSString * client_id = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@token%@",
                          privateKey,channel,client_id,imei,password,phone,verifyCode];
    NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:verifyCode forKey:@"token"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

//手机注册发送验证码接口
-(void)phoneUnnHeTooRegistVerify:(NSString*)phone
         completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
             failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/fastregisterphone" andParamDictionary:nil];
    NSString * imei = [UnnHeTooSdkImp getIdfa];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:imei forKey:@"imei"];

    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
    
}


//手机登录接口
-(void)phoneUnnHeTooLogin:(NSString*)phone
         password:(NSString*)password
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/phonelogin" andParamDictionary:nil];
    NSString * imei = [UnnHeTooSdkImp getIdfa];
    NSString * channel = [[UnnHeTooSdkImp sharedInstance] channel];
    NSString * client_id = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * gamename = [[NSBundle mainBundle] bundleIdentifier];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@phone%@",
                          privateKey,channel,client_id,imei,password,phone];
    NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gamename forKey:@"gamename"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


-(void)checkUnnHeTooUpdate:(NSString*)client_id
          bundleId:(NSString*)bundleId
           version:(NSString*)version
            device:(NSString*)device
        sourceCode:(NSString*)sourceCode
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"update/check_update" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:client_id forKey:@"client_id"];
    [bodyDictionary setValue:bundleId forKey:@"bundleId"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:device forKey:@"device"];
    [bodyDictionary setValue:sourceCode forKey:@"sourceCode"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];

}

- (void)UnnHeTooinstall:(NSString*)appId
   imeiOfDevice:(NSString*)imei
        channel:(NSString*)channel
          model:(NSString*)model
             os:(NSString*)os
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"data/install" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appId forKey:@"app_id"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:model forKey:@"model"];
    [bodyDictionary setValue:os forKey:@"os"];
    [bodyDictionary setValue:@"apple" forKey:@"platform"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)newadUnnHeTooinstall:dataEncode
                sign:sign
     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSString *uuu = [NSString stringWithFormat:@"%@%@", UnnHeToo_AD_SERVER_API_URL1, UnnHeToo_AD_SERVER_API_URL2];
    
    NSURL *url = [NSURL URLWithString:uuu];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:dataEncode forKey:@"data"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


-(void)bindUnnHeTooRegister:(NSString*) username
           password:(NSString*)password
       bindUsername:(NSString*) bindUsername
    completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
        failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/bind_username" andParamDictionary:nil];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * clientId = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@bind_password%@bind_username%@client_id%@username%@",
                          privateKey, password, username, clientId, bindUsername];
    NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:bindUsername forKey:@"username"];
    [bodyDictionary setValue:username forKey:@"bind_username"];
    [bodyDictionary setValue:password forKey:@"bind_password"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
    
}
- (void)normalUnnHeTooRegister:(NSString*)username
              password:(NSString*)password
       completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
           failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/register" andParamDictionary:nil];
    
    NSString * imei = [UnnHeTooSdkImp getIdfa];
    NSString * channel = [[UnnHeTooSdkImp sharedInstance] channel];
    NSString * clientId = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[UnnHeTooSdkImp sharedInstance] version];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, password, username];
    NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}

- (void)fastUnnHeTooRegister:(UnnHeToo_VSD_BLOCK)completionBlock
         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/fast_register_v04" andParamDictionary:nil];
    NSString * imei = [[UnnHeTooSdkImp sharedInstance] imei];
    NSString * channel = [[UnnHeTooSdkImp sharedInstance] channel];
    NSString * clientId = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[UnnHeTooSdkImp sharedInstance] version];
     NSString *idfa=[UnnHeTooSdkImp getIdfa];
    NSString * gameName = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@idfa%@imei%@",
                          privateKey, channel, clientId, idfa,imei];
      NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
     [bodyDictionary setValue:idfa forKey:@"idfa"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:gameName forKey:@"gamename"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}



- (void)login:(NSString*)username
     password:(NSString*)password
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/login" andParamDictionary:nil];
    NSString * imei = [UnnHeTooSdkImp getIdfa];
    NSString * channel = [[UnnHeTooSdkImp sharedInstance] channel];
    NSString * clientId = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[UnnHeTooSdkImp sharedInstance] version];
    
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@channel%@client_id%@imei%@password%@username%@",
                          privateKey, channel, clientId, imei, password, username];
     NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:channel forKey:@"channel"];
    [bodyDictionary setValue:imei forKey:@"imei"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

-(void) getUnnHeTooAccessToken:(NSString *)code
       completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
           failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/token" andParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:@"authorization_code" forKey:@"grant_type"];
    [bodyDictionary setValue:[[UnnHeTooSdkImp sharedInstance] appKey] forKey:@"client_id"];
    [bodyDictionary setValue:[[UnnHeTooSdkImp sharedInstance] appSecret] forKey:@"client_secret"];
    [bodyDictionary setValue:@"oob" forKey:@"redirect_uri"];
    [bodyDictionary setValue:code forKey:@"code"];
    [bodyDictionary setValue:UnnHeToo_SDK_VERSION forKey:@"version"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                     failedBlock:failedBlock];
}

-(void) getUnnHeTooUserId:(NSString *)accesstoken
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/me" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accesstoken forKey:@"access_token"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];

}

-(void)checkPUnnHeTooyTypeUrl:(UnnHeToo_VSD_BLOCK)completionBlock
             failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSString *a = [[NSString alloc] initWithFormat:@"oauth2/checkp%@", @"ay"];
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:a andParamDictionary:nil];
    
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:[[UnnHeTooSdkImp sharedInstance] appId] forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

-(void)UnnHeTooSdkPyCheck:(NSString *)orderId
         description:(NSString *)description
     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/notifyappstore"];
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:a andParamDictionary:nil];

    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:orderId forKey:@"orderid"];
    [bodyDictionary setValue:description forKey:@"description"];
    [bodyDictionary setValue:[[UnnHeTooSdkImp sharedInstance] appId]  forKey:@"client_id"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] forKey:@"client_package"];
    [bodyDictionary setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"client_version"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

- (void)logout:(NSString*)username
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
   failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"oauth2/logout" andParamDictionary:nil];
    
    NSString * clientId = [[UnnHeTooSdkImp sharedInstance] appKey];
    NSString * privateKey = [[UnnHeTooSdkImp sharedInstance] appPrivateKey];
    NSString * version = [[UnnHeTooSdkImp sharedInstance] version];
    NSString * signSrc = [[NSString alloc] initWithFormat:@"%@client_id%@username%@",
                          privateKey, clientId, username];
        NSString * sign = [UnnHeTooSdkMd5 md5:signSrc];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:clientId forKey:@"client_id"];
    [bodyDictionary setValue:version forKey:@"version"];
    [bodyDictionary setValue:sign forKey:@"sign"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)createOrUnnHeTooder:(NSString*)accessToken
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
    completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
        failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"y/create_order_new"];
    
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:a andParamDictionary:nil];
    
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
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    [bodyDictionary setValue:UnnHeToo_SDK_VERSION forKey:@"version"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}

- (void)checkUnnHeTooMail:(NSString*)accessToken
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/check_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}

- (void)bindUnnHeTooMail:(NSString*)accessToken
           email:(NSString*)email
 completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
     failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/bind_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:email forKey:@"email"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)checkUnnHeTooPhone:(NSString*)accessToken
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/check_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


-(void)bindUnnHeTooPhone:(NSString*)accessToken
            phone:(NSString*)phone
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/bind_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:phone forKey:@"phone"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)checkUnnHeTooIdentify:(NSString*)accessToken
      completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
          failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/identity_check" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

- (void)startUnnHeTooIdentify:(NSString*)accessToken
                 name:(NSString*)name
       identifyNumber:(NSString*)identifyNumber
      completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
          failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/identity" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:name forKey:@"name"];
    [bodyDictionary setValue:identifyNumber forKey:@"identity"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


- (void)confirmUnnHeTooPhone:(NSString*)accessToken
              verify:(NSString*)verify
     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/active_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:verify forKey:@"verify"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}


- (void)changeUnnHeTooPasswordByPhone:(NSString*)username
              completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/cp_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}
- (void)changeUnnHeTooPasswordByEmail:(NSString*)username
              completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/cp_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}


- (void)confirmchangeUnnHeTooPasswordByPhone:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/ccp_phone" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:verify forKey:@"verify"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
         bodyDictionary:bodyDictionary
        completionBlock:completionBlock
            failedBlock:failedBlock];
}
- (void)confirmUnnHeTooChangePasswordByEmail:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/ccp_email" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:username forKey:@"username"];
    [bodyDictionary setValue:password forKey:@"password"];
    [bodyDictionary setValue:verify forKey:@"verify"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}





-(void)getUnnHeTooHistoryUserNameByImei:(NSString *)imei
                           idfa:(NSString *)idfa
                completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/getHistoryUserNameByImei" andParamDictionary:nil];
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
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url bodyDictionary:bodyDictionar completionBlock:completionBlock failedBlock:failedBlock];
    
}




-(void)changeUnnHeTooPasswordWithToken:(NSString *)accessToken
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
               completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                   failedBlock:(UnnHeToo_VE_BLOCK)failedBlock {
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"user/change_password" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:accessToken forKey:@"access_token"];
    [bodyDictionary setValue:oldPassword forKey:@"old_password"];
    [bodyDictionary setValue:newPassword forKey:@"new_password"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:completionBlock
                failedBlock:failedBlock];
}




-(void)getUnnHeTooSupport:(NSString *)appId
        onSuccess:(UnnHeToo_VSD_BLOCK)successBlock
         onFailed:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url = [[UnnHeTooCommonApi sharedInstance] getUrlUnnHeTooWithController:@"game/support" andParamDictionary:nil];
    
    NSMutableDictionary *bodyDictionary = [NSMutableDictionary dictionary];
    [bodyDictionary setValue:appId forKey:@"app_id"];
    [bodyDictionary setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:bodyDictionary
            completionBlock:successBlock
                failedBlock:failedBlock];
}
-(void)loadingUnnHeToo:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
   failedBlock:(UnnHeToo_VE_BLOCK)failedBlock
{
    NSURL *url =[[UnnHeTooCommonApi sharedInstance]getUrlUnnHeTooWithController:@"data/loading" andParamDictionary:nil];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}



-(void)createUnnHeToo:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url =[[UnnHeTooCommonApi sharedInstance]getUrlUnnHeTooWithController:@"data/create_role" andParamDictionary:nil];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];}




-(void)login:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
 failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url =[[UnnHeTooCommonApi sharedInstance]getUrlUnnHeTooWithController:@"data/login" andParamDictionary:nil];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];}









-(void)loginUnnHeTooout:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url =[[UnnHeTooCommonApi sharedInstance]getUrlUnnHeTooWithController:@"data/logout" andParamDictionary:nil];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}

-(void)level:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
 failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url =[[UnnHeTooCommonApi sharedInstance]getUrlUnnHeTooWithController:@"data/level" andParamDictionary:nil];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}
-(void)erroUnnHeToo:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
failedBlock:(UnnHeToo_VE_BLOCK)failedBlock{
    NSURL *url =[[UnnHeTooCommonApi sharedInstance]getUrlUnnHeTooWithController:@"data/error" andParamDictionary:nil];
    [UnnHeTooRPC requestPostUnnHeTooUrl:url
             bodyDictionary:param
            completionBlock:completionBlock
                failedBlock:failedBlock];
}



+(void) showUnnHeTooToast:(UIView*) view text:(NSString*) message
{
    UnnHeTooProgressHUD *hud = [UnnHeTooProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide =YES;
    hud.mode = UnnHeTooProgressHUDModeCustomView;
    hud.labelText = message;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [hud hide:YES afterDelay:2];
}
@end
