
#import "QroughtDataBase.h"
#import "QroughtSdkImp.h"
#import "QroughtWebInterface.h"
#import <UIKit/UIKit.h>
#import "QroughtSdkImp.h"
#import "QroughtSdkMd5.h"
#import "QroughtProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "QroughtFloatWindow.h"
#import "QroughtNavViewController.h"
#import "QroughtOpenUDID.h"
#include <stdio.h>
#include <sys/time.h>
#import "QroughtSdk.h"
#import "QroughtUserInfo.h"
#import "QroughtQuickLogin.h"
#import  "QroughtPopWindow.h"
#import "QroughtDefaultLogin.h"
#import "QroughtCheckUpdate.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "QroughtShiMingRenZhengView.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"



@interface QroughtSdkImp()


@property(nonatomic) Boolean landscapeQrought;

@property(nonatomic, strong)NSMutableDictionary * errorsQrought;
@property(nonatomic,strong) QroughtCheckUpdate *updateViewQrought;
@property (nonatomic, strong) QroughtFloatWindow *QroughtFloatWindow;
@property (nonatomic,strong) QroughtQuickLogin *qucickLoginQrought;
@property (nonatomic,strong)QroughtDefaultLogin *defaultLoginQrought;
@property (nonatomic,strong)QroughtPopWindow *windowQrought;
@property (nonatomic,strong)QroughtProgressHUD * processQrought;
@property (nonatomic,strong)QroughtProgressHUD * zhuanjuhuaQrought;
@property(nonatomic) Boolean SHOWPROCESSQrought;
@property (nonatomic,strong)QroughtDataBase *databaseQrought;




@property(nonatomic) BOOL isOpenQroughtShiMingRenZheng;
@property (nonatomic,strong) NSString *msgForQroughtShiMingRenZheng;
@property (nonatomic,strong) NSString *appid_Qrought;
@property (nonatomic,strong) NSString *appkey_Qrought;
@property (nonatomic,strong) NSString *appchannel_Qrought;
@property (nonatomic,strong) NSString *appsecret_Qrought;
@property (nonatomic,strong) NSString *gid_Qrought;
@property (nonatomic,strong) NSString *ryappkey_Qrought;
@property (nonatomic,strong) NSString *packageId_Qrought;
@end

@implementation QroughtSdkImp

+(NSString*)getQroughtIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

+(NSString*)getQroughtIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString*)getQroughtCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

-(NSString*)getQroughtImei
{
    return [QroughtOpenUDID value];
}
-(NSString*)getQroughtAppId
{
    return self.appid_Qrought;
}

-(NSString*)getQroughtAppKey
{
    return self.appkey_Qrought;
}

-(NSString*)getQroughtNewAdGid
{
    return self.gid_Qrought;
}
-(NSString*)getQroughtNewAdid
{
    return @"0";
}

-(NSString*)getQroughtPackageId
{
    return self.packageId_Qrought;
}

-(NSString*)getQroughtAppPrivateKey
{
    NSString *getQroughtAppPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_Qrought, self.appsecret_Qrought];
    return [[QroughtSdkMd5 md5:getQroughtAppPrivateKey] lowercaseString];
}

-(NSString*)getQroughtAppSecret
{
    return self.appsecret_Qrought;
}


-(NSString*)getQroughtChannel
{
    return self.appchannel_Qrought;
}


-(BOOL)getQroughtShiMingRenZhengFlag{
    return self.isOpenQroughtShiMingRenZheng;
}
-(NSString*)getQroughtShiMingRenZhengMsg{
    return self.msgForQroughtShiMingRenZheng;
}


