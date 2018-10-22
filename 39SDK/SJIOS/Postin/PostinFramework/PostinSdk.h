
#import <Foundation/Foundation.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


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

@interface PostinSdk : NSObject

+(void)initPostin:(Boolean)isLandscape
     Postin_Appid:(NSString *)Postin_Appid
    Postin_Appkey:(NSString *)Postin_Appkey
   Postin_Channel:(NSString *)Postin_Channel
 Postin_Appsecret:(NSString *)Postin_Appsecret
       Postin_Gid:(NSString *)Postin_Gid
  Postin_RYAppkey:(NSString *)Postin_RYAppkey
  Postin_PackageId:(NSString *)Postin_PackageId
    success:(Postin_SUCCESS_Callback)success
     failed:(Postin_FAILED_Callback)failed;

+(void)destroyPostin;

+(void)loginPostin:(UIView*)viewPostin
   landscapePostin:(Boolean)isLandscapePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin;

+(void)logoutPostin:(UIView*)viewPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin;

+(void)executePostin:(UIViewController *)controllerPostin
     landscapePostin:(Boolean)isLandscapePostin
;

+(void)hideFloatPostin;

+(void)showPostinShiMingRenZhengView:(NSString *)accessTokenPostin callbackPostin:(Postin_COMMON_BLOCK)callbackPostin;

+(NSString *)getPostinImei;

+(NSString *)getPostinChannel;
//启动统计接口
+(void)loadingPostin:(Postin_SUCCESS_Callback)successPostin
        failedPostin:(Postin_FAILED_Callback)failedPostin;


//创建角色
+(void)createRolePostin:(NSString *) serveridPostin
       userIdPostin:(NSString*) userIdPostin
           roleIdPostin:(NSString *)roleIdPostin
        roleLevelPostin:(NSString *)roleLevelPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin;

+(void)loginRolePostin:(NSString *) serveridPostin
       userIdPostin:(NSString*) userIdPostin
          roleIdPostin:(NSString *)roleIdPostin
       roleLevelPostin:(NSString *)roleLevelPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin;

+(void)startPPostiny:(UIViewController*)contextPostin
 landscapePostin:(Boolean)isLandscapePostin
    paramsPostin:(NSDictionary*)paramsPostin
   successPostin:(Postin_SUCCESS_Callback)successPostin
    failedPostin:(Postin_FAILED_Callback)failedPostin;




+(void)levelupPostin:(NSString*) levelPostin
      serverNamePostin:(NSString *)serverNamePostin
    serveridPostin:(NSString *) serveridPostin
         userIdPostin:(NSString*) userIdPostin
     role_idPostin:(NSString*)roleidPostin
    roleNamePostin:(NSString*)roleNamePostin
        successPostin:(Postin_SUCCESS_Callback)successPostin
         failedPostin:(Postin_FAILED_Callback)failedPostin;

+(void)error:(NSString *)log
     success:(Postin_SUCCESS_Callback)success
      failed:(Postin_FAILED_Callback)failed;

+(void)checkPostinUpdate:(UIView*)contextPostin
           successPostin:(Postin_SUCCESS_Callback)successPostin
            failedPostin:(Postin_FAILED_Callback)failedPostin
         landscapePostin:(Boolean) landspacePostin;
@end
