

#import "OrzOSDKBranch_SanJHY.h"

@implementation OrzOSDKBranch_SanJHY


-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"1.0.3";
}

-(void)doOrzOSDKChannelInit{
    NSLog(@"OrzOSDKBranch_29 doChannelInit  !");
    
    self.isLogined = NO;
    self.loginViewIsShowing = NO;
    
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
    
    self.Appid_29 = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_29_Appid"]];
    self.GameKey_29 = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_29_GameKey"]];
//    self.igvaAPP_29 = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_29_igvaAPP"]];
    self.channelId_29 = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_29_channelId"]];
    
    NSLog(@"appid_29 = %@", self.Appid_29);
    NSLog(@"GameKey_29 = %@", self.GameKey_29);
//    NSLog(@"igvaAPP_29 = %@", self.igvaAPP_29);
    NSLog(@"channelId_29 = %@", self.channelId_29);
    
    [GPSDK configWithPlayId:self.Appid_29
                     secret:self.GameKey_29
                      canal:self.channelId_29
              completeBlock:^(BOOL success, NSString *info) {
                  if (success) {
                      NSLog(@"info -- %@", info);
                      [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
                  }else{
                      [self.delegate channel_initOrzOSDKFail:@{@"code":@"-1",@"msg":@"failed"}];
                  }
              }];
    
}

-(void)doOrzOSDKChannelLogin{
    NSLog(@"OrzOSDKBranch_29 doChannelLogin");
    if(self.loginViewIsShowing == NO){
        self.loginViewIsShowing = YES;
        
        [GPSDK loginFinished:^(NSDictionary *data) {
            NSLog(@"登录回调: uid = %@",data[@"uid"]);
            [GPSDK uploadRoleInfoWithRoleId:[data objectForKey:OrzOSDK_ROLE_ID] roleName:[data objectForKey:OrzOSDK_ROLE_NAME]  roleLv:[data objectForKey:OrzOSDK_ROLE_LEVEL]  serverId:[data objectForKey:OrzOSDK_SERVER_ID]  serverName:[data objectForKey:OrzOSDK_SERVER_NAME]];
            
            self.loginViewIsShowing = NO;
            self.isLogined = YES;
            
            [self.delegate channel_loginOrzOSDKSuccess:@{@"channel_uid":@"",
                                                         @"channel_username":@"",
                                                         @"channel_token":data[@"token"],
                                                         @"channel_deviceid":@"29Sdk"}];
        }];
    }
}

-(void)doOrzOSDKChannelSwitchAccount{
    
    if(self.isLogined == YES){
        NSLog(@"OrzOSDKBranch_29 doChannelSwitchAccount");
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
    
        [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
    }
}


-(void)doOrzOSDKChannelLogout{
    if(self.isLogined == YES){
        NSLog(@"OrzOSDKBranch_29 doChannelChannelLogout");
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        
        [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"logout success"}];
    }
    
}

-(void)doChannelshowOrzOSDKGameCenter{
    NSLog(@"OrzOSDKBranch_29 doChannelshowGameCenter");
    
}

-(void)doChannelshowOrzOSDKFloatView{
    NSLog(@"OrzOSDKBranch_29 doChannelshowFloatView");
    
}

-(void)doChannelhideOrzOSDKFloatView{
    NSLog(@"OrzOSDKBranch_29 doChannelhideFloatView");
}

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params{
    NSLog(@"OrzOSDKBranch_29 doChannelRegcharg");
    int flag = 0;
    if([[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_Landscape] == YES){
        flag = 1;
    }else{
        flag = 0;
    }
    NSLog(@"flag = %d", flag);
    
    [GPSDK iapWithProductId:[params objectForKey:OrzOSDK_IOS_PRODUCT_ID] roleId:[params objectForKey:OrzOSDK_IOS_ROLE_ID] serverId:[params objectForKey:OrzOSDK_IOS_SERVER_ID] cpInfo:[params objectForKey:OrzOSDK_IOS_ORDERID] finished:^(NSDictionary *data) {
        NSLog(@"支付回调：%@",data);
        [self.delegate channel_RegchargOrzOSDKSuccess:@{@"code":@"0",@"msg":@"支付完成"}];
    }];
    


}


- (void)lt_iapResultResponse:(NSDictionary *)response {
    NSLog(@"\niap = %@", response);
    
}

-(void)doOrzOSDKChannelRealNameRegister:(int)flag{
    NSLog(@"OrzOSDKBranch_29 doChannelRealNameRegister");
    
}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverid = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
    self.roleid = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
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
