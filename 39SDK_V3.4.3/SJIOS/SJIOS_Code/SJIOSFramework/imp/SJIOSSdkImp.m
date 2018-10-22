
#import "SJIOSDataBase.h"
#import "SJIOSSdkImp.h"
#import "SJIOSWebInterface.h"
#import <UIKit/UIKit.h>
#import "SJIOSSdkImp.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "SJIOSFloatWindow.h"
#import "SJIOSNavViewController.h"
#import "SJIOSOpenUDID.h"
#include <stdio.h>
#include <sys/time.h>
#import "SJIOSSdk.h"
#import "SJIOSUserInfo.h"
#import "SJIOSQuickLogin.h"
#import  "SJIOSPopWindow.h"
#import "SJIOSDefaultLogin.h"
#import "SJIOSCheckUpdate.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "SJIOSShiMingRenZhengView.h"



@interface SJIOSSdkImp()


@property(nonatomic) Boolean landscapeSJIOS;

@property(nonatomic, strong)NSMutableDictionary * errorsSJIOS;
@property(nonatomic,strong) SJIOSCheckUpdate *updateViewSJIOS;
@property (nonatomic, strong) SJIOSFloatWindow *SJIOSFloatWindow;
@property (nonatomic,strong) SJIOSQuickLogin *qucickLoginSJIOS;
@property (nonatomic,strong)SJIOSDefaultLogin *defaultLoginSJIOS;
@property (nonatomic,strong)SJIOSPopWindow *windowSJIOS;
@property (nonatomic,strong)SJIOSProgressHUD * processSJIOS;
@property (nonatomic,strong)SJIOSProgressHUD * zhuanjuhuaSJIOS;
@property(nonatomic) Boolean SHOWPROCESSSJIOS;
@property (nonatomic,strong)SJIOSDataBase *databaseSJIOS;




@property(nonatomic) BOOL isOpenSJIOSShiMingRenZheng;
@property (nonatomic,strong) NSString *msgForSJIOSShiMingRenZheng;
@property (nonatomic,strong) NSString *appid_SJIOS;
@property (nonatomic,strong) NSString *appkey_SJIOS;
@property (nonatomic,strong) NSString *appchannel_SJIOS;
@property (nonatomic,strong) NSString *appsecret_SJIOS;
@property (nonatomic,strong) NSString *gid_SJIOS;
@property (nonatomic,strong) NSString *ryappkey_SJIOS;
@property (nonatomic,strong) NSString *packageId_SJIOS;
@end

@implementation SJIOSSdkImp

+(NSString*)getSJIOSIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

+(NSString*)getSJIOSIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString*)getSJIOSCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

-(NSString*)getSJIOSImei
{
    return [SJIOSOpenUDID value];
}
-(NSString*)getSJIOSAppId
{
    return self.appid_SJIOS;
}

-(NSString*)getSJIOSAppKey
{
    return self.appkey_SJIOS;
}

-(NSString*)getSJIOSNewAdGid
{
    return self.gid_SJIOS;
}
-(NSString*)getSJIOSNewAdid
{
    return @"0";
}

-(NSString*)getSJIOSPackageId
{
    return self.packageId_SJIOS;
}

-(NSString*)getSJIOSAppPrivateKey
{
    NSString *getSJIOSAppPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_SJIOS, self.appsecret_SJIOS];
    return [[SJIOSSdkMd5 md5:getSJIOSAppPrivateKey] lowercaseString];
}

-(NSString*)getSJIOSAppSecret
{
    return self.appsecret_SJIOS;
}


-(NSString*)getSJIOSChannel
{
    return self.appchannel_SJIOS;
}


-(BOOL)getSJIOSShiMingRenZhengFlag{
    return self.isOpenSJIOSShiMingRenZheng;
}
-(NSString*)getSJIOSShiMingRenZhengMsg{
    return self.msgForSJIOSShiMingRenZheng;
}


