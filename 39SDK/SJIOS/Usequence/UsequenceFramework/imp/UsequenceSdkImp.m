
#import "UsequenceDataBase.h"
#import "UsequenceSdkImp.h"
#import "UsequenceWebInterface.h"
#import <UIKit/UIKit.h>
#import "UsequenceSdkImp.h"
#import "UsequenceSdkMd5.h"
#import "UsequenceProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "UsequenceFloatWindow.h"
#import "UsequenceNavViewController.h"
#import "UsequenceOpenUDID.h"
#include <stdio.h>
#include <sys/time.h>
#import "UsequenceSdk.h"
#import "UsequenceUserInfo.h"
#import "UsequenceQuickLogin.h"
#import  "UsequencePopWindow.h"
#import "UsequenceDefaultLogin.h"
#import "UsequenceCheckUpdate.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "UsequenceShiMingRenZhengView.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"



@interface UsequenceSdkImp()


@property(nonatomic) Boolean landscapeUsequence;

@property(nonatomic, strong)NSMutableDictionary * errorsUsequence;
@property(nonatomic,strong) UsequenceCheckUpdate *updateViewUsequence;
@property (nonatomic, strong) UsequenceFloatWindow *UsequenceFloatWindow;
@property (nonatomic,strong) UsequenceQuickLogin *qucickLoginUsequence;
@property (nonatomic,strong)UsequenceDefaultLogin *defaultLoginUsequence;
@property (nonatomic,strong)UsequencePopWindow *windowUsequence;
@property (nonatomic,strong)UsequenceProgressHUD * processUsequence;
@property (nonatomic,strong)UsequenceProgressHUD * zhuanjuhuaUsequence;
@property(nonatomic) Boolean SHOWPROCESSUsequence;
@property (nonatomic,strong)UsequenceDataBase *databaseUsequence;




@property(nonatomic) BOOL isOpenUsequenceShiMingRenZheng;
@property (nonatomic,strong) NSString *msgForUsequenceShiMingRenZheng;
@property (nonatomic,strong) NSString *appid_Usequence;
@property (nonatomic,strong) NSString *appkey_Usequence;
@property (nonatomic,strong) NSString *appchannel_Usequence;
@property (nonatomic,strong) NSString *appsecret_Usequence;
@property (nonatomic,strong) NSString *gid_Usequence;
@property (nonatomic,strong) NSString *ryappkey_Usequence;
@property (nonatomic,strong) NSString *packageId_Usequence;
@end

@implementation UsequenceSdkImp

+(NSString*)getUsequenceIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

+(NSString*)getUsequenceIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString*)getUsequenceCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

-(NSString*)getUsequenceImei
{
    return [UsequenceOpenUDID value];
}
-(NSString*)getUsequenceAppId
{
    return self.appid_Usequence;
}

-(NSString*)getUsequenceAppKey
{
    return self.appkey_Usequence;
}

-(NSString*)getUsequenceNewAdGid
{
    return self.gid_Usequence;
}
-(NSString*)getUsequenceNewAdid
{
    return @"0";
}

-(NSString*)getUsequencePackageId
{
    return self.packageId_Usequence;
}

-(NSString*)getUsequenceAppPrivateKey
{
    NSString *getUsequenceAppPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_Usequence, self.appsecret_Usequence];
    return [[UsequenceSdkMd5 md5:getUsequenceAppPrivateKey] lowercaseString];
}

-(NSString*)getUsequenceAppSecret
{
    return self.appsecret_Usequence;
}


-(NSString*)getUsequenceChannel
{
    return self.appchannel_Usequence;
}


-(BOOL)getUsequenceShiMingRenZhengFlag{
    return self.isOpenUsequenceShiMingRenZheng;
}
-(NSString*)getUsequenceShiMingRenZhengMsg{
    return self.msgForUsequenceShiMingRenZheng;
}


