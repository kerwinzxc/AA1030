
#import "SJIOSDataBase.h"
#import "SJIOSSdkImp.h"
#import "SJIOSCommonApi.h"
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


static BOOL checkUpade=NO;

@interface SJIOSSdkImp()

@property(nonatomic, strong)SJIOS_SUCCESS_Callback pySuccess;
@property(nonatomic, strong)SJIOS_FAILED_Callback pyFailed;

@property(nonatomic) Boolean autologin;
@property(nonatomic) Boolean landscape;

@property(nonatomic, strong)NSMutableDictionary * errors;
@property(nonatomic,strong) SJIOSCheckUpdate *updateView;
@property (nonatomic, strong) SJIOSFloatWindow *SJIOSFloatWindow;
@property (nonatomic,strong) SJIOSQuickLogin *qucickLogin;
@property (nonatomic,strong)SJIOSDefaultLogin *defaultLogin;
@property(nonatomic,assign) long  currentTime;
@property (nonatomic,strong)SJIOSPopWindow *window;
@property (nonatomic,strong)SJIOSProgressHUD * process;
@property (nonatomic,strong)SJIOSProgressHUD * zhuanjuhua;
@property(nonatomic) Boolean SHOWPROCESS;
@property (nonatomic,strong)SJIOSDataBase *database;



@property (nonatomic,strong) NSString *appid_SJIOS;
@property (nonatomic,strong) NSString *appkey_SJIOS;
@property (nonatomic,strong) NSString *appchannel_SJIOS;
@property (nonatomic,strong) NSString *appsecret_SJIOS;
@property (nonatomic,strong) NSString *gid_SJIOS;
@property (nonatomic,strong) NSString *ryappkey_SJIOS;
@end

@implementation SJIOSSdkImp

+(NSString*)getIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

+(NSString*)getIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString*)getCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

-(NSString*)imei
{
    return [SJIOSOpenUDID value];
}
-(NSString*)appId
{
    return self.appid_SJIOS;
}

-(NSString*)appKey
{
    return self.appkey_SJIOS;
}

-(NSString*)newAdGid
{
    return self.gid_SJIOS;
}
-(NSString*)newAdid
{
    return @"0";
}

-(NSString*)appPrivateKey
{
    NSString *appPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_SJIOS, self.appsecret_SJIOS];
    return [[SJIOSSdkMd5 md5:appPrivateKey] lowercaseString];
}

-(NSString*)appSecret
{
    return self.appsecret_SJIOS;
}


-(NSString*)channel
{
    return self.appchannel_SJIOS;
}


