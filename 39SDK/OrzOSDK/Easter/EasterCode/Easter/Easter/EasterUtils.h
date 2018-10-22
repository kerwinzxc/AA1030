

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>



#define Easter_SDK_VERSION @"3.4.3"

#define Easter_KEYCHAIN_IDFV @"Easter_KEYCHAIN_IDFV"
#define Easter_KEYCHAIN_UUID @"Easter_KEYCHAIN_UUID"



typedef void (^EasterRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^EasterInitCallback)(NSDictionary* result);
typedef void (^EasterLoginCallback)(NSDictionary* result);
typedef void (^EasterLogoutCallback)(NSDictionary* result);
typedef void (^EasterCheckUpdateCallback)(NSDictionary* result);
typedef void (^EasterCreateOderCallback)(NSDictionary* result);
typedef void (^EasterXXXCloseCallback)(NSDictionary* result);
typedef void (^EasterShiMimgRenZhengCallback)(NSString* result);


#define Easter_SUBMIT_CHOOSE_SERVER      @"Easter_SUBMIT_CHOOSE_SERVER"
#define Easter_SUBMIT_CHOOSE_ROLE        @"Easter_SUBMIT_CHOOSE_ROLE"
#define Easter_SUBMIT_ROLE_CREATE        @"Easter_SUBMIT_ROLE_CREATE"
#define Easter_SUBMIT_ROLE_LEVELUP       @"Easter_SUBMIT_ROLE_LEVELUP"
#define Easter_SUBMIT_ROLE_ENTERSERVER   @"Easter_SUBMIT_ROLE_ENTERSERVER"



#define Easter_ROLE_ID            @"Easter_ROLE_ID"
#define Easter_ROLE_LEVEL         @"Easter_ROLE_LEVEL"
#define Easter_ROLE_NAME          @"Easter_ROLE_NAME"
#define Easter_ROLE_CREATE_TIME   @"Easter_ROLE_CREATE_TIME"
#define Easter_SERVER_ID          @"Easter_SERVER_ID"
#define Easter_SERVER_NAME        @"Easter_SERVER_NAME"



#define Easter_IOS_PRODUCT_NAME   @"Easter_IOS_PRODUCT_NAME"
#define Easter_IOS_PRODUCT_ID     @"Easter_IOS_PRODUCT_ID"
#define Easter_IOS_CP_ORDERID     @"Easter_IOS_CP_ORDERID"
#define Easter_IOS_PRODUCT_DESC   @"Easter_IOS_PRODUCT_DESC"
#define Easter_IOS_PRODUCT_PRICE  @"Easter_IOS_PRODUCT_PRICE"
#define Easter_IOS_GOODS_NUM      @"Easter_IOS_GOODS_NUM"
#define Easter_IOS_ORDERID        @"Easter_IOS_ORDERID"
#define Easter_IOS_EXTRA          @"Easter_IOS_EXTRA"
#define Easter_IOS_ROLE_ID        @"Easter_IOS_ROLE_ID"
#define Easter_IOS_ROLE_NAME      @"Easter_IOS_ROLE_NAME"
#define Easter_IOS_ROLE_LEVEL     @"Easter_IOS_ROLE_LEVEL"
#define Easter_IOS_SERVER_ID      @"Easter_IOS_SERVER_ID"
#define Easter_IOS_SERVER_NAME    @"Easter_IOS_SERVER_NAME"




#define INIT_ERROR_NETWORK_ERROR @"请检查网络连接"





@interface EasterUtils : NSObject

+(EasterUtils*)getSharedInstance;

-(void) showEasterToastMsg:(NSString *)text view:(UIView *)view;

-(NSString *)getEasterNetIsp;//获取运营商信息
-(NSString *)getEasterNetworktype;//获取网络类型
-(NSString *)getEasterSystemVersion;//获取手机系统版本
-(NSString *)getEasterIdfa;//获取手机idfa
-(NSString *)getEasterIdfv;//获取手机idfv
-(NSString *)getEasterUUID;//获取手机getEasterUUID
-(NSString *)getEasterMac;//获取手机getEasterMac
-(NSString *)getEasterPhoneUserName;//获取手机别名
-(NSString *)getEasterDeviceName;//获取设备名称
-(NSString *)getEasterDeviceModel;//获取手机型号
-(NSString *)getEasterLocalPhoneModel;//获取地方型号（国际化区域名称）
-(NSString*)getEasterInstalledFlag;

-(NSString *)getEasterBundleId;
-(NSString *)getEasterAppName;
-(NSString *)getEasterAppVersion;
-(NSString *)getEasterAppBuildVersion;
-(NSString *)getEasterVersion;
-(NSString *)getEasterChannelSdkVersion;

-(NSString *)getEasterInfoPlist_PackageId;
-(Boolean)getEasterInfoPlist_Landscape;


-(void)setEasterUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token;
-(NSString *)getEasterUserId;
-(NSString *)getChannelUserId;

-(NSString *)Easter_md5:(NSString *)str;

-(void)postEasterActiveData;
-(void)postEasterGameData:(NSString *)dataPoint data:(NSDictionary *)data;
-(void)requestEasterNotice:(EasterRequestCallback)result;
-(void)requestEasterServerStatus:(EasterInitCallback)result;
-(void)getEasterLoginInfo:(NSDictionary *)dic result:(EasterLoginCallback)result;
-(void)doEasterLogout:(EasterLogoutCallback)result;
-(void)doEasterCheckUpdate:(EasterCheckUpdateCallback)result;
-(void)doEasterCreateOder:(NSDictionary *)param buildEasterodcb:(EasterCreateOderCallback)buildEasterodcb;
-(void)sendEasterHeartData;
-(void)doEasterPostAction:(NSDictionary *)httpParams toEasterServer:(NSString *)requestPath responseHandler:(EasterRequestCallback)handler showProgess:(Boolean)showprogress;

@end


