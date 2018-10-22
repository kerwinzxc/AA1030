
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QroughtSdkCommonDefine.h"

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



@interface QroughtWebInterface : NSObject

@property(nonatomic, strong) NSString * realQroughtURL;

@property(nonatomic, strong) NSString * server_idQrought;
@property(nonatomic, strong) NSString * role_idQrought;
@property(nonatomic, strong) NSString * role_nameQrought;


- (void)QroughtsendHeart:(NSString*)userid;

- (NSURL *)getUrlQroughtWithController:(NSString *)controller andQroughtParamDictionary:(NSDictionary *)paramDictionary;

-(void)getQroughtHistoryUserNameByImei:(NSString *)imeiQrought
                           idfaQrought:(NSString *)idfaQrought
                successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                    failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

//手机是否注册过
-(void)checkQroughtPhoneRegist:(NSString*)phoneQrought
        successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
            failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

//手机注册接口
-(void)phoneQroughtRegist:(NSString*)phoneQrought
          passwordQrought:(NSString*)passwordQrought
        verifyCodeQrought:(NSString*)verifyCodeQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

//手机注册发送验证码接口
-(void)phoneQroughtRegistVerify:(NSString*)phoneQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;



//手机登录接口
-(void)phoneQroughtLogin:(NSString*)phoneQrought
               passwordQrought:(NSString*)passwordQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;


- (void)getQroughtAntiFlag:(Qrought_VSD_BLOCK)successCallbackQrought
             failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

-(void)checkQroughtUpdate:(NSString*)client_idQrought
          bundleIdQrought:(NSString*)bundleIdQrought
           versionQrought:(NSString*)versionQrought
            deviceQrought:(NSString*)deviceQrought
        sourceCodeQrought:(NSString*)sourceCodeQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)Qroughtinstall:(NSString*)appIdQrought
   imeiOfDeviceQrought:(NSString*)imeiQrought
        channelQrought:(NSString*)channelQrought
          modelQrought:(NSString*)modelQrought
             osQrought:(NSString*)osQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
    failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;



- (void)newadQroughtinstall:dataEncodeQrought
                signQrought:signQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;


- (void)normalQroughtRegister:(NSString*)usernameQrought
              passwordQrought:(NSString*)passwordQrought
       successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
           failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)loginQrought:(NSString*)usernameQrought
     passwordQrought:(NSString*)passwordQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)getQroughtAccessTokenQrought:(NSString*)codeQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)getQroughtUserId:(NSString*)accesstokenQrought
       successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
           failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)logoutQrought:(NSString*)usernameQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
   failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

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
        failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)checkQroughtMail:(NSString*)accessTokenQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)bindQroughtMail:(NSString*)accessTokenQrought
           emailQrought:(NSString*)emailQrought
 successQroughtCallback:(Qrought_VSD_BLOCK)successQroughtCallback
     failQroughtCallback:(Qrought_VE_BLOCK)failQroughtCallback;

- (void)checkQroughtPhone:(NSString*)accessTokenQrought
   successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
       failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)bindQroughtPhone:(NSString*)accessTokenQrought
            phoneQrought:(NSString*)phoneQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)checkQroughtIdentify:(NSString*)accessTokenQrought
  successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
      failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)startQroughtIdentify:(NSString*)accessTokenQrought
                 nameQrought:(NSString*)nameQrought
       identifyNumberQrought:(NSString*)identifyNumberQrought
      successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
          failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;



- (void)confirmQroughtPhone:(NSString*)accessTokenQrought
              verifyQrought:(NSString*)verifyQrought
     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)changeQroughtPasswordByPhone:(NSString*)usernameQrought
              successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)confirmchangeQroughtPasswordByPhone:(NSString*)usernameQrought
                            passwordQrought:(NSString*)passwordQrought
                              verifyQrought:(NSString*)verifyQrought
                     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;




- (void)fastQroughtRegisterQrought:(Qrought_VSD_BLOCK)successCallbackQrought
         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;


+(QroughtWebInterface*)sharedInstance;

-(void)changeQroughtPasswordWithTokenQrought:(NSString *)accessTokenQrought
                   oldPasswordQrought:(NSString *)oldPasswordQrought
                   newPasswordQrought:(NSString *)newPasswordQrought
               successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                   failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;



-(void)getQroughtSupport:(NSString *)appIdQrought
        onSuccessQrought:(Qrought_VSD_BLOCK)successBlockQrought
         onFailedQrought:(Qrought_VE_BLOCK)failCallbackQrought;


-(void)loadingQrought:(NSMutableDictionary*) paramQrought
 successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
    failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;



-(void)createQrought:(NSMutableDictionary*) paramQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;




-(void)levelupQrought:(NSMutableDictionary*) paramQrought
successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
    failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

-(void)erroQrought:(NSMutableDictionary*) param
successCallback:(Qrought_VSD_BLOCK)successCallback
 failCallback:(Qrought_VE_BLOCK)failCallback;

-(void)bindQroughtRegister:(NSString*) usernameQrought
           passwordQrought:(NSString*)passwordQrought
       bindUsernameQrought:(NSString*) bindUsernameQrought
    successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
        failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;


- (void)changeQroughtPasswordByEmail:(NSString*)usernameQrought
              successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                  failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

- (void)confirmQroughtChangePasswordByEmail:(NSString*)usernameQrought
                            passwordQrought:(NSString*)passwordQrought
                              verifyQrought:(NSString*)verifyQrought
                     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
                         failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

-(void)checkPQroughtyTypeUrl:(Qrought_VSD_BLOCK)successCallbackQrought
             failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

-(void)QroughtSdkQroughtCheck:(NSString *)orQroughtderId
              descriptionQrought:(NSString *)descriptionQrought
     successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
              failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;
@end