-(NSString*)getQroughtKeychainIDFV
{
    if([QroughtKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [QroughtKeyChainTool saveKeychainValue:[QroughtSdkImp getQroughtIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [QroughtKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)getQroughtVersion
{
    return Qrought_SDK_VERSION;
}

-(Boolean)getQroughtIsLandscape
{
    return self.landscapeQrought;
}
-(UIView*)rootQroughtView
{
    return self.rootViewQrought;
}

-(NSString*)getQroughtInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"IS_INSTALLED_FLAG_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    NSLog(@"TAG = %@", TAG);
    if([QroughtKeyChainTool readKeychainValue:TAG] == NULL){
        [QroughtKeyChainTool saveKeychainValue:@"installed" key:TAG];
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [QroughtKeyChainTool readKeychainValue:TAG]);
        return [QroughtKeyChainTool readKeychainValue:TAG];
    }
}


-(void)initQrought:(Boolean)isLandscape
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
    
    self.landscapeQrought = isLandscape;
    
    self.landscapeQrought = isLandscape;
    self.appid_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_Appid];
    self.appkey_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_Appkey];
    self.appchannel_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_Channel];
    self.appsecret_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_Appsecret];
    self.gid_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_Gid];
    self.ryappkey_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_RYAppkey];
    self.packageId_Qrought = [[NSString alloc] initWithFormat:@"%@", Qrought_PackageId];
    
    if([[self getQroughtInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doQroughtNewAdInstall];
    
        
        Qrought_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        Qrought_VE_BLOCK failCallback = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[QroughtWebInterface sharedInstance] Qroughtinstall:self.appid_Qrought
                                   imeiOfDeviceQrought:[QroughtSdkImp getQroughtIdfa]
                                        channelQrought:self.appchannel_Qrought
                                          modelQrought:[[UIDevice currentDevice] model]
                                             osQrought:[[UIDevice currentDevice] systemVersion]
                                successCallbackQrought:successCallback
                                    failCallbackQrought:failCallback];
        
    }
    self.databaseQrought=[[QroughtDataBase alloc]init];
    [self initQroughtPart:success failedQrought:failed];
    
    [[QroughtWebInterface sharedInstance] getQroughtAntiFlag:^(NSDictionary *responseString, NSDictionary *headers) {
        self.isOpenQroughtShiMingRenZheng = [[responseString objectForKey:@"data2"] boolValue];
        self.msgForQroughtShiMingRenZheng = [NSString stringWithFormat:@"%@", [responseString objectForKey:@"msg2"]];
        NSLog(@"isOpenQroughtShiMingRenZheng = %d", self.isOpenQroughtShiMingRenZheng);
    } failCallbackQrought:^(NSError *responseError){
       
    }];
}


-(void)initQroughtPart:(Qrought_SUCCESS_Callback)successQrought
         failedQrought:(Qrought_FAILED_Callback)failedQrought
{
    self.errorsQrought = [NSMutableDictionary dictionary];
    [self.errorsQrought setValue:@"错误的请求" forKey:@"invalid_request"];
    [self.errorsQrought setValue:@"无法识别的客户端" forKey:@"unauthorized_client"];
    [self.errorsQrought setValue:@"拒绝访问" forKey:@"access_denied"];
    [self.errorsQrought setValue:@"系统错误" forKey:@"server_error"];
    [self.errorsQrought setValue:@"系统忙" forKey:@"temporarily_unavailable"];
    [self.errorsQrought setValue:@"用户名已存在,已重新生成用户名" forKey:@"duplicate_username"];
    [self.errorsQrought setValue:@"用户名不存在" forKey:@"username_not_exist"];
    [self.errorsQrought setValue:@"用户名或者密码错误" forKey:@"username_or_password_error"];
    [self.errorsQrought setValue:@"重复的订单" forKey:@"duplicate_order"];
    [self.errorsQrought setValue:@"邮箱已绑定" forKey:@"duplicate_email"];
    [self.errorsQrought setValue:@"手机已绑定" forKey:@"duplicate_phone"];
    [self.errorsQrought setValue:@"未绑定邮箱" forKey:@"unset_email"];
    [self.errorsQrought setValue:@"未绑定手机" forKey:@"unset_phone"];
    [self.errorsQrought setValue:@"帐号登录异常，请联系客服处理！" forKey:@"account_protect"];
    
    successQrought(@"success");
}