-(NSString*)getUsequenceKeychainIDFV
{
    if([UsequenceKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [UsequenceKeyChainTool saveKeychainValue:[UsequenceSdkImp getUsequenceIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [UsequenceKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)getUsequenceVersion
{
    return Usequence_SDK_VERSION;
}

-(Boolean)getUsequenceIsLandscape
{
    return self.landscapeUsequence;
}
-(UIView*)rootUsequenceView
{
    return self.rootViewUsequence;
}

-(NSString*)getUsequenceInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"IS_INSTALLED_FLAG_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    NSLog(@"TAG = %@", TAG);
    if([UsequenceKeyChainTool readKeychainValue:TAG] == NULL){
        [UsequenceKeyChainTool saveKeychainValue:@"installed" key:TAG];
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [UsequenceKeyChainTool readKeychainValue:TAG]);
        return [UsequenceKeyChainTool readKeychainValue:TAG];
    }
}


-(void)initUsequence:(Boolean)isLandscape
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
    
    self.landscapeUsequence = isLandscape;
    
    self.landscapeUsequence = isLandscape;
    self.appid_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_Appid];
    self.appkey_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_Appkey];
    self.appchannel_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_Channel];
    self.appsecret_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_Appsecret];
    self.gid_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_Gid];
    self.ryappkey_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_RYAppkey];
    self.packageId_Usequence = [[NSString alloc] initWithFormat:@"%@", Usequence_PackageId];
    
    if([[self getUsequenceInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doUsequenceNewAdInstall];
    
        
        Usequence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        Usequence_VE_BLOCK failCallback = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[UsequenceWebInterface sharedInstance] Usequenceinstall:self.appid_Usequence
                                   imeiOfDeviceUsequence:[UsequenceSdkImp getUsequenceIdfa]
                                        channelUsequence:self.appchannel_Usequence
                                          modelUsequence:[[UIDevice currentDevice] model]
                                             osUsequence:[[UIDevice currentDevice] systemVersion]
                                successCallbackUsequence:successCallback
                                    failCallbackUsequence:failCallback];
        
    }
    self.databaseUsequence=[[UsequenceDataBase alloc]init];
    [self initUsequencePart:success failedUsequence:failed];
    
    [[UsequenceWebInterface sharedInstance] getUsequenceAntiFlag:^(NSDictionary *responseString, NSDictionary *headers) {
        self.isOpenUsequenceShiMingRenZheng = [[responseString objectForKey:@"data2"] boolValue];
        self.msgForUsequenceShiMingRenZheng = [NSString stringWithFormat:@"%@", [responseString objectForKey:@"msg2"]];
        NSLog(@"isOpenUsequenceShiMingRenZheng = %d", self.isOpenUsequenceShiMingRenZheng);
    } failCallbackUsequence:^(NSError *responseError){
       
    }];
}


-(void)initUsequencePart:(Usequence_SUCCESS_Callback)successUsequence
         failedUsequence:(Usequence_FAILED_Callback)failedUsequence
{
    self.errorsUsequence = [NSMutableDictionary dictionary];
    [self.errorsUsequence setValue:@"错误的请求" forKey:@"invalid_request"];
    [self.errorsUsequence setValue:@"无法识别的客户端" forKey:@"unauthorized_client"];
    [self.errorsUsequence setValue:@"拒绝访问" forKey:@"access_denied"];
    [self.errorsUsequence setValue:@"系统错误" forKey:@"server_error"];
    [self.errorsUsequence setValue:@"系统忙" forKey:@"temporarily_unavailable"];
    [self.errorsUsequence setValue:@"用户名已存在,已重新生成用户名" forKey:@"duplicate_username"];
    [self.errorsUsequence setValue:@"用户名不存在" forKey:@"username_not_exist"];
    [self.errorsUsequence setValue:@"用户名或者密码错误" forKey:@"username_or_password_error"];
    [self.errorsUsequence setValue:@"重复的订单" forKey:@"duplicate_order"];
    [self.errorsUsequence setValue:@"邮箱已绑定" forKey:@"duplicate_email"];
    [self.errorsUsequence setValue:@"手机已绑定" forKey:@"duplicate_phone"];
    [self.errorsUsequence setValue:@"未绑定邮箱" forKey:@"unset_email"];
    [self.errorsUsequence setValue:@"未绑定手机" forKey:@"unset_phone"];
    [self.errorsUsequence setValue:@"帐号登录异常，请联系客服处理！" forKey:@"account_protect"];
    
    successUsequence(@"success");
}