-(NSString*)keychainIDFV
{
    if([SJIOSKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [SJIOSKeyChainTool saveKeychainValue:[SJIOSSdkImp getIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [SJIOSKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)version
{
    return SJIOS_SDK_VERSION;
}

-(Boolean)isLandscape
{
    return self.landscape;
}
-(UIView*)rootView
{
    return self.rootControllerView;
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
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed
{
    self.landscape = isLandscape;
    
    self.landscape = isLandscape;
    self.appid_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Appid];
    self.appkey_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Appkey];
    self.appchannel_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Channel];
    self.appsecret_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Appsecret];
    self.gid_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_Gid];
    self.ryappkey_SJIOS = [[NSString alloc] initWithFormat:@"%@", SJIOS_RYAppkey];
    
    if([[self getSJIOSInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doNewAdInstall];
    
        
        SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        SJIOS_VE_BLOCK failedBlock = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[SJIOSCommonApi sharedInstance] SJIOSinstall:self.appid_SJIOS
                                   imeiOfDevice:[SJIOSSdkImp getIdfa]
                                        channel:self.appchannel_SJIOS
                                          model:[[UIDevice currentDevice] model]
                                             os:[[UIDevice currentDevice] systemVersion]
                                completionBlock:completionBlock
                                    failedBlock:failedBlock];
        
    }
    self.database=[[SJIOSDataBase alloc]init];
    [self initSJIOSPart:success failed:failed];
}

//获取ip地址
- (NSString *)getIpAddresses{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;

    success = getifaddrs(&interfaces);
    if (success == 0)
    {

        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {

                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }

    freeifaddrs(interfaces);
    return address;
}

-(void)initSJIOSPart:(SJIOS_SUCCESS_Callback)success
         failed:(SJIOS_FAILED_Callback)failed
{
    self.errors = [NSMutableDictionary dictionary];
    [self.errors setValue:@"错误的请求" forKey:@"invalid_request"];
    [self.errors setValue:@"无法识别的客户端" forKey:@"unauthorized_client"];
    [self.errors setValue:@"拒绝访问" forKey:@"access_denied"];
    [self.errors setValue:@"系统错误" forKey:@"server_error"];
    [self.errors setValue:@"系统忙" forKey:@"temporarily_unavailable"];
    [self.errors setValue:@"用户名已存在,已重新生成用户名" forKey:@"duplicate_username"];
    [self.errors setValue:@"用户名不存在" forKey:@"username_not_exist"];
    [self.errors setValue:@"用户名或者密码错误" forKey:@"username_or_password_error"];
    [self.errors setValue:@"重复的订单" forKey:@"duplicate_order"];
    [self.errors setValue:@"邮箱已绑定" forKey:@"duplicate_email"];
    [self.errors setValue:@"手机已绑定" forKey:@"duplicate_phone"];
    [self.errors setValue:@"未绑定邮箱" forKey:@"unset_email"];
    [self.errors setValue:@"未绑定手机" forKey:@"unset_phone"];
    [self.errors setValue:@"帐号登录异常，请联系客服处理！" forKey:@"account_protect"];
    
    success(@"success");
}

- (NSString *)getIphoneType {
    
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

-(void)loginSJIOS:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed
{
    
    if (self.rootControllerView==nil) {
        self.rootControllerView=view;
    }
    NSMutableArray *alluserinfo;
    if (self.database) {
        
         alluserinfo=[self.database getTestList];
    }else{
        
        self.database=[[SJIOSDataBase alloc]init];
        alluserinfo=[self.database getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLogin=[[SJIOSDefaultLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
           [self.defaultLogin show:view];
    }else{
            

        [self getSJIOSHistoryUserNameByImei:view landscape:isLandscape success:success failed:failed];
    }
 
}

-(void)loginSJIOS:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed
        flag:(int *)flag;
{
    
    if (self.rootControllerView==nil) {
        self.rootControllerView=view;
    }
    NSMutableArray *alluserinfo;
    if (self.database) {
        
        alluserinfo=[self.database getTestList];
    }else{
        
        self.database=[[SJIOSDataBase alloc]init];
        alluserinfo=[self.database getTestList];
    }
    
    
    self.qucickLogin=[[SJIOSQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
    [self.qucickLogin show:view];
    
}

-(void)getSJIOSHistoryUserNameByImei:(UIView*)view
                      landscape:(Boolean)isLandscape
                        success:(SJIOS_SUCCESS_Callback)success
                         failed:(SJIOS_FAILED_Callback)failed{
    self.SHOWPROCESS = true;
    [self processShow];
    [[SJIOSCommonApi sharedInstance] getSJIOSHistoryUserNameByImei:[[SJIOSSdkImp sharedInstance] imei]
                                                        idfa:[SJIOSSdkImp getIdfa]
        completionBlock:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESS = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLogin=[[SJIOSQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                     [self.qucickLogin show:view];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到SJIOSDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到SJIOSYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[SJIOSSdkImp sharedInstance] addSJIOSUser:[array objectAtIndex:i] password:@"0" bind:@"0" tourist:@"0" phoneNumber:@"0"];
                         
                     }
                     self.defaultLogin=[[SJIOSDefaultLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                     [self.defaultLogin show:view];

                 }else{
                     //如果没有历史帐号，则跳转到SJIOSQuickLogin登录界面
                     self.qucickLogin=[[SJIOSQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                     [self.qucickLogin show:view];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLogin=[[SJIOSQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                 [self.qucickLogin show:view];
             }
             @finally
             {
             }
        }
        failedBlock:^(NSError *responseError) {
            self.SHOWPROCESS = false;
            self.qucickLogin=[[SJIOSQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
            [self.qucickLogin show:view];
        }];
}

-(void)processShow {
    if (self.zhuanjuhua == nil) {
        self.zhuanjuhua = [[SJIOSProgressHUD alloc] initWithView:self.rootControllerView];
        
    }
    [self.rootControllerView addSubview:self.zhuanjuhua];
    self.zhuanjuhua.labelText = @"正在获取历史帐号";
    
    [self.zhuanjuhua showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESS)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } completionBlock:^{
        [self.zhuanjuhua removeFromSuperview];
    }];
    
    
    
}

-(void)showSJIOSShiMingRenZhengView:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback{
    SJIOSShiMingRenZhengView *shiming = [[SJIOSShiMingRenZhengView alloc] initSJIOSShiMingRenZhengView:self.landscape accessToken:accessToken callback:callback];
    [shiming showSJIOSShiMingRenZhengView:[self getSJIOSCurrentView]];
    
}

-(UIView *)getSJIOSCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkSJIOSUpdate:(UIView*)context
           success:(SJIOS_SUCCESS_Callback)success
            failed:(SJIOS_FAILED_Callback)failed
               landscape:(Boolean)landscape
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[SJIOSCommonApi sharedInstance]checkSJIOSUpdate:self.appKey bundleId:bundleid version:version device:@"1" sourceCode:self.channel completionBlock:^(NSDictionary *dictionary, NSDictionary *headers) {

        @try
        {

            if (dictionary == nil)
            {
                failed(-30006);
                return;
            }
           
            success(dictionary);
            NSString *value = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"result"]];
               if ([value isEqualToString:@"1"]) {
                   checkUpade=YES;
                   NSString *openUrl=[dictionary objectForKey:@"url"];
                   if (self.updateView==nil) {
                       self.updateView=[[SJIOSCheckUpdate alloc]initWithBlock:landscape  url:openUrl];
                   }
                   [self.updateView show:context];

               }
            
           
        }
        @catch(NSException * e)
        {
            failed(-30006);
        }
        @finally
        {
        }
    } failedBlock:^(NSError *responseError) {
        failed(-30006);
    }];

    
    
    
  

}

-(void)logoutSJIOS:(UIView*)view
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed
{
    if (self.username != nil)
    {
        [[SJIOSCommonApi sharedInstance] logout:self.username completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
            self.username = nil;
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
                   
                }
                else
                {
                    
                }
                NSString *ok = [dictionary objectForKey:@"ok"];
                if ((NSNull *)ok == nil)
                {
                    failed(-30003);
                }
                else
                {
                    success(@"logout success");
                    [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"注销成功" ];
                    [self hideFloatSJIOS];
                }
            }
            @catch(NSException * e)
            {
                failed(-30002);
            }
            @finally
            {
            }
        } failedBlock:^(NSError * responseError) {
            failed(-30001);
        }];
    }
    else
    {
        failed(-30005);
    }
}





-(void)executeSJIOS:(UIViewController *)viewController
     landscape:(BOOL)isLandscape
     accessToken:(NSString *)accessToken
{

    if (self.window==nil) {
        self.window=[[SJIOSPopWindow alloc]initWithFrameSJIOSPopWindow:CGRectMake(0, 0, 50, 50) controller:viewController landspace:isLandscape accessToken:accessToken];

    }
    
}

-(void)hideFloatSJIOS{

    if (self.window!=nil) {
        [self.window removeFromSuperview];
        self.window = nil;
        
    }
    
}


-(void)pSJIOSy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(SJIOS_SUCCESS_Callback)success
    failed:(SJIOS_FAILED_Callback)failed
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"Token错误" ];
        
    }else{
        [params setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:SJIOS_PROTOCOL_ACCESSTOKEN];
    }
    
    SJIOS_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"有误"];
                failed(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
            //result:0 SJIOSSdkPy; 1 wb; -1  查不到
            
            NSString *result = [NSString stringWithFormat:@"%d", [[dictionary objectForKey:@"result"] intValue]];
            
            if([[[SJIOSSdkMd5 md5:result] lowercaseString] isEqualToString:@"cfcd208495d565ef66e7dff9f98764da"]){
                if(self.SJIOSSdkPy == NULL){
                    self.SJIOSSdkPy = [[SJIOSSdkPy alloc] init];
                }
                
                if(self.SJIOSSdkPy){
                    [self.SJIOSSdkPy pySJIOSForAppstroe:context.view
                                                param:params
                                         success:success
                                          failed:failed];
                }
            }else if([[[SJIOSSdkMd5 md5:result] lowercaseString] isEqualToString:@"c4ca4238a0b923820dcc509a6f75849b"]){
                NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"yurl"];
                [self createSJIOSOrderWithExtra:params xascad:[dictionary objectForKey:a] success:success failed:failed];
            }else{
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"信息未配置"];
                failed(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[SJIOSCommonApi sharedInstance] checkPSJIOSyTypeUrl:typeResult failedBlock:^(NSError *error){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
        failed(-1100);
    }];

}

-(void)createSJIOSOrderWithExtra:(NSDictionary*)param
                          xascad:(NSString *)xascad
                         success:(SJIOS_SUCCESS_Callback)success
                          failed:(SJIOS_FAILED_Callback)failed{
    NSString *clientId = [[SJIOSSdkImp sharedInstance]appKey];
    NSString *privateKey = [[SJIOSSdkImp sharedInstance]appPrivateKey];
    NSString *channel = [[SJIOSSdkImp sharedInstance]channel];
    NSString *sign ;
    NSString *extra = [NSString stringWithFormat:@"%@%@%@", @"we", @"bp", @"ay"];
    if ([[NSString stringWithFormat:@"%@", [param objectForKey:SJIOS_PROTOCOL_EXTEND_INFO]] isEqualToString:@""]) {
        
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typewebp%@product_id%@product_name%@user_id%@",privateKey,[param objectForKey:SJIOS_PROTOCOL_ACCESSTOKEN],(long)[[param objectForKey:SJIOS_PROTOCOL_ACCOUNT] integerValue],[param objectForKey:SJIOS_PROTOCOL_APP_NAME],[param objectForKey:SJIOS_PROTOCOL_APP_ORDER_ID],channel,clientId,extra,(long)[[param objectForKey:SJIOS_PROTOCOL_GATEWAY] integerValue], @"ay", [param objectForKey:SJIOS_PROTOCOL_PRODUCT_ID],[param objectForKey:SJIOS_PROTOCOL_PRODUCT_NAME],[param objectForKey:SJIOS_PROTOCOL_USER_ID]];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typewebp%@product_id%@product_name%@user_id%@",privateKey,[param objectForKey:SJIOS_PROTOCOL_ACCESSTOKEN],(long)[[param objectForKey:SJIOS_PROTOCOL_ACCOUNT] integerValue],[param objectForKey:SJIOS_PROTOCOL_APP_NAME],[param objectForKey:SJIOS_PROTOCOL_APP_ORDER_ID],channel,clientId,[[NSString alloc] initWithFormat:@"%@", [param objectForKey:SJIOS_PROTOCOL_EXTEND_INFO]],extra,(long)[[param objectForKey:SJIOS_PROTOCOL_GATEWAY] integerValue], @"ay",[param objectForKey:SJIOS_PROTOCOL_PRODUCT_ID],[param objectForKey:SJIOS_PROTOCOL_PRODUCT_NAME],[param objectForKey:SJIOS_PROTOCOL_USER_ID]];
    }
    sign = [SJIOSSdkMd5 md5:sign];
    NSString *a = [[NSString alloc] initWithFormat:@"we%@%@", @"bp", @"ay"];
    [[SJIOSCommonApi sharedInstance]createOrSJIOSder:[param objectForKey:SJIOS_PROTOCOL_ACCESSTOKEN] userId:[param objectForKey:SJIOS_PROTOCOL_USER_ID] productName:[param objectForKey:SJIOS_PROTOCOL_PRODUCT_NAME] productId:[param objectForKey:SJIOS_PROTOCOL_PRODUCT_ID] account:[[param objectForKey:SJIOS_PROTOCOL_ACCOUNT] integerValue] appOrderId:[param objectForKey:SJIOS_PROTOCOL_APP_ORDER_ID] appName:[param objectForKey:SJIOS_PROTOCOL_APP_NAME] clientId:clientId gateway:[[param objectForKey:SJIOS_PROTOCOL_GATEWAY] integerValue] channel:channel orderType:a extra:extra extend:[[NSString alloc] initWithFormat:@"%@", [param objectForKey:SJIOS_PROTOCOL_EXTEND_INFO]] sign:sign completionBlock:^(NSDictionary *dictionary, NSDictionary *header) {

        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                failed(-1002);
            }
            else{
                
                failed(-1002);
            }
        }
        else {
            NSString *b = [NSString stringWithFormat:@"%@%@", @"ord", @"er_id"];
            NSString *uxxxxrl = [[NSString alloc] initWithFormat:@"%@?ord%@=%@", xascad, @"erId", [dictionary objectForKey:b]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:uxxxxrl]];
            success(@"success");
        }
        
    } failedBlock:^(NSError *error) {
        failed(-1002);
    }];
    
    
}