- (NSString *)getQroughtIphoneType {
    
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


-(void)destroyQrought
{
   
}

-(void)loginQrought:(UIView*)viewQrought
   landscapeQrought:(Boolean)isLandscapeQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought
{
    
    if (self.rootViewQrought==nil) {
        self.rootViewQrought=viewQrought;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseQrought) {
        
         alluserinfo=[self.databaseQrought getTestList];
    }else{
        
        self.databaseQrought=[[QroughtDataBase alloc]init];
        alluserinfo=[self.databaseQrought getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLoginQrought=[[QroughtDefaultLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
           [self.defaultLoginQrought show:viewQrought];
    }else{
            

        [self getQroughtHistoryUserNameByImei:viewQrought landscapeQrought:isLandscapeQrought successQrought:successQrought failedQrought:failedQrought];
    }
 
}

-(void)loginQrought:(UIView*)viewQrought
   landscapeQrought:(Boolean)isLandscapeQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought
        flagQrought:(int *)flagQrought;
{
    
    if (self.rootViewQrought==nil) {
        self.rootViewQrought=viewQrought;
    }
    NSMutableArray *alluserinfo;
    if (self.databaseQrought) {
        
        alluserinfo=[self.databaseQrought getTestList];
    }else{
        
        self.databaseQrought=[[QroughtDataBase alloc]init];
        alluserinfo=[self.databaseQrought getTestList];
    }
    
    
    self.qucickLoginQrought=[[QroughtQuickLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
    [self.qucickLoginQrought show:viewQrought];
    
}

-(void)getQroughtHistoryUserNameByImei:(UIView*)viewQrought
                      landscapeQrought:(Boolean)isLandscapeQrought
                        successQrought:(Qrought_SUCCESS_Callback)successQrought
                         failedQrought:(Qrought_FAILED_Callback)failedQrought{
    self.SHOWPROCESSQrought = true;
    [self processQroughtShow];
    [[QroughtWebInterface sharedInstance] getQroughtHistoryUserNameByImei:[[QroughtSdkImp sharedInstance] getQroughtImei]
                                                        idfaQrought:[QroughtSdkImp getQroughtIdfa]
        successCallbackQrought:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESSQrought = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLoginQrought=[[QroughtQuickLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
                     [self.qucickLoginQrought show:viewQrought];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到QroughtDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到QroughtYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[QroughtSdkImp sharedInstance] addQroughtUser:[array objectAtIndex:i] passwordQrought:@"0" bindQrought:@"0" touristQrought:@"0" phoneNumberQrought:@"0"];
                         
                     }
                     self.defaultLoginQrought=[[QroughtDefaultLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
                     [self.defaultLoginQrought show:viewQrought];

                 }else{
                     //如果没有历史帐号，则跳转到QroughtQuickLogin登录界面
                     self.qucickLoginQrought=[[QroughtQuickLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
                     [self.qucickLoginQrought show:viewQrought];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLoginQrought=[[QroughtQuickLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
                 [self.qucickLoginQrought show:viewQrought];
             }
             @finally
             {
             }
        }
        failCallbackQrought:^(NSError *responseError) {
            self.SHOWPROCESSQrought = false;
            self.qucickLoginQrought=[[QroughtQuickLogin alloc]initWithBlock:successQrought failed:failedQrought landScape:isLandscapeQrought ];
            [self.qucickLoginQrought show:viewQrought];
        }];
}

-(void)processQroughtShow {
    if (self.zhuanjuhuaQrought == nil) {
        self.zhuanjuhuaQrought = [[QroughtProgressHUD alloc] initWithView:self.rootViewQrought];
        
    }
    [self.rootViewQrought addSubview:self.zhuanjuhuaQrought];
    self.zhuanjuhuaQrought.labelText = @"正在获取历史帐号";
    
    [self.zhuanjuhuaQrought showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESSQrought)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                
                break;
            }
        }
    } successCallback:^{
        [self.zhuanjuhuaQrought removeFromSuperview];
    }];
    
    
    
}

-(void)showQroughtShiMingRenZhengView:(NSString *)accessTokenQrought callbackQrought:(Qrought_COMMON_BLOCK)callbackQrought{
    QroughtShiMingRenZhengView *shiming = [[QroughtShiMingRenZhengView alloc] initQroughtShiMingRenZhengView:self.landscapeQrought accessToken:accessTokenQrought callback:callbackQrought];
    [shiming showQroughtShiMingRenZhengView:[self getQroughtCurrentView]];
    
}

-(UIView *)getQroughtCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkQroughtUpdate:(UIView*)contextQrought
           successQrought:(Qrought_SUCCESS_Callback)successQrought
            failedQrought:(Qrought_FAILED_Callback)failedQrought
               landscapeQrought:(Boolean)landscapeQrought
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[QroughtWebInterface sharedInstance]checkQroughtUpdate:self.appkey_Qrought bundleIdQrought:bundleid versionQrought:version deviceQrought:@"1" sourceCodeQrought:self.appchannel_Qrought successCallbackQrought:^(NSDictionary *dictionary, NSDictionary *headers) {

        @try
        {

            if (dictionary == nil)
            {
                failedQrought(-30006);
                return;
            }
           
            successQrought(dictionary);
            NSString *value = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"result"]];
               if ([value isEqualToString:@"1"]) {
                   NSString *openUrl=[dictionary objectForKey:@"url"];
                   if (self.updateViewQrought==nil) {
                       self.updateViewQrought=[[QroughtCheckUpdate alloc]initWithBlock:landscapeQrought  url:openUrl];
                   }
                   [self.updateViewQrought show:contextQrought];

               }
            
           
        }
        @catch(NSException * e)
        {
            failedQrought(-30006);
        }
        @finally
        {
        }
    } failCallbackQrought:^(NSError *responseError) {
        failedQrought(-30006);
    }];

    
    
    
  

}

-(void)logoutQrought:(UIView*)viewQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought
{
    if (self.usernameQrought != nil)
    {
        [[QroughtWebInterface sharedInstance] logoutQrought:self.usernameQrought successCallbackQrought:^(NSDictionary * dictionary, NSDictionary * headers) {
            self.usernameQrought = nil;
            @try
            {

                if (dictionary == nil)
                {
                    failedQrought(-30004);
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
                    failedQrought(-30003);
                }
                else
                {
                    successQrought(@"logout success");
                    [[QroughtSdkImp sharedInstance]showQroughtToast:@"注销成功" ];
                    [self hideFloatQrought];
                }
            }
            @catch(NSException * e)
            {
                failedQrought(-30002);
            }
            @finally
            {
            }
        } failCallbackQrought:^(NSError * responseError) {
            failedQrought(-30001);
        }];
    }
    else
    {
        failedQrought(-30005);
    }
}





-(void)executeQrought:(UIViewController *)viewControllerQrought
     landscapeQrought:(BOOL)isLandscapeQrought
     accessTokenQrought:(NSString *)accessTokenQrought
{

    if (self.windowQrought==nil) {
        self.windowQrought=[[QroughtPopWindow alloc]initWithFrameQroughtPopWindow:CGRectMake(0, 0, 50, 50) controller:viewControllerQrought landspace:isLandscapeQrought accessToken:accessTokenQrought];

    }
    
}

-(void)hideFloatQrought{

    if (self.windowQrought!=nil) {
        [self.windowQrought removeFromSuperview];
        self.windowQrought = nil;
        
    }
    
}


-(void)pQroughty:(UIViewController*)contextpQroughty
 landscapepQroughty:(Boolean)isLandscapepQroughty
    paramspQroughty:(NSDictionary*)paramspQroughty
   successpQroughty:(Qrought_SUCCESS_Callback)successpQroughty
    failedpQroughty:(Qrought_FAILED_Callback)failedpQroughty
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[QroughtSdkImp sharedInstance]showQroughtToast:@"Token错误" ];
        
    }else{
        [paramspQroughty setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:Qrought_PROTOCOL_ACCESSTOKEN];
    }
    
    Qrought_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[QroughtSdkImp sharedInstance]showQroughtToast:@"有误"];
                failedpQroughty(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
        
            
            if([[dictionary objectForKey:@"result"] intValue] == 0){
                if(self.QroughtSdkPy == NULL){
                    self.QroughtSdkPy = [[QroughtSdkPy alloc] init];
                }
                
                if(self.QroughtSdkPy){
                    [self.QroughtSdkPy pyQroughtForAppstroe:contextpQroughty.view
                                                paramQrought:paramspQroughty
                                         successQrought:successpQroughty
                                          failedQrought:failedpQroughty];
                }
            }else{
                [[QroughtSdkImp sharedInstance]showQroughtToast:@"信息未配置"];
                failedpQroughty(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[QroughtWebInterface sharedInstance] checkPQroughtyTypeUrl:typeResult failCallbackQrought:^(NSError *error){
        [[QroughtSdkImp sharedInstance]showQroughtToast:@"请检查网络连接！"];
        failedpQroughty(-1100);
    }];

}


-(void)addQroughtUser:(NSString*)usernameQrought
      passwordQrought:(NSString*)passwordQrought
          bindQrought:(NSString*) bindQrought
       touristQrought:(NSString*) touristQrought
   phoneNumberQrought:(NSString*) phoneNumberQrought
{
    
    self.usernameQrought=usernameQrought;
    QroughtUserInfo *info=[[QroughtUserInfo alloc]initWithInfo:usernameQrought password:passwordQrought bind:bindQrought tourist:touristQrought loginTime:[self getQroughtTimeUserNow] phoneNumber:phoneNumberQrought];
    if ([self.databaseQrought searchQroughtUser:usernameQrought]) {
        NSLog(@"hasuser");
        if ([touristQrought isEqual:@"1"]) {
                [self.databaseQrought updateQroughtTourist:info];

        }else{
            [self.databaseQrought updateQroughtUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([touristQrought isEqualToString:@"1"]) {
            if ([self.databaseQrought searchQroughtBindUser:touristQrought]) {

                [self.databaseQrought updateQroughtTourist:info];
               
            }else{
                  [self.databaseQrought insertQroughtList:info];

            }
        }else{
             [self.databaseQrought insertQroughtList:info];

        }
       
    }
     
    
 
}

-(void)removeQroughtUser:(NSString*)username
{

        [self.databaseQrought deleteQroughtList:username];
  
}


- (void)showQroughtWelcome:(NSString*)username
{
    self.usernameQrought = username;

    
    QroughtProgressHUD * process = [[QroughtProgressHUD alloc] initWithView:self.rootViewQrought];
    [self.rootViewQrought addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = QroughtProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [process removeFromSuperview];
    }];
}
-(void) showQroughtToast:(NSString *)text{
    if (_processQrought==nil) {
           _processQrought = [[QroughtProgressHUD alloc] initWithView:self.rootViewQrought];
    }
    [self.rootViewQrought addSubview:_processQrought];
    _processQrought.labelText = text;
    _processQrought.labelFont=[UIFont systemFontOfSize:11];
    _processQrought.mode = QroughtProgressHUDModeCustomView;
    _processQrought.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_processQrought showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [_processQrought removeFromSuperview];
    }];

    
}