- (NSString *)getUsequenceIphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}


-(void)destroyUsequence
{
   
}

-(void)loginUsequence:(UIView*)viewUsequence
   landscapeUsequence:(Boolean)isLandscapeUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence
{
    
    if (self.rootViewUsequence==nil) {
        self.rootViewUsequence=viewUsequence;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseUsequence) {
        
         alluserinfo=[self.databaseUsequence getTestList];
    }else{
        
        self.databaseUsequence=[[UsequenceDataBase alloc]init];
        alluserinfo=[self.databaseUsequence getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLoginUsequence=[[UsequenceDefaultLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
           [self.defaultLoginUsequence show:viewUsequence];
    }else{
            

        [self getUsequenceHistoryUserNameByImei:viewUsequence landscapeUsequence:isLandscapeUsequence successUsequence:successUsequence failedUsequence:failedUsequence];
    }
 
}

-(void)loginUsequence:(UIView*)viewUsequence
   landscapeUsequence:(Boolean)isLandscapeUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence
        flagUsequence:(int *)flagUsequence;
{
    
    if (self.rootViewUsequence==nil) {
        self.rootViewUsequence=viewUsequence;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseUsequence) {
        
        alluserinfo=[self.databaseUsequence getTestList];
    }else{
        
        self.databaseUsequence=[[UsequenceDataBase alloc]init];
        alluserinfo=[self.databaseUsequence getTestList];
    }
    
    
    self.qucickLoginUsequence=[[UsequenceQuickLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
    [self.qucickLoginUsequence show:viewUsequence];
    
}

-(void)getUsequenceHistoryUserNameByImei:(UIView*)viewUsequence
                      landscapeUsequence:(Boolean)isLandscapeUsequence
                        successUsequence:(Usequence_SUCCESS_Callback)successUsequence
                         failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    self.SHOWPROCESSUsequence = true;
    [self processUsequenceShow];
    [[UsequenceWebInterface sharedInstance] getUsequenceHistoryUserNameByImei:[[UsequenceSdkImp sharedInstance] getUsequenceImei]
                                                        idfaUsequence:[UsequenceSdkImp getUsequenceIdfa]
        successCallbackUsequence:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESSUsequence = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLoginUsequence=[[UsequenceQuickLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
                     [self.qucickLoginUsequence show:viewUsequence];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到UsequenceDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到UsequenceYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[UsequenceSdkImp sharedInstance] addUsequenceUser:[array objectAtIndex:i] passwordUsequence:@"0" bindUsequence:@"0" touristUsequence:@"0" phoneNumberUsequence:@"0"];
                         
                     }
                     self.defaultLoginUsequence=[[UsequenceDefaultLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
                     [self.defaultLoginUsequence show:viewUsequence];

                 }else{
                     //如果没有历史帐号，则跳转到UsequenceQuickLogin登录界面
                     self.qucickLoginUsequence=[[UsequenceQuickLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
                     [self.qucickLoginUsequence show:viewUsequence];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLoginUsequence=[[UsequenceQuickLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
                 [self.qucickLoginUsequence show:viewUsequence];
             }
             @finally
             {
             }
        }
        failCallbackUsequence:^(NSError *responseError) {
            self.SHOWPROCESSUsequence = false;
            self.qucickLoginUsequence=[[UsequenceQuickLogin alloc]initWithBlock:successUsequence failed:failedUsequence landScape:isLandscapeUsequence ];
            [self.qucickLoginUsequence show:viewUsequence];
        }];
}

-(void)processUsequenceShow {
    if (self.zhuanjuhuaUsequence == nil) {
        self.zhuanjuhuaUsequence = [[UsequenceProgressHUD alloc] initWithView:self.rootViewUsequence];
        
    }
    [self.rootViewUsequence addSubview:self.zhuanjuhuaUsequence];
    self.zhuanjuhuaUsequence.labelText = @"正在获取历史帐号";
    
    [self.zhuanjuhuaUsequence showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESSUsequence)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                
                break;
            }
        }
    } successCallback:^{
        [self.zhuanjuhuaUsequence removeFromSuperview];
    }];
    
    
    
}

-(void)showUsequenceShiMingRenZhengView:(NSString *)accessTokenUsequence callbackUsequence:(Usequence_COMMON_BLOCK)callbackUsequence{
    UsequenceShiMingRenZhengView *shiming = [[UsequenceShiMingRenZhengView alloc] initUsequenceShiMingRenZhengView:self.landscapeUsequence accessToken:accessTokenUsequence callback:callbackUsequence];
    [shiming showUsequenceShiMingRenZhengView:[self getUsequenceCurrentView]];
    
}

-(UIView *)getUsequenceCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkUsequenceUpdate:(UIView*)contextUsequence
           successUsequence:(Usequence_SUCCESS_Callback)successUsequence
            failedUsequence:(Usequence_FAILED_Callback)failedUsequence
               landscapeUsequence:(Boolean)landscapeUsequence
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[UsequenceWebInterface sharedInstance]checkUsequenceUpdate:self.appkey_Usequence bundleIdUsequence:bundleid versionUsequence:version deviceUsequence:@"1" sourceCodeUsequence:self.appchannel_Usequence successCallbackUsequence:^(NSDictionary *dictionary, NSDictionary *headers) {

        @try
        {

            if (dictionary == nil)
            {
                failedUsequence(-30006);
                return;
            }
           
            successUsequence(dictionary);
            NSString *value = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"result"]];
               if ([value isEqualToString:@"1"]) {
                   NSString *openUrl=[dictionary objectForKey:@"url"];
                   if (self.updateViewUsequence==nil) {
                       self.updateViewUsequence=[[UsequenceCheckUpdate alloc]initWithBlock:landscapeUsequence  url:openUrl];
                   }
                   [self.updateViewUsequence show:contextUsequence];

               }
            
           
        }
        @catch(NSException * e)
        {
            failedUsequence(-30006);
        }
        @finally
        {
        }
    } failCallbackUsequence:^(NSError *responseError) {
        failedUsequence(-30006);
    }];

    
    
    
  

}

