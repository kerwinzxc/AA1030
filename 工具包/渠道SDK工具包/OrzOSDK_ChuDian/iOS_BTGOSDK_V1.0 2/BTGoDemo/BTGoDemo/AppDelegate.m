//
//  AppDelegate.m
//  BTGoDemo
//
//  Created by BTGOFL on 2018/6/26.
//  Copyright © 2018年 BTGOFL. All rights reserved.
//

#import "AppDelegate.h"
#import <BTGOSDK/BTGOSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //SDK配置
    BTGOConfig*config = [[BTGOConfig alloc] init];
    //配置对应的appId
    config.appId = @"100";
    //配置对应的appKey
    config.appKey = @"7162d8851d1494f94fcae642f624fd77";
    [BTGOSDK initSDKWithSetBTGOConfig:config target:self ];
    return YES;
}
/**
 必须要实现  -(void)completionHandler:(id)sender 这个方法，来实现方法的回调。
 可以获取登录成功回调和参数
 获取支付的状态的回调
*/
-(void)completionHandler:(id)sender {
    NSDictionary *userInfo = [sender userInfo];
    NSInteger eventCode = [userInfo[KEY_EVENT_CODE] integerValue];
    NSDictionary *data = userInfo[KEY_DATA];
    switch (eventCode) {
        case BTGO_LOGIN_SUCCESS:
            //登录成功，游戏可从此获取账号信息
            NSLog(@"userid=%@", [data objectForKey:@"userid"]);
            NSLog(@"token=%@", [data objectForKey:@"token"]);
            NSLog(@"登录成功");
            break;
        case BTGO_PAY_SUCCESS:
            //支付成功
            NSLog(@"支付成功,订单号：%@", data[EXTRA_OUT_ORDER_ID]);
            break;
        case BTGO_PAY_CANCEL:
            //支付取消
            NSLog(@"支付取消");
            break;
        case BTGO_PAY_FAILED:
            //支付失败
            NSLog(@"支付失败");
            break;
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//*******************************************下面代码注意添加*****************************************/
#pragma mark 返回应用回调
-(void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [BTGOSDK onEnterForeground:application];
}
#pragma mark 调Url中间处理
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation{
    [BTGOSDK onOpenUrl:url];
    return YES;
}
#pragma mark 9.0以后使用新API接口

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{

    [BTGOSDK onOpenUrl:url];
    return YES;
}

@end
