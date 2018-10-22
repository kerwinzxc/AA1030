
#import <Foundation/Foundation.h>
#import "SJIOSSdk_const_def.h"
#import <UIKit/UIKit.h>

@interface SJIOSSdk : NSObject

+(void)initSJIOS:(Boolean)isLandscape
     SJIOS_Appid:(NSString *)SJIOS_Appid
    SJIOS_Appkey:(NSString *)SJIOS_Appkey
   SJIOS_Channel:(NSString *)SJIOS_Channel
 SJIOS_Appsecret:(NSString *)SJIOS_Appsecret
       SJIOS_Gid:(NSString *)SJIOS_Gid
  SJIOS_RYAppkey:(NSString *)SJIOS_RYAppkey
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed;

+(void)destroySJIOS;

+(void)loginSJIOS:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;

+(void)logoutSJIOS:(UIView*)view
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed;

+(void)executeSJIOS:(UIViewController *)controller
     landscape:(Boolean)isLandscape
;

+(void)hideFloatSJIOS;

+(void)showSJIOSShiMingRenZhengView:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback;

+(NSString *)getImei;

+(NSString *)getChannel;
//启动统计接口
+(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)success
        failed:(SJIOS_FAILED_Callback)failed;
//激活帐户
+(void)active;

//创建角色
+(void)createRoleSJIOS:(NSString *) serverid
       userId:(NSString*) userId
           roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed;

+(void)loginRoleSJIOS:(NSString *) serverid
       userId:(NSString*) userId
          roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed;

+(void)startPSJIOSy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(SJIOS_SUCCESS_Callback)success
    failed:(SJIOS_FAILED_Callback)failed;



+(void)logout:(NSString *) serverid
      userId:(NSString*) userId
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;

+(void)level:(NSString*) level
    serverid:(NSString *) serverid
         userId:(NSString*) userId
     role_id:(NSString*)roleid
        success:(SJIOS_SUCCESS_Callback)success
         failed:(SJIOS_FAILED_Callback)failed;

+(void)error:(NSString *)log
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;

+(void)checkSJIOSUpdate:(UIView*)context
           success:(SJIOS_SUCCESS_Callback)success
            failed:(SJIOS_FAILED_Callback)failed
         landscape:(Boolean) landspace;
@end