-(void)logoutUsequence:(UIView*)viewUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence
{
    if (self.usernameUsequence != nil)
    {
        [[UsequenceWebInterface sharedInstance] logoutUsequence:self.usernameUsequence successCallbackUsequence:^(NSDictionary * dictionary, NSDictionary * headers) {
            self.usernameUsequence = nil;
            @try
            {

                if (dictionary == nil)
                {
                    failedUsequence(-30004);
                    return;
                }
                
                NSString *value = [dictionary objectForKey:@"error"];
                if ((NSNull *)value == nil)
                {
                   
                }
                else
                {
                    
                }
                NSString *ok = [dictionary objectForKey:@"ok"];
                if ((NSNull *)ok == nil)
                {
                    failedUsequence(-30003);
                }
                else
                {
                    successUsequence(@"logout success");
                    [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"注销成功" ];
                    [self hideFloatUsequence];
                }
            }
            @catch(NSException * e)
            {
                failedUsequence(-30002);
            }
            @finally
            {
            }
        } failCallbackUsequence:^(NSError * responseError) {
            failedUsequence(-30001);
        }];
    }
    else
    {
        failedUsequence(-30005);
    }
}





-(void)executeUsequence:(UIViewController *)viewControllerUsequence
     landscapeUsequence:(BOOL)isLandscapeUsequence
     accessTokenUsequence:(NSString *)accessTokenUsequence
{

    if (self.windowUsequence==nil) {
        self.windowUsequence=[[UsequencePopWindow alloc]initWithFrameUsequencePopWindow:CGRectMake(0, 0, 50, 50) controller:viewControllerUsequence landspace:isLandscapeUsequence accessToken:accessTokenUsequence];

    }
    
}

-(void)hideFloatUsequence{

    if (self.windowUsequence!=nil) {
        [self.windowUsequence removeFromSuperview];
        self.windowUsequence = nil;
        
    }
    
}


