
#import "PostinDataBase.h"
#import "PostinSdkImp.h"
#import "PostinWebInterface.h"
#import <UIKit/UIKit.h>
#import "PostinSdkImp.h"
#import "PostinSdkMd5.h"
#import "PostinProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "PostinFloatWindow.h"
#import "PostinNavViewController.h"
#import "PostinOpenUDID.h"
#include <stdio.h>
#include <sys/time.h>
#import "PostinSdk.h"
#import "PostinUserInfo.h"
#import "PostinQuickLogin.h"
#import  "PostinPopWindow.h"
#import "PostinDefaultLogin.h"
#import "PostinCheckUpdate.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "PostinShiMingRenZhengView.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"



@interface PostinSdkImp()


@property(nonatomic) Boolean landscapePostin;

@property(nonatomic, strong)NSMutableDictionary * errorsPostin;
@property(nonatomic,strong) PostinCheckUpdate *updateViewPostin;
@property (nonatomic, strong) PostinFloatWindow *PostinFloatWindow;
@property (nonatomic,strong) PostinQuickLogin *qucickLoginPostin;
@property (nonatomic,strong)PostinDefaultLogin *defaultLoginPostin;
@property (nonatomic,strong)PostinPopWindow *windowPostin;
@property (nonatomic,strong)PostinProgressHUD * processPostin;
@property (nonatomic,strong)PostinProgressHUD * zhuanjuhuaPostin;
@property(nonatomic) Boolean SHOWPROCESSPostin;
@property (nonatomic,strong)PostinDataBase *databasePostin;




@property(nonatomic) BOOL isOpenPostinShiMingRenZheng;
@property (nonatomic,strong) NSString *msgForPostinShiMingRenZheng;
@property (nonatomic,strong) NSString *appid_Postin;
@property (nonatomic,strong) NSString *appkey_Postin;
@property (nonatomic,strong) NSString *appchannel_Postin;
@property (nonatomic,strong) NSString *appsecret_Postin;
@property (nonatomic,strong) NSString *gid_Postin;
@property (nonatomic,strong) NSString *ryappkey_Postin;
@property (nonatomic,strong) NSString *packageId_Postin;
@end

@implementation PostinSdkImp

