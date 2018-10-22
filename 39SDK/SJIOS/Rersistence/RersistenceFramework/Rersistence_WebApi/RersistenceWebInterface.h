
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"



#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSBase.h>
#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSContextRef.h>
#import <JavaScriptCore/JSValue.h>
#import <JavaScriptCore/WebKitAvailability.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>



@interface RersistenceWebInterface : NSObject

@property(nonatomic, strong) NSString * realRersistenceURL;

@property(nonatomic, strong) NSString * server_idRersistence;
@property(nonatomic, strong) NSString * role_idRersistence;
@property(nonatomic, strong) NSString * role_nameRersistence;


- (void)RersistencesendHeart:(NSString*)userid;

- (NSURL *)getUrlRersistenceWithController:(NSString *)controller andRersistenceParamDictionary:(NSDictionary *)paramDictionary;

-(void)getRersistenceHistoryUserNameByImei:(NSString *)imeiRersistence
                           idfaRersistence:(NSString *)idfaRersistence
                successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                    failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

//手机是否注册过
-(void)checkRersistencePhoneRegist:(NSString*)phoneRersistence
        successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
            failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

//手机注册接口
-(void)phoneRersistenceRegist:(NSString*)phoneRersistence
          passwordRersistence:(NSString*)passwordRersistence
        verifyCodeRersistence:(NSString*)verifyCodeRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

//手机注册发送验证码接口
-(void)phoneRersistenceRegistVerify:(NSString*)phoneRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;



//手机登录接口
-(void)phoneRersistenceLogin:(NSString*)phoneRersistence
               passwordRersistence:(NSString*)passwordRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;


- (void)getRersistenceAntiFlag:(Rersistence_VSD_BLOCK)successCallbackRersistence
             failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

-(void)checkRersistenceUpdate:(NSString*)client_idRersistence
          bundleIdRersistence:(NSString*)bundleIdRersistence
           versionRersistence:(NSString*)versionRersistence
            deviceRersistence:(NSString*)deviceRersistence
        sourceCodeRersistence:(NSString*)sourceCodeRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)Rersistenceinstall:(NSString*)appIdRersistence
   imeiOfDeviceRersistence:(NSString*)imeiRersistence
        channelRersistence:(NSString*)channelRersistence
          modelRersistence:(NSString*)modelRersistence
             osRersistence:(NSString*)osRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
    failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;



- (void)newadRersistenceinstall:dataEncodeRersistence
                signRersistence:signRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;


- (void)normalRersistenceRegister:(NSString*)usernameRersistence
              passwordRersistence:(NSString*)passwordRersistence
       successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
           failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)loginRersistence:(NSString*)usernameRersistence
     passwordRersistence:(NSString*)passwordRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)getRersistenceAccessTokenRersistence:(NSString*)codeRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)getRersistenceUserId:(NSString*)accesstokenRersistence
       successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
           failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)logoutRersistence:(NSString*)usernameRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
   failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

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
        failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)checkRersistenceMail:(NSString*)accessTokenRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)bindRersistenceMail:(NSString*)accessTokenRersistence
           emailRersistence:(NSString*)emailRersistence
 successRersistenceCallback:(Rersistence_VSD_BLOCK)successRersistenceCallback
     failRersistenceCallback:(Rersistence_VE_BLOCK)failRersistenceCallback;

- (void)checkRersistencePhone:(NSString*)accessTokenRersistence
   successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
       failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)bindRersistencePhone:(NSString*)accessTokenRersistence
            phoneRersistence:(NSString*)phoneRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)checkRersistenceIdentify:(NSString*)accessTokenRersistence
  successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
      failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)startRersistenceIdentify:(NSString*)accessTokenRersistence
                 nameRersistence:(NSString*)nameRersistence
       identifyNumberRersistence:(NSString*)identifyNumberRersistence
      successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
          failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;



- (void)confirmRersistencePhone:(NSString*)accessTokenRersistence
              verifyRersistence:(NSString*)verifyRersistence
     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)changeRersistencePasswordByPhone:(NSString*)usernameRersistence
              successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)confirmchangeRersistencePasswordByPhone:(NSString*)usernameRersistence
                            passwordRersistence:(NSString*)passwordRersistence
                              verifyRersistence:(NSString*)verifyRersistence
                     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;




- (void)fastRersistenceRegisterRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;


+(RersistenceWebInterface*)sharedInstance;

-(void)changeRersistencePasswordWithTokenRersistence:(NSString *)accessTokenRersistence
                   oldPasswordRersistence:(NSString *)oldPasswordRersistence
                   newPasswordRersistence:(NSString *)newPasswordRersistence
               successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                   failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;



-(void)getRersistenceSupport:(NSString *)appIdRersistence
        onSuccessRersistence:(Rersistence_VSD_BLOCK)successBlockRersistence
         onFailedRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;


-(void)loadingRersistence:(NSMutableDictionary*) paramRersistence
 successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
    failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;



-(void)createRersistence:(NSMutableDictionary*) paramRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;




-(void)levelupRersistence:(NSMutableDictionary*) paramRersistence
successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
    failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

-(void)erroRersistence:(NSMutableDictionary*) param
successCallback:(Rersistence_VSD_BLOCK)successCallback
 failCallback:(Rersistence_VE_BLOCK)failCallback;

-(void)bindRersistenceRegister:(NSString*) usernameRersistence
           passwordRersistence:(NSString*)passwordRersistence
       bindUsernameRersistence:(NSString*) bindUsernameRersistence
    successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
        failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;


- (void)changeRersistencePasswordByEmail:(NSString*)usernameRersistence
              successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                  failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

- (void)confirmRersistenceChangePasswordByEmail:(NSString*)usernameRersistence
                            passwordRersistence:(NSString*)passwordRersistence
                              verifyRersistence:(NSString*)verifyRersistence
                     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
                         failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

-(void)checkPRersistenceyTypeUrl:(Rersistence_VSD_BLOCK)successCallbackRersistence
             failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

-(void)RersistenceSdkRersistenceCheck:(NSString *)orRersistencederId
              descriptionRersistence:(NSString *)descriptionRersistence
     successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
              failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;
@end
