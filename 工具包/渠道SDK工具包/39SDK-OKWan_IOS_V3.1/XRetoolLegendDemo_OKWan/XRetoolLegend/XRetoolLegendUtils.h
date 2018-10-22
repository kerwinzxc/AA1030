

#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/ASIdentifierManager.h>
#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>



#define XRetoolLegend_SDK_VERSION @"3.1"

#define XRetoolLegend_KEYCHAIN_IDFV @"XRetoolLegend_KEYCHAIN_IDFV"
#define XRetoolLegend_KEYCHAIN_UUID @"XRetoolLegend_KEYCHAIN_UUID"



typedef void (^XRetoolLegendRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^XRetoolLegendInitCallback)(NSDictionary* result);
typedef void (^XRetoolLegendLoginCallback)(NSDictionary* result);
typedef void (^XRetoolLegendLogoutCallback)(NSDictionary* result);
typedef void (^XRetoolLegendCheckUpdateCallback)(NSDictionary* result);
typedef void (^XRetoolLegendCreateOderCallback)(NSDictionary* result);
typedef void (^XRetoolLegendXXXCloseCallback)(NSDictionary* result);


#define XRetoolLegend_SUBMIT_CHOOSE_SERVER      @"XRetoolLegend_SUBMIT_CHOOSE_SERVER"
#define XRetoolLegend_SUBMIT_CHOOSE_ROLE        @"XRetoolLegend_SUBMIT_CHOOSE_ROLE"
#define XRetoolLegend_SUBMIT_ROLE_CREATE        @"XRetoolLegend_SUBMIT_ROLE_CREATE"
#define XRetoolLegend_SUBMIT_ROLE_LEVELUP       @"XRetoolLegend_SUBMIT_ROLE_LEVELUP"
#define XRetoolLegend_SUBMIT_ROLE_ENTERSERVER   @"XRetoolLegend_SUBMIT_ROLE_ENTERSERVER"



#define XRetoolLegend_ROLE_ID            @"XRetoolLegend_ROLE_ID"
#define XRetoolLegend_ROLE_LEVEL         @"XRetoolLegend_ROLE_LEVEL"
#define XRetoolLegend_ROLE_NAME          @"XRetoolLegend_ROLE_NAME"
#define XRetoolLegend_ROLE_CREATE_TIME   @"XRetoolLegend_ROLE_CREATE_TIME"
#define XRetoolLegend_SERVER_ID          @"XRetoolLegend_SERVER_ID"
#define XRetoolLegend_SERVER_NAME        @"XRetoolLegend_SERVER_NAME"



#define XRetoolLegend_IOS_PRODUCT_NAME   @"XRetoolLegend_IOS_PRODUCT_NAME"
#define XRetoolLegend_IOS_PRODUCT_ID     @"XRetoolLegend_IOS_PRODUCT_ID"
#define XRetoolLegend_IOS_CP_ORDERID     @"XRetoolLegend_IOS_CP_ORDERID"
#define XRetoolLegend_IOS_PRODUCT_DESC   @"XRetoolLegend_IOS_PRODUCT_DESC"
#define XRetoolLegend_IOS_PRODUCT_PRICE  @"XRetoolLegend_IOS_PRODUCT_PRICE"
#define XRetoolLegend_IOS_GOODS_NUM      @"XRetoolLegend_IOS_GOODS_NUM"
#define XRetoolLegend_IOS_ORDERID        @"XRetoolLegend_IOS_ORDERID"
#define XRetoolLegend_IOS_EXTRA          @"XRetoolLegend_IOS_EXTRA"
#define XRetoolLegend_IOS_ROLE_ID        @"XRetoolLegend_IOS_ROLE_ID"
#define XRetoolLegend_IOS_ROLE_NAME      @"XRetoolLegend_IOS_ROLE_NAME"
#define XRetoolLegend_IOS_ROLE_LEVEL     @"XRetoolLegend_IOS_ROLE_LEVEL"
#define XRetoolLegend_IOS_SERVER_ID      @"XRetoolLegend_IOS_SERVER_ID"
#define XRetoolLegend_IOS_SERVER_NAME    @"XRetoolLegend_IOS_SERVER_NAME"




#define INIT_ERROR_NETWORK_ERROR @"请检查网络连接"





@interface XRetoolLegendUtils : NSObject

+(XRetoolLegendUtils*)getSharedInstance;

-(void) showXRetoolLegendToastMsg:(NSString *)text view:(UIView *)view;

-(NSString *)getXRetoolLegendNetIsp;//获取运营商信息
-(NSString *)getXRetoolLegendNetworktype;//获取网络类型
-(NSString *)getXRetoolLegendSystemVersion;//获取手机系统版本
-(NSString *)getXRetoolLegendIdfa;//获取手机idfa
-(NSString *)getXRetoolLegendIdfv;//获取手机idfv
-(NSString *)getXRetoolLegendUUID;//获取手机getXRetoolLegendUUID
-(NSString *)getXRetoolLegendMac;//获取手机getXRetoolLegendMac
-(NSString *)getXRetoolLegendPhoneUserName;//获取手机别名
-(NSString *)getXRetoolLegendDeviceName;//获取设备名称
-(NSString *)getXRetoolLegendDeviceModel;//获取手机型号
-(NSString *)getXRetoolLegendLocalPhoneModel;//获取地方型号（国际化区域名称）
-(NSString*)getXRetoolLegendInstalledFlag;

-(NSString *)getXRetoolLegendBundleId;
-(NSString *)getXRetoolLegendAppName;
-(NSString *)getXRetoolLegendAppVersion;
-(NSString *)getXRetoolLegendAppBuildVersion;
-(NSString *)getXRetoolLegendVersion;
-(NSString *)getXRetoolLegendChannelSdkVersion;

-(NSString *)getXRetoolLegendInfoPlist_PackageId;
-(Boolean)getXRetoolLegendInfoPlist_Landscape;


-(void)setXRetoolLegendUserInfo:(NSString*) username
            userid:(NSString*) userid
          password:(NSString*) password
             token:(NSString*) token;
-(NSString *)getXRetoolLegendUserId;
-(NSString *)getChannelUserId;

-(NSString *)XRetoolLegend_md5:(NSString *)str;

-(void)postXRetoolLegendActiveData;
-(void)postXRetoolLegendGameData:(NSString *)dataPoint data:(NSDictionary *)data;
-(void)requestXRetoolLegendNotice:(XRetoolLegendRequestCallback)result;
-(void)requestXRetoolLegendServerStatus:(XRetoolLegendInitCallback)result;
-(void)getXRetoolLegendLoginInfo:(NSDictionary *)dic result:(XRetoolLegendLoginCallback)result;
-(void)doXRetoolLegendLogout:(XRetoolLegendLogoutCallback)result;
-(void)doXRetoolLegendCheckUpdate:(XRetoolLegendCheckUpdateCallback)result;
-(void)doXRetoolLegendCreateOder:(NSDictionary *)param createOderCB:(XRetoolLegendCreateOderCallback)createOderCB;
-(void)sendXRetoolLegendHeartData;
-(void)doXRetoolLegendPostAction:(NSDictionary *)httpParams toXRetoolLegendServer:(NSString *)requestPath responseHandler:(XRetoolLegendRequestCallback)handler showProgess:(Boolean)showprogress;

@end


