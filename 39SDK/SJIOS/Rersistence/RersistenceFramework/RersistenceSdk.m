


#import "RersistenceSdk.h"
#import "RersistenceSdkImp.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"



@implementation RersistenceSdk

+(void)initRersistence:(Boolean)isLandscape
   Rersistence_Appid:(NSString *)Rersistence_Appid
  Rersistence_Appkey:(NSString *)Rersistence_Appkey
 Rersistence_Channel:(NSString *)Rersistence_Channel
Rersistence_Appsecret:(NSString *)Rersistence_Appsecret
     Rersistence_Gid:(NSString *)Rersistence_Gid
Rersistence_RYAppkey:(NSString *)Rersistence_RYAppkey
Rersistence_PackageId:(NSString *)Rersistence_PackageId
    success:(Rersistence_SUCCESS_Callback)success
     failed:(Rersistence_FAILED_Callback)failed
{

    [[RersistenceSdkImp sharedInstance] initRersistence:isLandscape Rersistence_Appid:Rersistence_Appid Rersistence_Appkey:Rersistence_Appkey Rersistence_Channel:Rersistence_Channel Rersistence_Appsecret:Rersistence_Appsecret Rersistence_Gid:Rersistence_Gid Rersistence_RYAppkey:Rersistence_RYAppkey Rersistence_PackageId:Rersistence_PackageId success:success failed:failed];
}

+(void)destroyRersistence
{
    [[RersistenceSdkImp sharedInstance] destroyRersistence];
}

+(void)loginRersistence:(UIView*)viewRersistence
   landscapeRersistence:(Boolean)isLandscapeRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
{

    [[RersistenceSdkImp sharedInstance] loginRersistence:viewRersistence landscapeRersistence:isLandscapeRersistence successRersistence:successRersistence failedRersistence:failedRersistence];
}

+(void)logoutRersistence:(UIView*)viewRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
{
    [[RersistenceSdkImp sharedInstance] logoutRersistence:viewRersistence successRersistence:successRersistence failedRersistence:failedRersistence];
}

+(void)startPRersistencey:(UIViewController*)contextRersistence
 landscapeRersistence:(Boolean)isLandscapeRersistence
    paramsRersistence:(NSDictionary*)paramsRersistence
   successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
    failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
{
    
    [[RersistenceSdkImp sharedInstance] pRersistencey:contextRersistence landscapepRersistencey:isLandscapeRersistence paramspRersistencey:paramsRersistence successpRersistencey:successRersistence failedpRersistencey:failedRersistence];
}


+(void)executeRersistence:(UIViewController *)controllerRersistence
     landscapeRersistence:(Boolean)isLandscapeRersistence

{
    
    NSString *accessTokenRersistence;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"Token错误" ];
        
    }else{
        accessTokenRersistence = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[RersistenceSdkImp sharedInstance] executeRersistence:controllerRersistence landscapeRersistence:isLandscapeRersistence accessTokenRersistence:accessTokenRersistence];
    }
    
    
}

+(void)hideFloatRersistence{
    [[RersistenceSdkImp sharedInstance] hideFloatRersistence];
}

+(void)showRersistenceShiMingRenZhengView:(NSString *)accessTokenRersistence callbackRersistence:(Rersistence_COMMON_BLOCK)callbackRersistence{
    [[RersistenceSdkImp sharedInstance] showRersistenceShiMingRenZhengView:accessTokenRersistence callbackRersistence:callbackRersistence];
}

+(NSString *)getRersistenceImei {
    return [[RersistenceSdkImp sharedInstance] getRersistenceImei];
}

+(NSString *)getRersistenceChannel{
    return [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
}


+(void)loadingRersistence:(Rersistence_SUCCESS_Callback)successRersistence
        failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;
{
    [[RersistenceSdkImp sharedInstance] loadingRersistence:successRersistence failedRersistence:failedRersistence];
}

+(void)createRoleRersistence:(NSString *) serveridRersistence
       userIdRersistence:(NSString*) userIdRersistence
           roleIdRersistence:(NSString *)roleIdRersistence
        roleLevelRersistence:(NSString *)roleLevelRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    [[RersistenceSdkImp sharedInstance] createRoleRersistence:serveridRersistence user_idRersistence:userIdRersistence roleIdRersistence:roleIdRersistence
                                  roleLevelRersistence:roleLevelRersistence successRersistence:successRersistence failedRersistence:failedRersistence];
}

+(void)loginRoleRersistence:(NSString *) serveridRersistence
      userIdRersistence:(NSString*) userIdRersistence
          roleIdRersistence:(NSString *)roleIdRersistence
       roleLevelRersistence:(NSString *)roleLevelRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    [[RersistenceSdkImp sharedInstance]loginRoleRersistence:serveridRersistence user_idRersistence:userIdRersistence roleIdRersistence:roleIdRersistence
                                roleLevelRersistence:roleLevelRersistence successRersistence:successRersistence failedRersistence:failedRersistence];
}



+(void)levelupRersistence:(NSString*) levelRersistence
  serverNameRersistence:(NSString *)serverNameRersistence
    serveridRersistence:(NSString *) serveridRersistence
      userIdRersistence:(NSString*) userIdRersistence
     role_idRersistence:(NSString*)roleidRersistence
    roleNameRersistence:(NSString*)roleNameRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    [[RersistenceSdkImp sharedInstance] levelupRersistence:levelRersistence serverNameRersistence:serverNameRersistence serveridRersistence:serveridRersistence userIdRersistence:userIdRersistence role_idRersistence:roleidRersistence roleNameRersistence:roleNameRersistence successRersistence:successRersistence failedRersistence:failedRersistence];

}
+(void)error:(NSString *)log
      success:(Rersistence_SUCCESS_Callback)success
      failed:(Rersistence_FAILED_Callback)failed{
    [[RersistenceSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkRersistenceUpdate:(UIView*)contextRersistence
           successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
            failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
            landscapeRersistence:(Boolean)landspaceRersistence
{
    [[RersistenceSdkImp sharedInstance]checkRersistenceUpdate:contextRersistence  successRersistence:successRersistence failedRersistence:failedRersistence landscapeRersistence:landspaceRersistence];
}
@end
