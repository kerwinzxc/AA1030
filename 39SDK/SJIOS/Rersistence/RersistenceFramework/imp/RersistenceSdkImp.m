
#import "RersistenceDataBase.h"
#import "RersistenceSdkImp.h"
#import "RersistenceWebInterface.h"
#import <UIKit/UIKit.h>
#import "RersistenceSdkImp.h"
#import "RersistenceSdkMd5.h"
#import "RersistenceProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "RersistenceFloatWindow.h"
#import "RersistenceNavViewController.h"
#import "RersistenceOpenUDID.h"
#include <stdio.h>
#include <sys/time.h>
#import "RersistenceSdk.h"
#import "RersistenceUserInfo.h"
#import "RersistenceQuickLogin.h"
#import  "RersistencePopWindow.h"
#import "RersistenceDefaultLogin.h"
#import "RersistenceCheckUpdate.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "RersistenceShiMingRenZhengView.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"



@interface RersistenceSdkImp()


@property(nonatomic) Boolean landscapeRersistence;

@property(nonatomic, strong)NSMutableDictionary * errorsRersistence;
@property(nonatomic,strong) RersistenceCheckUpdate *updateViewRersistence;
@property (nonatomic, strong) RersistenceFloatWindow *RersistenceFloatWindow;
@property (nonatomic,strong) RersistenceQuickLogin *qucickLoginRersistence;
@property (nonatomic,strong)RersistenceDefaultLogin *defaultLoginRersistence;
@property (nonatomic,strong)RersistencePopWindow *windowRersistence;
@property (nonatomic,strong)RersistenceProgressHUD * processRersistence;
@property (nonatomic,strong)RersistenceProgressHUD * zhuanjuhuaRersistence;
@property(nonatomic) Boolean SHOWPROCESSRersistence;
@property (nonatomic,strong)RersistenceDataBase *databaseRersistence;




@property(nonatomic) BOOL isOpenRersistenceShiMingRenZheng;
@property (nonatomic,strong) NSString *msgForRersistenceShiMingRenZheng;
@property (nonatomic,strong) NSString *appid_Rersistence;
@property (nonatomic,strong) NSString *appkey_Rersistence;
@property (nonatomic,strong) NSString *appchannel_Rersistence;
@property (nonatomic,strong) NSString *appsecret_Rersistence;
@property (nonatomic,strong) NSString *gid_Rersistence;
@property (nonatomic,strong) NSString *ryappkey_Rersistence;
@property (nonatomic,strong) NSString *packageId_Rersistence;
@end

@implementation RersistenceSdkImp

+(NSString*)getRersistenceIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

+(NSString*)getRersistenceIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString*)getRersistenceCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

-(NSString*)getRersistenceImei
{
    return [RersistenceOpenUDID value];
}
-(NSString*)getRersistenceAppId
{
    return self.appid_Rersistence;
}

-(NSString*)getRersistenceAppKey
{
    return self.appkey_Rersistence;
}

-(NSString*)getRersistenceNewAdGid
{
    return self.gid_Rersistence;
}
-(NSString*)getRersistenceNewAdid
{
    return @"0";
}

-(NSString*)getRersistencePackageId
{
    return self.packageId_Rersistence;
}

-(NSString*)getRersistenceAppPrivateKey
{
    NSString *getRersistenceAppPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_Rersistence, self.appsecret_Rersistence];
    return [[RersistenceSdkMd5 md5:getRersistenceAppPrivateKey] lowercaseString];
}

-(NSString*)getRersistenceAppSecret
{
    return self.appsecret_Rersistence;
}


-(NSString*)getRersistenceChannel
{
    return self.appchannel_Rersistence;
}


-(BOOL)getRersistenceShiMingRenZhengFlag{
    return self.isOpenRersistenceShiMingRenZheng;
}
-(NSString*)getRersistenceShiMingRenZhengMsg{
    return self.msgForRersistenceShiMingRenZheng;
}


