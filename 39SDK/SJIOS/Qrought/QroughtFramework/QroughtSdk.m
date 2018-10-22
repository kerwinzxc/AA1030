


#import "QroughtSdk.h"
#import "QroughtSdkImp.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"



@implementation QroughtSdk

+(void)initQrought:(Boolean)isLandscape
   Qrought_Appid:(NSString *)Qrought_Appid
  Qrought_Appkey:(NSString *)Qrought_Appkey
 Qrought_Channel:(NSString *)Qrought_Channel
Qrought_Appsecret:(NSString *)Qrought_Appsecret
     Qrought_Gid:(NSString *)Qrought_Gid
Qrought_RYAppkey:(NSString *)Qrought_RYAppkey
Qrought_PackageId:(NSString *)Qrought_PackageId
    success:(Qrought_SUCCESS_Callback)success
     failed:(Qrought_FAILED_Callback)failed
{

    [[QroughtSdkImp sharedInstance] initQrought:isLandscape Qrought_Appid:Qrought_Appid Qrought_Appkey:Qrought_Appkey Qrought_Channel:Qrought_Channel Qrought_Appsecret:Qrought_Appsecret Qrought_Gid:Qrought_Gid Qrought_RYAppkey:Qrought_RYAppkey Qrought_PackageId:Qrought_PackageId success:success failed:failed];
}

+(void)destroyQrought
{
    [[QroughtSdkImp sharedInstance] destroyQrought];
}

+(void)loginQrought:(UIView*)viewQrought
   landscapeQrought:(Boolean)isLandscapeQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought
{

    [[QroughtSdkImp sharedInstance] loginQrought:viewQrought landscapeQrought:isLandscapeQrought successQrought:successQrought failedQrought:failedQrought];
}

+(void)logoutQrought:(UIView*)viewQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought
{
    [[QroughtSdkImp sharedInstance] logoutQrought:viewQrought successQrought:successQrought failedQrought:failedQrought];
}

+(void)startPQroughty:(UIViewController*)contextQrought
 landscapeQrought:(Boolean)isLandscapeQrought
    paramsQrought:(NSDictionary*)paramsQrought
   successQrought:(Qrought_SUCCESS_Callback)successQrought
    failedQrought:(Qrought_FAILED_Callback)failedQrought
{
    
    [[QroughtSdkImp sharedInstance] pQroughty:contextQrought landscapepQroughty:isLandscapeQrought paramspQroughty:paramsQrought successpQroughty:successQrought failedpQroughty:failedQrought];
}


+(void)executeQrought:(UIViewController *)controllerQrought
     landscapeQrought:(Boolean)isLandscapeQrought

{
    
    NSString *accessTokenQrought;
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[QroughtSdkImp sharedInstance]showQroughtToast:@"Token错误" ];
        
    }else{
        accessTokenQrought = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        [[QroughtSdkImp sharedInstance] executeQrought:controllerQrought landscapeQrought:isLandscapeQrought accessTokenQrought:accessTokenQrought];
    }
    
    
}

+(void)hideFloatQrought{
    [[QroughtSdkImp sharedInstance] hideFloatQrought];
}

+(void)showQroughtShiMingRenZhengView:(NSString *)accessTokenQrought callbackQrought:(Qrought_COMMON_BLOCK)callbackQrought{
    [[QroughtSdkImp sharedInstance] showQroughtShiMingRenZhengView:accessTokenQrought callbackQrought:callbackQrought];
}

+(NSString *)getQroughtImei {
    return [[QroughtSdkImp sharedInstance] getQroughtImei];
}

+(NSString *)getQroughtChannel{
    return [[QroughtSdkImp sharedInstance] getQroughtChannel];
}


+(void)loadingQrought:(Qrought_SUCCESS_Callback)successQrought
        failedQrought:(Qrought_FAILED_Callback)failedQrought;
{
    [[QroughtSdkImp sharedInstance] loadingQrought:successQrought failedQrought:failedQrought];
}

+(void)createRoleQrought:(NSString *) serveridQrought
       userIdQrought:(NSString*) userIdQrought
           roleIdQrought:(NSString *)roleIdQrought
        roleLevelQrought:(NSString *)roleLevelQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought{
    [[QroughtSdkImp sharedInstance] createRoleQrought:serveridQrought user_idQrought:userIdQrought roleIdQrought:roleIdQrought
                                  roleLevelQrought:roleLevelQrought successQrought:successQrought failedQrought:failedQrought];
}

+(void)loginRoleQrought:(NSString *) serveridQrought
      userIdQrought:(NSString*) userIdQrought
          roleIdQrought:(NSString *)roleIdQrought
       roleLevelQrought:(NSString *)roleLevelQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought{
    [[QroughtSdkImp sharedInstance]loginRoleQrought:serveridQrought user_idQrought:userIdQrought roleIdQrought:roleIdQrought
                                roleLevelQrought:roleLevelQrought successQrought:successQrought failedQrought:failedQrought];
}



+(void)levelupQrought:(NSString*) levelQrought
  serverNameQrought:(NSString *)serverNameQrought
    serveridQrought:(NSString *) serveridQrought
      userIdQrought:(NSString*) userIdQrought
     role_idQrought:(NSString*)roleidQrought
    roleNameQrought:(NSString*)roleNameQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought{
    [[QroughtSdkImp sharedInstance] levelupQrought:levelQrought serverNameQrought:serverNameQrought serveridQrought:serveridQrought userIdQrought:userIdQrought role_idQrought:roleidQrought roleNameQrought:roleNameQrought successQrought:successQrought failedQrought:failedQrought];

}
+(void)error:(NSString *)log
      success:(Qrought_SUCCESS_Callback)success
      failed:(Qrought_FAILED_Callback)failed{
    [[QroughtSdkImp sharedInstance]error:log success:success failed:failed];
}
+(void)checkQroughtUpdate:(UIView*)contextQrought
           successQrought:(Qrought_SUCCESS_Callback)successQrought
            failedQrought:(Qrought_FAILED_Callback)failedQrought
            landscapeQrought:(Boolean)landspaceQrought
{
    [[QroughtSdkImp sharedInstance]checkQroughtUpdate:contextQrought  successQrought:successQrought failedQrought:failedQrought landscapeQrought:landspaceQrought];
}
@end