+(NSString*)getPostinIdfa{
    return  [[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString];
}

+(NSString*)getPostinIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(NSString*)getPostinCurrentTimestamp{
    
    NSDate* data= [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval interval=[data timeIntervalSince1970];
    
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];//转为字符型
    
    return timeString;
    
}

-(NSString*)getPostinImei
{
    return [PostinOpenUDID value];
}
-(NSString*)getPostinAppId
{
    return self.appid_Postin;
}

-(NSString*)getPostinAppKey
{
    return self.appkey_Postin;
}

-(NSString*)getPostinNewAdGid
{
    return self.gid_Postin;
}
-(NSString*)getPostinNewAdid
{
    return @"0";
}

-(NSString*)getPostinPackageId
{
    return self.packageId_Postin;
}

-(NSString*)getPostinAppPrivateKey
{
    NSString *getPostinAppPrivateKey = [NSString stringWithFormat:@"%@#%@", self.appkey_Postin, self.appsecret_Postin];
    return [[PostinSdkMd5 md5:getPostinAppPrivateKey] lowercaseString];
}

-(NSString*)getPostinAppSecret
{
    return self.appsecret_Postin;
}


-(NSString*)getPostinChannel
{
    return self.appchannel_Postin;
}


-(BOOL)getPostinShiMingRenZhengFlag{
    return self.isOpenPostinShiMingRenZheng;
}
-(NSString*)getPostinShiMingRenZhengMsg{
    return self.msgForPostinShiMingRenZheng;
}


-(NSString*)getPostinKeychainIDFV
{
    if([PostinKeyChainTool readKeychainValue:@"SJYX_IDFV"] == NULL){
        [PostinKeyChainTool saveKeychainValue:[PostinSdkImp getPostinIdfv] key:@"SJYX_IDFV"];
        
    }else{
        
    }
    
    
    return [PostinKeyChainTool readKeychainValue:@"SJYX_IDFV"];
}


-(NSString*)getPostinVersion
{
    return Postin_SDK_VERSION;
}

-(Boolean)getPostinIsLandscape
{
    return self.landscapePostin;
}
-(UIView*)rootPostinView
{
    return self.rootViewPostin;
}

-(NSString*)getPostinInstalledFlag{
    NSString *TAG = [[NSString alloc] initWithFormat:@"IS_INSTALLED_FLAG_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    NSLog(@"TAG = %@", TAG);
    if([PostinKeyChainTool readKeychainValue:TAG] == NULL){
        [PostinKeyChainTool saveKeychainValue:@"installed" key:TAG];
        return NULL;
    }else{
        NSLog(@"readKeychainValue = %@", [PostinKeyChainTool readKeychainValue:TAG]);
        return [PostinKeyChainTool readKeychainValue:TAG];
    }
}


-(void)initPostin:(Boolean)isLandscape
   Postin_Appid:(NSString *)Postin_Appid
  Postin_Appkey:(NSString *)Postin_Appkey
 Postin_Channel:(NSString *)Postin_Channel
Postin_Appsecret:(NSString *)Postin_Appsecret
     Postin_Gid:(NSString *)Postin_Gid
Postin_RYAppkey:(NSString *)Postin_RYAppkey
Postin_PackageId:(NSString *)Postin_PackageId
    success:(Postin_SUCCESS_Callback)success
     failed:(Postin_FAILED_Callback)failed
{
    
    self.landscapePostin = isLandscape;
    
    self.landscapePostin = isLandscape;
    self.appid_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_Appid];
    self.appkey_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_Appkey];
    self.appchannel_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_Channel];
    self.appsecret_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_Appsecret];
    self.gid_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_Gid];
    self.ryappkey_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_RYAppkey];
    self.packageId_Postin = [[NSString alloc] initWithFormat:@"%@", Postin_PackageId];
    
    if([[self getPostinInstalledFlag] isEqualToString:@"installed"]){
        NSLog(@"already postActiveData");
    }else{
        NSLog(@"never postActiveData");
        [self doPostinNewAdInstall];
    
        
        Postin_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        };
        
        Postin_VE_BLOCK failCallback = ^(NSError *responseError){
            failed(-10002);
        };
        
        [[PostinWebInterface sharedInstance] Postininstall:self.appid_Postin
                                   imeiOfDevicePostin:[PostinSdkImp getPostinIdfa]
                                        channelPostin:self.appchannel_Postin
                                          modelPostin:[[UIDevice currentDevice] model]
                                             osPostin:[[UIDevice currentDevice] systemVersion]
                                successCallbackPostin:successCallback
                                    failCallbackPostin:failCallback];
        
    }
    self.databasePostin=[[PostinDataBase alloc]init];
    [self initPostinPart:success failedPostin:failed];
    
    [[PostinWebInterface sharedInstance] getPostinAntiFlag:^(NSDictionary *responseString, NSDictionary *headers) {
        self.isOpenPostinShiMingRenZheng = [[responseString objectForKey:@"data2"] boolValue];
        self.msgForPostinShiMingRenZheng = [NSString stringWithFormat:@"%@", [responseString objectForKey:@"msg2"]];
        NSLog(@"isOpenPostinShiMingRenZheng = %d", self.isOpenPostinShiMingRenZheng);
    } failCallbackPostin:^(NSError *responseError){
       
    }];
}