-(NSString*)getRersistenceKeychainIDFV
{
    if([RersistenceKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [RersistenceKeyChainTool saveKeychainValue:[RersistenceSdkImp getRersistenceIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [RersistenceKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)getRersistenceVersion
{
    return Rersistence_SDK_VERSION;
}

-(Boolean)getRersistenceIsLandscape
{
    return self.landscapeRersistence;
}
-(UIView*)rootRersistenceView
{
    return self.rootViewRersistence;
}

-(NSString*)getRersistenceInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"IS_INSTALLED_FLAG_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    NSLog(@"TAG = %@", TAG);
    if([RersistenceKeyChainTool readKeychainValue:TAG] == NULL){
        [RersistenceKeyChainTool saveKeychainValue:@"installed" key:TAG];
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [RersistenceKeyChainTool readKeychainValue:TAG]);
        return [RersistenceKeyChainTool readKeychainValue:TAG];
    }
}


-(void)initRersistence:(Boolean)isLandscape
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
    
    self.landscapeRersistence = isLandscape;
    
    self.landscapeRersistence = isLandscape;
    self.appid_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_Appid];
    self.appkey_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_Appkey];
    self.appchannel_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_Channel];
    self.appsecret_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_Appsecret];
    self.gid_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_Gid];
    self.ryappkey_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_RYAppkey];
    self.packageId_Rersistence = [[NSString alloc] initWithFormat:@"%@", Rersistence_PackageId];
    
    if([[self getRersistenceInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doRersistenceNewAdInstall];
    
        
        Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        Rersistence_VE_BLOCK failCallback = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[RersistenceWebInterface sharedInstance] Rersistenceinstall:self.appid_Rersistence
                                   imeiOfDeviceRersistence:[RersistenceSdkImp getRersistenceIdfa]
                                        channelRersistence:self.appchannel_Rersistence
                                          modelRersistence:[[UIDevice currentDevice] model]
                                             osRersistence:[[UIDevice currentDevice] systemVersion]
                                successCallbackRersistence:successCallback
                                    failCallbackRersistence:failCallback];
        
    }
    self.databaseRersistence=[[RersistenceDataBase alloc]init];
    [self initRersistencePart:success failedRersistence:failed];
    
    [[RersistenceWebInterface sharedInstance] getRersistenceAntiFlag:^(NSDictionary *responseString, NSDictionary *headers) {
        self.isOpenRersistenceShiMingRenZheng = [[responseString objectForKey:@"data2"] boolValue];
        self.msgForRersistenceShiMingRenZheng = [NSString stringWithFormat:@"%@", [responseString objectForKey:@"msg2"]];
        NSLog(@"isOpenRersistenceShiMingRenZheng = %d", self.isOpenRersistenceShiMingRenZheng);
    } failCallbackRersistence:^(NSError *responseError){
       
    }];
}


-(void)initRersistencePart:(Rersistence_SUCCESS_Callback)successRersistence
         failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
{
    self.errorsRersistence = [NSMutableDictionary dictionary];
    [self.errorsRersistence setValue:@"错误的请求" forKey:@"invalid_request"];
    [self.errorsRersistence setValue:@"无法识别的客户端" forKey:@"unauthorized_client"];
    [self.errorsRersistence setValue:@"拒绝访问" forKey:@"access_denied"];
    [self.errorsRersistence setValue:@"系统错误" forKey:@"server_error"];
    [self.errorsRersistence setValue:@"系统忙" forKey:@"temporarily_unavailable"];
    [self.errorsRersistence setValue:@"用户名已存在,已重新生成用户名" forKey:@"duplicate_username"];
    [self.errorsRersistence setValue:@"用户名不存在" forKey:@"username_not_exist"];
    [self.errorsRersistence setValue:@"用户名或者密码错误" forKey:@"username_or_password_error"];
    [self.errorsRersistence setValue:@"重复的订单" forKey:@"duplicate_order"];
    [self.errorsRersistence setValue:@"邮箱已绑定" forKey:@"duplicate_email"];
    [self.errorsRersistence setValue:@"手机已绑定" forKey:@"duplicate_phone"];
    [self.errorsRersistence setValue:@"未绑定邮箱" forKey:@"unset_email"];
    [self.errorsRersistence setValue:@"未绑定手机" forKey:@"unset_phone"];
    [self.errorsRersistence setValue:@"帐号登录异常，请联系客服处理！" forKey:@"account_protect"];
    
    successRersistence(@"success");
}

