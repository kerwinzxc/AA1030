


#import "SJIOSSdk.h"
#import "SJIOSSdkImp.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"



@implementation SJIOSSdk

+(void)initSJIOS:(Boolean)isLandscape
   SJIOS_Appid:(NSString *)SJIOS_Appid
  SJIOS_Appkey:(NSString *)SJIOS_Appkey
 SJIOS_Channel:(NSString *)SJIOS_Channel
SJIOS_Appsecret:(NSString *)SJIOS_Appsecret
     SJIOS_Gid:(NSString *)SJIOS_Gid
SJIOS_RYAppkey:(NSString *)SJIOS_RYAppkey
SJIOS_PackageId:(NSString *)SJIOS_PackageId
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed
{

    [[SJIOSSdkImp sharedInstance] initSJIOS:isLandscape SJIOS_Appid:SJIOS_Appid SJIOS_Appkey:SJIOS_Appkey SJIOS_Channel:SJIOS_Channel SJIOS_Appsecret:SJIOS_Appsecret SJIOS_Gid:SJIOS_Gid SJIOS_RYAppkey:SJIOS_RYAppkey SJIOS_PackageId:SJIOS_PackageId success:success failed:failed];
}

+(void)destroySJIOS
{
    [[SJIOSSdkImp sharedInstance] destroySJIOS];
}

+(void)loginSJIOS:(UIView*)viewSJIOS
   landscapeSJIOS:(Boolean)isLandscapeSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
{

    [[SJIOSSdkImp sharedInstance] loginSJIOS:viewSJIOS landscapeSJIOS:isLandscapeSJIOS successSJIOS:successSJIOS failedSJIOS:failedSJIOS];
}

+(void)logoutSJIOS:(UIView*)viewSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
{
    [[SJIOSSdkImp sharedInstance] logoutSJIOS:viewSJIOS successSJIOS:successSJIOS failedSJIOS:failedSJIOS];
}

+(void)startPSJIOSy:(UIViewController*)contextSJIOS
 landscapeSJIOS:(Boolean)isLandscapeSJIOS
    paramsSJIOS:(NSDictionary*)paramsSJIOS
   successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
    failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
{
    
    [[SJIOSSdkImp sharedInstance] pSJIOSy:contextSJIOS landscapepSJIOSy:isLandscapeSJIOS paramspSJIOSy:paramsSJIOS successpSJIOSy:successSJIOS failedpSJIOSy:failedSJIOS];
}


+(void)executeSJIOS:(UIViewController *)controllerSJIOS
     landscapeSJIOS:(Boolean)isLandscapeSJIOS

{
    
    NSString *accessTokenSJIOS;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"Token错误" ];
        
    }else{
        accessTokenSJIOS = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[SJIOSSdkImp sharedInstance] executeSJIOS:controllerSJIOS landscapeSJIOS:isLandscapeSJIOS accessTokenSJIOS:accessTokenSJIOS];
    }
    
    
}

+(void)hideFloatSJIOS{
    [[SJIOSSdkImp sharedInstance] hideFloatSJIOS];
}

+(void)showSJIOSShiMingRenZhengView:(NSString *)accessTokenSJIOS callbackSJIOS:(SJIOS_COMMON_BLOCK)callbackSJIOS{
    [[SJIOSSdkImp sharedInstance] showSJIOSShiMingRenZhengView:accessTokenSJIOS callbackSJIOS:callbackSJIOS];
}

+(NSString *)getSJIOSImei {
    return [[SJIOSSdkImp sharedInstance] getSJIOSImei];
}

+(NSString *)getSJIOSChannel{
    return [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
}


+(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
        failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;
{
    [[SJIOSSdkImp sharedInstance] loadingSJIOS:successSJIOS failedSJIOS:failedSJIOS];
}

+(void)createRoleSJIOS:(NSString *) serveridSJIOS
       userIdSJIOS:(NSString*) userIdSJIOS
           roleIdSJIOS:(NSString *)roleIdSJIOS
        roleLevelSJIOS:(NSString *)roleLevelSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    [[SJIOSSdkImp sharedInstance] createRoleSJIOS:serveridSJIOS user_idSJIOS:userIdSJIOS roleIdSJIOS:roleIdSJIOS
                                  roleLevelSJIOS:roleLevelSJIOS successSJIOS:successSJIOS failedSJIOS:failedSJIOS];
}

+(void)loginRoleSJIOS:(NSString *) serveridSJIOS
      userIdSJIOS:(NSString*) userIdSJIOS
          roleIdSJIOS:(NSString *)roleIdSJIOS
       roleLevelSJIOS:(NSString *)roleLevelSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    [[SJIOSSdkImp sharedInstance]loginRoleSJIOS:serveridSJIOS user_idSJIOS:userIdSJIOS roleIdSJIOS:roleIdSJIOS
                                roleLevelSJIOS:roleLevelSJIOS successSJIOS:successSJIOS failedSJIOS:failedSJIOS];
}



+(void)levelupSJIOS:(NSString*) levelSJIOS
  serverNameSJIOS:(NSString *)serverNameSJIOS
    serveridSJIOS:(NSString *) serveridSJIOS
      userIdSJIOS:(NSString*) userIdSJIOS
     role_idSJIOS:(NSString*)roleidSJIOS
    roleNameSJIOS:(NSString*)roleNameSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    [[SJIOSSdkImp sharedInstance] levelupSJIOS:levelSJIOS serverNameSJIOS:serverNameSJIOS serveridSJIOS:serveridSJIOS userIdSJIOS:userIdSJIOS role_idSJIOS:roleidSJIOS roleNameSJIOS:roleNameSJIOS successSJIOS:successSJIOS failedSJIOS:failedSJIOS];

}
+(void)error:(NSString *)log
      success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed{
    [[SJIOSSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkSJIOSUpdate:(UIView*)contextSJIOS
           successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
            failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
            landscapeSJIOS:(Boolean)landspaceSJIOS
{
    [[SJIOSSdkImp sharedInstance]checkSJIOSUpdate:contextSJIOS  successSJIOS:successSJIOS failedSJIOS:failedSJIOS landscapeSJIOS:landspaceSJIOS];
}
@end
