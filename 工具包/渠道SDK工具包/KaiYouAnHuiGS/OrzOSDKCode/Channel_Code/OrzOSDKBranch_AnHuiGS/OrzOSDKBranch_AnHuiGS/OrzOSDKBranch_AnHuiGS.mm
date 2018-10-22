

#import "OrzOSDKBranch_AnHuiGS.h"
#import "XZsdkManagercdcn.h"
#import "XZRequestModelcdcn.h"
#import "XZRoleModelcdcn.h"

@implementation OrzOSDKBranch_AnHuiGS


-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"1.0.0";
}

-(void)doOrzOSDKChannelInit{
    NSLog(@"OrzOSDKBranch_AnHuiGS doChannelInit  !");

    self.isLogined = NO;
    self.loginViewIsShowing = YES;
    
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
    self.gid = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_gs_gid"]];
    self.apikey = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_gs_apikey"]];
    self.secretkey = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_gs_secretkey"]];
    self.gamename = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_gs_gamename"]];
    
    
    
    
    [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
    
}

-(void)doOrzOSDKChannelLogin{
    if(self.loginViewIsShowing == YES){
//        self.loginViewIsShowing = YES;
//        self.isLogined = NO;
    NSLog(@"OrzOSDKBranch_AnHuiGS doChannelLogin");
    [XZsdkManagercdcn XZstartLoginWithGid:self.gid apiKey:self.apikey secretKey:self.secretkey version:[[OrzOSDKUtils getSharedInstance] getOrzOSDKAppVersion]];
        self.loginViewIsShowing = NO;
        self.isLogined = YES;
        
    [XZsdkManagercdcn XZReVerifyToService];//向服务器再次发起验证凭证
    }
    
}

-(void)doOrzOSDKChannelRealNameRegister:(int)flag callback:(OrzOSDKShiMimgRenZhengCallback)callback{

}

-(void)doOrzOSDKChannelSwitchAccount{
    NSLog(@"OrzOSDKBranch_AnHuiGS doChannelSwitchAccount  !");
    if(self.isLogined == YES){
        
    [XZsdkManagercdcn XZLoginOutDidSuccess:^(BOOL isSuccess) {
        self.isLogined = NO;
        self.loginViewIsShowing = YES;
        if (isSuccess) {
            NSLog(@"切换注销成功");
            [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"SwitchAccountsuccess"}];
        }else{
            NSLog(@"切换注销失败");
        }
        
    }];
    }
    
}


-(void)doOrzOSDKChannelLogout{
    NSLog(@"OrzOSDKBranch_AnHuiGS doChannelLogout  !");
    [XZsdkManagercdcn XZLoginOutDidSuccess:^(BOOL isSuccess) {
        if(self.isLogined == YES){
            self.isLogined = NO;
            self.loginViewIsShowing = YES;
        if (isSuccess) {
            NSLog(@"登出注销成功");
            [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"logoutsuccess"}];
        }else{
            NSLog(@"登出注销失败");
        }
        }
    }];
    
}

- (void)notificationGetRegisterData:(NSNotification *)notification {
    NSDictionary  *dict=[notification userInfo];
    NSLog(@"注册获取的uid值:%@",[dict objectForKey:@"uid"]);
    NSLog(@"注册获取的scode值:%@",[dict objectForKey:@"scode"]);
    
}

-(void)notificationGetLoginData:(NSNotification *)notification{
    
//    NSDictionary  *dict=[notification userInfo];
    NSDictionary  *dict=[notification userInfo];
    NSLog(@"获取的uid值:%@",[dict objectForKey:@"uid"]);
    NSLog(@"获取的scode值:%@",[dict objectForKey:@"scode"]);
    [self.delegate channel_loginOrzOSDKSuccess:@{@"channel_uid":[dict objectForKey:@"uid"],
                                                 @"channel_username":@"",
                                                 @"channel_token":[dict objectForKey:@"scode"],
                                                 @"channel_deviceid":@""}];
}



-(void)notificationGetPayData:(NSNotification *)notification{
    NSDictionary  *dict=[notification userInfo];
    NSLog(@"获取的code值:%@",[dict objectForKey:@"code"]);
    NSLog(@"获取的mes值:%@",[dict objectForKey:@"mes"]);
    if([[dict objectForKey:@"code"] isEqualToString:@"1"]){
      //  [self.delegate channel_RegchargOrzOSDKSuccess:@{@"code":@"0",@"msg":@"已完成"}];
    }else{
      //  [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":@"已取消"}];
    }
}

-(void)doChannelshowOrzOSDKGameCenter{
    
}

-(void)doChannelshowOrzOSDKFloatView{
    
}

-(void)doChannelhideOrzOSDKFloatView{
    
}

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params{
    NSLog(@"OrzOSDKBranch_AnHuiGS doChannelRegcharg  !");
    XZRequestModelcdcn *model = [[XZRequestModelcdcn alloc]init];
    model.XZproductID = [params objectForKey:OrzOSDK_IOS_PRODUCT_ID];
    model.XZserverID = self.serverId;
    model.XZroleName = self.roleName;
    model.XZorderOn = [params objectForKey:OrzOSDK_IOS_ORDERID];
    model.XZgameName = self.gamename;
    model.XZgoodsNum = @"1";
    model.XZbody = [params objectForKey:OrzOSDK_IOS_PRODUCT_NAME];
    model.XZamount = [params objectForKey:OrzOSDK_IOS_PRODUCT_PRICE];
    model.XZRoleLevel = self.roleLevel;
    [XZsdkManagercdcn XZstartPayWithRequestModel:model];
    

}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    
    NSLog(@"doChannelSendGameData 1");
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
    self.roleName = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_NAME]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_LEVEL]];
    NSLog(@"doChannelSendGameData 2");
    XZRoleModelcdcn *model = [[XZRoleModelcdcn alloc]init];
    model.XZRoleName = [data objectForKey:OrzOSDK_ROLE_NAME];
    model.XZRoleLevel = [data objectForKey:OrzOSDK_ROLE_LEVEL];
    model.XZSerVerID = [data objectForKey:OrzOSDK_SERVER_ID];
    model.XZServerName = [data objectForKey:OrzOSDK_SERVER_NAME];
    
    
    [XZsdkManagercdcn XZUpdateRoleInfoWithRoleModel:model didSuccess:^(BOOL isUpdateRoleSuccess) {
        if (isUpdateRoleSuccess) {
            NSLog(@"更新角色信息成功");
        }else{
            NSLog(@"更新角色信息失败");
        }
    }];
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationGetLoginData:) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationGetPayData:) name:@"pay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationGetRegisterData:) name:@"register" object:nil];
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [XZsdkManagercdcn XZWillEnterForeground:application];
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