- (NSString *)getRersistenceIphoneType {
    
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


-(void)destroyRersistence
{
   
}

-(void)loginRersistence:(UIView*)viewRersistence
   landscapeRersistence:(Boolean)isLandscapeRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
{
    
    if (self.rootViewRersistence==nil) {
        self.rootViewRersistence=viewRersistence;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseRersistence) {
        
         alluserinfo=[self.databaseRersistence getTestList];
    }else{
        
        self.databaseRersistence=[[RersistenceDataBase alloc]init];
        alluserinfo=[self.databaseRersistence getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLoginRersistence=[[RersistenceDefaultLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
           [self.defaultLoginRersistence show:viewRersistence];
    }else{
            

        [self getRersistenceHistoryUserNameByImei:viewRersistence landscapeRersistence:isLandscapeRersistence successRersistence:successRersistence failedRersistence:failedRersistence];
    }
 
}

-(void)loginRersistence:(UIView*)viewRersistence
   landscapeRersistence:(Boolean)isLandscapeRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
        flagRersistence:(int *)flagRersistence;
{
    
    if (self.rootViewRersistence==nil) {
        self.rootViewRersistence=viewRersistence;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseRersistence) {
        
        alluserinfo=[self.databaseRersistence getTestList];
    }else{
        
        self.databaseRersistence=[[RersistenceDataBase alloc]init];
        alluserinfo=[self.databaseRersistence getTestList];
    }
    
    
    self.qucickLoginRersistence=[[RersistenceQuickLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
    [self.qucickLoginRersistence show:viewRersistence];
    
}

-(void)getRersistenceHistoryUserNameByImei:(UIView*)viewRersistence
                      landscapeRersistence:(Boolean)isLandscapeRersistence
                        successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
                         failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    self.SHOWPROCESSRersistence = true;
    [self processRersistenceShow];
    [[RersistenceWebInterface sharedInstance] getRersistenceHistoryUserNameByImei:[[RersistenceSdkImp sharedInstance] getRersistenceImei]
                                                        idfaRersistence:[RersistenceSdkImp getRersistenceIdfa]
        successCallbackRersistence:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESSRersistence = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLoginRersistence=[[RersistenceQuickLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
                     [self.qucickLoginRersistence show:viewRersistence];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到RersistenceDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到RersistenceYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[RersistenceSdkImp sharedInstance] addRersistenceUser:[array objectAtIndex:i] passwordRersistence:@"0" bindRersistence:@"0" touristRersistence:@"0" phoneNumberRersistence:@"0"];
                         
                     }
                     self.defaultLoginRersistence=[[RersistenceDefaultLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
                     [self.defaultLoginRersistence show:viewRersistence];

                 }else{
                     //如果没有历史帐号，则跳转到RersistenceQuickLogin登录界面
                     self.qucickLoginRersistence=[[RersistenceQuickLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
                     [self.qucickLoginRersistence show:viewRersistence];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLoginRersistence=[[RersistenceQuickLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
                 [self.qucickLoginRersistence show:viewRersistence];
             }
             @finally
             {
             }
        }
        failCallbackRersistence:^(NSError *responseError) {
            self.SHOWPROCESSRersistence = false;
            self.qucickLoginRersistence=[[RersistenceQuickLogin alloc]initWithBlock:successRersistence failed:failedRersistence landScape:isLandscapeRersistence ];
            [self.qucickLoginRersistence show:viewRersistence];
        }];
}

-(void)processRersistenceShow {
    if (self.zhuanjuhuaRersistence == nil) {
        self.zhuanjuhuaRersistence = [[RersistenceProgressHUD alloc] initWithView:self.rootViewRersistence];
        
    }
    [self.rootViewRersistence addSubview:self.zhuanjuhuaRersistence];
    self.zhuanjuhuaRersistence.labelText = @"正在获取历史帐号";
    
    [self.zhuanjuhuaRersistence showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESSRersistence)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                
                break;
            }
        }
    } successCallback:^{
        [self.zhuanjuhuaRersistence removeFromSuperview];
    }];
    
    
    
}

-(void)showRersistenceShiMingRenZhengView:(NSString *)accessTokenRersistence callbackRersistence:(Rersistence_COMMON_BLOCK)callbackRersistence{
    RersistenceShiMingRenZhengView *shiming = [[RersistenceShiMingRenZhengView alloc] initRersistenceShiMingRenZhengView:self.landscapeRersistence accessToken:accessTokenRersistence callback:callbackRersistence];
    [shiming showRersistenceShiMingRenZhengView:[self getRersistenceCurrentView]];
    
}

-(UIView *)getRersistenceCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkRersistenceUpdate:(UIView*)contextRersistence
           successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
            failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
               landscapeRersistence:(Boolean)landscapeRersistence
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[RersistenceWebInterface sharedInstance]checkRersistenceUpdate:self.appkey_Rersistence bundleIdRersistence:bundleid versionRersistence:version deviceRersistence:@"1" sourceCodeRersistence:self.appchannel_Rersistence successCallbackRersistence:^(NSDictionary *dictionary, NSDictionary *headers) {

        @try
        {

            if (dictionary == nil)
            {
                failedRersistence(-30006);
                return;
            }
           
            successRersistence(dictionary);
            NSString *value = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"result"]];
               if ([value isEqualToString:@"1"]) {
                   NSString *openUrl=[dictionary objectForKey:@"url"];
                   if (self.updateViewRersistence==nil) {
                       self.updateViewRersistence=[[RersistenceCheckUpdate alloc]initWithBlock:landscapeRersistence  url:openUrl];
                   }
                   [self.updateViewRersistence show:contextRersistence];

               }
            
           
        }
        @catch(NSException * e)
        {
            failedRersistence(-30006);
        }
        @finally
        {
        }
    } failCallbackRersistence:^(NSError *responseError) {
        failedRersistence(-30006);
    }];

    
    
    
  

}

-(void)logoutRersistence:(UIView*)viewRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
{
    if (self.usernameRersistence != nil)
    {
        [[RersistenceWebInterface sharedInstance] logoutRersistence:self.usernameRersistence successCallbackRersistence:^(NSDictionary * dictionary, NSDictionary * headers) {
            self.usernameRersistence = nil;
            @try
            {

                if (dictionary == nil)
                {
                    failedRersistence(-30004);
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
                    failedRersistence(-30003);
                }
                else
                {
                    successRersistence(@"logout success");
                    [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"注销成功" ];
                    [self hideFloatRersistence];
                }
            }
            @catch(NSException * e)
            {
                failedRersistence(-30002);
            }
            @finally
            {
            }
        } failCallbackRersistence:^(NSError * responseError) {
            failedRersistence(-30001);
        }];
    }
    else
    {
        failedRersistence(-30005);
    }
}





-(void)executeRersistence:(UIViewController *)viewControllerRersistence
     landscapeRersistence:(BOOL)isLandscapeRersistence
     accessTokenRersistence:(NSString *)accessTokenRersistence
{

    if (self.windowRersistence==nil) {
        self.windowRersistence=[[RersistencePopWindow alloc]initWithFrameRersistencePopWindow:CGRectMake(0, 0, 50, 50) controller:viewControllerRersistence landspace:isLandscapeRersistence accessToken:accessTokenRersistence];

    }
    
}

-(void)hideFloatRersistence{

    if (self.windowRersistence!=nil) {
        [self.windowRersistence removeFromSuperview];
        self.windowRersistence = nil;
        
    }
    
}


-(void)pRersistencey:(UIViewController*)contextpRersistencey
 landscapepRersistencey:(Boolean)isLandscapepRersistencey
    paramspRersistencey:(NSDictionary*)paramspRersistencey
   successpRersistencey:(Rersistence_SUCCESS_Callback)successpRersistencey
    failedpRersistencey:(Rersistence_FAILED_Callback)failedpRersistencey
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"Token错误" ];
        
    }else{
        [paramspRersistencey setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:Rersistence_PROTOCOL_ACCESSTOKEN];
    }
    
    Rersistence_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"有误"];
                failedpRersistencey(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
        
            
            if([[dictionary objectForKey:@"result"] intValue] == 0){
                if(self.RersistenceSdkPy == NULL){
                    self.RersistenceSdkPy = [[RersistenceSdkPy alloc] init];
                }
                
                if(self.RersistenceSdkPy){
                    [self.RersistenceSdkPy pyRersistenceForAppstroe:contextpRersistencey.view
                                                paramRersistence:paramspRersistencey
                                         successRersistence:successpRersistencey
                                          failedRersistence:failedpRersistencey];
                }
            }else{
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"信息未配置"];
                failedpRersistencey(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[RersistenceWebInterface sharedInstance] checkPRersistenceyTypeUrl:typeResult failCallbackRersistence:^(NSError *error){
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
        failedpRersistencey(-1100);
    }];

}