-(void)pUsequencey:(UIViewController*)contextpUsequencey
 landscapepUsequencey:(Boolean)isLandscapepUsequencey
    paramspUsequencey:(NSDictionary*)paramspUsequencey
   successpUsequencey:(Usequence_SUCCESS_Callback)successpUsequencey
    failedpUsequencey:(Usequence_FAILED_Callback)failedpUsequencey
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"Token错误" ];
        
    }else{
        [paramspUsequencey setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:Usequence_PROTOCOL_ACCESSTOKEN];
    }
    
    Usequence_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"有误"];
                failedpUsequencey(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
        
            
            if([[dictionary objectForKey:@"result"] intValue] == 0){
                if(self.UsequenceSdkPy == NULL){
                    self.UsequenceSdkPy = [[UsequenceSdkPy alloc] init];
                }
                
                if(self.UsequenceSdkPy){
                    [self.UsequenceSdkPy pyUsequenceForAppstroe:contextpUsequencey.view
                                                paramUsequence:paramspUsequencey
                                         successUsequence:successpUsequencey
                                          failedUsequence:failedpUsequencey];
                }
            }else{
                [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"信息未配置"];
                failedpUsequencey(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[UsequenceWebInterface sharedInstance] checkPUsequenceyTypeUrl:typeResult failCallbackUsequence:^(NSError *error){
        [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"请检查网络连接！"];
        failedpUsequencey(-1100);
    }];

}


-(void)addUsequenceUser:(NSString*)usernameUsequence
      passwordUsequence:(NSString*)passwordUsequence
          bindUsequence:(NSString*) bindUsequence
       touristUsequence:(NSString*) touristUsequence
   phoneNumberUsequence:(NSString*) phoneNumberUsequence
{
    
    self.usernameUsequence=usernameUsequence;
    UsequenceUserInfo *info=[[UsequenceUserInfo alloc]initWithInfo:usernameUsequence password:passwordUsequence bind:bindUsequence tourist:touristUsequence loginTime:[self getUsequenceTimeUserNow] phoneNumber:phoneNumberUsequence];
    if ([self.databaseUsequence searchUsequenceUser:usernameUsequence]) {
        NSLog(@"hasuser");
        if ([touristUsequence isEqual:@"1"]) {
                [self.databaseUsequence updateUsequenceTourist:info];

        }else{
            [self.databaseUsequence updateUsequenceUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([touristUsequence isEqualToString:@"1"]) {
            if ([self.databaseUsequence searchUsequenceBindUser:touristUsequence]) {

                [self.databaseUsequence updateUsequenceTourist:info];
               
            }else{
                  [self.databaseUsequence insertUsequenceList:info];

            }
        }else{
             [self.databaseUsequence insertUsequenceList:info];

        }
       
    }
     
    
 
}

-(void)removeUsequenceUser:(NSString*)username
{

        [self.databaseUsequence deleteUsequenceList:username];
  
}


- (void)showUsequenceWelcome:(NSString*)username
{
    self.usernameUsequence = username;

    
    UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.rootViewUsequence];
    [self.rootViewUsequence addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = UsequenceProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [process removeFromSuperview];
    }];
}
-(void) showUsequenceToast:(NSString *)text{
    if (_processUsequence==nil) {
           _processUsequence = [[UsequenceProgressHUD alloc] initWithView:self.rootViewUsequence];
    }
    [self.rootViewUsequence addSubview:_processUsequence];
    _processUsequence.labelText = text;
    _processUsequence.labelFont=[UIFont systemFontOfSize:11];
    _processUsequence.mode = UsequenceProgressHUDModeCustomView;
    _processUsequence.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_processUsequence showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [_processUsequence removeFromSuperview];
    }];

    
}


-(NSString*)translateUsequence:(NSString*) error
{
    NSString *value = [self.errorsUsequence objectForKey:error];
    if ((NSNull *)value == nil)
    {
        return error;
    }
    
    return error;
}



+(UsequenceSdkImp*)sharedInstance
{
    static __strong UsequenceSdkImp * g_UsequenceSdkImp = nil;
    if (g_UsequenceSdkImp == nil)
    {
        g_UsequenceSdkImp = [UsequenceSdkImp alloc];
    }
    
    return g_UsequenceSdkImp;
}
-(void)loadingUsequence:(Usequence_SUCCESS_Callback)successUsequence
        failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appid_Usequence forKey:@"app_id"];
    [param setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Usequence forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[UsequenceWebInterface sharedInstance] loadingUsequence:param  successCallbackUsequence:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {

            if (dictionary == nil)
            {
                failedUsequence(-30004);
                return;
            }
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                successUsequence([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedUsequence(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedUsequence(-30002);
        }
        @finally
        {
        }
    } failCallbackUsequence:^(NSError * responseError) {
        failedUsequence(-30001);
    }];
}
 -(long)getUsequenceTimeNow{
    return time(NULL);
}
-(NSString*) getUsequenceTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}


