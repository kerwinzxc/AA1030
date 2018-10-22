
#import <Foundation/Foundation.h>
#import "RersistenceSdkCommonDefine.h"
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

@interface RersistenceSdk : NSObject

+(void)initRersistence:(Boolean)isLandscape
     Rersistence_Appid:(NSString *)Rersistence_Appid
    Rersistence_Appkey:(NSString *)Rersistence_Appkey
   Rersistence_Channel:(NSString *)Rersistence_Channel
 Rersistence_Appsecret:(NSString *)Rersistence_Appsecret
       Rersistence_Gid:(NSString *)Rersistence_Gid
  Rersistence_RYAppkey:(NSString *)Rersistence_RYAppkey
  Rersistence_PackageId:(NSString *)Rersistence_PackageId
    success:(Rersistence_SUCCESS_Callback)success
     failed:(Rersistence_FAILED_Callback)failed;

+(void)destroyRersistence;

+(void)loginRersistence:(UIView*)viewRersistence
   landscapeRersistence:(Boolean)isLandscapeRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

+(void)logoutRersistence:(UIView*)viewRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

+(void)executeRersistence:(UIViewController *)controllerRersistence
     landscapeRersistence:(Boolean)isLandscapeRersistence
;

+(void)hideFloatRersistence;

+(void)showRersistenceShiMingRenZhengView:(NSString *)accessTokenRersistence callbackRersistence:(Rersistence_COMMON_BLOCK)callbackRersistence;

+(NSString *)getRersistenceImei;

+(NSString *)getRersistenceChannel;
//启动统计接口
+(void)loadingRersistence:(Rersistence_SUCCESS_Callback)successRersistence
        failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;


//创建角色
+(void)createRoleRersistence:(NSString *) serveridRersistence
       userIdRersistence:(NSString*) userIdRersistence
           roleIdRersistence:(NSString *)roleIdRersistence
        roleLevelRersistence:(NSString *)roleLevelRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

+(void)loginRoleRersistence:(NSString *) serveridRersistence
       userIdRersistence:(NSString*) userIdRersistence
          roleIdRersistence:(NSString *)roleIdRersistence
       roleLevelRersistence:(NSString *)roleLevelRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

+(void)startPRersistencey:(UIViewController*)contextRersistence
 landscapeRersistence:(Boolean)isLandscapeRersistence
    paramsRersistence:(NSDictionary*)paramsRersistence
   successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
    failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;




+(void)levelupRersistence:(NSString*) levelRersistence
      serverNameRersistence:(NSString *)serverNameRersistence
    serveridRersistence:(NSString *) serveridRersistence
         userIdRersistence:(NSString*) userIdRersistence
     role_idRersistence:(NSString*)roleidRersistence
    roleNameRersistence:(NSString*)roleNameRersistence
        successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
         failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

+(void)error:(NSString *)log
     success:(Rersistence_SUCCESS_Callback)success
      failed:(Rersistence_FAILED_Callback)failed;

+(void)checkRersistenceUpdate:(UIView*)contextRersistence
           successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
            failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
         landscapeRersistence:(Boolean) landspaceRersistence;
@end