-(void)initPostinPart:(Postin_SUCCESS_Callback)successPostin
         failedPostin:(Postin_FAILED_Callback)failedPostin
{
    self.errorsPostin = [NSMutableDictionary dictionary];
    [self.errorsPostin setValue:@"错误的请求" forKey:@"invalid_request"];
    [self.errorsPostin setValue:@"无法识别的客户端" forKey:@"unauthorized_client"];
    [self.errorsPostin setValue:@"拒绝访问" forKey:@"access_denied"];
    [self.errorsPostin setValue:@"系统错误" forKey:@"server_error"];
    [self.errorsPostin setValue:@"系统忙" forKey:@"temporarily_unavailable"];
    [self.errorsPostin setValue:@"用户名已存在,已重新生成用户名" forKey:@"duplicate_username"];
    [self.errorsPostin setValue:@"用户名不存在" forKey:@"username_not_exist"];
    [self.errorsPostin setValue:@"用户名或者密码错误" forKey:@"username_or_password_error"];
    [self.errorsPostin setValue:@"重复的订单" forKey:@"duplicate_order"];
    [self.errorsPostin setValue:@"邮箱已绑定" forKey:@"duplicate_email"];
    [self.errorsPostin setValue:@"手机已绑定" forKey:@"duplicate_phone"];
    [self.errorsPostin setValue:@"未绑定邮箱" forKey:@"unset_email"];
    [self.errorsPostin setValue:@"未绑定手机" forKey:@"unset_phone"];
    [self.errorsPostin setValue:@"帐号登录异常，请联系客服处理！" forKey:@"account_protect"];
    
    successPostin(@"success");
}