-(NSString*)getSJIOSKeychainIDFV
{
    if([SJIOSKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [SJIOSKeyChainTool saveKeychainValue:[SJIOSSdkImp getSJIOSIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [SJIOSKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)getSJIOSVersion
{
    return SJIOS_SDK_VERSION;
}

-(Boolean)getSJIOSIsLandscape
{
    return self.landscapeSJIOS;
}
-(UIView*)rootSJIOSView
{
    return self.rootViewSJIOS;
}

-(NSString*)getSJIOSInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"IS_INSTALLED_FLAG_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    NSLog(@"TAG = %@", TAG);
    if([SJIOSKeyChainTool readKeychainValue:TAG] == NULL){
        [SJIOSKeyChainTool saveKeychainValue:@"installed" key:TAG];
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [SJIOSKeyChainTool readKeychainValue:TAG]);
        return [SJIOSKeyChainTool readKeychainValue:TAG];
    }
}


-(void)initSJIOS:(Boolean)isLandscape
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
    
    self.landscapeSJIOS = isLandscape;
    
    self.landscapeSJIOS = isLandscape;
    self.appid_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Appid];
    self.appkey_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Appkey];
    self.appchannel_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Channel];
    self.appsecret_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Appsecret];
    self.gid_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Gid];
    self.ryappkey_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_RYAppkey];
    self.packageId_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_PackageId];
    
    if([[self getSJIOSInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doSJIOSNewAdInstall];
    
        
        SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        SJIOS_VE_BLOCK failCallback = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[SJIOSWebInterface sharedInstance] SJIOSinstall:self.appid_SJIOS
                                   imeiOfDeviceSJIOS:[SJIOSSdkImp getSJIOSIdfa]
                                        channelSJIOS:self.appchannel_SJIOS
                                          modelSJIOS:[[UIDevice currentDevice] model]
                                             osSJIOS:[[UIDevice currentDevice] systemVersion]
                                successCallbackSJIOS:successCallback
                                    failCallbackSJIOS:failCallback];
        
    }
    self.databaseSJIOS=[[SJIOSDataBase alloc]init];
    [self initSJIOSPart:success failedSJIOS:failed];
    
    [[SJIOSWebInterface sharedInstance] getSJIOSAntiFlag:^(NSDictionary *responseString, NSDictionary *headers) {
        self.isOpenSJIOSShiMingRenZheng = [[responseString objectForKey:@"data2"] boolValue];
        self.msgForSJIOSShiMingRenZheng = [NSString stringWithFormat:@"%@", [responseString objectForKey:@"msg2"]];
        NSLog(@"isOpenSJIOSShiMingRenZheng = %d", self.isOpenSJIOSShiMingRenZheng);
    } failCallbackSJIOS:^(NSError *responseError){
       
    }];
}


-(void)initSJIOSPart:(SJIOS_SUCCESS_Callback)successSJIOS
         failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
{
    self.errorsSJIOS = [NSMutableDictionary dictionary];
    [self.errorsSJIOS setValue:@"错误的请求" forKey:@"invalid_request"];
    [self.errorsSJIOS setValue:@"无法识别的客户端" forKey:@"unauthorized_client"];
    [self.errorsSJIOS setValue:@"拒绝访问" forKey:@"access_denied"];
    [self.errorsSJIOS setValue:@"系统错误" forKey:@"server_error"];
    [self.errorsSJIOS setValue:@"系统忙" forKey:@"temporarily_unavailable"];
    [self.errorsSJIOS setValue:@"用户名已存在,已重新生成用户名" forKey:@"duplicate_username"];
    [self.errorsSJIOS setValue:@"用户名不存在" forKey:@"username_not_exist"];
    [self.errorsSJIOS setValue:@"用户名或者密码错误" forKey:@"username_or_password_error"];
    [self.errorsSJIOS setValue:@"重复的订单" forKey:@"duplicate_order"];
    [self.errorsSJIOS setValue:@"邮箱已绑定" forKey:@"duplicate_email"];
    [self.errorsSJIOS setValue:@"手机已绑定" forKey:@"duplicate_phone"];
    [self.errorsSJIOS setValue:@"未绑定邮箱" forKey:@"unset_email"];
    [self.errorsSJIOS setValue:@"未绑定手机" forKey:@"unset_phone"];
    [self.errorsSJIOS setValue:@"帐号登录异常，请联系客服处理！" forKey:@"account_protect"];
    
    successSJIOS(@"success");
}

