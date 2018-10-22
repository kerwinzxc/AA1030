//
//  XLSDK.h
//  XLSDK
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XLSDKUtils.h"

@protocol XLSDKDelegate <NSObject>

/**
 *  @from                    v1.0.0
 *  @brief                   SDK初始化成功
 *  @param result            初始化成功返回数据
 */
-(void)initXLSDKSuccess:(NSDictionary *)result;

/**
 *  @from                    v1.0.0
 *  @brief                   SDK初始化失败
 *  @param result            初始化失败返回数据
 */
-(void)initXLSDKFail:(NSDictionary *)result;

/**
 *  @from                    v1.0.0
 *  @brief                   SDK登录成功
 *  @param result            登录成功返回数据
 */
-(void)loginXLSDKSuccess:(NSDictionary *)result;


/**
 *  @from                    v1.0.0
 *  @brief                   SDK登录失败
 *  @param result            登录失败返回数据
 */
-(void)loginXLSDKFail:(NSDictionary *)result;


/**
 *  @from                    v1.0.0
 *  @brief                   SDK登出成功
 *  @param result            登出成功返回数据
 */
-(void)logoutXLSDKSuccess:(NSDictionary *)result;


/**
 *  @from                    v1.0.0
 *  @brief                   SDK登出失败
 *  @param result            登出失败返回数据
 */
-(void)logoutXLSDKFail:(NSDictionary *)result;

/**
 *  @from                    v1.0.0
 *  @brief                   SDK消费成功
 *  @param result            消费成功返回数据
 */
-(void)RegchargXLSDKSuccess:(NSDictionary *)result;


/**
 *  @from                    v1.0.0
 *  @brief                   SDK消费失败
 *  @param result            消费失败返回数据
 */
-(void)RegchargXLSDKFail:(NSDictionary *)result;

/**
 *  @from                    v1.0.0
 *  @brief                   展示SDK用户中心
 */
-(void)openXLSDKUserCenter;

/**
 *  @from                    v1.0.0
 *  @brief                   关闭SDK用户中心
 */
-(void)closeXLSDKUserCenter;

@end

@interface XLSDK : NSObject

@property (strong, nonatomic) id <XLSDKDelegate> xlSDKDelegate;

@property (nonatomic) Boolean xlSDKnetWorkIsOK;


/**
 * @from               1.0.0
 * @brief              初始化SDK类对象
 * @return             返回SDK对象
 */
+(XLSDK*)getSharedInstance;


/**
 * @from               1.0.0
 * @brief              初始化SDK
 */
-(void)initXLSDK;


/**
 * @from               1.0.0
 * @brief              SDK开始登录
 */
-(void)startXLSDKLogin;


/**
 * @from               1.0.0
 * @brief              SDK切换账号
 */
-(void)startXLSDKSwitchAccount;


/**
 * @from               1.0.0
 * @brief              SDK账号登出
 */
-(void)startXLSDKLogout;


/**
 * @from               1.0.0
 * @brief              展示SDK游戏中心
 */
-(void)showXLSDKGameCenter;


/**
 * @from               1.0.0
 * @brief              显示SDK浮标
 */
-(void)showXLSDKFloatView;


/**
 * @from               1.0.0
 * @brief              隐藏SDK浮标
 */
-(void)hideXLSDKFloatView;


/**
 *  @from                    v1.0.0
 *  @brief                   SDK消费成功
 *  @param  params           消费参数
 */
-(void)startXLSDKRegcharg:(NSDictionary *)params;


/**
 *  @from                    v1.0.0
 *  @brief                   SDK消费成功
 *  @param  dataPoint        传送数据
 *  @param  data             数据
 */
-(void)sendXLSDKData:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)applicationWillResignActive:(UIApplication *)application;

- (void)applicationDidEnterBackground:(UIApplication *)application;

- (void)applicationWillEnterForeground:(UIApplication *)application;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)applicationWillTerminate:(UIApplication *)application;

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end