- (NSString *)getPostinIphoneType {
    
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


-(void)destroyPostin
{
   
}

-(void)loginPostin:(UIView*)viewPostin
   landscapePostin:(Boolean)isLandscapePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin
{
    
    if (self.rootViewPostin==nil) {
        self.rootViewPostin=viewPostin;
    }
    NSMutableArray *alluserinfo;
    if (self.databasePostin) {
        
         alluserinfo=[self.databasePostin getTestList];
    }else{
        
        self.databasePostin=[[PostinDataBase alloc]init];
        alluserinfo=[self.databasePostin getTestList];
    }

  
    if ([alluserinfo count]>0) {
        
            self.defaultLoginPostin=[[PostinDefaultLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
           [self.defaultLoginPostin show:viewPostin];
    }else{
            

        [self getPostinHistoryUserNameByImei:viewPostin landscapePostin:isLandscapePostin successPostin:successPostin failedPostin:failedPostin];
    }
 
}

-(void)loginPostin:(UIView*)viewPostin
   landscapePostin:(Boolean)isLandscapePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin
        flagPostin:(int *)flagPostin;
{
    
    if (self.rootViewPostin==nil) {
        self.rootViewPostin=viewPostin;
    }
    NSMutableArray *alluserinfo;
    if (self.databasePostin) {
        
        alluserinfo=[self.databasePostin getTestList];
    }else{
        
        self.databasePostin=[[PostinDataBase alloc]init];
        alluserinfo=[self.databasePostin getTestList];
    }
    
    
    self.qucickLoginPostin=[[PostinQuickLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
    [self.qucickLoginPostin show:viewPostin];
    
}

-(void)getPostinHistoryUserNameByImei:(UIView*)viewPostin
                      landscapePostin:(Boolean)isLandscapePostin
                        successPostin:(Postin_SUCCESS_Callback)successPostin
                         failedPostin:(Postin_FAILED_Callback)failedPostin{
    self.SHOWPROCESSPostin = true;
    [self processPostinShow];
    [[PostinWebInterface sharedInstance] getPostinHistoryUserNameByImei:[[PostinSdkImp sharedInstance] getPostinImei]
                                                        idfaPostin:[PostinSdkImp getPostinIdfa]
        successCallbackPostin:^(NSDictionary *dictionary, NSDictionary *headers) {
  
            self.SHOWPROCESSPostin = false;
             @try
             {
                 if (dictionary == nil)
                 {
                     self.qucickLoginPostin=[[PostinQuickLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
                     [self.qucickLoginPostin show:viewPostin];

                     return;
                 }
                 
                 if([[dictionary objectForKey:@"code"] intValue] == 1){
                     //如果存在历史帐号，则把3个最近登录的历史帐号保存到本地，再跳转到PostinDefaultLogin登录界面
                     //保存方式：username字段为服务端返回值，密码为0，其他字段默认。在读取本地信息时，如果密码为0，则跳转到PostinYMLoginView界面输入密码登录
                     
                     NSMutableArray *array = [dictionary objectForKey:@"data"];
                     for(int i = 0; i < [array count]; i++){
                         NSLog(@"i = %d, name = %@", i, [array objectAtIndex:i]);
                         [[PostinSdkImp sharedInstance] addPostinUser:[array objectAtIndex:i] passwordPostin:@"0" bindPostin:@"0" touristPostin:@"0" phoneNumberPostin:@"0"];
                         
                     }
                     self.defaultLoginPostin=[[PostinDefaultLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
                     [self.defaultLoginPostin show:viewPostin];

                 }else{
                     //如果没有历史帐号，则跳转到PostinQuickLogin登录界面
                     self.qucickLoginPostin=[[PostinQuickLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
                     [self.qucickLoginPostin show:viewPostin];
                 }
  
             }
             @catch(NSException * e)
             {
                 self.qucickLoginPostin=[[PostinQuickLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
                 [self.qucickLoginPostin show:viewPostin];
             }
             @finally
             {
             }
        }
        failCallbackPostin:^(NSError *responseError) {
            self.SHOWPROCESSPostin = false;
            self.qucickLoginPostin=[[PostinQuickLogin alloc]initWithBlock:successPostin failed:failedPostin landScape:isLandscapePostin ];
            [self.qucickLoginPostin show:viewPostin];
        }];
}

-(void)processPostinShow {
    if (self.zhuanjuhuaPostin == nil) {
        self.zhuanjuhuaPostin = [[PostinProgressHUD alloc] initWithView:self.rootViewPostin];
        
    }
    [self.rootViewPostin addSubview:self.zhuanjuhuaPostin];
    self.zhuanjuhuaPostin.labelText = @"正在获取历史帐号";
    
    [self.zhuanjuhuaPostin showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESSPostin)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                
                break;
            }
        }
    } successCallback:^{
        [self.zhuanjuhuaPostin removeFromSuperview];
    }];
    
    
    
}

-(void)showPostinShiMingRenZhengView:(NSString *)accessTokenPostin callbackPostin:(Postin_COMMON_BLOCK)callbackPostin{
    PostinShiMingRenZhengView *shiming = [[PostinShiMingRenZhengView alloc] initPostinShiMingRenZhengView:self.landscapePostin accessToken:accessTokenPostin callback:callbackPostin];
    [shiming showPostinShiMingRenZhengView:[self getPostinCurrentView]];
    
}

-(UIView *)getPostinCurrentView{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(void)checkPostinUpdate:(UIView*)contextPostin
           successPostin:(Postin_SUCCESS_Callback)successPostin
            failedPostin:(Postin_FAILED_Callback)failedPostin
               landscapePostin:(Boolean)landscapePostin
{
    NSString  *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString  *bundleid=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
    [[PostinWebInterface sharedInstance]checkPostinUpdate:self.appkey_Postin bundleIdPostin:bundleid versionPostin:version devicePostin:@"1" sourceCodePostin:self.appchannel_Postin successCallbackPostin:^(NSDictionary *dictionary, NSDictionary *headers) {

        @try
        {

            if (dictionary == nil)
            {
                failedPostin(-30006);
                return;
            }
           
            successPostin(dictionary);
            NSString *value = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"result"]];
               if ([value isEqualToString:@"1"]) {
                   NSString *openUrl=[dictionary objectForKey:@"url"];
                   if (self.updateViewPostin==nil) {
                       self.updateViewPostin=[[PostinCheckUpdate alloc]initWithBlock:landscapePostin  url:openUrl];
                   }
                   [self.updateViewPostin show:contextPostin];

               }
            
           
        }
        @catch(NSException * e)
        {
            failedPostin(-30006);
        }
        @finally
        {
        }
    } failCallbackPostin:^(NSError *responseError) {
        failedPostin(-30006);
    }];

    
    
    
  

}

-(void)logoutPostin:(UIView*)viewPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin
{
    if (self.usernamePostin != nil)
    {
        [[PostinWebInterface sharedInstance] logoutPostin:self.usernamePostin successCallbackPostin:^(NSDictionary * dictionary, NSDictionary * headers) {
            self.usernamePostin = nil;
            @try
            {

                if (dictionary == nil)
                {
                    failedPostin(-30004);
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
                    failedPostin(-30003);
                }
                else
                {
                    successPostin(@"logout success");
                    [[PostinSdkImp sharedInstance]showPostinToast:@"注销成功" ];
                    [self hideFloatPostin];
                }
            }
            @catch(NSException * e)
            {
                failedPostin(-30002);
            }
            @finally
            {
            }
        } failCallbackPostin:^(NSError * responseError) {
            failedPostin(-30001);
        }];
    }
    else
    {
        failedPostin(-30005);
    }
}





-(void)executePostin:(UIViewController *)viewControllerPostin
     landscapePostin:(BOOL)isLandscapePostin
     accessTokenPostin:(NSString *)accessTokenPostin
{

    if (self.windowPostin==nil) {
        self.windowPostin=[[PostinPopWindow alloc]initWithFramePostinPopWindow:CGRectMake(0, 0, 50, 50) controller:viewControllerPostin landspace:isLandscapePostin accessToken:accessTokenPostin];

    }
    
}

-(void)hideFloatPostin{

    if (self.windowPostin!=nil) {
        [self.windowPostin removeFromSuperview];
        self.windowPostin = nil;
        
    }
    
}


-(void)pPostiny:(UIViewController*)contextpPostiny
 landscapepPostiny:(Boolean)isLandscapepPostiny
    paramspPostiny:(NSDictionary*)paramspPostiny
   successpPostiny:(Postin_SUCCESS_Callback)successpPostiny
    failedpPostiny:(Postin_FAILED_Callback)failedpPostiny
{
    
    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[PostinSdkImp sharedInstance]showPostinToast:@"Token错误" ];
        
    }else{
        [paramspPostiny setValue:[tokenDic valueForKey:@"ACCESS_TOKEN"] forKey:Postin_PROTOCOL_ACCESSTOKEN];
    }
    
    Postin_VSD_BLOCK typeResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                [[PostinSdkImp sharedInstance]showPostinToast:@"有误"];
                failedpPostiny(-1101);
                return;
            }
            NSLog(@"dic = %@", dictionary);
            
        
            
            if([[dictionary objectForKey:@"result"] intValue] == 0){
                if(self.PostinSdkPy == NULL){
                    self.PostinSdkPy = [[PostinSdkPy alloc] init];
                }
                
                if(self.PostinSdkPy){
                    [self.PostinSdkPy pyPostinForAppstroe:contextpPostiny.view
                                                paramPostin:paramspPostiny
                                         successPostin:successpPostiny
                                          failedPostin:failedpPostiny];
                }
            }else{
                [[PostinSdkImp sharedInstance]showPostinToast:@"信息未配置"];
                failedpPostiny(-1102);
            }

        }@catch(NSException * e)
        {

        }
        @finally
        {
        }
    };
    [[PostinWebInterface sharedInstance] checkPPostinyTypeUrl:typeResult failCallbackPostin:^(NSError *error){
        [[PostinSdkImp sharedInstance]showPostinToast:@"请检查网络连接！"];
        failedpPostiny(-1100);
    }];

}


-(void)addPostinUser:(NSString*)usernamePostin
      passwordPostin:(NSString*)passwordPostin
          bindPostin:(NSString*) bindPostin
       touristPostin:(NSString*) touristPostin
   phoneNumberPostin:(NSString*) phoneNumberPostin
{
    
    self.usernamePostin=usernamePostin;
    PostinUserInfo *info=[[PostinUserInfo alloc]initWithInfo:usernamePostin password:passwordPostin bind:bindPostin tourist:touristPostin loginTime:[self getPostinTimeUserNow] phoneNumber:phoneNumberPostin];
    if ([self.databasePostin searchPostinUser:usernamePostin]) {
        NSLog(@"hasuser");
        if ([touristPostin isEqual:@"1"]) {
                [self.databasePostin updatePostinTourist:info];

        }else{
            [self.databasePostin updatePostinUserInfo:info];
        }
    
    }else{
         NSLog(@"nouser");

        if ([touristPostin isEqualToString:@"1"]) {
            if ([self.databasePostin searchPostinBindUser:touristPostin]) {

                [self.databasePostin updatePostinTourist:info];
               
            }else{
                  [self.databasePostin insertPostinList:info];

            }
        }else{
             [self.databasePostin insertPostinList:info];

        }
       
    }
     
    
 
}

-(void)removePostinUser:(NSString*)username
{

        [self.databasePostin deletePostinList:username];
  
}


- (void)showPostinWelcome:(NSString*)username
{
    self.usernamePostin = username;

    
    PostinProgressHUD * process = [[PostinProgressHUD alloc] initWithView:self.rootViewPostin];
    [self.rootViewPostin addSubview:process];
    process.labelText = [[NSString alloc] initWithFormat:@"%@，欢迎归来", username];
    process.mode = PostinProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [process removeFromSuperview];
    }];
}
-(void) showPostinToast:(NSString *)text{
    if (_processPostin==nil) {
           _processPostin = [[PostinProgressHUD alloc] initWithView:self.rootViewPostin];
    }
    [self.rootViewPostin addSubview:_processPostin];
    _processPostin.labelText = text;
    _processPostin.labelFont=[UIFont systemFontOfSize:11];
    _processPostin.mode = PostinProgressHUDModeCustomView;
    _processPostin.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [_processPostin showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } successCallback:^{
        [_processPostin removeFromSuperview];
    }];

    
}