- (NSString *)getSJIOSIphoneType {
    
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


-(void)destroySJIOS
{
   
}

-(void)loginSJIOS:(UIView*)viewSJIOS
   landscapeSJIOS:(Boolean)isLandscapeSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
{
    
    if (self.rootViewSJIOS==nil) {
        self.rootViewSJIOS=viewSJIOS;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseSJIOS) {
        
         alluserinfo=[self.databaseSJIOS getTestList];
    }else{
        
        self.databaseSJIOS=[[SJIOSDataBase alloc]init];
        alluserinfo=[self.databaseSJIOS getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLoginSJIOS=[[SJIOSDefaultLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
           [self.defaultLoginSJIOS show:viewSJIOS];
    }else{
            

        [self getSJIOSHistoryUserNameByImei:viewSJIOS landscapeSJIOS:isLandscapeSJIOS successSJIOS:successSJIOS failedSJIOS:failedSJIOS];
    }
 
}

-(void)loginSJIOS:(UIView*)viewSJIOS
   landscapeSJIOS:(Boolean)isLandscapeSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
        flagSJIOS:(int *)flagSJIOS;
{
    
    if (self.rootViewSJIOS==nil) {
        self.rootViewSJIOS=viewSJIOS;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseSJIOS) {
        
        alluserinfo=[self.databaseSJIOS getTestList];
    }else{
        
        self.databaseSJIOS=[[SJIOSDataBase alloc]init];
        alluserinfo=[self.databaseSJIOS getTestList];
    }
    
    
    self.qucickLoginSJIOS=[[SJIOSQuickLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
    [self.qucickLoginSJIOS show:viewSJIOS];
    
}

-(void)getSJIOSHistoryUserNameByImei:(UIView*)viewSJIOS
                      landscapeSJIOS:(Boolean)isLandscapeSJIOS
                        successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
                         failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    self.SHOWPROCESSSJIOS = true;
    [self processSJIOSShow];
    [[SJIOSWebInterface sharedInstance] getSJIOSHistoryUserNameByImei:[[SJIOSSdkImp sharedInstance] getSJIOSImei]
                                                        idfaSJIOS:[SJIOSSdkImp getSJIOSIdfa]
        successCallbackSJIOS:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESSSJIOS = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLoginSJIOS=[[SJIOSQuickLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
                     [self.qucickLoginSJIOS show:viewSJIOS];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到SJIOSDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到SJIOSYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[SJIOSSdkImp sharedInstance] addSJIOSUser:[array objectAtIndex:i] passwordSJIOS:@"0" bindSJIOS:@"0" touristSJIOS:@"0" phoneNumberSJIOS:@"0"];
                         
                     }
                     self.defaultLoginSJIOS=[[SJIOSDefaultLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
                     [self.defaultLoginSJIOS show:viewSJIOS];

                 }else{
                     //如果没有历史帐号，则跳转到SJIOSQuickLogin登录界面
                     self.qucickLoginSJIOS=[[SJIOSQuickLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
                     [self.qucickLoginSJIOS show:viewSJIOS];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLoginSJIOS=[[SJIOSQuickLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
                 [self.qucickLoginSJIOS show:viewSJIOS];
             }
             @finally
             {
             }
        }
        failCallbackSJIOS:^(NSError *responseError) {
            self.SHOWPROCESSSJIOS = false;
            self.qucickLoginSJIOS=[[SJIOSQuickLogin alloc]initWithBlock:successSJIOS failed:failedSJIOS landScape:isLandscapeSJIOS ];
            [self.qucickLoginSJIOS show:viewSJIOS];
        }];
}

-(void)processSJIOSShow {
    if (self.zhuanjuhuaSJIOS == nil) {
        self.zhuanjuhuaSJIOS = [[SJIOSProgressHUD alloc] initWithView:self.rootViewSJIOS];
        
    }
    [self.rootViewSJIOS addSubview:self.zhuanjuhuaSJIOS];
    self.zhuanjuhuaSJIOS.labelText = @"正在获取历史帐号";
    
    [self.zhuanjuhuaSJIOS showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESSSJIOS)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                
                break;
            }
        }
    } successCallback:^{
        [self.zhuanjuhuaSJIOS removeFromSuperview];
    }];
    
    
    
}

-(void)showSJIOSShiMingRenZhengView:(NSString *)accessTokenSJIOS callbackSJIOS:(SJIOS_COMMON_BLOCK)callbackSJIOS{
    SJIOSShiMingRenZhengView *shiming = [[SJIOSShiMingRenZhengView alloc] initSJIOSShiMingRenZhengView:self.landscapeSJIOS accessToken:accessTokenSJIOS callback:callbackSJIOS];
    [shiming showSJIOSShiMingRenZhengView:[self getSJIOSCurrentView]];
    
}

-(UIView *)getSJIOSCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkSJIOSUpdate:(UIView*)contextSJIOS
           successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
            failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
               landscapeSJIOS:(Boolean)landscapeSJIOS
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[SJIOSWebInterface sharedInstance]checkSJIOSUpdate:self.appkey_SJIOS bundleIdSJIOS:bundleid versionSJIOS:version deviceSJIOS:@"1" sourceCodeSJIOS:self.appchannel_SJIOS successCallbackSJIOS:^(NSDictionary *dictionary, NSDictionary *headers) {

        @try
        {

            if (dictionary == nil)
            {
                failedSJIOS(-30006);
                return;
            }
           
            successSJIOS(dictionary);
            NSString *value = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"result"]];
               if ([value isEqualToString:@"1"]) {
                   NSString *openUrl=[dictionary objectForKey:@"url"];
                   if (self.updateViewSJIOS==nil) {
                       self.updateViewSJIOS=[[SJIOSCheckUpdate alloc]initWithBlock:landscapeSJIOS  url:openUrl];
                   }
                   [self.updateViewSJIOS show:contextSJIOS];

               }
            
           
        }
        @catch(NSException * e)
        {
            failedSJIOS(-30006);
        }
        @finally
        {
        }
    } failCallbackSJIOS:^(NSError *responseError) {
        failedSJIOS(-30006);
    }];

    
    
    
  

}

-(void)logoutSJIOS:(UIView*)viewSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
{
    if (self.usernameSJIOS != nil)
    {
        [[SJIOSWebInterface sharedInstance] logoutSJIOS:self.usernameSJIOS successCallbackSJIOS:^(NSDictionary * dictionary, NSDictionary * headers) {
            self.usernameSJIOS = nil;
            @try
            {

                if (dictionary == nil)
                {
                    failedSJIOS(-30004);
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
                    failedSJIOS(-30003);
                }
                else
                {
                    successSJIOS(@"logout success");
                    [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"注销成功" ];
                    [self hideFloatSJIOS];
                }
            }
            @catch(NSException * e)
            {
                failedSJIOS(-30002);
            }
            @finally
            {
            }
        } failCallbackSJIOS:^(NSError * responseError) {
            failedSJIOS(-30001);
        }];
    }
    else
    {
        failedSJIOS(-30005);
    }
}





-(void)executeSJIOS:(UIViewController *)viewControllerSJIOS
     landscapeSJIOS:(BOOL)isLandscapeSJIOS
     accessTokenSJIOS:(NSString *)accessTokenSJIOS
{

    if (self.windowSJIOS==nil) {
        self.windowSJIOS=[[SJIOSPopWindow alloc]initWithFrameSJIOSPopWindow:CGRectMake(0, 0, 50, 50) controller:viewControllerSJIOS landspace:isLandscapeSJIOS accessToken:accessTokenSJIOS];

    }
    
}

-(void)hideFloatSJIOS{

    if (self.windowSJIOS!=nil) {
        [self.windowSJIOS removeFromSuperview];
        self.windowSJIOS = nil;
        
    }
    
}


-(void)pSJIOSy:(UIViewController*)contextpSJIOSy
 landscapepSJIOSy:(Boolean)isLandscapepSJIOSy
    paramspSJIOSy:(NSDictionary*)paramspSJIOSy
   successpSJIOSy:(SJIOS_SUCCESS_Callback)successpSJIOSy
    failedpSJIOSy:(SJIOS_FAILED_Callback)failedpSJIOSy
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"Token错误" ];
        
    }else{
        [paramspSJIOSy setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:SJIOS_PROTOCOL_ACCESSTOKEN];
    }
    
    SJIOS_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"有误"];
                failedpSJIOSy(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
        
            
            if([[dictionary objectForKey:@"result"] intValue] == 0){
                if(self.SJIOSSdkPy == NULL){
                    self.SJIOSSdkPy = [[SJIOSSdkPy alloc] init];
                }
                
                if(self.SJIOSSdkPy){
                    [self.SJIOSSdkPy pySJIOSForAppstroe:contextpSJIOSy.view
                                                paramSJIOS:paramspSJIOSy
                                         successSJIOS:successpSJIOSy
                                          failedSJIOS:failedpSJIOSy];
                }
            }else{
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"信息未配置"];
                failedpSJIOSy(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[SJIOSWebInterface sharedInstance] checkPSJIOSyTypeUrl:typeResult failCallbackSJIOS:^(NSError *error){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
        failedpSJIOSy(-1100);
    }];

}


