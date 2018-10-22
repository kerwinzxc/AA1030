
#import <Foundation/Foundation.h>
#import "QroughtSdkCommonDefine.h"
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

@interface QroughtSdk : NSObject

+(void)initQrought:(Boolean)isLandscape
     Qrought_Appid:(NSString *)Qrought_Appid
    Qrought_Appkey:(NSString *)Qrought_Appkey
   Qrought_Channel:(NSString *)Qrought_Channel
 Qrought_Appsecret:(NSString *)Qrought_Appsecret
       Qrought_Gid:(NSString *)Qrought_Gid
  Qrought_RYAppkey:(NSString *)Qrought_RYAppkey
  Qrought_PackageId:(NSString *)Qrought_PackageId
    success:(Qrought_SUCCESS_Callback)success
     failed:(Qrought_FAILED_Callback)failed;

+(void)destroyQrought;

+(void)loginQrought:(UIView*)viewQrought
   landscapeQrought:(Boolean)isLandscapeQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought;

+(void)logoutQrought:(UIView*)viewQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought;

+(void)executeQrought:(UIViewController *)controllerQrought
     landscapeQrought:(Boolean)isLandscapeQrought
;

+(void)hideFloatQrought;

+(void)showQroughtShiMingRenZhengView:(NSString *)accessTokenQrought callbackQrought:(Qrought_COMMON_BLOCK)callbackQrought;

+(NSString *)getQroughtImei;

+(NSString *)getQroughtChannel;
//启动统计接口
+(void)loadingQrought:(Qrought_SUCCESS_Callback)successQrought
        failedQrought:(Qrought_FAILED_Callback)failedQrought;


//创建角色
+(void)createRoleQrought:(NSString *) serveridQrought
       userIdQrought:(NSString*) userIdQrought
           roleIdQrought:(NSString *)roleIdQrought
        roleLevelQrought:(NSString *)roleLevelQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought;

+(void)loginRoleQrought:(NSString *) serveridQrought
       userIdQrought:(NSString*) userIdQrought
          roleIdQrought:(NSString *)roleIdQrought
       roleLevelQrought:(NSString *)roleLevelQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought;

+(void)startPQroughty:(UIViewController*)contextQrought
 landscapeQrought:(Boolean)isLandscapeQrought
    paramsQrought:(NSDictionary*)paramsQrought
   successQrought:(Qrought_SUCCESS_Callback)successQrought
    failedQrought:(Qrought_FAILED_Callback)failedQrought;




+(void)levelupQrought:(NSString*) levelQrought
      serverNameQrought:(NSString *)serverNameQrought
    serveridQrought:(NSString *) serveridQrought
         userIdQrought:(NSString*) userIdQrought
     role_idQrought:(NSString*)roleidQrought
    roleNameQrought:(NSString*)roleNameQrought
        successQrought:(Qrought_SUCCESS_Callback)successQrought
         failedQrought:(Qrought_FAILED_Callback)failedQrought;

+(void)error:(NSString *)log
     success:(Qrought_SUCCESS_Callback)success
      failed:(Qrought_FAILED_Callback)failed;

+(void)checkQroughtUpdate:(UIView*)contextQrought
           successQrought:(Qrought_SUCCESS_Callback)successQrought
            failedQrought:(Qrought_FAILED_Callback)failedQrought
         landscapeQrought:(Boolean) landspaceQrought;
@end
