
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"



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



@interface UsequenceWebInterface : NSObject

@property(nonatomic, strong) NSString * realUsequenceURL;

@property(nonatomic, strong) NSString * server_idUsequence;
@property(nonatomic, strong) NSString * role_idUsequence;
@property(nonatomic, strong) NSString * role_nameUsequence;


- (void)UsequencesendHeart:(NSString*)userid;

- (NSURL *)getUrlUsequenceWithController:(NSString *)controller andUsequenceParamDictionary:(NSDictionary *)paramDictionary;

-(void)getUsequenceHistoryUserNameByImei:(NSString *)imeiUsequence
                           idfaUsequence:(NSString *)idfaUsequence
                successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                    failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

//手机是否注册过
-(void)checkUsequencePhoneRegist:(NSString*)phoneUsequence
        successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
            failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

//手机注册接口
-(void)phoneUsequenceRegist:(NSString*)phoneUsequence
          passwordUsequence:(NSString*)passwordUsequence
        verifyCodeUsequence:(NSString*)verifyCodeUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

//手机注册发送验证码接口
-(void)phoneUsequenceRegistVerify:(NSString*)phoneUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;



//手机登录接口
-(void)phoneUsequenceLogin:(NSString*)phoneUsequence
               passwordUsequence:(NSString*)passwordUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;


- (void)getUsequenceAntiFlag:(Usequence_VSD_BLOCK)successCallbackUsequence
             failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

-(void)checkUsequenceUpdate:(NSString*)client_idUsequence
          bundleIdUsequence:(NSString*)bundleIdUsequence
           versionUsequence:(NSString*)versionUsequence
            deviceUsequence:(NSString*)deviceUsequence
        sourceCodeUsequence:(NSString*)sourceCodeUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)Usequenceinstall:(NSString*)appIdUsequence
   imeiOfDeviceUsequence:(NSString*)imeiUsequence
        channelUsequence:(NSString*)channelUsequence
          modelUsequence:(NSString*)modelUsequence
             osUsequence:(NSString*)osUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
    failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;



- (void)newadUsequenceinstall:dataEncodeUsequence
                signUsequence:signUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;


- (void)normalUsequenceRegister:(NSString*)usernameUsequence
              passwordUsequence:(NSString*)passwordUsequence
       successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
           failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)loginUsequence:(NSString*)usernameUsequence
     passwordUsequence:(NSString*)passwordUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)getUsequenceAccessTokenUsequence:(NSString*)codeUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)getUsequenceUserId:(NSString*)accesstokenUsequence
       successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
           failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)logoutUsequence:(NSString*)usernameUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
   failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

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
        failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)checkUsequenceMail:(NSString*)accessTokenUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)bindUsequenceMail:(NSString*)accessTokenUsequence
           emailUsequence:(NSString*)emailUsequence
 successUsequenceCallback:(Usequence_VSD_BLOCK)successUsequenceCallback
     failUsequenceCallback:(Usequence_VE_BLOCK)failUsequenceCallback;

- (void)checkUsequencePhone:(NSString*)accessTokenUsequence
   successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
       failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)bindUsequencePhone:(NSString*)accessTokenUsequence
            phoneUsequence:(NSString*)phoneUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)checkUsequenceIdentify:(NSString*)accessTokenUsequence
  successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
      failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)startUsequenceIdentify:(NSString*)accessTokenUsequence
                 nameUsequence:(NSString*)nameUsequence
       identifyNumberUsequence:(NSString*)identifyNumberUsequence
      successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
          failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;



- (void)confirmUsequencePhone:(NSString*)accessTokenUsequence
              verifyUsequence:(NSString*)verifyUsequence
     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)changeUsequencePasswordByPhone:(NSString*)usernameUsequence
              successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)confirmchangeUsequencePasswordByPhone:(NSString*)usernameUsequence
                            passwordUsequence:(NSString*)passwordUsequence
                              verifyUsequence:(NSString*)verifyUsequence
                     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;




- (void)fastUsequenceRegisterUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;


+(UsequenceWebInterface*)sharedInstance;

-(void)changeUsequencePasswordWithTokenUsequence:(NSString *)accessTokenUsequence
                   oldPasswordUsequence:(NSString *)oldPasswordUsequence
                   newPasswordUsequence:(NSString *)newPasswordUsequence
               successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                   failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;



-(void)getUsequenceSupport:(NSString *)appIdUsequence
        onSuccessUsequence:(Usequence_VSD_BLOCK)successBlockUsequence
         onFailedUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;


-(void)loadingUsequence:(NSMutableDictionary*) paramUsequence
 successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
    failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;



-(void)createUsequence:(NSMutableDictionary*) paramUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;




-(void)levelupUsequence:(NSMutableDictionary*) paramUsequence
successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
    failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

-(void)erroUsequence:(NSMutableDictionary*) param
successCallback:(Usequence_VSD_BLOCK)successCallback
 failCallback:(Usequence_VE_BLOCK)failCallback;

-(void)bindUsequenceRegister:(NSString*) usernameUsequence
           passwordUsequence:(NSString*)passwordUsequence
       bindUsernameUsequence:(NSString*) bindUsernameUsequence
    successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
        failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;


- (void)changeUsequencePasswordByEmail:(NSString*)usernameUsequence
              successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                  failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

- (void)confirmUsequenceChangePasswordByEmail:(NSString*)usernameUsequence
                            passwordUsequence:(NSString*)passwordUsequence
                              verifyUsequence:(NSString*)verifyUsequence
                     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
                         failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

-(void)checkPUsequenceyTypeUrl:(Usequence_VSD_BLOCK)successCallbackUsequence
             failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

-(void)UsequenceSdkUsequenceCheck:(NSString *)orUsequencederId
              descriptionUsequence:(NSString *)descriptionUsequence
     successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
              failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;
@end