-(void)addSJIOSUser:(NSString*)usernameSJIOS
      passwordSJIOS:(NSString*)passwordSJIOS
          bindSJIOS:(NSString*) bindSJIOS
       touristSJIOS:(NSString*) touristSJIOS
   phoneNumberSJIOS:(NSString*) phoneNumberSJIOS
{
    
    self.usernameSJIOS=usernameSJIOS;
    SJIOSUserInfo *info=[[SJIOSUserInfo alloc]initWithInfo:usernameSJIOS password:passwordSJIOS bind:bindSJIOS tourist:touristSJIOS loginTime:[self getSJIOSTimeUserNow] phoneNumber:phoneNumberSJIOS];
    if ([self.databaseSJIOS searchSJIOSUser:usernameSJIOS]) {
        NSLog(@"hasuser");
        if ([touristSJIOS isEqual:@"1"]) {
                [self.databaseSJIOS updateSJIOSTourist:info];

        }else{
            [self.databaseSJIOS updateSJIOSUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([touristSJIOS isEqualToString:@"1"]) {
            if ([self.databaseSJIOS searchSJIOSBindUser:touristSJIOS]) {

                [self.databaseSJIOS updateSJIOSTourist:info];
               
            }else{
                  [self.databaseSJIOS insertSJIOSList:info];

            }
        }else{
             [self.databaseSJIOS insertSJIOSList:info];

        }
       
    }
     
    
 
}

-(void)removeSJIOSUser:(NSString*)username
{

        [self.databaseSJIOS deleteSJIOSList:username];
  
}


- (void)showSJIOSWelcome:(NSString*)username
{
    self.usernameSJIOS = username;

    
    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.rootViewSJIOS];
    [self.rootViewSJIOS addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = SJIOSProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [process removeFromSuperview];
    }];
}
-(void) showSJIOSToast:(NSString *)text{
    if (_processSJIOS==nil) {
           _processSJIOS = [[SJIOSProgressHUD alloc] initWithView:self.rootViewSJIOS];
    }
    [self.rootViewSJIOS addSubview:_processSJIOS];
    _processSJIOS.labelText = text;
    _processSJIOS.labelFont=[UIFont systemFontOfSize:11];
    _processSJIOS.mode = SJIOSProgressHUDModeCustomView;
    _processSJIOS.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_processSJIOS showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [_processSJIOS removeFromSuperview];
    }];

    
}