-(void)addSJIOSUser:(NSString*)username
      password:(NSString*)password
          bind:(NSString*) bind
       tourist:(NSString*) tourist
   phoneNumber:(NSString*) phoneNumber
{
    
    self.username=username;
    SJIOSUserInfo *info=[[SJIOSUserInfo alloc]initWithInfo:username password:password bind:bind tourist:tourist loginTime:[self getSJIOSTimeUserNow] phoneNumber:phoneNumber];
    if ([self.database searchSJIOSUser:username]) {
        NSLog(@"hasuser");
        if ([tourist isEqual:@"1"]) {
                [self.database updateSJIOSTourist:info];

        }else{
            [self.database updateSJIOSUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([tourist isEqualToString:@"1"]) {
            if ([self.database searchSJIOSBindUser:tourist]) {

                [self.database updateSJIOSTourist:info];
               
            }else{
                  [self.database insertSJIOSList:info];

            }
        }else{
             [self.database insertSJIOSList:info];

        }
       
    }
     
    
 
}

-(void)removeSJIOSUser:(NSString*)username
{

        [self.database deleteSJIOSList:username];
  
}


- (void)showSJIOSWelcome:(NSString*)username
{
    self.username = username;

    
    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.rootControllerView];
    [self.rootControllerView addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = SJIOSProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [process removeFromSuperview];
    }];
}
-(void) showSJIOSToast:(NSString *)text{
    if (_process==nil) {
           _process = [[SJIOSProgressHUD alloc] initWithView:[self getSJIOSCurrentView]];
    }
    [self.rootControllerView addSubview:_process];
    _process.labelText = text;
    _process.labelFont=[UIFont systemFontOfSize:11];
    _process.mode = SJIOSProgressHUDModeCustomView;
    _process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [_process removeFromSuperview];
    }];

    
}


