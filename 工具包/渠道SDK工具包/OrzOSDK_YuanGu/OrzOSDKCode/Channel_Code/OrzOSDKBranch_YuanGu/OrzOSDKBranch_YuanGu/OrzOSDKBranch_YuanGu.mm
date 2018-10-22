

#import "OrzOSDKBranch_YuanGu.h"

@implementation OrzOSDKBranch_YuanGu


-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"3.5";
}

-(void)doOrzOSDKChannelInit{
    NSLog(@"OrzOSDKBranch_YuanGu doChannelInit  !");
    
    [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
}

-(void)doOrzOSDKChannelLogin{
    NSLog(@"OrzOSDKBranch_YuanGu doChannelLogin");
    [[Zs4Game sharedInstance] login];
    if ([[Zs4Game sharedInstance] isLogined]) {
        // 登录成功后的操作
        [self.delegate channel_loginOrzOSDKSuccess:@{@"code":@"1",@"msg":@"loginsuccess"}];
        
        [[Zs4Game sharedInstance]showLogo];
        
    }

}

-(void)doOrzOSDKChannelSwitchAccount{
    NSLog(@"OrzOSDKBranch_YuanGu logoutSuccess  !");
    [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
}


-(void)doOrzOSDKChannelLogout{
    NSLog(@"OrzOSDKBranch_YuanGu logoutSuccess  !");
    [[Zs4Game sharedInstance] logout];
    [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"logout success"}];
}

-(void)doChannelshowOrzOSDKGameCenter{
    NSLog(@"OrzOSDKBranch_YuanGu showGameCenter  !");
}

-(void)doChannelshowOrzOSDKFloatView{
    NSLog(@"OrzOSDKBranch_YuanGu showFloatView  !");
}

-(void)doChannelhideOrzOSDKFloatView{
    NSLog(@"OrzOSDKBranch_YuanGu hideFloatView  !");
}

- (void)lt_loginResultResponse:(NSDictionary *)response {
    NSLog(@"\nlogin = %@", response);
    // 测试的使用，正常这个接口会在登录游戏角色后调用
    int RoleGrade = [[response objectForKey:OrzOSDK_ROLE_LEVEL]intValue];
    [[Zs4Game sharedInstance] setServId:[response objectForKey:OrzOSDK_SERVER_ID] ServName:[response objectForKey:OrzOSDK_SERVER_NAME] RoleId:[response objectForKey:OrzOSDK_ROLE_ID] RoleName:[response objectForKey:OrzOSDK_ROLE_NAME] RoleGrade:RoleGrade];
    // start pay
    [[Zs4Game sharedInstance] payforProduct:@"shisamenrui6" Expand_Data:@"test data"];
    
}

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params{
    int flag = 0;
    if([[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_Landscape] == YES){
        flag = 1;
    }else{
        flag = 0;
    }
    NSLog(@"flag = %d", flag);
    int ROLELEVEL = [[params objectForKey:OrzOSDK_ROLE_LEVEL]intValue];
    [[Zs4Game sharedInstance]setServId:[params objectForKey:OrzOSDK_SERVER_ID]  //区服ID
                              ServName:[params objectForKey:OrzOSDK_SERVER_NAME]       //区服名称
                                RoleId:[params objectForKey:OrzOSDK_ROLE_ID]    //角色ID
                              RoleName:[params objectForKey:OrzOSDK_ROLE_NAME]          //角色名称
                             RoleGrade:ROLELEVEL];              //等级 int 型
    
}

- (void)lt_iapResultResponse:(NSDictionary *)response {
    NSLog(@"\niap = %@", response);
    [self.delegate channel_RegchargOrzOSDKSuccess:@{@"code":@"0",@"msg":@"支付完成"}];
}

-(void)doOrzOSDKChannelRealNameRegister:(int)flag{
    
}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    NSLog(@"OrzOSDKBranch_YuanGu doSendGameData  !");
    self.serverid = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
    self.roleid = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
    
    int ROLELEVEL = [[data objectForKey:OrzOSDK_ROLE_LEVEL]intValue];
    [[Zs4Game sharedInstance]setServId:[data objectForKey:OrzOSDK_SERVER_ID]  //区服ID
                              ServName:[data objectForKey:OrzOSDK_SERVER_NAME]       //区服名称
                                RoleId:[data objectForKey:OrzOSDK_ROLE_ID]    //角色ID
                              RoleName:[data objectForKey:OrzOSDK_ROLE_NAME]          //角色名称
                             RoleGrade:ROLELEVEL];              //等级 int 型
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
    
    self.AppID_YuanGu = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"AppID_YuanGu"]];
    self.AppKey_YuanGu = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"AppKey_YuanGu"]];
    self.UmengKey_YuanGu = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"UmengKey_YuanGu"]];
    self.TalkingDataAdTracking_YuanGu = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"TalkingDataAdTracking_YuanGu"]];
    self.TrackingKey_YuanGu = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"TrackingKey_YuanGu"]];
    self.TrackingChannelId_YuanGu = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"TrackingChannelId_YuanGu"]];
    self.Rate = [[NSString alloc]initWithFormat:@"%@",[channel_config objectForKey:@"Rate"]];
    
    NSLog(@"setAppID = %@", self.AppID_YuanGu);
    NSLog(@"AppKey = %@", self.AppKey_YuanGu);
    NSLog(@"UmengKey = %@", self.UmengKey_YuanGu);
    NSLog(@"TalkingDataAdTracking = %@", self.TalkingDataAdTracking_YuanGu);
    NSLog(@"TrackingKey = %@", self.TrackingKey_YuanGu);
    NSLog(@"TrackingChannelId = %@", self.TrackingChannelId_YuanGu);
    NSLog(@"兑换比例Rate = %@",self.Rate);
    
    int AppID_YuanGu = [self.AppID_YuanGu intValue];
    [[Zs4Game sharedInstance]
     setAppID:AppID_YuanGu
     AppKey:self.AppKey_YuanGu
     UmengKey:self.UmengKey_YuanGu
     TalkingDataAdTracking:self.TalkingDataAdTracking_YuanGu
     TrackingKey:self.TrackingChannelId_YuanGu
     TrackingChannelId:self.TalkingDataAdTracking_YuanGu
     GameOrientation:GAMEInterfaceOrientationLandscape  //横竖屏 GAMEInterfaceOrientationPortrait  GAMEInterfaceOrientationLandscape
     LaunchOptions:launchOptions];
    
    
    
    return TRUE;
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

- (void)applicationWillResignActive:(UIApplication *)application{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}
- (void)applicationWillTerminate:(UIApplication *)application{
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return TRUE;
}


@end
