//
//  XRetoolLegendBranch_okwan.h
//  XRetoolLegendBranch_okwan
//
//  Created by leo1234 on 2017/9/7.
//  Copyright © 2017年 514713374@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRetoolLegendBranch.h"
#import "XRetoolLegendUtils.h"

#import "SLEsdkManagerLEfile.h"
#import "SLERoleModelLEfile.h"
#import "SLERequestModelLEfile.h"


@interface XRetoolLegendBranch_okwan : XRetoolLegendBranch
@property (nonatomic) Boolean IsClickedLogin;
@property (nonatomic) Boolean IsLoginSuccess;

@property (strong, nonatomic) NSString *gid;
@property (strong, nonatomic) NSString *apikey;
@property (strong, nonatomic) NSString *secretkey;
@property (strong, nonatomic) NSString *gamename;

@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleName;


-(NSString *)getXRetoolLegendChannelSdkVersion;

-(void)doXRetoolLegendChannelInit;

-(void)doXRetoolLegendChannelLogin;

-(void)doXRetoolLegendChannelSwitchAccount;

-(void)doXRetoolLegendChannelLogout;

-(void)doChannelshowXRetoolLegendGameCenter;

-(void)doChannelshowXRetoolLegendFloatView;

-(void)doChannelhideXRetoolLegendFloatView;

-(void)doXRetoolLegendChannelRegcharg:(NSDictionary *)params;

-(void)doXRetoolLegendChannelRealNameRegister:(int)flag;

-(void)doXRetoolLegendChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

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


@end
