

#import "ReleasbBranch_39.h"
#import <Rersistence/RersistenceSdk.h>




@implementation ReleasbBranch_39

-(NSString *)getReleasbChannelSdkVersion{
    return @"3.4.3";
    
}


-(void)doReleasbChannelInit{
    NSLog(@"ReleasbBranch_SanJHY doChannelInit !");
    
    self.isLogined = NO;
    self.loginViewIsShowing = NO;
    
    NSDictionary *NsDictionary = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ReleasbParams"];
    
    [RersistenceSdk initRersistence:[[ReleasbUtils getSharedInstance] getReleasbInfoPlist_Landscape]
            Rersistence_Appid:[NsDictionary objectForKey:@"Releasb_APPID"]
           Rersistence_Appkey:[NsDictionary objectForKey:@"Releasb_APPKEY"]
          Rersistence_Channel:[NsDictionary objectForKey:@"Releasb_Channel"]
        Rersistence_Appsecret:[NsDictionary objectForKey:@"Releasb_SecretKey"]
              Rersistence_Gid:[NsDictionary objectForKey:@"Releasb_GID"]
         Rersistence_RYAppkey:[NsDictionary objectForKey:@"Releasb_ReYun"]
        Rersistence_PackageId:[[ReleasbUtils getSharedInstance] getReleasbInfoPlist_PackageId]
                success:^(NSString* info){
                    NSLog(@"init success %@", info);
                    [self.delegate channel_initReleasbSuccess:@{@"code":@"1",@"msg":@"success"}];
                    
                    [RersistenceSdk checkRersistenceUpdate:[self getReleasbCurrentView] successRersistence:^(NSString * result) {
                        NSLog(@"checkUpdate success %@", result);
                    } failedRersistence:^(int code){
                        NSLog(@"checkUpdate failed %d", code);
                    } landscapeRersistence:YES];
                    
                } failed:^(int error){
                    NSLog(@"init failed %d", error);
                    [self.delegate channel_initReleasbFail:@{@"code":@"-2",@"msg":@"failed"}];
                }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerOK:) name:@"registerOK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openSJUserCenter:) name:@"openSJUserCenter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSJUserCenter:) name:@"closeSJUserCenter" object:nil];
    
}

//账号注册成功通知,notification.userInfo为账号id----
-(void)registerOK:(NSNotification *)notification{
    NSLog(@"-------");
    NSLog(@"-----------%@", notification.userInfo);
    
}

-(void)openSJUserCenter:(NSNotification *)notification{
    NSLog(@"---openSJUserCenter----");
    [self.delegate channel_openReleasbUserCenter];
    
}


-(void)closeSJUserCenter:(NSNotification *)notification{
    NSLog(@"---closeSJUserCenter----");
    [self.delegate channel_closeReleasbUserCenter];
    
}

-(void)doReleasbChannelLogin{
    
    NSLog(@"ReleasbBranch doChannelLogin");
    if(self.loginViewIsShowing == NO){
        self.loginViewIsShowing = YES;
        [RersistenceSdk loginRersistence:[self getReleasbCurrentView] landscapeRersistence:[[ReleasbUtils getSharedInstance] getReleasbInfoPlist_Landscape] successRersistence:^(NSString* userInfo){
            
            
            NSError *error = nil;
            NSDictionary *dictionary = (NSDictionary *)userInfo;
            if (dictionary == nil)
            {
                NSLog(@"333");
                [self.delegate channel_loginReleasbFail:@{@"code":@"-1",@"msg":@"loginfailed"}];
                return;
            }
            self.loginViewIsShowing = NO;
            self.isLogined = YES;
            
            
            self.userId = [dictionary objectForKey:@"userid"];
            self.accesstoken = [dictionary objectForKey:@"accesstoken"];
            NSString *username = [dictionary objectForKey:@"username"];
            
            NSLog(@"111  userid = %@", self.userId);
            NSLog(@"111  accesstoken = %@", self.accesstoken);
            NSLog(@"111  username = %@", username);
            
            [self.delegate channel_loginReleasbSuccess:@{@"channel_uid":[dictionary objectForKey:@"userid"],
                                                         @"channel_username":@"",
                                                         @"channel_token":[dictionary objectForKey:@"accesstoken"],
                                                         @"channel_deviceid":@""}];
            [self doChannelhideReleasbFloatView];
            [self doChannelshowReleasbFloatView];
            
        } failedRersistence:^(int error){
            NSLog(@"222");
            [self.delegate channel_loginReleasbFail:@{@"code":@"-2",@"msg":@"loginfailed"}];
        }];
        
    }
    
    
}

-(void)doReleasbChannelRealNameRegister:(int)flag callback:(ReleasbShiMimgRenZhengCallback)callbackxxx{
    [RersistenceSdk showRersistenceShiMingRenZhengView:self.accesstoken callbackRersistence:^(NSString *callback){
        if(flag == 1){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_loginReleasbSuccess:@{@"channel_uid":self.userId,
                                                             @"channel_username":@"",
                                                             @"channel_token":self.accesstoken,
                                                             @"channel_deviceid":@""}];
            }else{
                [self.delegate channel_loginReleasbFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"1");
        }else if(flag == 2){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_RegchargReleasbFail:@{@"code":@"-2",@"msg":@"请重新下单"}];
            }else{
                [self.delegate channel_RegchargReleasbFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"2");
        }
    }];
}

