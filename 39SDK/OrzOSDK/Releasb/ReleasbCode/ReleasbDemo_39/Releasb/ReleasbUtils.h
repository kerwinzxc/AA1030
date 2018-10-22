

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>



#define Releasb_SDK_VERSION @"3.4.3"

#define Releasb_KEYCHAIN_IDFV @"Releasb_KEYCHAIN_IDFV"
#define Releasb_KEYCHAIN_UUID @"Releasb_KEYCHAIN_UUID"



typedef void (^ReleasbRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^ReleasbInitCallback)(NSDictionary* result);
typedef void (^ReleasbLoginCallback)(NSDictionary* result);
typedef void (^ReleasbLogoutCallback)(NSDictionary* result);
typedef void (^ReleasbCheckUpdateCallback)(NSDictionary* result);
typedef void (^ReleasbCreateOderCallback)(NSDictionary* result);
typedef void (^ReleasbXXXCloseCallback)(NSDictionary* result);
typedef void (^ReleasbShiMimgRenZhengCallback)(NSString* result);


#define Releasb_SUBMIT_CHOOSE_SERVER      @"Releasb_SUBMIT_CHOOSE_SERVER"
#define Releasb_SUBMIT_CHOOSE_ROLE        @"Releasb_SUBMIT_CHOOSE_ROLE"
#define Releasb_SUBMIT_ROLE_CREATE        @"Releasb_SUBMIT_ROLE_CREATE"
#define Releasb_SUBMIT_ROLE_LEVELUP       @"Releasb_SUBMIT_ROLE_LEVELUP"
#define Releasb_SUBMIT_ROLE_ENTERSERVER   @"Releasb_SUBMIT_ROLE_ENTERSERVER"



#define Releasb_ROLE_ID            @"Releasb_ROLE_ID"
#define Releasb_ROLE_LEVEL         @"Releasb_ROLE_LEVEL"
#define Releasb_ROLE_NAME          @"Releasb_ROLE_NAME"
#define Releasb_ROLE_CREATE_TIME   @"Releasb_ROLE_CREATE_TIME"
#define Releasb_SERVER_ID          @"Releasb_SERVER_ID"
#define Releasb_SERVER_NAME        @"Releasb_SERVER_NAME"



#define Releasb_IOS_PRODUCT_NAME   @"Releasb_IOS_PRODUCT_NAME"
#define Releasb_IOS_PRODUCT_ID     @"Releasb_IOS_PRODUCT_ID"
#define Releasb_IOS_CP_ORDERID     @"Releasb_IOS_CP_ORDERID"
#define Releasb_IOS_PRODUCT_DESC   @"Releasb_IOS_PRODUCT_DESC"
#define Releasb_IOS_PRODUCT_PRICE  @"Releasb_IOS_PRODUCT_PRICE"
#define Releasb_IOS_GOODS_NUM      @"Releasb_IOS_GOODS_NUM"
#define Releasb_IOS_ORDERID        @"Releasb_IOS_ORDERID"
#define Releasb_IOS_EXTRA          @"Releasb_IOS_EXTRA"
#define Releasb_IOS_ROLE_ID        @"Releasb_IOS_ROLE_ID"
#define Releasb_IOS_ROLE_NAME      @"Releasb_IOS_ROLE_NAME"
#define Releasb_IOS_ROLE_LEVEL     @"Releasb_IOS_ROLE_LEVEL"
#define Releasb_IOS_SERVER_ID      @"Releasb_IOS_SERVER_ID"
#define Releasb_IOS_SERVER_NAME    @"Releasb_IOS_SERVER_NAME"




#define INIT_ERROR_NETWORK_ERROR @"请检查网络连接"





@interface ReleasbUtils : NSObject

+(ReleasbUtils*)getSharedInstance;

-(void) showReleasbToastMsg:(NSString *)text view:(UIView *)view;

-(NSString *)getReleasbNetIsp;//获取运营商信息
-(NSString *)getReleasbNetworktype;//获取网络类型
-(NSString *)getReleasbSystemVersion;//获取手机系统版本
-(NSString *)getReleasbIdfa;//获取手机idfa
-(NSString *)getReleasbIdfv;//获取手机idfv
-(NSString *)getReleasbUUID;//获取手机getReleasbUUID
-(NSString *)getReleasbMac;//获取手机getReleasbMac
-(NSString *)getReleasbPhoneUserName;//获取手机别名
-(NSString *)getReleasbDeviceName;//获取设备名称
-(NSString *)getReleasbDeviceModel;//获取手机型号
-(NSString *)getReleasbLocalPhoneModel;//获取地方型号（国际化区域名称）
-(NSString*)getReleasbInstalledFlag;

-(NSString *)getReleasbBundleId;
-(NSString *)getReleasbAppName;
-(NSString *)getReleasbAppVersion;
-(NSString *)getReleasbAppBuildVersion;
-(NSString *)getReleasbVersion;
-(NSString *)getReleasbChannelSdkVersion;

-(NSString *)getReleasbInfoPlist_PackageId;
-(Boolean)getReleasbInfoPlist_Landscape;


-(void)setReleasbUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token;
-(NSString *)getReleasbUserId;
-(NSString *)getChannelUserId;

-(NSString *)Releasb_md5:(NSString *)str;

-(void)postReleasbActiveData;
-(void)postReleasbGameData:(NSString *)dataPoint data:(NSDictionary *)data;
-(void)requestReleasbNotice:(ReleasbRequestCallback)result;
-(void)requestReleasbServerStatus:(ReleasbInitCallback)result;
-(void)getReleasbLoginInfo:(NSDictionary *)dic result:(ReleasbLoginCallback)result;
-(void)doReleasbLogout:(ReleasbLogoutCallback)result;
-(void)doReleasbCheckUpdate:(ReleasbCheckUpdateCallback)result;
-(void)doReleasbCreateOder:(NSDictionary *)param buildReleasbodcb:(ReleasbCreateOderCallback)buildReleasbodcb;
-(void)sendReleasbHeartData;
-(void)doReleasbPostAction:(NSDictionary *)httpParams toReleasbServer:(NSString *)requestPath responseHandler:(ReleasbRequestCallback)handler showProgess:(Boolean)showprogress;

@end