-(NSString*)translateQrought:(NSString*) error
{
    NSString *value = [self.errorsQrought objectForKey:error];
    if ((NSNull *)value == nil)
    {
        return error;
    }
    
    return error;
}



+(QroughtSdkImp*)sharedInstance
{
    static __strong QroughtSdkImp * g_QroughtSdkImp = nil;
    if (g_QroughtSdkImp == nil)
    {
        g_QroughtSdkImp = [QroughtSdkImp alloc];
    }
    
    return g_QroughtSdkImp;
}
-(void)loadingQrought:(Qrought_SUCCESS_Callback)successQrought
        failedQrought:(Qrought_FAILED_Callback)failedQrought{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appid_Qrought forKey:@"app_id"];
    [param setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Qrought forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[QroughtWebInterface sharedInstance] loadingQrought:param  successCallbackQrought:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {

            if (dictionary == nil)
            {
                failedQrought(-30004);
                return;
            }
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                successQrought([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedQrought(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedQrought(-30002);
        }
        @finally
        {
        }
    } failCallbackQrought:^(NSError * responseError) {
        failedQrought(-30001);
    }];
}
 -(long)getQroughtTimeNow{
    return time(NULL);
}
-(NSString*) getQroughtTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}


-(void)createRoleQrought:(NSString *)serveridQrought user_idQrought:(NSString*)user_idQrought roleIdQrought:(NSString *)roleIdQrought
        roleLevelQrought:(NSString *)roleLevelQrought successQrought:(Qrought_SUCCESS_Callback)successQrought failedQrought:(Qrought_FAILED_Callback)failedQrought{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_idQrought forKey:@"user_id"];
    [param setValue:self.appid_Qrought forKey:@"app_id"];
    [param setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Qrought forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getQroughtTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridQrought forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[QroughtWebInterface sharedInstance] createQrought:param  successCallbackQrought:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedQrought(-30004);
                return;
            }
            NSLog(@"createQrought:%@",dictionary);
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
              successQrought([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedQrought(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedQrought(-30002);
        }
        @finally
        {
        }
    } failCallbackQrought:^(NSError * responseError) {
        failedQrought(-30001);
    }];
    
    


}
-(void)loginRoleQrought:(NSString *)serveridQrought user_idQrought:(NSString*)user_idQrought roleIdQrought:(NSString *)roleIdQrought
       roleLevelQrought:(NSString *)roleLevelQrought successQrought:(Qrought_SUCCESS_Callback)successQrought failedQrought:(Qrought_FAILED_Callback)failedQrought{
    
    [self doQroughtNewAdLogin:user_idQrought role_id:roleIdQrought server_id:serveridQrought];
    
}





