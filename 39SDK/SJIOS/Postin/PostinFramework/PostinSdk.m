


#import "PostinSdk.h"
#import "PostinSdkImp.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"



@implementation PostinSdk

+(void)initPostin:(Boolean)isLandscape
   Postin_Appid:(NSString *)Postin_Appid
  Postin_Appkey:(NSString *)Postin_Appkey
 Postin_Channel:(NSString *)Postin_Channel
Postin_Appsecret:(NSString *)Postin_Appsecret
     Postin_Gid:(NSString *)Postin_Gid
Postin_RYAppkey:(NSString *)Postin_RYAppkey
Postin_PackageId:(NSString *)Postin_PackageId
    success:(Postin_SUCCESS_Callback)success
     failed:(Postin_FAILED_Callback)failed
{

    [[PostinSdkImp sharedInstance] initPostin:isLandscape Postin_Appid:Postin_Appid Postin_Appkey:Postin_Appkey Postin_Channel:Postin_Channel Postin_Appsecret:Postin_Appsecret Postin_Gid:Postin_Gid Postin_RYAppkey:Postin_RYAppkey Postin_PackageId:Postin_PackageId success:success failed:failed];
}

+(void)destroyPostin
{
    [[PostinSdkImp sharedInstance] destroyPostin];
}

+(void)loginPostin:(UIView*)viewPostin
   landscapePostin:(Boolean)isLandscapePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin
{

    [[PostinSdkImp sharedInstance] loginPostin:viewPostin landscapePostin:isLandscapePostin successPostin:successPostin failedPostin:failedPostin];
}

+(void)logoutPostin:(UIView*)viewPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin
{
    [[PostinSdkImp sharedInstance] logoutPostin:viewPostin successPostin:successPostin failedPostin:failedPostin];
}

+(void)startPPostiny:(UIViewController*)contextPostin
 landscapePostin:(Boolean)isLandscapePostin
    paramsPostin:(NSDictionary*)paramsPostin
   successPostin:(Postin_SUCCESS_Callback)successPostin
    failedPostin:(Postin_FAILED_Callback)failedPostin
{
    
    [[PostinSdkImp sharedInstance] pPostiny:contextPostin landscapepPostiny:isLandscapePostin paramspPostiny:paramsPostin successpPostiny:successPostin failedpPostiny:failedPostin];
}


+(void)executePostin:(UIViewController *)controllerPostin
     landscapePostin:(Boolean)isLandscapePostin

{
    
    NSString *accessTokenPostin;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[PostinSdkImp sharedInstance]showPostinToast:@"Token错误" ];
        
    }else{
        accessTokenPostin = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[PostinSdkImp sharedInstance] executePostin:controllerPostin landscapePostin:isLandscapePostin accessTokenPostin:accessTokenPostin];
    }
    
    
}

+(void)hideFloatPostin{
    [[PostinSdkImp sharedInstance] hideFloatPostin];
}

+(void)showPostinShiMingRenZhengView:(NSString *)accessTokenPostin callbackPostin:(Postin_COMMON_BLOCK)callbackPostin{
    [[PostinSdkImp sharedInstance] showPostinShiMingRenZhengView:accessTokenPostin callbackPostin:callbackPostin];
}

+(NSString *)getPostinImei {
    return [[PostinSdkImp sharedInstance] getPostinImei];
}

+(NSString *)getPostinChannel{
    return [[PostinSdkImp sharedInstance] getPostinChannel];
}


+(void)loadingPostin:(Postin_SUCCESS_Callback)successPostin
        failedPostin:(Postin_FAILED_Callback)failedPostin;
{
    [[PostinSdkImp sharedInstance] loadingPostin:successPostin failedPostin:failedPostin];
}

+(void)createRolePostin:(NSString *) serveridPostin
       userIdPostin:(NSString*) userIdPostin
           roleIdPostin:(NSString *)roleIdPostin
        roleLevelPostin:(NSString *)roleLevelPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin{
    [[PostinSdkImp sharedInstance] createRolePostin:serveridPostin user_idPostin:userIdPostin roleIdPostin:roleIdPostin
                                  roleLevelPostin:roleLevelPostin successPostin:successPostin failedPostin:failedPostin];
}

+(void)loginRolePostin:(NSString *) serveridPostin
      userIdPostin:(NSString*) userIdPostin
          roleIdPostin:(NSString *)roleIdPostin
       roleLevelPostin:(NSString *)roleLevelPostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin{
    [[PostinSdkImp sharedInstance]loginRolePostin:serveridPostin user_idPostin:userIdPostin roleIdPostin:roleIdPostin
                                roleLevelPostin:roleLevelPostin successPostin:successPostin failedPostin:failedPostin];
}



+(void)levelupPostin:(NSString*) levelPostin
  serverNamePostin:(NSString *)serverNamePostin
    serveridPostin:(NSString *) serveridPostin
      userIdPostin:(NSString*) userIdPostin
     role_idPostin:(NSString*)roleidPostin
    roleNamePostin:(NSString*)roleNamePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin{
    [[PostinSdkImp sharedInstance] levelupPostin:levelPostin serverNamePostin:serverNamePostin serveridPostin:serveridPostin userIdPostin:userIdPostin role_idPostin:roleidPostin roleNamePostin:roleNamePostin successPostin:successPostin failedPostin:failedPostin];

}
+(void)error:(NSString *)log
      success:(Postin_SUCCESS_Callback)success
      failed:(Postin_FAILED_Callback)failed{
    [[PostinSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkPostinUpdate:(UIView*)contextPostin
           successPostin:(Postin_SUCCESS_Callback)successPostin
            failedPostin:(Postin_FAILED_Callback)failedPostin
            landscapePostin:(Boolean)landspacePostin
{
    [[PostinSdkImp sharedInstance]checkPostinUpdate:contextPostin  successPostin:successPostin failedPostin:failedPostin landscapePostin:landspacePostin];
}
@end