-(void)addRersistenceUser:(NSString*)usernameRersistence
      passwordRersistence:(NSString*)passwordRersistence
          bindRersistence:(NSString*) bindRersistence
       touristRersistence:(NSString*) touristRersistence
   phoneNumberRersistence:(NSString*) phoneNumberRersistence
{
    
    self.usernameRersistence=usernameRersistence;
    RersistenceUserInfo *info=[[RersistenceUserInfo alloc]initWithInfo:usernameRersistence password:passwordRersistence bind:bindRersistence tourist:touristRersistence loginTime:[self getRersistenceTimeUserNow] phoneNumber:phoneNumberRersistence];
    if ([self.databaseRersistence searchRersistenceUser:usernameRersistence]) {
        NSLog(@"hasuser");
        if ([touristRersistence isEqual:@"1"]) {
                [self.databaseRersistence updateRersistenceTourist:info];

        }else{
            [self.databaseRersistence updateRersistenceUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([touristRersistence isEqualToString:@"1"]) {
            if ([self.databaseRersistence searchRersistenceBindUser:touristRersistence]) {

                [self.databaseRersistence updateRersistenceTourist:info];
               
            }else{
                  [self.databaseRersistence insertRersistenceList:info];

            }
        }else{
             [self.databaseRersistence insertRersistenceList:info];

        }
       
    }
     
    
 
}

-(void)removeRersistenceUser:(NSString*)username
{

        [self.databaseRersistence deleteRersistenceList:username];
  
}


- (void)showRersistenceWelcome:(NSString*)username
{
    self.usernameRersistence = username;

    
    RersistenceProgressHUD * process = [[RersistenceProgressHUD alloc] initWithView:self.rootViewRersistence];
    [self.rootViewRersistence addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = RersistenceProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [process removeFromSuperview];
    }];
}
-(void) showRersistenceToast:(NSString *)text{
    if (_processRersistence==nil) {
           _processRersistence = [[RersistenceProgressHUD alloc] initWithView:self.rootViewRersistence];
    }
    [self.rootViewRersistence addSubview:_processRersistence];
    _processRersistence.labelText = text;
    _processRersistence.labelFont=[UIFont systemFontOfSize:11];
    _processRersistence.mode = RersistenceProgressHUDModeCustomView;
    _processRersistence.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_processRersistence showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [_processRersistence removeFromSuperview];
    }];

    
}


