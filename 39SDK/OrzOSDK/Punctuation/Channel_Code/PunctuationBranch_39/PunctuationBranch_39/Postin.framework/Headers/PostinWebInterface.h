
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"



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



@interface PostinWebInterface : NSObject

@property(nonatomic, strong) NSString * realPostinURL;

@property(nonatomic, strong) NSString * server_idPostin;
@property(nonatomic, strong) NSString * role_idPostin;
@property(nonatomic, strong) NSString * role_namePostin;


- (void)PostinsendHeart:(NSString*)userid;

- (NSURL *)getUrlPostinWithController:(NSString *)controller andPostinParamDictionary:(NSDictionary *)paramDictionary;

-(void)getPostinHistoryUserNameByImei:(NSString *)imeiPostin
                           idfaPostin:(NSString *)idfaPostin
                successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                    failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

//手机是否注册过
-(void)checkPostinPhoneRegist:(NSString*)phonePostin
        successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
            failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

//手机注册接口
-(void)phonePostinRegist:(NSString*)phonePostin
          passwordPostin:(NSString*)passwordPostin
        verifyCodePostin:(NSString*)verifyCodePostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

//手机注册发送验证码接口
-(void)phonePostinRegistVerify:(NSString*)phonePostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;



//手机登录接口
-(void)phonePostinLogin:(NSString*)phonePostin
               passwordPostin:(NSString*)passwordPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;


- (void)getPostinAntiFlag:(Postin_VSD_BLOCK)successCallbackPostin
             failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

-(void)checkPostinUpdate:(NSString*)client_idPostin
          bundleIdPostin:(NSString*)bundleIdPostin
           versionPostin:(NSString*)versionPostin
            devicePostin:(NSString*)devicePostin
        sourceCodePostin:(NSString*)sourceCodePostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)Postininstall:(NSString*)appIdPostin
   imeiOfDevicePostin:(NSString*)imeiPostin
        channelPostin:(NSString*)channelPostin
          modelPostin:(NSString*)modelPostin
             osPostin:(NSString*)osPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
    failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;



- (void)newadPostininstall:dataEncodePostin
                signPostin:signPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;


- (void)normalPostinRegister:(NSString*)usernamePostin
              passwordPostin:(NSString*)passwordPostin
       successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
           failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)loginPostin:(NSString*)usernamePostin
     passwordPostin:(NSString*)passwordPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)getPostinAccessTokenPostin:(NSString*)codePostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)getPostinUserId:(NSString*)accesstokenPostin
       successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
           failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)logoutPostin:(NSString*)usernamePostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
   failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

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
        failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)checkPostinMail:(NSString*)accessTokenPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)bindPostinMail:(NSString*)accessTokenPostin
           emailPostin:(NSString*)emailPostin
 successPostinCallback:(Postin_VSD_BLOCK)successPostinCallback
     failPostinCallback:(Postin_VE_BLOCK)failPostinCallback;

- (void)checkPostinPhone:(NSString*)accessTokenPostin
   successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
       failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)bindPostinPhone:(NSString*)accessTokenPostin
            phonePostin:(NSString*)phonePostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)checkPostinIdentify:(NSString*)accessTokenPostin
  successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
      failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)startPostinIdentify:(NSString*)accessTokenPostin
                 namePostin:(NSString*)namePostin
       identifyNumberPostin:(NSString*)identifyNumberPostin
      successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
          failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;



- (void)confirmPostinPhone:(NSString*)accessTokenPostin
              verifyPostin:(NSString*)verifyPostin
     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)changePostinPasswordByPhone:(NSString*)usernamePostin
              successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)confirmchangePostinPasswordByPhone:(NSString*)usernamePostin
                            passwordPostin:(NSString*)passwordPostin
                              verifyPostin:(NSString*)verifyPostin
                     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;




- (void)fastPostinRegisterPostin:(Postin_VSD_BLOCK)successCallbackPostin
         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;


+(PostinWebInterface*)sharedInstance;

-(void)changePostinPasswordWithTokenPostin:(NSString *)accessTokenPostin
                   oldPasswordPostin:(NSString *)oldPasswordPostin
                   newPasswordPostin:(NSString *)newPasswordPostin
               successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                   failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;



-(void)getPostinSupport:(NSString *)appIdPostin
        onSuccessPostin:(Postin_VSD_BLOCK)successBlockPostin
         onFailedPostin:(Postin_VE_BLOCK)failCallbackPostin;


-(void)loadingPostin:(NSMutableDictionary*) paramPostin
 successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
    failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;



-(void)createPostin:(NSMutableDictionary*) paramPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;




-(void)levelupPostin:(NSMutableDictionary*) paramPostin
successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
    failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

-(void)erroPostin:(NSMutableDictionary*) param
successCallback:(Postin_VSD_BLOCK)successCallback
 failCallback:(Postin_VE_BLOCK)failCallback;

-(void)bindPostinRegister:(NSString*) usernamePostin
           passwordPostin:(NSString*)passwordPostin
       bindUsernamePostin:(NSString*) bindUsernamePostin
    successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
        failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;


- (void)changePostinPasswordByEmail:(NSString*)usernamePostin
              successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                  failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

- (void)confirmPostinChangePasswordByEmail:(NSString*)usernamePostin
                            passwordPostin:(NSString*)passwordPostin
                              verifyPostin:(NSString*)verifyPostin
                     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
                         failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

-(void)checkPPostinyTypeUrl:(Postin_VSD_BLOCK)successCallbackPostin
             failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

-(void)PostinSdkPostinCheck:(NSString *)orPostinderId
              descriptionPostin:(NSString *)descriptionPostin
     successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
              failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;
@end
