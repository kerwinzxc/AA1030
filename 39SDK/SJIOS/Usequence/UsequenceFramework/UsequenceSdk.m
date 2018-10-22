


#import "UsequenceSdk.h"
#import "UsequenceSdkImp.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"



@implementation UsequenceSdk

+(void)initUsequence:(Boolean)isLandscape
   Usequence_Appid:(NSString *)Usequence_Appid
  Usequence_Appkey:(NSString *)Usequence_Appkey
 Usequence_Channel:(NSString *)Usequence_Channel
Usequence_Appsecret:(NSString *)Usequence_Appsecret
     Usequence_Gid:(NSString *)Usequence_Gid
Usequence_RYAppkey:(NSString *)Usequence_RYAppkey
Usequence_PackageId:(NSString *)Usequence_PackageId
    success:(Usequence_SUCCESS_Callback)success
     failed:(Usequence_FAILED_Callback)failed
{

    [[UsequenceSdkImp sharedInstance] initUsequence:isLandscape Usequence_Appid:Usequence_Appid Usequence_Appkey:Usequence_Appkey Usequence_Channel:Usequence_Channel Usequence_Appsecret:Usequence_Appsecret Usequence_Gid:Usequence_Gid Usequence_RYAppkey:Usequence_RYAppkey Usequence_PackageId:Usequence_PackageId success:success failed:failed];
}

+(void)destroyUsequence
{
    [[UsequenceSdkImp sharedInstance] destroyUsequence];
}

+(void)loginUsequence:(UIView*)viewUsequence
   landscapeUsequence:(Boolean)isLandscapeUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence
{

    [[UsequenceSdkImp sharedInstance] loginUsequence:viewUsequence landscapeUsequence:isLandscapeUsequence successUsequence:successUsequence failedUsequence:failedUsequence];
}

+(void)logoutUsequence:(UIView*)viewUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence
{
    [[UsequenceSdkImp sharedInstance] logoutUsequence:viewUsequence successUsequence:successUsequence failedUsequence:failedUsequence];
}

+(void)startPUsequencey:(UIViewController*)contextUsequence
 landscapeUsequence:(Boolean)isLandscapeUsequence
    paramsUsequence:(NSDictionary*)paramsUsequence
   successUsequence:(Usequence_SUCCESS_Callback)successUsequence
    failedUsequence:(Usequence_FAILED_Callback)failedUsequence
{
    
    [[UsequenceSdkImp sharedInstance] pUsequencey:contextUsequence landscapepUsequencey:isLandscapeUsequence paramspUsequencey:paramsUsequence successpUsequencey:successUsequence failedpUsequencey:failedUsequence];
}


+(void)executeUsequence:(UIViewController *)controllerUsequence
     landscapeUsequence:(Boolean)isLandscapeUsequence

{
    
    NSString *accessTokenUsequence;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"Token错误" ];
        
    }else{
        accessTokenUsequence = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[UsequenceSdkImp sharedInstance] executeUsequence:controllerUsequence landscapeUsequence:isLandscapeUsequence accessTokenUsequence:accessTokenUsequence];
    }
    
    
}

+(void)hideFloatUsequence{
    [[UsequenceSdkImp sharedInstance] hideFloatUsequence];
}

+(void)showUsequenceShiMingRenZhengView:(NSString *)accessTokenUsequence callbackUsequence:(Usequence_COMMON_BLOCK)callbackUsequence{
    [[UsequenceSdkImp sharedInstance] showUsequenceShiMingRenZhengView:accessTokenUsequence callbackUsequence:callbackUsequence];
}

+(NSString *)getUsequenceImei {
    return [[UsequenceSdkImp sharedInstance] getUsequenceImei];
}

+(NSString *)getUsequenceChannel{
    return [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
}


+(void)loadingUsequence:(Usequence_SUCCESS_Callback)successUsequence
        failedUsequence:(Usequence_FAILED_Callback)failedUsequence;
{
    [[UsequenceSdkImp sharedInstance] loadingUsequence:successUsequence failedUsequence:failedUsequence];
}

+(void)createRoleUsequence:(NSString *) serveridUsequence
       userIdUsequence:(NSString*) userIdUsequence
           roleIdUsequence:(NSString *)roleIdUsequence
        roleLevelUsequence:(NSString *)roleLevelUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    [[UsequenceSdkImp sharedInstance] createRoleUsequence:serveridUsequence user_idUsequence:userIdUsequence roleIdUsequence:roleIdUsequence
                                  roleLevelUsequence:roleLevelUsequence successUsequence:successUsequence failedUsequence:failedUsequence];
}

+(void)loginRoleUsequence:(NSString *) serveridUsequence
      userIdUsequence:(NSString*) userIdUsequence
          roleIdUsequence:(NSString *)roleIdUsequence
       roleLevelUsequence:(NSString *)roleLevelUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    [[UsequenceSdkImp sharedInstance]loginRoleUsequence:serveridUsequence user_idUsequence:userIdUsequence roleIdUsequence:roleIdUsequence
                                roleLevelUsequence:roleLevelUsequence successUsequence:successUsequence failedUsequence:failedUsequence];
}



+(void)levelupUsequence:(NSString*) levelUsequence
  serverNameUsequence:(NSString *)serverNameUsequence
    serveridUsequence:(NSString *) serveridUsequence
      userIdUsequence:(NSString*) userIdUsequence
     role_idUsequence:(NSString*)roleidUsequence
    roleNameUsequence:(NSString*)roleNameUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    [[UsequenceSdkImp sharedInstance] levelupUsequence:levelUsequence serverNameUsequence:serverNameUsequence serveridUsequence:serveridUsequence userIdUsequence:userIdUsequence role_idUsequence:roleidUsequence roleNameUsequence:roleNameUsequence successUsequence:successUsequence failedUsequence:failedUsequence];

}
+(void)error:(NSString *)log
      success:(Usequence_SUCCESS_Callback)success
      failed:(Usequence_FAILED_Callback)failed{
    [[UsequenceSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkUsequenceUpdate:(UIView*)contextUsequence
           successUsequence:(Usequence_SUCCESS_Callback)successUsequence
            failedUsequence:(Usequence_FAILED_Callback)failedUsequence
            landscapeUsequence:(Boolean)landspaceUsequence
{
    [[UsequenceSdkImp sharedInstance]checkUsequenceUpdate:contextUsequence  successUsequence:successUsequence failedUsequence:failedUsequence landscapeUsequence:landspaceUsequence];
}
@end
