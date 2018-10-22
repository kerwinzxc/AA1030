

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>



#define Punctuation_SDK_VERSION @"3.4.3"

#define Punctuation_KEYCHAIN_IDFV @"Punctuation_KEYCHAIN_IDFV"
#define Punctuation_KEYCHAIN_UUID @"Punctuation_KEYCHAIN_UUID"



typedef void (^PunctuationRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^PunctuationInitCallback)(NSDictionary* result);
typedef void (^PunctuationLoginCallback)(NSDictionary* result);
typedef void (^PunctuationLogoutCallback)(NSDictionary* result);
typedef void (^PunctuationCheckUpdateCallback)(NSDictionary* result);
typedef void (^PunctuationCreateOderCallback)(NSDictionary* result);
typedef void (^PunctuationXXXCloseCallback)(NSDictionary* result);
typedef void (^PunctuationShiMimgRenZhengCallback)(NSString* result);


#define Punctuation_SUBMIT_CHOOSE_SERVER      @"Punctuation_SUBMIT_CHOOSE_SERVER"
#define Punctuation_SUBMIT_CHOOSE_ROLE        @"Punctuation_SUBMIT_CHOOSE_ROLE"
#define Punctuation_SUBMIT_ROLE_CREATE        @"Punctuation_SUBMIT_ROLE_CREATE"
#define Punctuation_SUBMIT_ROLE_LEVELUP       @"Punctuation_SUBMIT_ROLE_LEVELUP"
#define Punctuation_SUBMIT_ROLE_ENTERSERVER   @"Punctuation_SUBMIT_ROLE_ENTERSERVER"



#define Punctuation_ROLE_ID            @"Punctuation_ROLE_ID"
#define Punctuation_ROLE_LEVEL         @"Punctuation_ROLE_LEVEL"
#define Punctuation_ROLE_NAME          @"Punctuation_ROLE_NAME"
#define Punctuation_ROLE_CREATE_TIME   @"Punctuation_ROLE_CREATE_TIME"
#define Punctuation_SERVER_ID          @"Punctuation_SERVER_ID"
#define Punctuation_SERVER_NAME        @"Punctuation_SERVER_NAME"



#define Punctuation_IOS_PRODUCT_NAME   @"Punctuation_IOS_PRODUCT_NAME"
#define Punctuation_IOS_PRODUCT_ID     @"Punctuation_IOS_PRODUCT_ID"
#define Punctuation_IOS_CP_ORDERID     @"Punctuation_IOS_CP_ORDERID"
#define Punctuation_IOS_PRODUCT_DESC   @"Punctuation_IOS_PRODUCT_DESC"
#define Punctuation_IOS_PRODUCT_PRICE  @"Punctuation_IOS_PRODUCT_PRICE"
#define Punctuation_IOS_GOODS_NUM      @"Punctuation_IOS_GOODS_NUM"
#define Punctuation_IOS_ORDERID        @"Punctuation_IOS_ORDERID"
#define Punctuation_IOS_EXTRA          @"Punctuation_IOS_EXTRA"
#define Punctuation_IOS_ROLE_ID        @"Punctuation_IOS_ROLE_ID"
#define Punctuation_IOS_ROLE_NAME      @"Punctuation_IOS_ROLE_NAME"
#define Punctuation_IOS_ROLE_LEVEL     @"Punctuation_IOS_ROLE_LEVEL"
#define Punctuation_IOS_SERVER_ID      @"Punctuation_IOS_SERVER_ID"
#define Punctuation_IOS_SERVER_NAME    @"Punctuation_IOS_SERVER_NAME"




#define INIT_ERROR_NETWORK_ERROR @"请检查网络连接"





@interface PunctuationUtils : NSObject

+(PunctuationUtils*)getSharedInstance;

-(void) showPunctuationToastMsg:(NSString *)text view:(UIView *)view;

-(NSString *)getPunctuationNetIsp;//获取运营商信息
-(NSString *)getPunctuationNetworktype;//获取网络类型
-(NSString *)getPunctuationSystemVersion;//获取手机系统版本
-(NSString *)getPunctuationIdfa;//获取手机idfa
-(NSString *)getPunctuationIdfv;//获取手机idfv
-(NSString *)getPunctuationUUID;//获取手机getPunctuationUUID
-(NSString *)getPunctuationMac;//获取手机getPunctuationMac
-(NSString *)getPunctuationPhoneUserName;//获取手机别名
-(NSString *)getPunctuationDeviceName;//获取设备名称
-(NSString *)getPunctuationDeviceModel;//获取手机型号
-(NSString *)getPunctuationLocalPhoneModel;//获取地方型号（国际化区域名称）
-(NSString*)getPunctuationInstalledFlag;

-(NSString *)getPunctuationBundleId;
-(NSString *)getPunctuationAppName;
-(NSString *)getPunctuationAppVersion;
-(NSString *)getPunctuationAppBuildVersion;
-(NSString *)getPunctuationVersion;
-(NSString *)getPunctuationChannelSdkVersion;

-(NSString *)getPunctuationInfoPlist_PackageId;
-(Boolean)getPunctuationInfoPlist_Landscape;


-(void)setPunctuationUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token;
-(NSString *)getPunctuationUserId;
-(NSString *)getChannelUserId;

-(NSString *)Punctuation_md5:(NSString *)str;

-(void)postPunctuationActiveData;
-(void)postPunctuationGameData:(NSString *)dataPoint data:(NSDictionary *)data;
-(void)requestPunctuationNotice:(PunctuationRequestCallback)result;
-(void)requestPunctuationServerStatus:(PunctuationInitCallback)result;
-(void)getPunctuationLoginInfo:(NSDictionary *)dic result:(PunctuationLoginCallback)result;
-(void)doPunctuationLogout:(PunctuationLogoutCallback)result;
-(void)doPunctuationCheckUpdate:(PunctuationCheckUpdateCallback)result;
-(void)doPunctuationCreateOder:(NSDictionary *)param buildPunctuationodcb:(PunctuationCreateOderCallback)buildPunctuationodcb;
-(void)sendPunctuationHeartData;
-(void)doPunctuationPostAction:(NSDictionary *)httpParams toPunctuationServer:(NSString *)requestPath responseHandler:(PunctuationRequestCallback)handler showProgess:(Boolean)showprogress;

@end


