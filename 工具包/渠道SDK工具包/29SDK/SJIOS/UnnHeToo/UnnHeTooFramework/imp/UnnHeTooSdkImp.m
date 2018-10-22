
#import "UnnHeTooDataBase.h"
#import "UnnHeTooSdkImp.h"
#import "UnnHeTooCommonApi.h"
#import <UIKit/UIKit.h>
#import "UnnHeTooSdkImp.h"
#import "UnnHeTooSdkMd5.h"
#import "UnnHeTooProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "UnnHeTooFloatWindow.h"
#import "UnnHeTooNavViewController.h"
#import "UnnHeTooOpenUDID.h"
#include <stdio.h>
#include <sys/time.h>
#import "UnnHeTooSdk.h"
#import "UnnHeTooUserInfo.h"
#import "UnnHeTooQuickLogin.h"
#import  "UnnHeTooPopWindow.h"
#import "UnnHeTooDefaultLogin.h"
#import "UnnHeTooCheckUpdate.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "UnnHeTooShiMingRenZhengView.h"


static BOOL checkUpade=NO;

@interface UnnHeTooSdkImp()

@property(nonatomic, strong)UnnHeToo_SUCCESS_Callback pySuccess;
@property(nonatomic, strong)UnnHeToo_FAILED_Callback pyFailed;

@property(nonatomic) Boolean autologin;
@property(nonatomic) Boolean landscape;

@property(nonatomic, strong)NSMutableDictionary * errors;
@property(nonatomic,strong) UnnHeTooCheckUpdate *updateView;
@property (nonatomic, strong) UnnHeTooFloatWindow *UnnHeTooFloatWindow;
@property (nonatomic,strong) UnnHeTooQuickLogin *qucickLogin;
@property (nonatomic,strong)UnnHeTooDefaultLogin *defaultLogin;
@property(nonatomic,assign) long  currentTime;
@property (nonatomic,strong)UnnHeTooPopWindow *window;
@property (nonatomic,strong)UnnHeTooProgressHUD * process;
@property (nonatomic,strong)UnnHeTooProgressHUD * zhuanjuhua;
@property(nonatomic) Boolean SHOWPROCESS;
@property (nonatomic,strong)UnnHeTooDataBase *database;



@property (nonatomic,strong) NSString *appid_UnnHeToo;
@property (nonatomic,strong) NSString *appkey_UnnHeToo;
@property (nonatomic,strong) NSString *appchannel_UnnHeToo;
@property (nonatomic,strong) NSString *appsecret_UnnHeToo;
@property (nonatomic,strong) NSString *gid_UnnHeToo;
@property (nonatomic,strong) NSString *ryappkey_UnnHeToo;
@end

@implementation UnnHeTooSdkImp

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
    return [UnnHeTooOpenUDID value];
}
-(NSString*)appId
{
    return self.appid_UnnHeToo;
}

-(NSString*)appKey
{
    return self.appkey_UnnHeToo;
}

-(NSString*)newAdGid
{
    return self.gid_UnnHeToo;
}
-(NSString*)newAdid
{
    return @"0";
}

-(NSString*)appPrivateKey
{
    NSString *appPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_UnnHeToo, self.appsecret_UnnHeToo];
    return [[UnnHeTooSdkMd5 md5:appPrivateKey] lowercaseString];
}

-(NSString*)appSecret
{
    return self.appsecret_UnnHeToo;
}


-(NSString*)channel
{
    return self.appchannel_UnnHeToo;
}


