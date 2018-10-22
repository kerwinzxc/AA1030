//
//  Channel_39.h
//  Channel_39
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XLSDKBranch.h"
#import "XLSDKUtils.h"

@interface Channel_39 : XLSDKBranch

@property (nonatomic) Boolean IsClickedLogin;

@property (strong, nonatomic) NSString *userId;

@property (strong, nonatomic) NSString *accesstoken;

@property (strong, nonatomic) NSString *serverId;

@property (strong, nonatomic) NSString *roleId;

@property (strong, nonatomic) NSString *roleLevel;

@property (nonatomic, strong) UIAlertView* myAlert;

@property (strong, nonatomic) NSString *productId;

@property (strong, nonatomic) NSString *apple_oderid;

/**
 * @from               1.0.0
 * @brief              获取渠道版本号
 * @return             返回渠道SDK版本号
 */
-(NSString *)fetchChannelSDKVersionAction;

/**
 * @from               1.0.0
 * @brief              初始化渠道SDK
 */
-(void)channelSDKInitAction;

/**
 * @from               1.0.0
 * @brief              登录渠道SDK
 */
-(void)channelSDKLoginAction;

/**
 * @from               1.0.0
 * @brief              切换账号
 */
-(void)channelSDKSwitchAccountAction;

/**
 * @from               1.0.0
 * @brief              登出渠道SDK
 */
-(void)channelSDKLoginOutAction;

/**
 * @from               1.0.0
 * @brief              展示渠道SDK游戏中心
 */
-(void)showChannelSDKGameCenterAction;

/**
 * @from               1.0.0
 * @brief              展示浮标
 */
-(void)showChannelSDKFloatViewAction;

/**
 * @from               1.0.0
 * @brief              隐藏浮标
 */
-(void)hideChannelSDKFloatViewAction;

/**
 * @from               1.0.0
 * @brief              消费
 * @params  params     参数
 */
-(void)channelSDKRegchargAction:(NSDictionary *)params;

/**
 * @from               1.0.0
 * @brief              实名认证
 * @params  flag       认证标识
 * @params  callback   回调
 */
-(void)channelSDKRealNameRegisterAction:(int)flag callback:(XLSDKShiMimgRenZhengCallback)callback;

/**
 * @from               1.0.0
 * @brief              实名认证
 * @params  dataPoint  参数
 * @params  data       参数
 */
-(void)channelSDKSendGameDataAction:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)applicationWillResignActive:(UIApplication *)application;

- (void)applicationDidEnterBackground:(UIApplication *)application;

- (void)applicationWillEnterForeground:(UIApplication *)application;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)applicationWillTerminate:(UIApplication *)application;


@end