-(void) sjQroughtRegister:(NSString *)userid{

    
    [self doQroughtNewAdRegister:userid];
}


-(void)levelupQrought:(NSString*) levelQrought
  serverNameQrought:(NSString *)serverNameQrought
    serveridQrought:(NSString *) serveridQrought
      userIdQrought:(NSString*) userIdQrought
     role_idQrought:(NSString*)roleidQrought
    roleNameQrought:(NSString*)roleNameQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought{
    
    [self doQroughtNewAdLevelUp:userIdQrought role_id:roleidQrought server_id:serveridQrought level:levelQrought];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:userIdQrought forKey:@"user_id"];
    [param setValue:self.appid_Qrought forKey:@"app_id"];
    [param setValue:serveridQrought forKey:@"server_id"];
    [param setValue:serverNameQrought forKey:@"server_name"];
    [param setValue:roleidQrought forKey:@"role_id"];
    [param setValue:roleNameQrought forKey:@"role_name"];
    [param setValue:levelQrought forKey:@"role_level"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getQroughtTimeNow]] forKey:@"role_createtime"];
    [param setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"imei"];
    [param setValue:[QroughtSdkImp getQroughtIdfa] forKey:@"idfa"];
    [param setValue:self.appchannel_Qrought forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getQroughtTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridQrought forKey:@"gateway"];
    [param setValue:levelQrought forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[QroughtWebInterface sharedInstance] levelupQrought:param  successCallbackQrought:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedQrought(-30004);
                return;
            }
      
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
               successQrought([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedQrought(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedQrought(-30002);
        }
        @finally
        {
        }
    } failCallbackQrought:^(NSError * responseError) {
        failedQrought(-30001);
    }];
}
-(void)error:(NSString *)log
     success:(Qrought_SUCCESS_Callback)success
      failed:(Qrought_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[QroughtSdkImp sharedInstance] getQroughtAppId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getQroughtTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[QroughtWebInterface sharedInstance] erroQrought:param successCallback:^(NSDictionary * dictionary, NSDictionary * headers) {
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

-(NSString *)getQroughtNetworktype{
    
    
    QroughtReachability *reachability   = [QroughtReachability reachabilityWithHostName:@"www.apple.com"];
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


-(NSString *)getQroughtNetIsp{
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

-(void)doQroughtNewAdInstall{
    
    Qrought_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall successCallback1 = %@", responseString);
    };
    
    Qrought_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new adinstall failCallback1 = %@", responseError);
    };

    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_Qrought,
                      [self getQroughtNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getQroughtNetworktype],
                      [self getQroughtIphoneType],
                      [QroughtSdkImp getQroughtIdfa],
                      [QroughtSdkImp getQroughtIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Qrought_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil getSha256String:signSrc]];
    
    [[QroughtWebInterface sharedInstance] newadQroughtinstall:dataEncode
                                             signQrought:sign
                                 successCallbackQrought:successCallback
                                     failCallbackQrought:failCallback];
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

-(void)doQroughtNewAdRegister:(NSString *)userid{
    Qrought_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doQroughtNewAdRegister successCallback1 = %@", responseString);
    };
    
    Qrought_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doQroughtNewAdRegister failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Qrought,
                      userid,
                      [self getQroughtNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getQroughtNetworktype],
                      [self getQroughtIphoneType],
                      [QroughtSdkImp getQroughtIdfa],
                      [QroughtSdkImp getQroughtIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Qrought_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil getSha256String:signSrc]];
    
    [[QroughtWebInterface sharedInstance] newadQroughtinstall:dataEncode
                                            signQrought:sign
                                 successCallbackQrought:successCallback
                                     failCallbackQrought:failCallback];
}

