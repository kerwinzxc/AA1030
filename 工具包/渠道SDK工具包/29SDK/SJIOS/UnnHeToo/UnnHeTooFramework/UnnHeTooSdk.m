

#import "UnnHeTooSdk.h"
#import "UnnHeTooSdkImp.h"

@implementation UnnHeTooSdk

+(void)initUnnHeToo:(Boolean)isLandscape
   UnnHeToo_Appid:(NSString *)UnnHeToo_Appid
  UnnHeToo_Appkey:(NSString *)UnnHeToo_Appkey
 UnnHeToo_Channel:(NSString *)UnnHeToo_Channel
UnnHeToo_Appsecret:(NSString *)UnnHeToo_Appsecret
     UnnHeToo_Gid:(NSString *)UnnHeToo_Gid
UnnHeToo_RYAppkey:(NSString *)UnnHeToo_RYAppkey
    success:(UnnHeToo_SUCCESS_Callback)success
     failed:(UnnHeToo_FAILED_Callback)failed
{

    [[UnnHeTooSdkImp sharedInstance] initUnnHeToo:isLandscape UnnHeToo_Appid:UnnHeToo_Appid UnnHeToo_Appkey:UnnHeToo_Appkey UnnHeToo_Channel:UnnHeToo_Channel UnnHeToo_Appsecret:UnnHeToo_Appsecret UnnHeToo_Gid:UnnHeToo_Gid UnnHeToo_RYAppkey:UnnHeToo_RYAppkey success:success failed:failed];
}

+(void)destroyUnnHeToo
{
    [[UnnHeTooSdkImp sharedInstance] destroyUnnHeToo];
}

+(void)loginUnnHeToo:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed
{

    [[UnnHeTooSdkImp sharedInstance] loginUnnHeToo:view landscape:isLandscape success:success failed:failed];
}

+(void)logoutUnnHeToo:(UIView*)view
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed
{
    [[UnnHeTooSdkImp sharedInstance] logoutUnnHeToo:view success:success failed:failed];
}

+(void)startPUnnHeTooy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(UnnHeToo_SUCCESS_Callback)success
    failed:(UnnHeToo_FAILED_Callback)failed
{
    
    [[UnnHeTooSdkImp sharedInstance] pUnnHeTooy:context landscape:isLandscape params:params success:success failed:failed];
}


+(void)executeUnnHeToo:(UIViewController *)controller
     landscape:(Boolean)isLandscape

{
    
    NSString *accessToken;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"Token错误" ];
        
    }else{
        accessToken = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[UnnHeTooSdkImp sharedInstance] executeUnnHeToo:controller landscape:isLandscape accessToken:accessToken];
    }
    
    
}

+(void)hideFloatUnnHeToo{
    [[UnnHeTooSdkImp sharedInstance] hideFloatUnnHeToo];
}

+(void)showUnnHeTooShiMingRenZhengView:(NSString *)accessToken callback:(UnnHeToo_COMMON_BLOCK)callback{
    [[UnnHeTooSdkImp sharedInstance] showUnnHeTooShiMingRenZhengView:accessToken callback:callback];
}

+(NSString *)getImei {
    return [[UnnHeTooSdkImp sharedInstance] imei];
}

+(NSString *)getChannel{
    return [[UnnHeTooSdkImp sharedInstance]channel];
}


+(void)loadingUnnHeToo:(UnnHeToo_SUCCESS_Callback)success
        failed:(UnnHeToo_FAILED_Callback)failed;
{
    [[UnnHeTooSdkImp sharedInstance] loadingUnnHeToo:success failed:failed];
}
+(void)active{
    [[UnnHeTooSdkImp sharedInstance] active];
}

+(void)createRoleUnnHeToo:(NSString *) serverid
       userId:(NSString*) userId
           roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed{
    [[UnnHeTooSdkImp sharedInstance] createRoleUnnHeToo:serverid user_id:userId roleId:roleId
                                  roleLevel:roleLevel success:success failed:failed];
}

+(void)loginRoleUnnHeToo:(NSString *) serverid
      userId:(NSString*) userId
          roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed{
    [[UnnHeTooSdkImp sharedInstance]loginRoleUnnHeToo:serverid user_id:userId roleId:roleId
                                roleLevel:roleLevel success:success failed:failed];
}




+(void)logout:(NSString *) serverid
         userId:(NSString*) userId
        success:(UnnHeToo_SUCCESS_Callback)success
         failed:(UnnHeToo_FAILED_Callback)failed{
    [[UnnHeTooSdkImp sharedInstance]logout:serverid user_id:userId success:success failed:failed];
}
+(void)level:(NSString*) level
    serverid:(NSString *) serverid
      userId:(NSString*) userId
     role_id:(NSString*)roleid
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed{
    [[UnnHeTooSdkImp sharedInstance]level:level serverid:serverid user_id:userId  role_id:roleid success:success failed:failed];

}
+(void)error:(NSString *)log
      success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed{
    [[UnnHeTooSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkUnnHeTooUpdate:(UIView*)context
           success:(UnnHeToo_SUCCESS_Callback)success
            failed:(UnnHeToo_FAILED_Callback)failed
            landscape:(Boolean)landspace
{
    [[UnnHeTooSdkImp sharedInstance]checkUnnHeTooUpdate:context  success:success failed:failed landscape:landspace];
}
@end