-(NSString*)translateRersistence:(NSString*) error
{
    NSString *value = [self.errorsRersistence objectForKey:error];
    if ((NSNull *)value == nil)
    {
        return error;
    }
    
    return error;
}



+(RersistenceSdkImp*)sharedInstance
{
    static __strong RersistenceSdkImp * g_RersistenceSdkImp = nil;
    if (g_RersistenceSdkImp == nil)
    {
        g_RersistenceSdkImp = [RersistenceSdkImp alloc];
    }
    
    return g_RersistenceSdkImp;
}
-(void)loadingRersistence:(Rersistence_SUCCESS_Callback)successRersistence
        failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appid_Rersistence forKey:@"app_id"];
    [param setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Rersistence forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[RersistenceWebInterface sharedInstance] loadingRersistence:param  successCallbackRersistence:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {

            if (dictionary == nil)
            {
                failedRersistence(-30004);
                return;
            }
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                successRersistence([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedRersistence(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedRersistence(-30002);
        }
        @finally
        {
        }
    } failCallbackRersistence:^(NSError * responseError) {
        failedRersistence(-30001);
    }];
}
 -(long)getRersistenceTimeNow{
    return time(NULL);
}
-(NSString*) getRersistenceTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}


-(void)createRoleRersistence:(NSString *)serveridRersistence user_idRersistence:(NSString*)user_idRersistence roleIdRersistence:(NSString *)roleIdRersistence
        roleLevelRersistence:(NSString *)roleLevelRersistence successRersistence:(Rersistence_SUCCESS_Callback)successRersistence failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_idRersistence forKey:@"user_id"];
    [param setValue:self.appid_Rersistence forKey:@"app_id"];
    [param setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Rersistence forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getRersistenceTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridRersistence forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[RersistenceWebInterface sharedInstance] createRersistence:param  successCallbackRersistence:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedRersistence(-30004);
                return;
            }
            NSLog(@"createRersistence:%@",dictionary);
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
              successRersistence([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedRersistence(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedRersistence(-30002);
        }
        @finally
        {
        }
    } failCallbackRersistence:^(NSError * responseError) {
        failedRersistence(-30001);
    }];
    
    


}
-(void)loginRoleRersistence:(NSString *)serveridRersistence user_idRersistence:(NSString*)user_idRersistence roleIdRersistence:(NSString *)roleIdRersistence
       roleLevelRersistence:(NSString *)roleLevelRersistence successRersistence:(Rersistence_SUCCESS_Callback)successRersistence failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    
    [self doRersistenceNewAdLogin:user_idRersistence role_id:roleIdRersistence server_id:serveridRersistence];
    
}





