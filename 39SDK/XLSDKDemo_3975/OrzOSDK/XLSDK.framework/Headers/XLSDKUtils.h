//
//  XLSDKUtils.h
//  XLSDK
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XLSDK_SDK_VERSION @"3.3.1"

#define XLSDK_KEYCHAIN_IDFV @"OrzOSDK_KEYCHAIN_IDFV"

#define XLSDK_KEYCHAIN_UUID @"OrzOSDK_KEYCHAIN_UUID"

typedef void (^XLSDKRequestCallback)(NSURLResponse* response, id data, NSError* connectionError);

typedef void (^XLSDKInitCallback)(NSDictionary* result);

typedef void (^XLSDKLoginCallback)(NSDictionary* result);

typedef void (^XLSDKLogoutCallback)(NSDictionary* result);

typedef void (^XLSDKCheckUpdateCallback)(NSDictionary* result);

typedef void (^XLSDKCreateOderCallback)(NSDictionary* result);

typedef void (^XLSDKXXXCloseCallback)(NSDictionary* result);

typedef void (^XLSDKShiMimgRenZhengCallback)(NSString* result);


#define XLSDK_SUBMIT_CHOOSE_SERVER      @"OrzOSDK_SUBMIT_CHOOSE_SERVER"
#define XLSDK_SUBMIT_CHOOSE_ROLE        @"OrzOSDK_SUBMIT_CHOOSE_ROLE"
#define XLSDK_SUBMIT_ROLE_CREATE        @"OrzOSDK_SUBMIT_ROLE_CREATE"
#define XLSDK_SUBMIT_ROLE_LEVELUP       @"OrzOSDK_SUBMIT_ROLE_LEVELUP"
#define XLSDK_SUBMIT_ROLE_ENTERSERVER   @"OrzOSDK_SUBMIT_ROLE_ENTERSERVER"


#define XLSDK_ROLE_ID            @"OrzOSDK_ROLE_ID"
#define XLSDK_ROLE_LEVEL         @"OrzOSDK_ROLE_LEVEL"
#define XLSDK_ROLE_NAME          @"OrzOSDK_ROLE_NAME"
#define XLSDK_ROLE_CREATE_TIME   @"OrzOSDK_ROLE_CREATE_TIME"
#define XLSDK_SERVER_ID          @"OrzOSDK_SERVER_ID"
#define XLSDK_SERVER_NAME        @"OrzOSDK_SERVER_NAME"


#define XLSDK_IOS_PRODUCT_NAME   @"OrzOSDK_IOS_PRODUCT_NAME"
#define XLSDK_IOS_PRODUCT_ID     @"OrzOSDK_IOS_PRODUCT_ID"
#define XLSDK_IOS_CP_ORDERID     @"OrzOSDK_IOS_CP_ORDERID"
#define XLSDK_IOS_PRODUCT_DESC   @"OrzOSDK_IOS_PRODUCT_DESC"
#define XLSDK_IOS_PRODUCT_PRICE  @"OrzOSDK_IOS_PRODUCT_PRICE"
#define XLSDK_IOS_GOODS_NUM      @"OrzOSDK_IOS_GOODS_NUM"
#define XLSDK_IOS_ORDERID        @"OrzOSDK_IOS_ORDERID"
#define XLSDK_IOS_EXTRA          @"OrzOSDK_IOS_EXTRA"
#define XLSDK_IOS_ROLE_ID        @"OrzOSDK_IOS_ROLE_ID"
#define XLSDK_IOS_ROLE_NAME      @"OrzOSDK_IOS_ROLE_NAME"
#define XLSDK_IOS_ROLE_LEVEL     @"OrzOSDK_IOS_ROLE_LEVEL"
#define XLSDK_IOS_SERVER_ID      @"OrzOSDK_IOS_SERVER_ID"
#define XLSDK_IOS_SERVER_NAME    @"OrzOSDK_IOS_SERVER_NAME"



@interface XLSDKUtils : NSObject

@property (nonatomic ,copy) NSString *XLSDK_channel_id;

+(XLSDKUtils*)getSharedInstance;

-(void) showXLDKToastMsg:(NSString *)text view:(UIView *)view;

/**
 *  @from                    v1.0.0
 *  @brief                   获取运营商信息
 *  @return                  返回运营商信息
 */
-(NSString *)fetchXLSDKNetIsp;

/**
 *  @from                    v1.0.0
 *  @brief                   获取网络类型
 *  @return                  返回网络类型信息
 */
-(NSString *)fetchXLSDKNetworktype;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备系统版本
 *  @return                  返回设备系统版本信息
 */
