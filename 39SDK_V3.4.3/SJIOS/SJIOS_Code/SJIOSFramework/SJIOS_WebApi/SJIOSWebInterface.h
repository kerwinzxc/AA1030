
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SJIOSSdkCommonDefine.h"





@interface SJIOSWebInterface : NSObject

@property(nonatomic, strong) NSString * realSJIOSURL;

@property(nonatomic, strong) NSString * server_idSJIOS;
@property(nonatomic, strong) NSString * role_idSJIOS;
@property(nonatomic, strong) NSString * role_nameSJIOS;


- (void)SJIOSsendHeart:(NSString*)userid;

- (NSURL *)getUrlSJIOSWithController:(NSString *)controller andSJIOSParamDictionary:(NSDictionary *)paramDictionary;

-(void)getSJIOSHistoryUserNameByImei:(NSString *)imeiSJIOS
                           idfaSJIOS:(NSString *)idfaSJIOS
                successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                    failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

//手机是否注册过
-(void)checkSJIOSPhoneRegist:(NSString*)phoneSJIOS
        successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
            failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

//手机注册接口
-(void)phoneSJIOSRegist:(NSString*)phoneSJIOS
          passwordSJIOS:(NSString*)passwordSJIOS
        verifyCodeSJIOS:(NSString*)verifyCodeSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

//手机注册发送验证码接口
-(void)phoneSJIOSRegistVerify:(NSString*)phoneSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;



//手机登录接口
-(void)phoneSJIOSLogin:(NSString*)phoneSJIOS
               passwordSJIOS:(NSString*)passwordSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;


- (void)getSJIOSAntiFlag:(SJIOS_VSD_BLOCK)successCallbackSJIOS
             failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

-(void)checkSJIOSUpdate:(NSString*)client_idSJIOS
          bundleIdSJIOS:(NSString*)bundleIdSJIOS
           versionSJIOS:(NSString*)versionSJIOS
            deviceSJIOS:(NSString*)deviceSJIOS
        sourceCodeSJIOS:(NSString*)sourceCodeSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)SJIOSinstall:(NSString*)appIdSJIOS
   imeiOfDeviceSJIOS:(NSString*)imeiSJIOS
        channelSJIOS:(NSString*)channelSJIOS
          modelSJIOS:(NSString*)modelSJIOS
             osSJIOS:(NSString*)osSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
    failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;



- (void)newadSJIOSinstall:dataEncodeSJIOS
                signSJIOS:signSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;


- (void)normalSJIOSRegister:(NSString*)usernameSJIOS
              passwordSJIOS:(NSString*)passwordSJIOS
       successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
           failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)loginSJIOS:(NSString*)usernameSJIOS
     passwordSJIOS:(NSString*)passwordSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)getSJIOSAccessTokenSJIOS:(NSString*)codeSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)getSJIOSUserId:(NSString*)accesstokenSJIOS
       successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
           failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)logoutSJIOS:(NSString*)usernameSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
   failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

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
        failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)checkSJIOSMail:(NSString*)accessTokenSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)bindSJIOSMail:(NSString*)accessTokenSJIOS
           emailSJIOS:(NSString*)emailSJIOS
 successSJIOSCallback:(SJIOS_VSD_BLOCK)successSJIOSCallback
     failSJIOSCallback:(SJIOS_VE_BLOCK)failSJIOSCallback;

- (void)checkSJIOSPhone:(NSString*)accessTokenSJIOS
   successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
       failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)bindSJIOSPhone:(NSString*)accessTokenSJIOS
            phoneSJIOS:(NSString*)phoneSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)checkSJIOSIdentify:(NSString*)accessTokenSJIOS
  successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
      failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)startSJIOSIdentify:(NSString*)accessTokenSJIOS
                 nameSJIOS:(NSString*)nameSJIOS
       identifyNumberSJIOS:(NSString*)identifyNumberSJIOS
      successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
          failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;



- (void)confirmSJIOSPhone:(NSString*)accessTokenSJIOS
              verifySJIOS:(NSString*)verifySJIOS
     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)changeSJIOSPasswordByPhone:(NSString*)usernameSJIOS
              successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)confirmchangeSJIOSPasswordByPhone:(NSString*)usernameSJIOS
                            passwordSJIOS:(NSString*)passwordSJIOS
                              verifySJIOS:(NSString*)verifySJIOS
                     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;




- (void)fastSJIOSRegisterSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;


+(SJIOSWebInterface*)sharedInstance;

-(void)changeSJIOSPasswordWithTokenSJIOS:(NSString *)accessTokenSJIOS
                   oldPasswordSJIOS:(NSString *)oldPasswordSJIOS
                   newPasswordSJIOS:(NSString *)newPasswordSJIOS
               successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                   failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;



-(void)getSJIOSSupport:(NSString *)appIdSJIOS
        onSuccessSJIOS:(SJIOS_VSD_BLOCK)successBlockSJIOS
         onFailedSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;


-(void)loadingSJIOS:(NSMutableDictionary*) paramSJIOS
 successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
    failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;



-(void)createSJIOS:(NSMutableDictionary*) paramSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;




-(void)levelupSJIOS:(NSMutableDictionary*) paramSJIOS
successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
    failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

-(void)erroSJIOS:(NSMutableDictionary*) param
successCallback:(SJIOS_VSD_BLOCK)successCallback
 failCallback:(SJIOS_VE_BLOCK)failCallback;

-(void)bindSJIOSRegister:(NSString*) usernameSJIOS
           passwordSJIOS:(NSString*)passwordSJIOS
       bindUsernameSJIOS:(NSString*) bindUsernameSJIOS
    successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
        failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;


- (void)changeSJIOSPasswordByEmail:(NSString*)usernameSJIOS
              successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                  failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

- (void)confirmSJIOSChangePasswordByEmail:(NSString*)usernameSJIOS
                            passwordSJIOS:(NSString*)passwordSJIOS
                              verifySJIOS:(NSString*)verifySJIOS
                     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
                         failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

-(void)checkPSJIOSyTypeUrl:(SJIOS_VSD_BLOCK)successCallbackSJIOS
             failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

-(void)SJIOSSdkSJIOSCheck:(NSString *)orSJIOSderId
              descriptionSJIOS:(NSString *)descriptionSJIOS
     successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
              failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;
@end