-(void) sjRersistenceRegister:(NSString *)userid{

    
    [self doRersistenceNewAdRegister:userid];
}


-(void)levelupRersistence:(NSString*) levelRersistence
  serverNameRersistence:(NSString *)serverNameRersistence
    serveridRersistence:(NSString *) serveridRersistence
      userIdRersistence:(NSString*) userIdRersistence
     role_idRersistence:(NSString*)roleidRersistence
    roleNameRersistence:(NSString*)roleNameRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    
    [self doRersistenceNewAdLevelUp:userIdRersistence role_id:roleidRersistence server_id:serveridRersistence level:levelRersistence];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:userIdRersistence forKey:@"user_id"];
    [param setValue:self.appid_Rersistence forKey:@"app_id"];
    [param setValue:serveridRersistence forKey:@"server_id"];
    [param setValue:serverNameRersistence forKey:@"server_name"];
    [param setValue:roleidRersistence forKey:@"role_id"];
    [param setValue:roleNameRersistence forKey:@"role_name"];
    [param setValue:levelRersistence forKey:@"role_level"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getRersistenceTimeNow]] forKey:@"role_createtime"];
    [param setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"imei"];
    [param setValue:[RersistenceSdkImp getRersistenceIdfa] forKey:@"idfa"];
    [param setValue:self.appchannel_Rersistence forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getRersistenceTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridRersistence forKey:@"gateway"];
    [param setValue:levelRersistence forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[RersistenceWebInterface sharedInstance] levelupRersistence:param  successCallbackRersistence:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedRersistence(-30004);
                return;
            }
      
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
               successRersistence([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedRersistence(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedRersistence(-30002);
        }
        @finally
        {
        }
    } failCallbackRersistence:^(NSError * responseError) {
        failedRersistence(-30001);
    }];
}
-(void)error:(NSString *)log
     success:(Rersistence_SUCCESS_Callback)success
      failed:(Rersistence_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[RersistenceSdkImp sharedInstance] getRersistenceAppId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getRersistenceTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[RersistenceWebInterface sharedInstance] erroRersistence:param successCallback:^(NSDictionary * dictionary, NSDictionary * headers) {
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

-(NSString *)getRersistenceNetworktype{
    
    
    RersistenceReachability *reachability   = [RersistenceReachability reachabilityWithHostName:@"www.apple.com"];
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


-(NSString *)getRersistenceNetIsp{
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

-(void)doRersistenceNewAdInstall{
    
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall successCallback1 = %@", responseString);
    };
    
    Rersistence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new adinstall failCallback1 = %@", responseError);
    };

    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_Rersistence,
                      [self getRersistenceNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getRersistenceNetworktype],
                      [self getRersistenceIphoneType],
                      [RersistenceSdkImp getRersistenceIdfa],
                      [RersistenceSdkImp getRersistenceIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Rersistence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil getSha256String:signSrc]];
    
    [[RersistenceWebInterface sharedInstance] newadRersistenceinstall:dataEncode
                                             signRersistence:sign
                                 successCallbackRersistence:successCallback
                                     failCallbackRersistence:failCallback];
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

-(void)doRersistenceNewAdRegister:(NSString *)userid{
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doRersistenceNewAdRegister successCallback1 = %@", responseString);
    };
    
    Rersistence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doRersistenceNewAdRegister failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Rersistence,
                      userid,
                      [self getRersistenceNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getRersistenceNetworktype],
                      [self getRersistenceIphoneType],
                      [RersistenceSdkImp getRersistenceIdfa],
                      [RersistenceSdkImp getRersistenceIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Rersistence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil getSha256String:signSrc]];
    
    [[RersistenceWebInterface sharedInstance] newadRersistenceinstall:dataEncode
                                            signRersistence:sign
                                 successCallbackRersistence:successCallback
                                     failCallbackRersistence:failCallback];
}