-(NSString*)keychainIDFV
{
    if([UnnHeTooKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [UnnHeTooKeyChainTool saveKeychainValue:[UnnHeTooSdkImp getIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [UnnHeTooKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)version
{
    return UnnHeToo_SDK_VERSION;
}

-(Boolean)isLandscape
{
    return self.landscape;
}
-(UIView*)rootView
{
    return self.rootControllerView;
}

-(NSString*)getUnnHeTooInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"IS_INSTALLED_FLAG_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    NSLog(@"TAG = %@", TAG);
    if([UnnHeTooKeyChainTool readKeychainValue:TAG] == NULL){
        [UnnHeTooKeyChainTool saveKeychainValue:@"installed" key:TAG];
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [UnnHeTooKeyChainTool readKeychainValue:TAG]);
        return [UnnHeTooKeyChainTool readKeychainValue:TAG];
    }
}


-(void)initUnnHeToo:(Boolean)isLandscape
   UnnHeToo_Appid:(NSString *)UnnHeToo_Appid
  UnnHeToo_Appkey:(NSString *)UnnHeToo_Appkey
 UnnHeToo_Channel:(NSString *)UnnHeToo_Channel
UnnHeToo_Appsecret:(NSString *)UnnHeToo_Appsecret
     UnnHeToo_Gid:(NSString *)UnnHeToo_Gid
UnnHeToo_RYAppkey:(NSString *)UnnHeToo_RYAppkey
    success:(UnnHeToo_SUCCESS_Callback)success
     failed:(UnnHeToo_FAILED_Callback)failed
{
    self.landscape = isLandscape;
    
    self.landscape = isLandscape;
    self.appid_UnnHeToo = [[NSString alloc] initWithFormat:@"%@", UnnHeToo_Appid];
    self.appkey_UnnHeToo = [[NSString alloc] initWithFormat:@"%@", UnnHeToo_Appkey];
    self.appchannel_UnnHeToo = [[NSString alloc] initWithFormat:@"%@", UnnHeToo_Channel];
    self.appsecret_UnnHeToo = [[NSString alloc] initWithFormat:@"%@", UnnHeToo_Appsecret];
    self.gid_UnnHeToo = [[NSString alloc] initWithFormat:@"%@", UnnHeToo_Gid];
    self.ryappkey_UnnHeToo = [[NSString alloc] initWithFormat:@"%@", UnnHeToo_RYAppkey];
    
    if([[self getUnnHeTooInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doNewAdInstall];
    
        
        UnnHeToo_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        UnnHeToo_VE_BLOCK failedBlock = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[UnnHeTooCommonApi sharedInstance] UnnHeTooinstall:self.appid_UnnHeToo
                                   imeiOfDevice:[UnnHeTooSdkImp getIdfa]
                                        channel:self.appchannel_UnnHeToo
                                          model:[[UIDevice currentDevice] model]
                                             os:[[UIDevice currentDevice] systemVersion]
                                completionBlock:completionBlock
                                    failedBlock:failedBlock];
        
    }
    self.database=[[UnnHeTooDataBase alloc]init];
    [self initUnnHeTooPart:success failed:failed];
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

-(void)initUnnHeTooPart:(UnnHeToo_SUCCESS_Callback)success
         failed:(UnnHeToo_FAILED_Callback)failed
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


-(void)destroyUnnHeToo
{
   
}

-(void)loginUnnHeToo:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed
{
    
    if (self.rootControllerView==nil) {
        self.rootControllerView=view;
    }
    NSMutableArray *alluserinfo;
    if (self.database) {
        
         alluserinfo=[self.database getTestList];
    }else{
        
        self.database=[[UnnHeTooDataBase alloc]init];
        alluserinfo=[self.database getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLogin=[[UnnHeTooDefaultLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
           [self.defaultLogin show:view];
    }else{
            

        [self getUnnHeTooHistoryUserNameByImei:view landscape:isLandscape success:success failed:failed];
    }
 
}

-(void)loginUnnHeToo:(UIView*)view
   landscape:(Boolean)isLandscape
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed
        flag:(int *)flag;
{
    
    if (self.rootControllerView==nil) {
        self.rootControllerView=view;
    }
    NSMutableArray *alluserinfo;
    if (self.database) {
        
        alluserinfo=[self.database getTestList];
    }else{
        
        self.database=[[UnnHeTooDataBase alloc]init];
        alluserinfo=[self.database getTestList];
    }
    
    
    self.qucickLogin=[[UnnHeTooQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
    [self.qucickLogin show:view];
    
}

-(void)getUnnHeTooHistoryUserNameByImei:(UIView*)view
                      landscape:(Boolean)isLandscape
                        success:(UnnHeToo_SUCCESS_Callback)success
                         failed:(UnnHeToo_FAILED_Callback)failed{
    self.SHOWPROCESS = true;
    [self processShow];
    [[UnnHeTooCommonApi sharedInstance] getUnnHeTooHistoryUserNameByImei:[[UnnHeTooSdkImp sharedInstance] imei]
                                                        idfa:[UnnHeTooSdkImp getIdfa]
        completionBlock:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESS = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLogin=[[UnnHeTooQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                     [self.qucickLogin show:view];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到UnnHeTooDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到UnnHeTooYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[UnnHeTooSdkImp sharedInstance] addUnnHeTooUser:[array objectAtIndex:i] password:@"0" bind:@"0" tourist:@"0" phoneNumber:@"0"];
                         
                     }
                     self.defaultLogin=[[UnnHeTooDefaultLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                     [self.defaultLogin show:view];

                 }else{
                     //如果没有历史帐号，则跳转到UnnHeTooQuickLogin登录界面
                     self.qucickLogin=[[UnnHeTooQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                     [self.qucickLogin show:view];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLogin=[[UnnHeTooQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
                 [self.qucickLogin show:view];
             }
             @finally
             {
             }
        }
        failedBlock:^(NSError *responseError) {
            self.SHOWPROCESS = false;
            self.qucickLogin=[[UnnHeTooQuickLogin alloc]initWithBlock:success failed:failed landScape:isLandscape ];
            [self.qucickLogin show:view];
        }];
}

-(void)processShow {
    if (self.zhuanjuhua == nil) {
        self.zhuanjuhua = [[UnnHeTooProgressHUD alloc] initWithView:self.rootControllerView];
        
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
                [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } completionBlock:^{
        [self.zhuanjuhua removeFromSuperview];
    }];
    
    
    
}

-(void)showUnnHeTooShiMingRenZhengView:(NSString *)accessToken callback:(UnnHeToo_COMMON_BLOCK)callback{
    UnnHeTooShiMingRenZhengView *shiming = [[UnnHeTooShiMingRenZhengView alloc] initUnnHeTooShiMingRenZhengView:self.landscape accessToken:accessToken callback:callback];
    [shiming showUnnHeTooShiMingRenZhengView:[self getUnnHeTooCurrentView]];
    
}

-(UIView *)getUnnHeTooCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkUnnHeTooUpdate:(UIView*)context
           success:(UnnHeToo_SUCCESS_Callback)success
            failed:(UnnHeToo_FAILED_Callback)failed
               landscape:(Boolean)landscape
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[UnnHeTooCommonApi sharedInstance]checkUnnHeTooUpdate:self.appKey bundleId:bundleid version:version device:@"1" sourceCode:self.channel completionBlock:^(NSDictionary *dictionary, NSDictionary *headers) {

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
                       self.updateView=[[UnnHeTooCheckUpdate alloc]initWithBlock:landscape  url:openUrl];
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

-(void)logoutUnnHeToo:(UIView*)view
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed
{
    if (self.username != nil)
    {
        [[UnnHeTooCommonApi sharedInstance] logout:self.username completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
                    [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"注销成功" ];
                    [self hideFloatUnnHeToo];
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





-(void)executeUnnHeToo:(UIViewController *)viewController
     landscape:(BOOL)isLandscape
     accessToken:(NSString *)accessToken
{

    if (self.window==nil) {
        self.window=[[UnnHeTooPopWindow alloc]initWithFrameUnnHeTooPopWindow:CGRectMake(0, 0, 50, 50) controller:viewController landspace:isLandscape accessToken:accessToken];

    }
    
}

-(void)hideFloatUnnHeToo{

    if (self.window!=nil) {
        [self.window removeFromSuperview];
        self.window = nil;
        
    }
    
}


-(void)pUnnHeTooy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(UnnHeToo_SUCCESS_Callback)success
    failed:(UnnHeToo_FAILED_Callback)failed
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"Token错误" ];
        
    }else{
        [params setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:UnnHeToo_PROTOCOL_ACCESSTOKEN];
    }
    
    UnnHeToo_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"有误"];
                failed(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
            //result:0 UnnHeTooSdkPy; 1 wb; -1  查不到
            
            NSString *result = [NSString stringWithFormat:@"%d", [[dictionary objectForKey:@"result"] intValue]];
            
            if([[[UnnHeTooSdkMd5 md5:result] lowercaseString] isEqualToString:@"cfcd208495d565ef66e7dff9f98764da"]){
                if(self.UnnHeTooSdkPy == NULL){
                    self.UnnHeTooSdkPy = [[UnnHeTooSdkPy alloc] init];
                }
                
                if(self.UnnHeTooSdkPy){
                    [self.UnnHeTooSdkPy pyUnnHeTooForAppstroe:context.view
                                                param:params
                                         success:success
                                          failed:failed];
                }
            }else if([[[UnnHeTooSdkMd5 md5:result] lowercaseString] isEqualToString:@"c4ca4238a0b923820dcc509a6f75849b"]){
                NSString *a = [[NSString alloc] initWithFormat:@"pa%@", @"yurl"];
                [self createUnnHeTooOrderWithExtra:params xascad:[dictionary objectForKey:a] success:success failed:failed];
            }else{
                [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"信息未配置"];
                failed(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[UnnHeTooCommonApi sharedInstance] checkPUnnHeTooyTypeUrl:typeResult failedBlock:^(NSError *error){
        [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"请检查网络连接！"];
        failed(-1100);
    }];

}

-(void)createUnnHeTooOrderWithExtra:(NSDictionary*)param
                          xascad:(NSString *)xascad
                         success:(UnnHeToo_SUCCESS_Callback)success
                          failed:(UnnHeToo_FAILED_Callback)failed{
    NSString *clientId = [[UnnHeTooSdkImp sharedInstance]appKey];
    NSString *privateKey = [[UnnHeTooSdkImp sharedInstance]appPrivateKey];
    NSString *channel = [[UnnHeTooSdkImp sharedInstance]channel];
    NSString *sign ;
    NSString *extra = [NSString stringWithFormat:@"%@%@%@", @"we", @"bp", @"ay"];
    if ([[NSString stringWithFormat:@"%@", [param objectForKey:UnnHeToo_PROTOCOL_EXTEND_INFO]] isEqualToString:@""]) {
        
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typewebp%@product_id%@product_name%@user_id%@",privateKey,[param objectForKey:UnnHeToo_PROTOCOL_ACCESSTOKEN],(long)[[param objectForKey:UnnHeToo_PROTOCOL_ACCOUNT] integerValue],[param objectForKey:UnnHeToo_PROTOCOL_APP_NAME],[param objectForKey:UnnHeToo_PROTOCOL_APP_ORDER_ID],channel,clientId,extra,(long)[[param objectForKey:UnnHeToo_PROTOCOL_GATEWAY] integerValue], @"ay", [param objectForKey:UnnHeToo_PROTOCOL_PRODUCT_ID],[param objectForKey:UnnHeToo_PROTOCOL_PRODUCT_NAME],[param objectForKey:UnnHeToo_PROTOCOL_USER_ID]];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typewebp%@product_id%@product_name%@user_id%@",privateKey,[param objectForKey:UnnHeToo_PROTOCOL_ACCESSTOKEN],(long)[[param objectForKey:UnnHeToo_PROTOCOL_ACCOUNT] integerValue],[param objectForKey:UnnHeToo_PROTOCOL_APP_NAME],[param objectForKey:UnnHeToo_PROTOCOL_APP_ORDER_ID],channel,clientId,[[NSString alloc] initWithFormat:@"%@", [param objectForKey:UnnHeToo_PROTOCOL_EXTEND_INFO]],extra,(long)[[param objectForKey:UnnHeToo_PROTOCOL_GATEWAY] integerValue], @"ay",[param objectForKey:UnnHeToo_PROTOCOL_PRODUCT_ID],[param objectForKey:UnnHeToo_PROTOCOL_PRODUCT_NAME],[param objectForKey:UnnHeToo_PROTOCOL_USER_ID]];
    }
    sign = [UnnHeTooSdkMd5 md5:sign];
    NSString *a = [[NSString alloc] initWithFormat:@"we%@%@", @"bp", @"ay"];
    [[UnnHeTooCommonApi sharedInstance]createOrUnnHeTooder:[param objectForKey:UnnHeToo_PROTOCOL_ACCESSTOKEN] userId:[param objectForKey:UnnHeToo_PROTOCOL_USER_ID] productName:[param objectForKey:UnnHeToo_PROTOCOL_PRODUCT_NAME] productId:[param objectForKey:UnnHeToo_PROTOCOL_PRODUCT_ID] account:[[param objectForKey:UnnHeToo_PROTOCOL_ACCOUNT] integerValue] appOrderId:[param objectForKey:UnnHeToo_PROTOCOL_APP_ORDER_ID] appName:[param objectForKey:UnnHeToo_PROTOCOL_APP_NAME] clientId:clientId gateway:[[param objectForKey:UnnHeToo_PROTOCOL_GATEWAY] integerValue] channel:channel orderType:a extra:extra extend:[[NSString alloc] initWithFormat:@"%@", [param objectForKey:UnnHeToo_PROTOCOL_EXTEND_INFO]] sign:sign completionBlock:^(NSDictionary *dictionary, NSDictionary *header) {

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

-(void)addUnnHeTooUser:(NSString*)username
      password:(NSString*)password
          bind:(NSString*) bind
       tourist:(NSString*) tourist
   phoneNumber:(NSString*) phoneNumber
{
    
    self.username=username;
    UnnHeTooUserInfo *info=[[UnnHeTooUserInfo alloc]initWithInfo:username password:password bind:bind tourist:tourist loginTime:[self getUnnHeTooTimeUserNow] phoneNumber:phoneNumber];
    if ([self.database searchUnnHeTooUser:username]) {
        NSLog(@"hasuser");
        if ([tourist isEqual:@"1"]) {
                [self.database updateUnnHeTooTourist:info];

        }else{
            [self.database updateUnnHeTooUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([tourist isEqualToString:@"1"]) {
            if ([self.database searchUnnHeTooBindUser:tourist]) {

                [self.database updateUnnHeTooTourist:info];
               
            }else{
                  [self.database insertUnnHeTooList:info];

            }
        }else{
             [self.database insertUnnHeTooList:info];

        }
       
    }
     
    
 
}

-(void)removeUnnHeTooUser:(NSString*)username
{

        [self.database deleteUnnHeTooList:username];
  
}


- (void)showUnnHeTooWelcome:(NSString*)username
{
    self.username = username;

    
    UnnHeTooProgressHUD * process = [[UnnHeTooProgressHUD alloc] initWithView:self.rootControllerView];
    [self.rootControllerView addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = UnnHeTooProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [process removeFromSuperview];
    }];
}
-(void) showUnnHeTooToast:(NSString *)text{
    if (_process==nil) {
           _process = [[UnnHeTooProgressHUD alloc] initWithView:[self getUnnHeTooCurrentView]];
    }
    [self.rootControllerView addSubview:_process];
    _process.labelText = text;
    _process.labelFont=[UIFont systemFontOfSize:11];
    _process.mode = UnnHeTooProgressHUDModeCustomView;
    _process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [_process removeFromSuperview];
    }];

    
}


-(NSString*)translateUnnHeToo:(NSString*) error
{
    NSString *value = [self.errors objectForKey:error];
    if ((NSNull *)value == nil)
    {
        return error;
    }
    
    return error;
}



+(UnnHeTooSdkImp*)sharedInstance
{
    static __strong UnnHeTooSdkImp * g_UnnHeTooSdkImp = nil;
    if (g_UnnHeTooSdkImp == nil)
    {
        g_UnnHeTooSdkImp = [UnnHeTooSdkImp alloc];
    }
    
    return g_UnnHeTooSdkImp;
}
-(void)loadingUnnHeToo:(UnnHeToo_SUCCESS_Callback)success
        failed:(UnnHeToo_FAILED_Callback)failed{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[UnnHeTooCommonApi sharedInstance] loadingUnnHeToo:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
 -(long)getUnnHeTooTimeNow{
    return time(NULL);
}
-(NSString*) getUnnHeTooTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}


-(void)active{
    

}
-(void)createRoleUnnHeToo:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUnnHeTooTimeNow]]   forKey:@"timestamp"];
    [param setValue:serverid forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[UnnHeTooCommonApi sharedInstance] createUnnHeToo:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failed(-30004);
                return;
            }
            NSLog(@"createUnnHeToo:%@",dictionary);
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
-(void)loginRoleUnnHeToo:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed{
    
    [self doNewAdLogin:user_id role_id:roleId server_id:serverid];
    
       
    

    
}





-(void) sjRegister:(NSString *)userid{

    
    [self doNewAdRegister:userid];
}

-(void)logout:(NSString *)serverid user_id:(NSString*)user_id success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed{
    long timeNow=[self getUnnHeTooTimeNow];
    long elapse=timeNow-self.currentTime;
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",timeNow]   forKey:@"timestamp"];
    [param setValue:serverid forKey:@"gateway"];
    [param setValue:[NSString stringWithFormat:@"%ld",elapse] forKeyPath:@"elapse"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[UnnHeTooCommonApi sharedInstance] loginUnnHeTooout:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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

-(void)level:(NSString *)level  serverid:(NSString*)serverid user_id:(NSString*)user_id role_id:(NSString*)roleid success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed{
    
    [self doNewAdLevelUp:user_id role_id:roleid server_id:serverid level:level];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:self.appId forKey:@"app_id"];
    [param setValue:[UnnHeTooSdkImp getIdfa] forKey:@"imei"];
    [param setValue:self.channel forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUnnHeTooTimeNow]]   forKey:@"timestamp"];
    [param setValue:serverid forKey:@"gateway"];
    [param setValue:level forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[UnnHeTooCommonApi sharedInstance] level:param  completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[UnnHeTooSdkImp sharedInstance] appId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getUnnHeTooTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[UnnHeTooCommonApi sharedInstance] erroUnnHeToo:param completionBlock:^(NSDictionary * dictionary, NSDictionary * headers) {
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
    
    
    UnnHeTooReachability *reachability   = [UnnHeTooReachability reachabilityWithHostName:@"www.apple.com"];
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
    
    UnnHeToo_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall completionBlock1 = %@", responseString);
    };
    
    UnnHeToo_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new adinstall failedBlock1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_UnnHeToo,
                      [self getNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self networktype],
                      [self getIphoneType],
                      [UnnHeTooSdkImp getIdfa],
                      [UnnHeTooSdkImp getIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, UnnHeToo_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil getSha256String:signSrc]];
    
    [[UnnHeTooCommonApi sharedInstance] newadUnnHeTooinstall:dataEncode
                                             sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}

-(void)doNewAdRegister:(NSString *)userid{
    UnnHeToo_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doNewAdRegister completionBlock1 = %@", responseString);
    };
    
    UnnHeToo_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new doNewAdRegister failedBlock1 = %@", responseError);
    };
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_UnnHeToo,
                      userid,
                      [self getNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self networktype],
                      [self getIphoneType],
                      [UnnHeTooSdkImp getIdfa],
                      [UnnHeTooSdkImp getIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, UnnHeToo_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil getSha256String:signSrc]];
    
    [[UnnHeTooCommonApi sharedInstance] newadUnnHeTooinstall:dataEncode
                                            sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}

-(void)doNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    UnnHeToo_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doNewAdLogin completionBlock1 = %@", responseString);
    };
    
    UnnHeToo_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new doNewAdLogin failedBlock1 = %@", responseError);
    };
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_UnnHeToo,
                      userid,
                      server_id,
                      role_id,
                      [self getNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self networktype],
                      [self getIphoneType],
                      [UnnHeTooSdkImp getIdfa],
                      [UnnHeTooSdkImp getIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, UnnHeToo_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil getSha256String:signSrc]];
    
    [[UnnHeTooCommonApi sharedInstance] newadUnnHeTooinstall:dataEncode
                                            sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}

-(void)doNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    UnnHeToo_VSD_BLOCK completionBlock = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doNewAdLevelUp completionBlock1 = %@", responseString);
    };
    
    UnnHeToo_VE_BLOCK failedBlock = ^(NSError *responseError){
        NSLog(@"new doNewAdLevelUp failedBlock1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=update_level&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&level=%@&mac=&idfa=%@&os=ios&platform=39",
                      self.gid_UnnHeToo,
                      userid,
                      server_id,
                      role_id,
                      level,
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, UnnHeToo_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [UnnHeTooSecurityUtil getSha256String:signSrc]];
    
    [[UnnHeTooCommonApi sharedInstance] newadUnnHeTooinstall:dataEncode
                                            sign:sign
                                 completionBlock:completionBlock
                                     failedBlock:failedBlock];
}




@end