-(void)createRoleUsequence:(NSString *)serveridUsequence user_idUsequence:(NSString*)user_idUsequence roleIdUsequence:(NSString *)roleIdUsequence
        roleLevelUsequence:(NSString *)roleLevelUsequence successUsequence:(Usequence_SUCCESS_Callback)successUsequence failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_idUsequence forKey:@"user_id"];
    [param setValue:self.appid_Usequence forKey:@"app_id"];
    [param setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Usequence forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUsequenceTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridUsequence forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[UsequenceWebInterface sharedInstance] createUsequence:param  successCallbackUsequence:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedUsequence(-30004);
                return;
            }
            NSLog(@"createUsequence:%@",dictionary);
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
              successUsequence([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedUsequence(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedUsequence(-30002);
        }
        @finally
        {
        }
    } failCallbackUsequence:^(NSError * responseError) {
        failedUsequence(-30001);
    }];
    
    


}
-(void)loginRoleUsequence:(NSString *)serveridUsequence user_idUsequence:(NSString*)user_idUsequence roleIdUsequence:(NSString *)roleIdUsequence
       roleLevelUsequence:(NSString *)roleLevelUsequence successUsequence:(Usequence_SUCCESS_Callback)successUsequence failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    
    [self doUsequenceNewAdLogin:user_idUsequence role_id:roleIdUsequence server_id:serveridUsequence];
    
}





-(void) sjUsequenceRegister:(NSString *)userid{

    
    [self doUsequenceNewAdRegister:userid];
}


-(void)levelupUsequence:(NSString*) levelUsequence
  serverNameUsequence:(NSString *)serverNameUsequence
    serveridUsequence:(NSString *) serveridUsequence
      userIdUsequence:(NSString*) userIdUsequence
     role_idUsequence:(NSString*)roleidUsequence
    roleNameUsequence:(NSString*)roleNameUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    
    [self doUsequenceNewAdLevelUp:userIdUsequence role_id:roleidUsequence server_id:serveridUsequence level:levelUsequence];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:userIdUsequence forKey:@"user_id"];
    [param setValue:self.appid_Usequence forKey:@"app_id"];
    [param setValue:serveridUsequence forKey:@"server_id"];
    [param setValue:serverNameUsequence forKey:@"server_name"];
    [param setValue:roleidUsequence forKey:@"role_id"];
    [param setValue:roleNameUsequence forKey:@"role_name"];
    [param setValue:levelUsequence forKey:@"role_level"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUsequenceTimeNow]] forKey:@"role_createtime"];
    [param setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"imei"];
    [param setValue:[UsequenceSdkImp getUsequenceIdfa] forKey:@"idfa"];
    [param setValue:self.appchannel_Usequence forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUsequenceTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridUsequence forKey:@"gateway"];
    [param setValue:levelUsequence forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[UsequenceWebInterface sharedInstance] levelupUsequence:param  successCallbackUsequence:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedUsequence(-30004);
                return;
            }
      
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
               successUsequence([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedUsequence(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedUsequence(-30002);
        }
        @finally
        {
        }
    } failCallbackUsequence:^(NSError * responseError) {
        failedUsequence(-30001);
    }];
}
-(void)error:(NSString *)log
     success:(Usequence_SUCCESS_Callback)success
      failed:(Usequence_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[UsequenceSdkImp sharedInstance] getUsequenceAppId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUsequenceTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[UsequenceWebInterface sharedInstance] erroUsequence:param successCallback:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failed(-30004);
                return;
            }
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                success([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failed(-30003);
            }
        }
        @catch(NSException * e)
        {
            failed(-30002);
        }
        @finally
        {
        }
    } failCallback:^(NSError * responseError) {
        failed(-30001);
    }];
}