-(void)doRersistenceNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doRersistenceNewAdLogin successCallback1 = %@", responseString);
    };
    
    Rersistence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doRersistenceNewAdLogin failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Rersistence,
                      userid,
                      server_id,
                      role_id,
                      [self getRersistenceNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getRersistenceNetworktype],
                      [self getRersistenceIphoneType],
                      [RersistenceSdkImp getRersistenceIdfa],
                      [RersistenceSdkImp getRersistenceIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Rersistence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil getSha256String:signSrc]];
    
    [[RersistenceWebInterface sharedInstance] newadRersistenceinstall:dataEncode
                                            signRersistence:sign
                                 successCallbackRersistence:successCallback
                                     failCallbackRersistence:failCallback];
}

-(void)doRersistenceNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doRersistenceNewAdLevelUp successCallback1 = %@", responseString);
    };
    
    Rersistence_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doRersistenceNewAdLevelUp failCallback1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=update_level&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&level=%@&mac=&idfa=%@&os=ios&platform=39",
                      self.gid_Rersistence,
                      userid,
                      server_id,
                      role_id,
                      level,
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Rersistence_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [RersistenceSecurityUtil getSha256String:signSrc]];
    
    [[RersistenceWebInterface sharedInstance] newadRersistenceinstall:dataEncode
                                            signRersistence:sign
                                 successCallbackRersistence:successCallback
                                     failCallbackRersistence:failCallback];
}




@end
