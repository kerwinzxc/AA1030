
#import <Foundation/Foundation.h>
#import "UnnHeTooSdk_const_def.h"
#import <UIKit/UIKit.h>

@interface UnnHeTooSdk : NSObject

+(void)initUnnHeToo:(Boolean)isLandscape
     UnnHeToo_Appid:(NSString *)UnnHeToo_Appid
    UnnHeToo_Appkey:(NSString *)UnnHeToo_Appkey
   UnnHeToo_Channel:(NSString *)UnnHeToo_Channel
 UnnHeToo_Appsecret:(NSString *)UnnHeToo_Appsecret
       UnnHeToo_Gid:(NSString *)UnnHeToo_Gid
  UnnHeToo_RYAppkey:(NSString *)UnnHeToo_RYAppkey
    success:(UnnHeToo_SUCCESS_Callback)success
     failed:(UnnHeToo_FAILED_Callback)failed;

+(void)destroyUnnHeToo;

+(void)loginUnnHeToo:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed;

+(void)logoutUnnHeToo:(UIView*)view
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed;

+(void)executeUnnHeToo:(UIViewController *)controller
     landscape:(Boolean)isLandscape
;

+(void)hideFloatUnnHeToo;

+(void)showUnnHeTooShiMingRenZhengView:(NSString *)accessToken callback:(UnnHeToo_COMMON_BLOCK)callback;

+(NSString *)getImei;

+(NSString *)getChannel;
//启动统计接口
+(void)loadingUnnHeToo:(UnnHeToo_SUCCESS_Callback)success
        failed:(UnnHeToo_FAILED_Callback)failed;
//激活帐户
+(void)active;

//创建角色
+(void)createRoleUnnHeToo:(NSString *) serverid
       userId:(NSString*) userId
           roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed;

+(void)loginRoleUnnHeToo:(NSString *) serverid
       userId:(NSString*) userId
          roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed;

+(void)startPUnnHeTooy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(UnnHeToo_SUCCESS_Callback)success
    failed:(UnnHeToo_FAILED_Callback)failed;



+(void)logout:(NSString *) serverid
      userId:(NSString*) userId
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed;

+(void)level:(NSString*) level
    serverid:(NSString *) serverid
         userId:(NSString*) userId
     role_id:(NSString*)roleid
        success:(UnnHeToo_SUCCESS_Callback)success
         failed:(UnnHeToo_FAILED_Callback)failed;

+(void)error:(NSString *)log
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed;

+(void)checkUnnHeTooUpdate:(UIView*)context
           success:(UnnHeToo_SUCCESS_Callback)success
            failed:(UnnHeToo_FAILED_Callback)failed
         landscape:(Boolean) landspace;
@end