-(NSString*)translateSJIOS:(NSString*) error
{
    NSString *value = [self.errors objectForKey:error];
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
-(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)success
        failed:(SJIOS_FAILED_Callback)failed{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[SJIOSCommonApi sharedInstance] loadingSJIOS:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
    } failedBlock:^(NSError * responseError) {
        failed(-30001);
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


-(void)active{
    

}
-(void)createRoleSJIOS:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]]   forKey:@"timestamp"];
    [param setValue:serverid forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[SJIOSCommonApi sharedInstance] createSJIOS:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failed(-30004);
                return;
            }
            NSLog(@"createSJIOS:%@",dictionary);
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
    } failedBlock:^(NSError * responseError) {
        failed(-30001);
    }];
    
    


}
-(void)loginRoleSJIOS:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed{
    
    [self doNewAdLogin:user_id role_id:roleId server_id:serverid];
    
       
    

    
}





-(void) sjRegister:(NSString *)userid{

    
    [self doNewAdRegister:userid];
}

-(void)logout:(NSString *)serverid user_id:(NSString*)user_id success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed{
    long timeNow=[self getSJIOSTimeNow];
    long elapse=timeNow-self.currentTime;
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",timeNow]   forKey:@"timestamp"];
    [param setValue:serverid forKey:@"gateway"];
    [param setValue:[NSString stringWithFormat:@"%ld",elapse] forKeyPath:@"elapse"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[SJIOSCommonApi sharedInstance] loginSJIOSout:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
    } failedBlock:^(NSError * responseError) {
        failed(-30001);
    }];
    
}