-(void)doReleasbChannelSwitchAccount{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [RersistenceSdk logoutRersistence:[self getReleasbCurrentView] successRersistence:^(NSString *info){
            NSLog(@"logout success");
            
            [self.delegate channel_logoutReleasbSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
        }failedRersistence:^(int error){
            NSLog(@"logout failed");
            
            [self.delegate channel_logoutReleasbSuccess:@{@"code":@"-1",@"msg":@"switch account failed"}];
        }];
    }
}


-(void)doReleasbChannelLogout{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [self.delegate channel_logoutReleasbSuccess:@{@"code":@"1",@"msg":@"logout success"}];
        [self doChannelhideReleasbFloatView];
    }
    
}

-(void)doChannelshowReleasbGameCenter{
    
}

-(void)doChannelshowReleasbFloatView{
    [RersistenceSdk executeRersistence:[self getReleasbCurrentViewController] landscapeRersistence:[[ReleasbUtils getSharedInstance] getReleasbInfoPlist_Landscape]];
}

-(void)doChannelhideReleasbFloatView{
    [RersistenceSdk hideFloatRersistence];
}

-(void)doReleasbChannelRegcharg:(NSDictionary *)params{
    
    NSLog(@"start py");
    
    NSMutableDictionary * sj_params = [NSMutableDictionary dictionary];
    [sj_params setValue:[params objectForKey:Releasb_IOS_PRODUCT_NAME] forKey:Rersistence_PROTOCOL_PRODUCT_NAME];//商品名称，若无，则传商品价格
    [sj_params setValue:[params objectForKey:Releasb_IOS_PRODUCT_ID] forKey:Rersistence_PROTOCOL_PRODUCT_ID];//苹果内购id
    [sj_params setValue:[params objectForKey:Releasb_IOS_PRODUCT_PRICE] forKey:Rersistence_PROTOCOL_ACCOUNT];//商品价格
    [sj_params setValue:[[ReleasbUtils getSharedInstance] getReleasbBundleId] forKey:Rersistence_PROTOCOL_APP_NAME];//应用名称，由提供
    [sj_params setValue:self.userId forKey:Rersistence_PROTOCOL_USER_ID];//用户id
    [sj_params setValue:[params objectForKey:Releasb_IOS_ORDERID] forKey:Rersistence_PROTOCOL_APP_ORDER_ID];//游戏内订单号
    [sj_params setValue:self.serverId forKey:Rersistence_PROTOCOL_GATEWAY];//区服id
    [sj_params setValue:[params objectForKey:Releasb_IOS_ORDERID] forKey:Rersistence_PROTOCOL_EXTEND_INFO];//透传信息，若无，则传1
    [sj_params setValue:self.roleId forKey:Rersistence_PROTOCOL_ROLE_ID];//角色id
    [sj_params setValue:self.roleLevel forKey:Rersistence_PROTOCOL_ROLE_LEVEL];//角色level
    [RersistenceSdk startPRersistencey:[self getReleasbCurrentViewController] landscapeRersistence:[[ReleasbUtils getSharedInstance] getReleasbInfoPlist_Landscape] paramsRersistence:sj_params successRersistence:^(NSString * info) {
        NSLog(@"py:%@",info);
        [self.delegate channel_RegchargReleasbSuccess:@{@"code":@"0",@"msg":info}];
        
    } failedRersistence:^(int error) {
        NSLog(@"error:%d",error);
        NSString *err = [[NSString alloc] initWithFormat:@"%d", error];
        [self.delegate channel_RegchargReleasbFail:@{@"code":@"-2",@"msg":err}];
    }];
    
    
}

-(void)doReleasbChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Releasb_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Releasb_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Releasb_ROLE_LEVEL]];
    if([dataPoint isEqualToString:Releasb_SUBMIT_ROLE_CREATE]){
        [RersistenceSdk createRoleRersistence:[data objectForKey:Releasb_SERVER_ID] userIdRersistence:self.userId roleIdRersistence:[data objectForKey:Releasb_ROLE_ID] roleLevelRersistence:[data objectForKey:Releasb_ROLE_LEVEL] successRersistence:^(NSString *success) {
            NSLog(@"createRole:%@",success);
        } failedRersistence:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Releasb_SUBMIT_ROLE_LEVELUP]){
        
        [RersistenceSdk levelupRersistence:[data objectForKey:Releasb_ROLE_LEVEL] serverNameRersistence:[data objectForKey:Releasb_SERVER_NAME] serveridRersistence:[data objectForKey:Releasb_SERVER_ID] userIdRersistence:self.userId role_idRersistence:[data objectForKey:Releasb_ROLE_ID] roleNameRersistence:[data objectForKey:Releasb_ROLE_NAME] successRersistence:^(NSString *success) {
            NSLog(@"roleLevelUp:%@",success);
        } failedRersistence:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Releasb_SUBMIT_ROLE_ENTERSERVER]){
        [RersistenceSdk loginRoleRersistence:[data objectForKey:Releasb_SERVER_ID] userIdRersistence:self.userId roleIdRersistence:[data objectForKey:Releasb_ROLE_ID]  roleLevelRersistence:[data objectForKey:Releasb_ROLE_LEVEL] successRersistence:^(NSString *success) {
            NSLog(@"loginRole:%@",success);
            
        } failedRersistence:^(int code) {
            
        }];
    }
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


@end