-(NSString*)translateSJIOS:(NSString*) error
{
    NSString *value = [self.errorsSJIOS objectForKey:error];
    if ((NSNull *)value == nil)
    {
        return error;
    }
    
    return error;
}



+(SJIOSSdkImp*)sharedInstance
{
    static __strong SJIOSSdkImp * g_SJIOSSdkImp = nil;
    if (g_SJIOSSdkImp == nil)
    {
        g_SJIOSSdkImp = [SJIOSSdkImp alloc];
    }
    
    return g_SJIOSSdkImp;
}
-(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
        failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appid_SJIOS forKey:@"app_id"];
    [param setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_SJIOS forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[SJIOSWebInterface sharedInstance] loadingSJIOS:param  successCallbackSJIOS:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {

            if (dictionary == nil)
            {
                failedSJIOS(-30004);
                return;
            }
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                successSJIOS([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedSJIOS(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedSJIOS(-30002);
        }
        @finally
        {
        }
    } failCallbackSJIOS:^(NSError * responseError) {
        failedSJIOS(-30001);
    }];
}
 -(long)getSJIOSTimeNow{
    return time(NULL);
}
-(NSString*) getSJIOSTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}


-(void)createRoleSJIOS:(NSString *)serveridSJIOS user_idSJIOS:(NSString*)user_idSJIOS roleIdSJIOS:(NSString *)roleIdSJIOS
        roleLevelSJIOS:(NSString *)roleLevelSJIOS successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_idSJIOS forKey:@"user_id"];
    [param setValue:self.appid_SJIOS forKey:@"app_id"];
    [param setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_SJIOS forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridSJIOS forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[SJIOSWebInterface sharedInstance] createSJIOS:param  successCallbackSJIOS:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedSJIOS(-30004);
                return;
            }
            NSLog(@"createSJIOS:%@",dictionary);
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
              successSJIOS([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedSJIOS(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedSJIOS(-30002);
        }
        @finally
        {
        }
    } failCallbackSJIOS:^(NSError * responseError) {
        failedSJIOS(-30001);
    }];
    
    


}
-(void)loginRoleSJIOS:(NSString *)serveridSJIOS user_idSJIOS:(NSString*)user_idSJIOS roleIdSJIOS:(NSString *)roleIdSJIOS
       roleLevelSJIOS:(NSString *)roleLevelSJIOS successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    
    [self doSJIOSNewAdLogin:user_idSJIOS role_id:roleIdSJIOS server_id:serveridSJIOS];
    
}





