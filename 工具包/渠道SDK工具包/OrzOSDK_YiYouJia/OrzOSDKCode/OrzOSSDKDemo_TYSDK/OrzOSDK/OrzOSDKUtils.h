

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>



#define OrzOSDK_SDK_VERSION @"3.3.1"

#define OrzOSDK_KEYCHAIN_IDFV @"OrzOSDK_KEYCHAIN_IDFV"
#define OrzOSDK_KEYCHAIN_UUID @"OrzOSDK_KEYCHAIN_UUID"



typedef void (^OrzOSDKRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^OrzOSDKInitCallback)(NSDictionary* result);
typedef void (^OrzOSDKLoginCallback)(NSDictionary* result);
typedef void (^OrzOSDKLogoutCallback)(NSDictionary* result);
typedef void (^OrzOSDKCheckUpdateCallback)(NSDictionary* result);
typedef void (^OrzOSDKCreateOderCallback)(NSDictionary* result);
typedef void (^OrzOSDKXXXCloseCallback)(NSDictionary* result);
typedef void (^OrzOSDKShiMimgRenZhengCallback)(NSString* result);


#define OrzOSDK_SUBMIT_CHOOSE_SERVER      @"OrzOSDK_SUBMIT_CHOOSE_SERVER"
#define OrzOSDK_SUBMIT_CHOOSE_ROLE        @"OrzOSDK_SUBMIT_CHOOSE_ROLE"
#define OrzOSDK_SUBMIT_ROLE_CREATE        @"OrzOSDK_SUBMIT_ROLE_CREATE"
#define OrzOSDK_SUBMIT_ROLE_LEVELUP       @"OrzOSDK_SUBMIT_ROLE_LEVELUP"
#define OrzOSDK_SUBMIT_ROLE_ENTERSERVER   @"OrzOSDK_SUBMIT_ROLE_ENTERSERVER"



#define OrzOSDK_ROLE_ID            @"OrzOSDK_ROLE_ID"
#define OrzOSDK_ROLE_LEVEL         @"OrzOSDK_ROLE_LEVEL"
#define OrzOSDK_ROLE_NAME          @"OrzOSDK_ROLE_NAME"
#define OrzOSDK_ROLE_CREATE_TIME   @"OrzOSDK_ROLE_CREATE_TIME"
#define OrzOSDK_SERVER_ID          @"OrzOSDK_SERVER_ID"
#define OrzOSDK_SERVER_NAME        @"OrzOSDK_SERVER_NAME"



#define OrzOSDK_IOS_PRODUCT_NAME   @"OrzOSDK_IOS_PRODUCT_NAME"
#define OrzOSDK_IOS_PRODUCT_ID     @"OrzOSDK_IOS_PRODUCT_ID"
#define OrzOSDK_IOS_CP_ORDERID     @"OrzOSDK_IOS_CP_ORDERID"
#define OrzOSDK_IOS_PRODUCT_DESC   @"OrzOSDK_IOS_PRODUCT_DESC"
#define OrzOSDK_IOS_PRODUCT_PRICE  @"OrzOSDK_IOS_PRODUCT_PRICE"
#define OrzOSDK_IOS_GOODS_NUM      @"OrzOSDK_IOS_GOODS_NUM"
#define OrzOSDK_IOS_ORDERID        @"OrzOSDK_IOS_ORDERID"
#define OrzOSDK_IOS_EXTRA          @"OrzOSDK_IOS_EXTRA"
#define OrzOSDK_IOS_ROLE_ID        @"OrzOSDK_IOS_ROLE_ID"
#define OrzOSDK_IOS_ROLE_NAME      @"OrzOSDK_IOS_ROLE_NAME"
#define OrzOSDK_IOS_ROLE_LEVEL     @"OrzOSDK_IOS_ROLE_LEVEL"
#define OrzOSDK_IOS_SERVER_ID      @"OrzOSDK_IOS_SERVER_ID"
#define OrzOSDK_IOS_SERVER_NAME    @"OrzOSDK_IOS_SERVER_NAME"




#define INIT_ERROR_NETWORK_ERROR @"请检查网络连接"





@interface OrzOSDKUtils : NSObject

+(OrzOSDKUtils*)getSharedInstance;

-(void) showOrzOSDKToastMsg:(NSString *)text view:(UIView *)view;

-(NSString *)getOrzOSDKNetIsp;//获取运营商信息
-(NSString *)getOrzOSDKNetworktype;//获取网络类型
-(NSString *)getOrzOSDKSystemVersion;//获取手机系统版本
-(NSString *)getOrzOSDKIdfa;//获取手机idfa
-(NSString *)getOrzOSDKIdfv;//获取手机idfv
-(NSString *)getOrzOSDKUUID;//获取手机getOrzOSDKUUID
-(NSString *)getOrzOSDKMac;//获取手机getOrzOSDKMac
-(NSString *)getOrzOSDKPhoneUserName;//获取手机别名
-(NSString *)getOrzOSDKDeviceName;//获取设备名称
-(NSString *)getOrzOSDKDeviceModel;//获取手机型号
-(NSString *)getOrzOSDKLocalPhoneModel;//获取地方型号（国际化区域名称）
-(NSString*)getOrzOSDKInstalledFlag;

-(NSString *)getOrzOSDKBundleId;
-(NSString *)getOrzOSDKAppName;
-(NSString *)getOrzOSDKAppVersion;
-(NSString *)getOrzOSDKAppBuildVersion;
-(NSString *)getOrzOSDKVersion;
-(NSString *)getOrzOSDKChannelSdkVersion;

-(NSString *)getOrzOSDKInfoPlist_PackageId;
-(Boolean)getOrzOSDKInfoPlist_Landscape;


-(void)setOrzOSDKUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token;
-(NSString *)getOrzOSDKUserId;
-(NSString *)getChannelUserId;

-(NSString *)OrzOSDK_md5:(NSString *)str;

-(void)postOrzOSDKActiveData;
-(void)postOrzOSDKGameData:(NSString *)dataPoint data:(NSDictionary *)data;
-(void)requestOrzOSDKNotice:(OrzOSDKRequestCallback)result;
-(void)requestOrzOSDKServerStatus:(OrzOSDKInitCallback)result;
-(void)getOrzOSDKLoginInfo:(NSDictionary *)dic result:(OrzOSDKLoginCallback)result;
-(void)doOrzOSDKLogout:(OrzOSDKLogoutCallback)result;
-(void)doOrzOSDKCheckUpdate:(OrzOSDKCheckUpdateCallback)result;
-(void)doOrzOSDKCreateOder:(NSDictionary *)param buildOrzOSDKodcb:(OrzOSDKCreateOderCallback)buildOrzOSDKodcb;
-(void)sendOrzOSDKHeartData;
-(void)doOrzOSDKPostAction:(NSDictionary *)httpParams toOrzOSDKServer:(NSString *)requestPath responseHandler:(OrzOSDKRequestCallback)handler showProgess:(Boolean)showprogress;

@end


