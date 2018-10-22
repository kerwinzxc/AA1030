

#import "SJIOSSdk.h"
#import "SJIOSSdkImp.h"

@implementation SJIOSSdk

+(void)initSJIOS:(Boolean)isLandscape
   SJIOS_Appid:(NSString *)SJIOS_Appid
  SJIOS_Appkey:(NSString *)SJIOS_Appkey
 SJIOS_Channel:(NSString *)SJIOS_Channel
SJIOS_Appsecret:(NSString *)SJIOS_Appsecret
     SJIOS_Gid:(NSString *)SJIOS_Gid
SJIOS_RYAppkey:(NSString *)SJIOS_RYAppkey
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed
{

    [[SJIOSSdkImp sharedInstance] initSJIOS:isLandscape SJIOS_Appid:SJIOS_Appid SJIOS_Appkey:SJIOS_Appkey SJIOS_Channel:SJIOS_Channel SJIOS_Appsecret:SJIOS_Appsecret SJIOS_Gid:SJIOS_Gid SJIOS_RYAppkey:SJIOS_RYAppkey success:success failed:failed];
}

+(void)destroySJIOS
{
    [[SJIOSSdkImp sharedInstance] destroySJIOS];
}

+(void)loginSJIOS:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed
{

    [[SJIOSSdkImp sharedInstance] loginSJIOS:view landscape:isLandscape success:success failed:failed];
}

+(void)logoutSJIOS:(UIView*)view
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed
{
    [[SJIOSSdkImp sharedInstance] logoutSJIOS:view success:success failed:failed];
}

+(void)startPSJIOSy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(SJIOS_SUCCESS_Callback)success
    failed:(SJIOS_FAILED_Callback)failed
{
    
    [[SJIOSSdkImp sharedInstance] pSJIOSy:context landscape:isLandscape params:params success:success failed:failed];
}


+(void)executeSJIOS:(UIViewController *)controller
     landscape:(Boolean)isLandscape

{
    
    NSString *accessToken;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"Token错误" ];
        
    }else{
        accessToken = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[SJIOSSdkImp sharedInstance] executeSJIOS:controller landscape:isLandscape accessToken:accessToken];
    }
    
    
}

+(void)hideFloatSJIOS{
    [[SJIOSSdkImp sharedInstance] hideFloatSJIOS];
}

+(void)showSJIOSShiMingRenZhengView:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback{
    [[SJIOSSdkImp sharedInstance] showSJIOSShiMingRenZhengView:accessToken callback:callback];
}

+(NSString *)getImei {
    return [[SJIOSSdkImp sharedInstance] imei];
}

+(NSString *)getChannel{
    return [[SJIOSSdkImp sharedInstance]channel];
}


+(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)success
        failed:(SJIOS_FAILED_Callback)failed;
{
    [[SJIOSSdkImp sharedInstance] loadingSJIOS:success failed:failed];
}
+(void)active{
    [[SJIOSSdkImp sharedInstance] active];
}

+(void)createRoleSJIOS:(NSString *) serverid
       userId:(NSString*) userId
           roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed{
    [[SJIOSSdkImp sharedInstance] createRoleSJIOS:serverid user_id:userId roleId:roleId
                                  roleLevel:roleLevel success:success failed:failed];
}

+(void)loginRoleSJIOS:(NSString *) serverid
      userId:(NSString*) userId
          roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed{
    [[SJIOSSdkImp sharedInstance]loginRoleSJIOS:serverid user_id:userId roleId:roleId
                                roleLevel:roleLevel success:success failed:failed];
}




+(void)logout:(NSString *) serverid
         userId:(NSString*) userId
        success:(SJIOS_SUCCESS_Callback)success
         failed:(SJIOS_FAILED_Callback)failed{
    [[SJIOSSdkImp sharedInstance]logout:serverid user_id:userId success:success failed:failed];
}
+(void)level:(NSString*) level
    serverid:(NSString *) serverid
      userId:(NSString*) userId
     role_id:(NSString*)roleid
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed{
    [[SJIOSSdkImp sharedInstance]level:level serverid:serverid user_id:userId  role_id:roleid success:success failed:failed];

}
+(void)error:(NSString *)log
      success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed{
    [[SJIOSSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkSJIOSUpdate:(UIView*)context
           success:(SJIOS_SUCCESS_Callback)success
            failed:(SJIOS_FAILED_Callback)failed
            landscape:(Boolean)landspace
{
    [[SJIOSSdkImp sharedInstance]checkSJIOSUpdate:context  success:success failed:failed landscape:landspace];
}
@end
