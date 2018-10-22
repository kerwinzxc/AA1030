
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UnnHeTooSdk_const_def.h"





@interface UnnHeTooCommonApi : NSObject

@property(nonatomic, strong) NSString * realURL;


- (NSURL *)getUrlUnnHeTooWithController:(NSString *)controller andParamDictionary:(NSDictionary *)paramDictionary;

-(void)getUnnHeTooHistoryUserNameByImei:(NSString *)imei
                           idfa:(NSString *)idfa
                completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

//手机是否注册过
-(void)checkUnnHeTooPhoneRegist:(NSString*)phone
        completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
            failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

//手机注册接口
-(void)phoneUnnHeTooRegist:(NSString*)phone
          password:(NSString*)password
        verifyCode:(NSString*)verifyCode
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

//手机注册发送验证码接口
-(void)phoneUnnHeTooRegistVerify:(NSString*)phone
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;


//手机登录接口
-(void)phoneUnnHeTooLogin:(NSString*)phone
               password:(NSString*)password
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;


-(void)checkUnnHeTooUpdate:(NSString*)client_id
          bundleId:(NSString*)bundleId
           version:(NSString*)version
            device:(NSString*)device
        sourceCode:(NSString*)sourceCode
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)UnnHeTooinstall:(NSString*)appId
   imeiOfDevice:(NSString*)imei
        channel:(NSString*)channel
          model:(NSString*)model
             os:(NSString*)os
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;



- (void)newadUnnHeTooinstall:dataEncode
                sign:sign
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;


- (void)normalUnnHeTooRegister:(NSString*)username
              password:(NSString*)password
       completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
           failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)login:(NSString*)username
     password:(NSString*)password
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)getUnnHeTooAccessToken:(NSString*)code
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)getUnnHeTooUserId:(NSString*)accesstoken
       completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
           failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)logout:(NSString*)username
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
   failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

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
        failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)checkUnnHeTooMail:(NSString*)accessToken
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)bindUnnHeTooMail:(NSString*)accessToken
           email:(NSString*)email
 completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
     failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)checkUnnHeTooPhone:(NSString*)accessToken
   completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
       failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)bindUnnHeTooPhone:(NSString*)accessToken
            phone:(NSString*)phone
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)checkUnnHeTooIdentify:(NSString*)accessToken
  completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
      failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)startUnnHeTooIdentify:(NSString*)accessToken
                 name:(NSString*)name
       identifyNumber:(NSString*)identifyNumber
      completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
          failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;



- (void)confirmUnnHeTooPhone:(NSString*)accessToken
              verify:(NSString*)verify
     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)changeUnnHeTooPasswordByPhone:(NSString*)username
              completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)confirmchangeUnnHeTooPasswordByPhone:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;




- (void)fastUnnHeTooRegister:(UnnHeToo_VSD_BLOCK)completionBlock
         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;


+(UnnHeTooCommonApi*)sharedInstance;

-(void)changeUnnHeTooPasswordWithToken:(NSString *)accessToken
                   oldPassword:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
               completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                   failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;



-(void)getUnnHeTooSupport:(NSString *)appId
        onSuccess:(UnnHeToo_VSD_BLOCK)successBlock
         onFailed:(UnnHeToo_VE_BLOCK)failedBlock;


-(void)loadingUnnHeToo:(NSMutableDictionary*) param
 completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;



-(void)createUnnHeToo:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;



-(void)login:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;


-(void)loginUnnHeTooout:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
 failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

-(void)level:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
    failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

-(void)erroUnnHeToo:(NSMutableDictionary*) param
completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
 failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

-(void)bindUnnHeTooRegister:(NSString*) username
           password:(NSString*)password
       bindUsername:(NSString*) bindUsername
    completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
        failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;


+(void) showUnnHeTooToast:(UIView*) view text:(NSString*) message;

- (void)changeUnnHeTooPasswordByEmail:(NSString*)username
              completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                  failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

- (void)confirmUnnHeTooChangePasswordByEmail:(NSString*)username
                            password:(NSString*)password
                              verify:(NSString*)verify
                     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
                         failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

-(void)checkPUnnHeTooyTypeUrl:(UnnHeToo_VSD_BLOCK)completionBlock
             failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

-(void)UnnHeTooSdkPyCheck:(NSString *)orderId
              description:(NSString *)description
     completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
              failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;
@end