-(NSString *)fetchXLSDKSystemVersion;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备idfa
 *  @return                  返回设备idfa
 */
-(NSString *)fetchXLSDKIdfa;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备idfv
 *  @return                  返回设备idfv
 */
-(NSString *)fetchXLSDKIdfv;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备UUID
 *  @return                  返回设备UUID
 */
-(NSString *)fetchXLSDKUUID;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备Mac地址
 *  @return                  返回设备Mac地址
 */
-(NSString *)fetchXLSDKMac;

/**
 *  @from                    v1.0.0
 *  @brief                   获取秘钥
 */
-(NSString *)fetchXLSDKSecret;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备别名
 *  @return                  返回设备别名
 */
-(NSString *)fetchXLSDKPhoneUserName;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备名称
 *  @return                  返回设备名称
 */
-(NSString *)fetchXLSDKDeviceName;

/**
 *  @from                    v1.0.0
 *  @brief                   获取设备型号
 *  @return                  返回设备型号
 */
-(NSString *)fetchXLSDKDeviceModel;

/**
 *  @from                    v1.0.0
 *  @brief                   获取地方型号（国际化区域名称）
 *  @return                  返回地方型号（国际化区域名称）
 */
-(NSString *)fetchXLSDKLocalPhoneModel;

/**
 *  @from                    v1.0.0
 *  @brief                   获取是否激活flag
 *  @return                  返回激活flag
 */
-(NSString *)fetchXLSDKInstalledFlag;

/**
 *  @from                    v1.0.0
 *  @brief                   获取appBudleId
 *  @return                  返回appBudleId
 */
-(NSString *)fetchXLSDKBundleId;

/**
 *  @from                    v1.0.0
 *  @brief                   获取appName
 *  @return                  返回appName
 */
-(NSString *)fetchXLSDKAppName;

/**
 *  @from                    v1.0.0
 *  @brief                   获取appVersion
 *  @return                  返回appVersion
 */
-(NSString *)fetchXLSDKAppVersion;

/**
 *  @from                    v1.0.0
 *  @brief                   获取appBuildVersion
 *  @return                  返回appBuildVersion
 */
-(NSString *)fetchXLSDKAppBuildVersion;

/**
 *  @from                    v1.0.0
 *  @brief                   获取SDK version
 *  @return                  返回SDK version
 */
-(NSString *)fetchXLSDKVersion;

/**
 *  @from                    v1.0.0
 *  @brief                   获取渠道SDK version
 *  @return                  返回渠道SDK version
 */
-(NSString *)fetchXLSDKChannelSdkVersion;

/**
 *  @from                    v1.0.0
 *  @brief                   获取packageId
 *  @return                  返回packageId
 */
-(NSString *)fetchXLSDKInfoPlist_PackageId;

/**
 *  @from                    v1.0.0
 *  @brief                   是否支持横竖屏
 *  @return                  返回是否支持横竖屏
 */
-(Boolean)fetchXLSDKInfoPlist_Landscape;


/**
 *  @from                    v1.0.0
 *  @brief                   保持数据
 *  @params  sValue          待保存数据
 *  @params  sKey            待保存数据key
 */
- (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;


//-(void)setXLSDKUserInfo:(NSString*) username
//                 userid:(NSString*) userid
//               password:(NSString*) password
//                  token:(NSString*) token;

/**
 *  @from                    v1.0.0
 *  @brief                   获取XLSDK userId
 *  @return                  返回userId
 */
-(NSString *)fetchXLSDKUserId;

/**
 *  @from                    v1.0.0
 *  @brief                   获取渠道userId
 *  @return                  返回userId
 */
-(NSString *)fetchChannelUserId;

/**
 *  @from                    v1.0.0
 *  @brief
 *  @parma  str              待加密参数
 *  @return                  返回加密后数据
 */
-(NSString *)xlSDKEncrypt_md5:(NSString *)str;

/**
 *  @from                    v1.0.0
 *  @brief                   获取登录信息
 *  @parma  dic              请求参数
 *  @parma  result           请求结果回调
 */
-(void)fetchXLSDKLoginInfo:(NSDictionary *)dic result:(XLSDKLoginCallback)result;


-(void)xLSDKCreateOderAction:(NSDictionary *)param buildXLSDKodcb:(XLSDKCreateOderCallback)buildOrzOSDKodcb;

-(void)doXLSDKPostAction:(NSDictionary *)httpParams toOrzOSDKServer:(NSString *)requestPath responseHandler:(XLSDKRequestCallback)handler showProgess:(Boolean)showprogress;

@end
