//
//  AppDelegate.m
//
//  Created by aXiBa on 15/2/4.
//  Copyright (c) 2015年 aXiBa. All rights reserved.
//
//  项目初始化在这边做，
//

#import "AppDelegate.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //是否隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:
                   [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    gameInitViewController = [[Zs4GameInitViewCtr alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:gameInitViewController];
    
    
    self.window.rootViewController = nav;
    
    //在这边进行初始化，参数分别为
    //SDK 分配的 AppID  如 1000
    //SDK 分配的 APPKey 如 0a305ff02845aacdbf9a8dd75c3b8316
    //友盟的  UmengKey 520075a556240bf6f600618f000
    //TalkingData 的 TalkingDataAdTracking 如 76047EF6A58B87AE5CF4C86E61FCDF19 (没有的话填demo的)
    //游戏横竖屏参数 GameOrientation （GAMEInterfaceOrientationPortrait 或者 GAMEInterfaceOrientationLandscape）
    
    [[Zs4Game sharedInstance]
     setAppID:1000
     AppKey:@"0a305ff02845aacdbf9a8dd75c3b8316"
     UmengKey:@"579c09afe0f55a498a002028"
     TalkingDataAdTracking:@"76047EF6A58B87AE5CF4C86E61FCDF19"
     TrackingKey:@"8c2a492b76d750bc465d4d29009dbbdc"
     TrackingChannelId:@"_default_"
     GameOrientation:GAMEInterfaceOrientationLandscape  //横竖屏 GAMEInterfaceOrientationPortrait  GAMEInterfaceOrientationLandscape
     LaunchOptions:launchOptions];
     
   
    return YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application NS_AVAILABLE_IOS(4_0)
{
    //配置appid appkey umengkey 和 启动参数
    [[Zs4Game sharedInstance] setSDKEnterForeground];
}



// IOS6.0 SDK 必须设置方向支持
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    //UIInterfaceOrientationMaskPortrait  UIInterfaceOrientationMaskLandscape
    return UIInterfaceOrientationMaskLandscape;
    
}

@end