-(NSString*)translatePostin:(NSString*) error
{
    NSString *value = [self.errorsPostin objectForKey:error];
    if ((NSNull *)value == nil)
    {
        return error;
    }
    
    return error;
}



+(PostinSdkImp*)sharedInstance
{
    static __strong PostinSdkImp * g_PostinSdkImp = nil;
    if (g_PostinSdkImp == nil)
    {
        g_PostinSdkImp = [PostinSdkImp alloc];
    }
    
    return g_PostinSdkImp;
}
-(void)loadingPostin:(Postin_SUCCESS_Callback)successPostin
        failedPostin:(Postin_FAILED_Callback)failedPostin{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:self.appid_Postin forKey:@"app_id"];
    [param setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Postin forKey:@"channel"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    
    [[PostinWebInterface sharedInstance] loadingPostin:param  successCallbackPostin:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {

            if (dictionary == nil)
            {
                failedPostin(-30004);
                return;
            }
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                successPostin([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedPostin(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedPostin(-30002);
        }
        @finally
        {
        }
    } failCallbackPostin:^(NSError * responseError) {
        failedPostin(-30001);
    }];
}
 -(long)getPostinTimeNow{
    return time(NULL);
}
-(NSString*) getPostinTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}


-(void)createRolePostin:(NSString *)serveridPostin user_idPostin:(NSString*)user_idPostin roleIdPostin:(NSString *)roleIdPostin
        roleLevelPostin:(NSString *)roleLevelPostin successPostin:(Postin_SUCCESS_Callback)successPostin failedPostin:(Postin_FAILED_Callback)failedPostin{
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:user_idPostin forKey:@"user_id"];
    [param setValue:self.appid_Postin forKey:@"app_id"];
    [param setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [param setValue:self.appchannel_Postin forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getPostinTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridPostin forKey:@"gateway"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[PostinWebInterface sharedInstance] createPostin:param  successCallbackPostin:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedPostin(-30004);
                return;
            }
            NSLog(@"createPostin:%@",dictionary);
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
              successPostin([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedPostin(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedPostin(-30002);
        }
        @finally
        {
        }
    } failCallbackPostin:^(NSError * responseError) {
        failedPostin(-30001);
    }];
    
    


}
-(void)loginRolePostin:(NSString *)serveridPostin user_idPostin:(NSString*)user_idPostin roleIdPostin:(NSString *)roleIdPostin
       roleLevelPostin:(NSString *)roleLevelPostin successPostin:(Postin_SUCCESS_Callback)successPostin failedPostin:(Postin_FAILED_Callback)failedPostin{
    
    [self doPostinNewAdLogin:user_idPostin role_id:roleIdPostin server_id:serveridPostin];
    
}





-(void) sjPostinRegister:(NSString *)userid{

    
    [self doPostinNewAdRegister:userid];
}


-(void)levelupPostin:(NSString*) levelPostin
  serverNamePostin:(NSString *)serverNamePostin
    serveridPostin:(NSString *) serveridPostin
      userIdPostin:(NSString*) userIdPostin
     role_idPostin:(NSString*)roleidPostin
    roleNamePostin:(NSString*)roleNamePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin{
    
    [self doPostinNewAdLevelUp:userIdPostin role_id:roleidPostin server_id:serveridPostin level:levelPostin];
    
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:userIdPostin forKey:@"user_id"];
    [param setValue:self.appid_Postin forKey:@"app_id"];
    [param setValue:serveridPostin forKey:@"server_id"];
    [param setValue:serverNamePostin forKey:@"server_name"];
    [param setValue:roleidPostin forKey:@"role_id"];
    [param setValue:roleNamePostin forKey:@"role_name"];
    [param setValue:levelPostin forKey:@"role_level"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getPostinTimeNow]] forKey:@"role_createtime"];
    [param setValue:[PostinSdkImp getPostinIdfa] forKey:@"imei"];
    [param setValue:[PostinSdkImp getPostinIdfa] forKey:@"idfa"];
    [param setValue:self.appchannel_Postin forKey:@"channel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getPostinTimeNow]]   forKey:@"timestamp"];
    [param setValue:serveridPostin forKey:@"gateway"];
    [param setValue:levelPostin forKey:@"level"];
    [param setValue:[[NSBundle mainBundle] bundleIdentifier] forKey:@"gamename"];
    [[PostinWebInterface sharedInstance] levelupPostin:param  successCallbackPostin:^(NSDictionary * dictionary, NSDictionary * headers) {
        @try
        {
            if (dictionary == nil)
            {
                failedPostin(-30004);
                return;
            }
      
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
               successPostin([dictionary valueForKey:@"ok"]);
            }
            else
            {
                failedPostin(-30003);
            }
        }
        @catch(NSException * e)
        {
            failedPostin(-30002);
        }
        @finally
        {
        }
    } failCallbackPostin:^(NSError * responseError) {
        failedPostin(-30001);
    }];
}
-(void)error:(NSString *)log
     success:(Postin_SUCCESS_Callback)success
      failed:(Postin_FAILED_Callback)failed
{
    
   
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    [param setValue:[[PostinSdkImp sharedInstance] getPostinAppId] forKey:@"appId"];
    [param setValue:[UIDevice currentDevice].name forKey:@"deviceName"];
    [param setValue:[UIDevice currentDevice].systemVersion forKeyPath:@"phoneVersion"];
    [param setValue:[UIDevice currentDevice].model forKey:@"phoneModel"];
    [param setValue:[NSString stringWithFormat:@"%ld",[self getPostinTimeNow]]   forKey:@"timestamp"];
    [param setValue:log forKeyPath:@"log"];
    [[PostinWebInterface sharedInstance] erroPostin:param successCallback:^(NSDictionary * dictionary, NSDictionary * headers) {
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

-(NSString *)getPostinNetworktype{
    
    
    PostinReachability *reachability   = [PostinReachability reachabilityWithHostName:@"www.apple.com"];
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


-(NSString *)getPostinNetIsp{
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

-(void)doPostinNewAdInstall{
    
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new adinstall successCallback1 = %@", responseString);
    };
    
    Postin_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new adinstall failCallback1 = %@", responseError);
    };

    NSString *data = [[NSString alloc] initWithFormat:@"do=active&is_crack=0&gid=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@",
                      self.gid_Postin,
                      [self getPostinNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getPostinNetworktype],
                      [self getPostinIphoneType],
                      [PostinSdkImp getPostinIdfa],
                      [PostinSdkImp getPostinIdfv],
                    @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Postin_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil getSha256String:signSrc]];
    
    [[PostinWebInterface sharedInstance] newadPostininstall:dataEncode
                                             signPostin:sign
                                 successCallbackPostin:successCallback
                                     failCallbackPostin:failCallback];
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

-(void)doPostinNewAdRegister:(NSString *)userid{
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doPostinNewAdRegister successCallback1 = %@", responseString);
    };
    
    Postin_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doPostinNewAdRegister failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=reg&is_crack=0&gid=%@&user_name=%@&server_id=0&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Postin,
                      userid,
                      [self getPostinNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getPostinNetworktype],
                      [self getPostinIphoneType],
                      [PostinSdkImp getPostinIdfa],
                      [PostinSdkImp getPostinIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Postin_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil getSha256String:signSrc]];
    
    [[PostinWebInterface sharedInstance] newadPostininstall:dataEncode
                                            signPostin:sign
                                 successCallbackPostin:successCallback
                                     failCallbackPostin:failCallback];
}

-(void)doPostinNewAdLogin:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id{
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doPostinNewAdLogin successCallback1 = %@", responseString);
    };
    
    Postin_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doPostinNewAdLogin failCallback1 = %@", responseError);
    };

    
    NSString *data = [[NSString alloc] initWithFormat:@"do=login&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&net_isp=%@&os_ver=%@&netconn_type=%@&machine_version=%@&mac=&idfa=%@&idfv=%@&os=ios&adid=%@&platform=39",
                      self.gid_Postin,
                      userid,
                      server_id,
                      role_id,
                      [self getPostinNetIsp],
                      [[UIDevice currentDevice] systemVersion],
                      [self getPostinNetworktype],
                      [self getPostinIphoneType],
                      [PostinSdkImp getPostinIdfa],
                      [PostinSdkImp getPostinIdfv],
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Postin_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil getSha256String:signSrc]];
    
    [[PostinWebInterface sharedInstance] newadPostininstall:dataEncode
                                            signPostin:sign
                                 successCallbackPostin:successCallback
                                     failCallbackPostin:failCallback];
}