-(void)doQroughtNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    Qrought_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doQroughtNewAdLogin successCallback1 = %@", responseString);
    };
    
    Qrought_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doQroughtNewAdLogin failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Qrought,
                      userid,
                      server_id,
                      role_id,
                      [self getQroughtNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getQroughtNetworktype],
                      [self getQroughtIphoneType],
                      [QroughtSdkImp getQroughtIdfa],
                      [QroughtSdkImp getQroughtIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Qrought_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil getSha256String:signSrc]];
    
    [[QroughtWebInterface sharedInstance] newadQroughtinstall:dataEncode
                                            signQrought:sign
                                 successCallbackQrought:successCallback
                                     failCallbackQrought:failCallback];
}

-(void)doQroughtNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    Qrought_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doQroughtNewAdLevelUp successCallback1 = %@", responseString);
    };
    
    Qrought_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doQroughtNewAdLevelUp failCallback1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=update_level&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&level=%@&mac=&idfa=%@&os=ios&platform=39",
                      self.gid_Qrought,
                      userid,
                      server_id,
                      role_id,
                      level,
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Qrought_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [QroughtSecurityUtil getSha256String:signSrc]];
    
    [[QroughtWebInterface sharedInstance] newadQroughtinstall:dataEncode
                                            signQrought:sign
                                 successCallbackQrought:successCallback
                                     failCallbackQrought:failCallback];
}




@end