-(NSString *)getUsequenceNetworktype{
    
    
    UsequenceReachability *reachability   = [UsequenceReachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"wifi";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"wifi";
            break;
            
        case ReachableViaWWAN:
            net = @"3G/4G";
            break;
            
        case NotReachable:
            net = @"notReachable";
            
        default:
            net = @"unknown";
            break;
    }

    return net;
}


-(NSString *)getUsequenceNetIsp{
    //获取本机运营商名称
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    //当前手机所属运营商名称
    
    NSString *mobile = [[NSString alloc] init];
    
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    
    if (!carrier.isoCountryCode) {
    
        
        mobile = @"无运营商";
        
    }else{
        
        mobile = [carrier carrierName];
    }

    return mobile;
}

-(void)doUsequenceNewAdInstall{
    
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall successCallback1 = %@", responseString);
    };
    
    Usequence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new adinstall failCallback1 = %@", responseError);
    };

    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_Usequence,
                      [self getUsequenceNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getUsequenceNetworktype],
                      [self getUsequenceIphoneType],
                      [UsequenceSdkImp getUsequenceIdfa],
                      [UsequenceSdkImp getUsequenceIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Usequence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil getSha256String:signSrc]];
    
    [[UsequenceWebInterface sharedInstance] newadUsequenceinstall:dataEncode
                                             signUsequence:sign
                                 successCallbackUsequence:successCallback
                                     failCallbackUsequence:failCallback];
    //    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    //    [dataFormate setDateFormat:@"YYYYMMddHHmm"];
    //    NSString *locationString=[dataFormate stringFromDate:[NSDate date]];
    //    NSLog(@"nowtime = %@", locationString);
    //    long releaseTime = 201806010000L;
    //    if([locationString longLongValue] < releaseTime){
    //        UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //        // 动画 1
    //        [UIView animateWithDuration:1.0f animations:^{
    //            window.alpha = 0;
    //            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    //        } completion:^(BOOL finished) {
    //            exit(1);
    //        }];
    //    }
    

}

-(void)doUsequenceNewAdRegister:(NSString *)userid{
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doUsequenceNewAdRegister successCallback1 = %@", responseString);
    };
    
    Usequence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doUsequenceNewAdRegister failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Usequence,
                      userid,
                      [self getUsequenceNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getUsequenceNetworktype],
                      [self getUsequenceIphoneType],
                      [UsequenceSdkImp getUsequenceIdfa],
                      [UsequenceSdkImp getUsequenceIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Usequence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil getSha256String:signSrc]];
    
    [[UsequenceWebInterface sharedInstance] newadUsequenceinstall:dataEncode
                                            signUsequence:sign
                                 successCallbackUsequence:successCallback
                                     failCallbackUsequence:failCallback];
}

-(void)doUsequenceNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doUsequenceNewAdLogin successCallback1 = %@", responseString);
    };
    
    Usequence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doUsequenceNewAdLogin failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Usequence,
                      userid,
                      server_id,
                      role_id,
                      [self getUsequenceNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getUsequenceNetworktype],
                      [self getUsequenceIphoneType],
                      [UsequenceSdkImp getUsequenceIdfa],
                      [UsequenceSdkImp getUsequenceIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Usequence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil getSha256String:signSrc]];
    
    [[UsequenceWebInterface sharedInstance] newadUsequenceinstall:dataEncode
                                            signUsequence:sign
                                 successCallbackUsequence:successCallback
                                     failCallbackUsequence:failCallback];
}

-(void)doUsequenceNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doUsequenceNewAdLevelUp successCallback1 = %@", responseString);
    };
    
    Usequence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doUsequenceNewAdLevelUp failCallback1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=update_level&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&level=%@&mac=&idfa=%@&os=ios&platform=39",
                      self.gid_Usequence,
                      userid,
                      server_id,
                      role_id,
                      level,
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Usequence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UsequenceSecurityUtil getSha256String:signSrc]];
    
    [[UsequenceWebInterface sharedInstance] newadUsequenceinstall:dataEncode
                                            signUsequence:sign
                                 successCallbackUsequence:successCallback
                                     failCallbackUsequence:failCallback];
}




@end
