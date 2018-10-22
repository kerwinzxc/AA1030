
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SJIOSSdk_const_def.h"





@interface SJIOSCommonApi : NSObject

@property(nonatomic, strong) NSString * realURL;


- (NSURL *)getUrlSJIOSWithController:(NSString *)controller andParamDictionary:(NSDictionary *)paramDictionary;

-(void)getSJIOSHistoryUserNameByImei:(NSString *)imei
                           idfa:(NSString *)idfa
                completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                    failedBlock:(SJIOS_VE_BLOCK)failedBlock;

//手机是否注册过
-(void)checkSJIOSPhoneRegist:(NSString*)phone
        completionBlock:(SJIOS_VSD_BLOCK)completionBlock
            failedBlock:(SJIOS_VE_BLOCK)failedBlock;

//手机注册接口
-(void)phoneSJIOSRegist:(NSString*)phone
          password:(NSString*)password
        verifyCode:(NSString*)verifyCode
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock;

//手机注册发送验证码接口
-(void)phoneSJIOSRegistVerify:(NSString*)phone
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock;


//手机登录接口
-(void)phoneSJIOSLogin:(NSString*)phone
               password:(NSString*)password
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock;


-(void)checkSJIOSUpdate:(NSString*)client_id
          bundleId:(NSString*)bundleId
           version:(NSString*)version
            device:(NSString*)device
        sourceCode:(NSString*)sourceCode
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)SJIOSinstall:(NSString*)appId
   imeiOfDevice:(NSString*)imei
        channel:(NSString*)channel
          model:(NSString*)model
             os:(NSString*)os
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
    failedBlock:(SJIOS_VE_BLOCK)failedBlock;



- (void)newadSJIOSinstall:dataEncode
                sign:sign
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock;


- (void)normalSJIOSRegister:(NSString*)username
              password:(NSString*)password
       completionBlock:(SJIOS_VSD_BLOCK)completionBlock
           failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)login:(NSString*)username
     password:(NSString*)password
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
  failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)getSJIOSAccessToken:(NSString*)code
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
  failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)getSJIOSUserId:(NSString*)accesstoken
       completionBlock:(SJIOS_VSD_BLOCK)completionBlock
           failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)logout:(NSString*)username
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
   failedBlock:(SJIOS_VE_BLOCK)failedBlock;

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
        failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)checkSJIOSMail:(NSString*)accessToken
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)bindSJIOSMail:(NSString*)accessToken
           email:(NSString*)email
 completionBlock:(SJIOS_VSD_BLOCK)completionBlock
     failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)checkSJIOSPhone:(NSString*)accessToken
   completionBlock:(SJIOS_VSD_BLOCK)completionBlock
       failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)bindSJIOSPhone:(NSString*)accessToken
            phone:(NSString*)phone
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)checkSJIOSIdentify:(NSString*)accessToken
  completionBlock:(SJIOS_VSD_BLOCK)completionBlock
      failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)startSJIOSIdentify:(NSString*)accessToken
                 name:(NSString*)name
       identifyNumber:(NSString*)identifyNumber
      completionBlock:(SJIOS_VSD_BLOCK)completionBlock
          failedBlock:(SJIOS_VE_BLOCK)failedBlock;



- (void)confirmSJIOSPhone:(NSString*)accessToken
              verify:(NSString*)verify
     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
         failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)changeSJIOSPasswordByPhone:(NSString*)username
              completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                  failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)confirmchangeSJIOSPasswordByPhone:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                         failedBlock:(SJIOS_VE_BLOCK)failedBlock;




- (void)fastSJIOSRegister:(SJIOS_VSD_BLOCK)completionBlock
         failedBlock:(SJIOS_VE_BLOCK)failedBlock;


+(SJIOSCommonApi*)sharedInstance;

-(void)changeSJIOSPasswordWithToken:(NSString *)accessToken
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
               completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                   failedBlock:(SJIOS_VE_BLOCK)failedBlock;



-(void)getSJIOSSupport:(NSString *)appId
        onSuccess:(SJIOS_VSD_BLOCK)successBlock
         onFailed:(SJIOS_VE_BLOCK)failedBlock;


-(void)loadingSJIOS:(NSMutableDictionary*) param
 completionBlock:(SJIOS_VSD_BLOCK)completionBlock
    failedBlock:(SJIOS_VE_BLOCK)failedBlock;



-(void)createSJIOS:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
  failedBlock:(SJIOS_VE_BLOCK)failedBlock;



-(void)login:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
  failedBlock:(SJIOS_VE_BLOCK)failedBlock;


-(void)loginSJIOSout:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
 failedBlock:(SJIOS_VE_BLOCK)failedBlock;

-(void)level:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
    failedBlock:(SJIOS_VE_BLOCK)failedBlock;

-(void)erroSJIOS:(NSMutableDictionary*) param
completionBlock:(SJIOS_VSD_BLOCK)completionBlock
 failedBlock:(SJIOS_VE_BLOCK)failedBlock;

-(void)bindSJIOSRegister:(NSString*) username
           password:(NSString*)password
       bindUsername:(NSString*) bindUsername
    completionBlock:(SJIOS_VSD_BLOCK)completionBlock
        failedBlock:(SJIOS_VE_BLOCK)failedBlock;


+(void) showSJIOSToast:(UIView*) view text:(NSString*) message;

- (void)changeSJIOSPasswordByEmail:(NSString*)username
              completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                  failedBlock:(SJIOS_VE_BLOCK)failedBlock;

- (void)confirmSJIOSChangePasswordByEmail:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
                         failedBlock:(SJIOS_VE_BLOCK)failedBlock;

-(void)checkPSJIOSyTypeUrl:(SJIOS_VSD_BLOCK)completionBlock
             failedBlock:(SJIOS_VE_BLOCK)failedBlock;

-(void)SJIOSSdkPyCheck:(NSString *)orderId
              description:(NSString *)description
     completionBlock:(SJIOS_VSD_BLOCK)completionBlock
              failedBlock:(SJIOS_VE_BLOCK)failedBlock;
@end
