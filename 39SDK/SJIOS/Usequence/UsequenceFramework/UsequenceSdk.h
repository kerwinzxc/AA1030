
#import <Foundation/Foundation.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import <UIKit/UIKit.h>

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

@interface UsequenceSdk : NSObject

+(void)initUsequence:(Boolean)isLandscape
     Usequence_Appid:(NSString *)Usequence_Appid
    Usequence_Appkey:(NSString *)Usequence_Appkey
   Usequence_Channel:(NSString *)Usequence_Channel
 Usequence_Appsecret:(NSString *)Usequence_Appsecret
       Usequence_Gid:(NSString *)Usequence_Gid
  Usequence_RYAppkey:(NSString *)Usequence_RYAppkey
  Usequence_PackageId:(NSString *)Usequence_PackageId
    success:(Usequence_SUCCESS_Callback)success
     failed:(Usequence_FAILED_Callback)failed;

+(void)destroyUsequence;

+(void)loginUsequence:(UIView*)viewUsequence
   landscapeUsequence:(Boolean)isLandscapeUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

+(void)logoutUsequence:(UIView*)viewUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

+(void)executeUsequence:(UIViewController *)controllerUsequence
     landscapeUsequence:(Boolean)isLandscapeUsequence
;

+(void)hideFloatUsequence;

+(void)showUsequenceShiMingRenZhengView:(NSString *)accessTokenUsequence callbackUsequence:(Usequence_COMMON_BLOCK)callbackUsequence;

+(NSString *)getUsequenceImei;

+(NSString *)getUsequenceChannel;
//启动统计接口
+(void)loadingUsequence:(Usequence_SUCCESS_Callback)successUsequence
        failedUsequence:(Usequence_FAILED_Callback)failedUsequence;


//创建角色
+(void)createRoleUsequence:(NSString *) serveridUsequence
       userIdUsequence:(NSString*) userIdUsequence
           roleIdUsequence:(NSString *)roleIdUsequence
        roleLevelUsequence:(NSString *)roleLevelUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

+(void)loginRoleUsequence:(NSString *) serveridUsequence
       userIdUsequence:(NSString*) userIdUsequence
          roleIdUsequence:(NSString *)roleIdUsequence
       roleLevelUsequence:(NSString *)roleLevelUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

+(void)startPUsequencey:(UIViewController*)contextUsequence
 landscapeUsequence:(Boolean)isLandscapeUsequence
    paramsUsequence:(NSDictionary*)paramsUsequence
   successUsequence:(Usequence_SUCCESS_Callback)successUsequence
    failedUsequence:(Usequence_FAILED_Callback)failedUsequence;




+(void)levelupUsequence:(NSString*) levelUsequence
      serverNameUsequence:(NSString *)serverNameUsequence
    serveridUsequence:(NSString *) serveridUsequence
         userIdUsequence:(NSString*) userIdUsequence
     role_idUsequence:(NSString*)roleidUsequence
    roleNameUsequence:(NSString*)roleNameUsequence
        successUsequence:(Usequence_SUCCESS_Callback)successUsequence
         failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

+(void)error:(NSString *)log
     success:(Usequence_SUCCESS_Callback)success
      failed:(Usequence_FAILED_Callback)failed;

+(void)checkUsequenceUpdate:(UIView*)contextUsequence
           successUsequence:(Usequence_SUCCESS_Callback)successUsequence
            failedUsequence:(Usequence_FAILED_Callback)failedUsequence
         landscapeUsequence:(Boolean) landspaceUsequence;
@end
