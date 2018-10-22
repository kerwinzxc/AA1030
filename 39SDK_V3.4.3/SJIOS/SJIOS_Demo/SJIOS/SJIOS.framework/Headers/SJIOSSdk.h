
#import <Foundation/Foundation.h>
#import "SJIOSSdkCommonDefine.h"
#import <UIKit/UIKit.h>

@interface SJIOSSdk : NSObject

+(void)initSJIOS:(Boolean)isLandscape
     SJIOS_Appid:(NSString *)SJIOS_Appid
    SJIOS_Appkey:(NSString *)SJIOS_Appkey
   SJIOS_Channel:(NSString *)SJIOS_Channel
 SJIOS_Appsecret:(NSString *)SJIOS_Appsecret
       SJIOS_Gid:(NSString *)SJIOS_Gid
  SJIOS_RYAppkey:(NSString *)SJIOS_RYAppkey
  SJIOS_PackageId:(NSString *)SJIOS_PackageId
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed;

+(void)destroySJIOS;

+(void)loginSJIOS:(UIView*)viewSJIOS
   landscapeSJIOS:(Boolean)isLandscapeSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

+(void)logoutSJIOS:(UIView*)viewSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

+(void)executeSJIOS:(UIViewController *)controllerSJIOS
     landscapeSJIOS:(Boolean)isLandscapeSJIOS
;

+(void)hideFloatSJIOS;

+(void)showSJIOSShiMingRenZhengView:(NSString *)accessTokenSJIOS callbackSJIOS:(SJIOS_COMMON_BLOCK)callbackSJIOS;

+(NSString *)getSJIOSImei;

+(NSString *)getSJIOSChannel;
//启动统计接口
+(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
        failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;


//创建角色
+(void)createRoleSJIOS:(NSString *) serveridSJIOS
       userIdSJIOS:(NSString*) userIdSJIOS
           roleIdSJIOS:(NSString *)roleIdSJIOS
        roleLevelSJIOS:(NSString *)roleLevelSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

+(void)loginRoleSJIOS:(NSString *) serveridSJIOS
       userIdSJIOS:(NSString*) userIdSJIOS
          roleIdSJIOS:(NSString *)roleIdSJIOS
       roleLevelSJIOS:(NSString *)roleLevelSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

+(void)startPSJIOSy:(UIViewController*)contextSJIOS
 landscapeSJIOS:(Boolean)isLandscapeSJIOS
    paramsSJIOS:(NSDictionary*)paramsSJIOS
   successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
    failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;




+(void)levelupSJIOS:(NSString*) levelSJIOS
      serverNameSJIOS:(NSString *)serverNameSJIOS
    serveridSJIOS:(NSString *) serveridSJIOS
         userIdSJIOS:(NSString*) userIdSJIOS
     role_idSJIOS:(NSString*)roleidSJIOS
    roleNameSJIOS:(NSString*)roleNameSJIOS
        successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
         failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

+(void)error:(NSString *)log
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;

+(void)checkSJIOSUpdate:(UIView*)contextSJIOS
           successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
            failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
         landscapeSJIOS:(Boolean) landspaceSJIOS;
@end
