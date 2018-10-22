//
//  BTGOSDK.h
//  BTGOSDK
//  Created by River on 26/7/16.
//  Copyright © 2016年 River. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BTGOConfig.h"
#import "BTGOPayInfo.h"
#import "BTGORole.h"


//SDK基本定义
#define GAME_MODEL @"BTGOSDK"
#define SDK_VERSION_CODE @"100"
#define SDK_VERSION_NAME @"1.0.0"

//配置参数的KEY
#define KEY_APP_ID @"KEY_APP_ID"
#define KEY_APP_KEY @"KEY_APP_KEY"

//消息通知事件Key
#define KEY_EVENT_CODE @"KEY_EVENT_CODE"
#define KEY_DATA @"KEY_DATA"

//消息通知数据Key
#define EXTRA_USER @"EXTRA_USER"
#define EXTRA_ERROR_MESSAGE @"EXTRA_ERROR_MESSAGE"
#define EXTRA_OUT_ORDER_ID @"EXTRA_OUT_ORDER_ID"

/**
 消息通知事件码定义
 */

typedef NS_ENUM(NSInteger,SDK_EVENT_CODE) {
    BTGO_LOGIN_SUCCESS = 1,
    BTGO_LOGIN_FAILED = 2,
    BTGO_PAY_SUCCESS = 3,
    BTGO_PAY_CANCEL = 4,
    BTGO_PAY_FAILED = 5,
};

@interface BTGOSDK : NSObject
/** 初始化BTGO所有组件产品
 @param model 开发者配置appkey 和appId 的model.
 @param aTarget 渠道标识，可设置nil表示"App Store".
 @return;
 */
+(void)initSDKWithSetBTGOConfig:(BTGOConfig*)model target:(id)aTarget;
//
/**
 进入登录页面
 */
+(void)login;
/**
 进入支付流程
 */

+(void)payWithPayInfo:(BTGOPayInfo *)model;
/**
 提交角色信息
 */
+(void)sendBTGORole:(BTGORole *)role;
/**
 处理应用内调Url的拦截处理
 */
+(void)onOpenUrl:(NSURL *)url;

/**
 处理返回本应用逻辑
 */
+(void)onEnterForeground:(UIApplication *)application;

@end
