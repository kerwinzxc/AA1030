
#import "XRetoolLegendBranch_okwan.h"


@implementation XRetoolLegendBranch_okwan


-(NSString *)getXRetoolLegendChannelSdkVersion{
    return @"1.0";
}

-(void)doXRetoolLegendChannelInit{
    NSLog(@"XRetoolLegendBranch_okwan doChannelInit  !");
    self.IsClickedLogin = NO;
    self.IsLoginSuccess = NO;
   
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"XRetoolLegendParams"];
    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
    self.gid = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_okwan_gid"]];
    self.apikey = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_okwan_apikey"]];
    self.secretkey = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_okwan_secretkey"]];
    self.gamename = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_okwan_gamename"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationGetLoginData:) name:@"login" object:nil];
    
    [self.delegate channel_initXRetoolLegendSuccess:@{@"code":@"1",@"msg":@"success"}];
    
}

-(void)doXRetoolLegendChannelLogin{
    
    NSLog(@"XRetoolLegendBranch_okwan doChannelLogin");
    
    if(self.IsClickedLogin == NO){
        self.IsClickedLogin = YES;
        [SLEsdkManagerLEfile SLEstartLoginWithGid:self.gid apiKey:self.apikey secretKey:self.secretkey version:[[XRetoolLegendUtils getSharedInstance] getXRetoolLegendAppVersion]];
        [SLEsdkManagerLEfile SLEReVerifyToService];//向服务器再次发起验证凭证
    }
}

-(void)doXRetoolLegendChannelSwitchAccount{
    
}


-(void)doXRetoolLegendChannelLogout{
    [SLEsdkManagerLEfile SLELoginOutDidSuccess:^(BOOL isSuccess) {
        
        if (isSuccess) {
            NSLog(@"注销成功");
            if(self.IsLoginSuccess == YES){
                self.IsLoginSuccess = NO;
                self.IsClickedLogin = NO;
            }
            [self.delegate channel_logoutXRetoolLegendSuccess:@{@"code":@"1",@"msg":@"logout success"}];
        }else{
            NSLog(@"注销失败");
        }
    }];
}

- (void)notificationGetRegisterData:(NSNotification *)notification {
    NSDictionary  *dict=[notification userInfo];
    NSLog(@"注册获取的uid值:%@",[dict objectForKey:@"uid"]);
    NSLog(@"注册获取的scode值:%@",[dict objectForKey:@"scode"]);
}

-(void)notificationGetLoginData:(NSNotification *)notification{
    if(self.IsClickedLogin == YES){
        self.IsLoginSuccess = NO;
        self.IsClickedLogin = NO;
        NSDictionary  *dict=[notification userInfo];
        NSLog(@"获取的uid值:%@",[dict objectForKey:@"uid"]);
        NSLog(@"获取的scode值:%@",[dict objectForKey:@"scode"]);
        [self.delegate channel_loginXRetoolLegendSuccess:@{@"channel_uid":[dict objectForKey:@"uid"],
                                                           @"channel_username":@"",
                                                           @"channel_token":[dict objectForKey:@"scode"],
                                                           @"channel_deviceid":@""}];
    }
}



-(void)notificationGetPayData:(NSNotification *)notification{
    NSDictionary  *dict=[notification userInfo];
    NSLog(@"获取的code值:%@",[dict objectForKey:@"code"]);
    NSLog(@"获取的mes值:%@",[dict objectForKey:@"mes"]);
    if([[dict objectForKey:@"code"] isEqualToString:@"1"]){
        [self.delegate channel_RegchargXRetoolLegendSuccess:@{@"code":@"0",@"msg":@"已完成"}];
    }else{
        [self.delegate channel_RegchargXRetoolLegendFail:@{@"code":@"-2",@"msg":@"已取消"}];
    }
}
-(void)doChannelshowXRetoolLegendGameCenter{
    
}

-(void)doChannelshowXRetoolLegendFloatView{
    
}

-(void)doChannelhideXRetoolLegendFloatView{
    
}

-(void)doXRetoolLegendChannelRegcharg:(NSDictionary *)params{
    SLERequestModelLEfile *model = [[SLERequestModelLEfile alloc]init];
    model.SLEproductID = [params objectForKey:XRetoolLegend_IOS_PRODUCT_ID];
    model.SLEserverID = self.serverId;
    model.SLEroleName = self.roleName;
    model.SLEorderOn = [params objectForKey:XRetoolLegend_IOS_ORDERID];
    model.SLEgameName = self.gamename;
    model.SLEgoodsNum = @"1";
    model.SLEbody = [params objectForKey:XRetoolLegend_IOS_PRODUCT_NAME];
    model.SLEamount = [params objectForKey:XRetoolLegend_IOS_PRODUCT_PRICE];
    [SLEsdkManagerLEfile SLEstartPayWithRequestModel:model];

}

-(void)doXRetoolLegendChannelRealNameRegister:(int)flag{
    
}

-(void)doXRetoolLegendChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    NSLog(@"doChannelSendGameData 1");
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:XRetoolLegend_SERVER_ID]];
    self.roleName = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:XRetoolLegend_ROLE_NAME]];
    NSLog(@"doChannelSendGameData 2");
//    KXWRoleModel *model = [[KXWRoleModel alloc]init];
    SLERoleModelLEfile *model = [[SLERoleModelLEfile alloc]init];
    model.SLERoleName = [data objectForKey:XRetoolLegend_ROLE_NAME];
    model.SLERoleLevel = [data objectForKey:XRetoolLegend_ROLE_LEVEL];
    model.SLESerVerID = [data objectForKey:XRetoolLegend_SERVER_ID];
    model.SLEServerName = [data objectForKey:XRetoolLegend_SERVER_NAME];
    NSLog(@"doChannelSendGameData 3");
    NSLog(@"doChannelSendGameData , roleName = %@", model.SLERoleName);
    NSLog(@"doChannelSendGameData , KXWRoleLevel = %@", model.SLERoleLevel);
    NSLog(@"doChannelSendGameData , KXWSerVerID = %@", model.SLESerVerID);
    NSLog(@"doChannelSendGameData , KXWServerName = %@", model.SLEServerName);
    
    [SLEsdkManagerLEfile SLEUpdateRoleInfoWithRoleModel:model didSuccess:^(BOOL isUpdateRoleSuccess) {
        if (isUpdateRoleSuccess) {
            NSLog(@"更新角色信息成功");
        }else{
            NSLog(@"更新角色信息失败");
        }
    }];
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [SLEsdkManagerLEfile SLEWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}
- (void)applicationWillTerminate:(UIApplication *)application{
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [SLEsdkManagerLEfile application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [SLEsdkManagerLEfile application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return TRUE;
}


@end
