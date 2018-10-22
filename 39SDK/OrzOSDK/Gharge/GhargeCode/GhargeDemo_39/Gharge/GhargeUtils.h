

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>



#define Gharge_SDK_VERSION @"3.4.3"

#define Gharge_KEYCHAIN_IDFV @"Gharge_KEYCHAIN_IDFV"
#define Gharge_KEYCHAIN_UUID @"Gharge_KEYCHAIN_UUID"



typedef void (^GhargeRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^GhargeInitCallback)(NSDictionary* result);
typedef void (^GhargeLoginCallback)(NSDictionary* result);
typedef void (^GhargeLogoutCallback)(NSDictionary* result);
typedef void (^GhargeCheckUpdateCallback)(NSDictionary* result);
typedef void (^GhargeCreateOderCallback)(NSDictionary* result);
typedef void (^GhargeXXXCloseCallback)(NSDictionary* result);
typedef void (^GhargeShiMimgRenZhengCallback)(NSString* result);


#define Gharge_SUBMIT_CHOOSE_SERVER      @"Gharge_SUBMIT_CHOOSE_SERVER"
#define Gharge_SUBMIT_CHOOSE_ROLE        @"Gharge_SUBMIT_CHOOSE_ROLE"
#define Gharge_SUBMIT_ROLE_CREATE        @"Gharge_SUBMIT_ROLE_CREATE"
#define Gharge_SUBMIT_ROLE_LEVELUP       @"Gharge_SUBMIT_ROLE_LEVELUP"
#define Gharge_SUBMIT_ROLE_ENTERSERVER   @"Gharge_SUBMIT_ROLE_ENTERSERVER"



#define Gharge_ROLE_ID            @"Gharge_ROLE_ID"
#define Gharge_ROLE_LEVEL         @"Gharge_ROLE_LEVEL"
#define Gharge_ROLE_NAME          @"Gharge_ROLE_NAME"
#define Gharge_ROLE_CREATE_TIME   @"Gharge_ROLE_CREATE_TIME"
#define Gharge_SERVER_ID          @"Gharge_SERVER_ID"
#define Gharge_SERVER_NAME        @"Gharge_SERVER_NAME"



#define Gharge_IOS_PRODUCT_NAME   @"Gharge_IOS_PRODUCT_NAME"
#define Gharge_IOS_PRODUCT_ID     @"Gharge_IOS_PRODUCT_ID"
#define Gharge_IOS_CP_ORDERID     @"Gharge_IOS_CP_ORDERID"
#define Gharge_IOS_PRODUCT_DESC   @"Gharge_IOS_PRODUCT_DESC"
#define Gharge_IOS_PRODUCT_PRICE  @"Gharge_IOS_PRODUCT_PRICE"
#define Gharge_IOS_GOODS_NUM      @"Gharge_IOS_GOODS_NUM"
#define Gharge_IOS_ORDERID        @"Gharge_IOS_ORDERID"
#define Gharge_IOS_EXTRA          @"Gharge_IOS_EXTRA"
#define Gharge_IOS_ROLE_ID        @"Gharge_IOS_ROLE_ID"
#define Gharge_IOS_ROLE_NAME      @"Gharge_IOS_ROLE_NAME"
#define Gharge_IOS_ROLE_LEVEL     @"Gharge_IOS_ROLE_LEVEL"
#define Gharge_IOS_SERVER_ID      @"Gharge_IOS_SERVER_ID"
#define Gharge_IOS_SERVER_NAME    @"Gharge_IOS_SERVER_NAME"




#define INIT_ERROR_NETWORK_ERROR @"请检查网络连接"





@interface GhargeUtils : NSObject

+(GhargeUtils*)getSharedInstance;

-(void) showGhargeToastMsg:(NSString *)text view:(UIView *)view;

-(NSString *)getGhargeNetIsp;//获取运营商信息
-(NSString *)getGhargeNetworktype;//获取网络类型
-(NSString *)getGhargeSystemVersion;//获取手机系统版本
-(NSString *)getGhargeIdfa;//获取手机idfa
-(NSString *)getGhargeIdfv;//获取手机idfv
-(NSString *)getGhargeUUID;//获取手机getGhargeUUID
-(NSString *)getGhargeMac;//获取手机getGhargeMac
-(NSString *)getGhargePhoneUserName;//获取手机别名
-(NSString *)getGhargeDeviceName;//获取设备名称
-(NSString *)getGhargeDeviceModel;//获取手机型号
-(NSString *)getGhargeLocalPhoneModel;//获取地方型号（国际化区域名称）
-(NSString*)getGhargeInstalledFlag;

-(NSString *)getGhargeBundleId;
-(NSString *)getGhargeAppName;
-(NSString *)getGhargeAppVersion;
-(NSString *)getGhargeAppBuildVersion;
-(NSString *)getGhargeVersion;
-(NSString *)getGhargeChannelSdkVersion;

-(NSString *)getGhargeInfoPlist_PackageId;
-(Boolean)getGhargeInfoPlist_Landscape;


-(void)setGhargeUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token;
-(NSString *)getGhargeUserId;
-(NSString *)getChannelUserId;

-(NSString *)Gharge_md5:(NSString *)str;

-(void)postGhargeActiveData;
-(void)postGhargeGameData:(NSString *)dataPoint data:(NSDictionary *)data;
-(void)requestGhargeNotice:(GhargeRequestCallback)result;
-(void)requestGhargeServerStatus:(GhargeInitCallback)result;
-(void)getGhargeLoginInfo:(NSDictionary *)dic result:(GhargeLoginCallback)result;
-(void)doGhargeLogout:(GhargeLogoutCallback)result;
-(void)doGhargeCheckUpdate:(GhargeCheckUpdateCallback)result;
-(void)doGhargeCreateOder:(NSDictionary *)param buildGhargeodcb:(GhargeCreateOderCallback)buildGhargeodcb;
-(void)sendGhargeHeartData;
-(void)doGhargePostAction:(NSDictionary *)httpParams toGhargeServer:(NSString *)requestPath responseHandler:(GhargeRequestCallback)handler showProgess:(Boolean)showprogress;

@end