-(void) sjSJIOSRegister:(NSString *)userid{

    
    [self doSJIOSNewAdRegister:userid];
}


-(void)levelupSJIOS:(NSString*) levelSJIOS
  serverNameSJIOS:(NSString *)serverNameSJIOS
    serveridSJIOS:(NSString *) serveridSJIOS
      userIdSJIOS:(NSString*) userIdSJIOS
     role_idSJIOS:(NSString*)roleidSJIOS
    roleNameSJIOS:(NSString*)roleNameSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    
    [self doSJIOSNewAdLevelUp:userIdSJIOS role_id:roleidSJIOS server_id:serveridSJIOS level:levelSJIOS];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:userIdSJIOS forKey:@"user_id"];
    [param setValue:self.appid_SJIOS forKey:@"app_id"];
    [param setValue:serveridSJIOS forKey:@"server_id"];
    [param setValue:serverNameSJIOS forKey:@"server_name"];
    [param setValue:roleidSJIOS forKey:@"role_id"];
    [param setValue:roleNameSJIOS forKey:@"role_name"];
    [param setValue:levelSJIOS forKey:@"role_level"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]] forKey:@"role_createtime"];
    [param setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"imei"];
    [param setValue:[SJIOSSdkImp getSJIOSIdfa] forKey:@"idfa"];
    [param setValue:self.appchannel_SJIOS forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridSJIOS forKey:@"gateway"];
    [param setValue:levelSJIOS forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[SJIOSWebInterface sharedInstance] levelupSJIOS:param  successCallbackSJIOS:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedSJIOS(-30004);
                return;
            }
      
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
               successSJIOS([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedSJIOS(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedSJIOS(-30002);
        }
        @finally
        {
        }
    } failCallbackSJIOS:^(NSError * responseError) {
        failedSJIOS(-30001);
    }];
}
-(void)error:(NSString *)log
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[SJIOSSdkImp sharedInstance] getSJIOSAppId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[SJIOSWebInterface sharedInstance] erroSJIOS:param successCallback:^(NSDictionary * dictionary, NSDictionary * headers) {
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

-(NSString *)getSJIOSNetworktype{
    
    
    SJIOSReachability *reachability   = [SJIOSReachability reachabilityWithHostName:@"www.apple.com"];
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


-(NSString *)getSJIOSNetIsp{
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

-(void)doSJIOSNewAdInstall{
    
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall successCallback1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new adinstall failCallback1 = %@", responseError);
    };

    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_SJIOS,
                      [self getSJIOSNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getSJIOSNetworktype],
                      [self getSJIOSIphoneType],
                      [SJIOSSdkImp getSJIOSIdfa],
                      [SJIOSSdkImp getSJIOSIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSWebInterface sharedInstance] newadSJIOSinstall:dataEncode
                                             signSJIOS:sign
                                 successCallbackSJIOS:successCallback
                                     failCallbackSJIOS:failCallback];
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

-(void)doSJIOSNewAdRegister:(NSString *)userid{
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doSJIOSNewAdRegister successCallback1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doSJIOSNewAdRegister failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_SJIOS,
                      userid,
                      [self getSJIOSNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getSJIOSNetworktype],
                      [self getSJIOSIphoneType],
                      [SJIOSSdkImp getSJIOSIdfa],
                      [SJIOSSdkImp getSJIOSIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSWebInterface sharedInstance] newadSJIOSinstall:dataEncode
                                            signSJIOS:sign
                                 successCallbackSJIOS:successCallback
                                     failCallbackSJIOS:failCallback];
}

-(void)doSJIOSNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doSJIOSNewAdLogin successCallback1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doSJIOSNewAdLogin failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_SJIOS,
                      userid,
                      server_id,
                      role_id,
                      [self getSJIOSNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getSJIOSNetworktype],
                      [self getSJIOSIphoneType],
                      [SJIOSSdkImp getSJIOSIdfa],
                      [SJIOSSdkImp getSJIOSIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSWebInterface sharedInstance] newadSJIOSinstall:dataEncode
                                            signSJIOS:sign
                                 successCallbackSJIOS:successCallback
                                     failCallbackSJIOS:failCallback];
}

-(void)doSJIOSNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doSJIOSNewAdLevelUp successCallback1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doSJIOSNewAdLevelUp failCallback1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=update_level&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&level=%@&mac=&idfa=%@&os=ios&platform=39",
                      self.gid_SJIOS,
                      userid,
                      server_id,
                      role_id,
                      level,
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSWebInterface sharedInstance] newadSJIOSinstall:dataEncode
                                            signSJIOS:sign
                                 successCallbackSJIOS:successCallback
                                     failCallbackSJIOS:failCallback];
}




@end