-(void)level:(NSString *)level  serverid:(NSString*)serverid user_id:(NSString*)user_id role_id:(NSString*)roleid success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed{
    
    [self doNewAdLevelUp:user_id role_id:roleid server_id:serverid level:level];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[SJIOSSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]]   forKey:@"timestamp"];
    [param setValue:serverid forKey:@"gateway"];
    [param setValue:level forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[SJIOSCommonApi sharedInstance] level:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
    } failedBlock:^(NSError * responseError) {
        failed(-30001);
    }];
}
-(void)error:(NSString *)log
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[SJIOSSdkImp sharedInstance] appId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getSJIOSTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[SJIOSCommonApi sharedInstance] erroSJIOS:param completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
    } failedBlock:^(NSError * responseError) {
        failed(-30001);
    }];
}

-(NSString *)networktype{
    
    
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


-(NSString *)getNetIsp{
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

-(void)doNewAdInstall{
    
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall completionBlock1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new adinstall failedBlock1 = %@", responseError);
    };
    
    
    
    
    
    [TrackingIO setPrintLog:TRUE];
    [TrackingIO initWithappKey:self.ryappkey_SJIOS withChannelId:@"default"];
    
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_SJIOS,
                      [self getNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self networktype],
                      [self getIphoneType],
                      [SJIOSSdkImp getIdfa],
                      [SJIOSSdkImp getIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSCommonApi sharedInstance] newadSJIOSinstall:dataEncode
                                             sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}

-(void)doNewAdRegister:(NSString *)userid{
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doNewAdRegister completionBlock1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new doNewAdRegister failedBlock1 = %@", responseError);
    };
    
   
    //ry sdk
    [TrackingIO setRegisterWithAccountID:userid];
    //end
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_SJIOS,
                      userid,
                      [self getNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self networktype],
                      [self getIphoneType],
                      [SJIOSSdkImp getIdfa],
                      [SJIOSSdkImp getIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSCommonApi sharedInstance] newadSJIOSinstall:dataEncode
                                            sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}

-(void)doNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doNewAdLogin completionBlock1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new doNewAdLogin failedBlock1 = %@", responseError);
    };
    
    
    
    //ry sdk
    [TrackingIO setLoginWithAccountID:userid];
    //end
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_SJIOS,
                      userid,
                      server_id,
                      role_id,
                      [self getNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self networktype],
                      [self getIphoneType],
                      [SJIOSSdkImp getIdfa],
                      [SJIOSSdkImp getIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, SJIOS_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [SJIOSSecurityUtil getSha256String:signSrc]];
    
    [[SJIOSCommonApi sharedInstance] newadSJIOSinstall:dataEncode
                                            sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}

-(void)doNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doNewAdLevelUp completionBlock1 = %@", responseString);
    };
    
    SJIOS_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new doNewAdLevelUp failedBlock1 = %@", responseError);
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
    
    [[SJIOSCommonApi sharedInstance] newadSJIOSinstall:dataEncode
                                            sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}




@end