-(void)doPostinNewAdLevelUp:(NSString *)userid
            role_id:(NSString *)role_id
          server_id:(NSString *)server_id
            level:(NSString *)level{
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *responseString, NSDictionary *headers) {
        NSLog(@"new doPostinNewAdLevelUp successCallback1 = %@", responseString);
    };
    
    Postin_VE_BLOCK failCallback = ^(NSError *responseError){
        NSLog(@"new doPostinNewAdLevelUp failCallback1 = %@", responseError);
    };
    
    
    NSString *data = [[NSString alloc] initWithFormat:@"do=update_level&is_crack=0&gid=%@&user_name=%@&server_id=%@&role_id=%@&level=%@&mac=&idfa=%@&os=ios&platform=39",
                      self.gid_Postin,
                      userid,
                      server_id,
                      role_id,
                      level,
                      @"0"];
    
    NSString *dataEncode = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil encodeBase64String:data]];
    
    NSString *signSrc = [NSString stringWithFormat:@"%@%@", dataEncode, Postin_AD_API_SECRET];
    NSString *sign = [[NSString alloc] initWithFormat:@"%@", [PostinSecurityUtil getSha256String:signSrc]];
    
    [[PostinWebInterface sharedInstance] newadPostininstall:dataEncode
                                            signPostin:sign
                                 successCallbackPostin:successCallback
                                     failCallbackPostin:failCallback];
}




@end
