

#import "EasterBranch_39.h"
#import <Usequence/UsequenceSdk.h>




@implementation EasterBranch_39

-(NSString *)getEasterChannelSdkVersion{
    return @"3.4.3";
    
}


-(void)doEasterChannelInit{
    NSLog(@"EasterBranch_SanJHY doChannelInit !");
    
    self.isLogined = NO;
    self.loginViewIsShowing = NO;
    
    NSDictionary *NsDictionary = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EasterParams"];
    
    [UsequenceSdk initUsequence:[[EasterUtils getSharedInstance] getEasterInfoPlist_Landscape]
            Usequence_Appid:[NsDictionary objectForKey:@"Easter_APPID"]
           Usequence_Appkey:[NsDictionary objectForKey:@"Easter_APPKEY"]
          Usequence_Channel:[NsDictionary objectForKey:@"Easter_Channel"]
        Usequence_Appsecret:[NsDictionary objectForKey:@"Easter_SecretKey"]
              Usequence_Gid:[NsDictionary objectForKey:@"Easter_GID"]
         Usequence_RYAppkey:[NsDictionary objectForKey:@"Easter_ReYun"]
        Usequence_PackageId:[[EasterUtils getSharedInstance] getEasterInfoPlist_PackageId]
                success:^(NSString* info){
                    NSLog(@"init success %@", info);
                    [self.delegate channel_initEasterSuccess:@{@"code":@"1",@"msg":@"success"}];
                    
                    [UsequenceSdk checkUsequenceUpdate:[self getEasterCurrentView] successUsequence:^(NSString * result) {
                        NSLog(@"checkUpdate success %@", result);
                    } failedUsequence:^(int code){
                        NSLog(@"checkUpdate failed %d", code);
                    } landscapeUsequence:YES];
                    
                } failed:^(int error){
                    NSLog(@"init failed %d", error);
                    [self.delegate channel_initEasterFail:@{@"code":@"-2",@"msg":@"failed"}];
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
    [self.delegate channel_openEasterUserCenter];
    
}


-(void)closeSJUserCenter:(NSNotification *)notification{
    NSLog(@"---closeSJUserCenter----");
    [self.delegate channel_closeEasterUserCenter];
    
}

-(void)doEasterChannelLogin{
    
    NSLog(@"EasterBranch doChannelLogin");
    if(self.loginViewIsShowing == NO){
        self.loginViewIsShowing = YES;
        [UsequenceSdk loginUsequence:[self getEasterCurrentView] landscapeUsequence:[[EasterUtils getSharedInstance] getEasterInfoPlist_Landscape] successUsequence:^(NSString* userInfo){
            
            
            NSError *error = nil;
            NSDictionary *dictionary = (NSDictionary *)userInfo;
            if (dictionary == nil)
            {
                NSLog(@"333");
                [self.delegate channel_loginEasterFail:@{@"code":@"-1",@"msg":@"loginfailed"}];
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
            
            [self.delegate channel_loginEasterSuccess:@{@"channel_uid":[dictionary objectForKey:@"userid"],
                                                         @"channel_username":@"",
                                                         @"channel_token":[dictionary objectForKey:@"accesstoken"],
                                                         @"channel_deviceid":@""}];
            [self doChannelhideEasterFloatView];
            [self doChannelshowEasterFloatView];
            
        } failedUsequence:^(int error){
            NSLog(@"222");
            [self.delegate channel_loginEasterFail:@{@"code":@"-2",@"msg":@"loginfailed"}];
        }];
        
    }
    
    
}

-(void)doEasterChannelRealNameRegister:(int)flag callback:(EasterShiMimgRenZhengCallback)callbackxxx{
    [UsequenceSdk showUsequenceShiMingRenZhengView:self.accesstoken callbackUsequence:^(NSString *callback){
        if(flag == 1){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_loginEasterSuccess:@{@"channel_uid":self.userId,
                                                             @"channel_username":@"",
                                                             @"channel_token":self.accesstoken,
                                                             @"channel_deviceid":@""}];
            }else{
                [self.delegate channel_loginEasterFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"1");
        }else if(flag == 2){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_RegchargEasterFail:@{@"code":@"-2",@"msg":@"请重新下单"}];
            }else{
                [self.delegate channel_RegchargEasterFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"2");
        }
    }];
}

-(void)doEasterChannelSwitchAccount{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [UsequenceSdk logoutUsequence:[self getEasterCurrentView] successUsequence:^(NSString *info){
            NSLog(@"logout success");
            
            [self.delegate channel_logoutEasterSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
        }failedUsequence:^(int error){
            NSLog(@"logout failed");
            
            [self.delegate channel_logoutEasterSuccess:@{@"code":@"-1",@"msg":@"switch account failed"}];
        }];
    }
}


-(void)doEasterChannelLogout{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [self.delegate channel_logoutEasterSuccess:@{@"code":@"1",@"msg":@"logout success"}];
        [self doChannelhideEasterFloatView];
    }
    
}

-(void)doChannelshowEasterGameCenter{
    
}

-(void)doChannelshowEasterFloatView{
    [UsequenceSdk executeUsequence:[self getEasterCurrentViewController] landscapeUsequence:[[EasterUtils getSharedInstance] getEasterInfoPlist_Landscape]];
}

-(void)doChannelhideEasterFloatView{
    [UsequenceSdk hideFloatUsequence];
}

-(void)doEasterChannelRegcharg:(NSDictionary *)params{
    
    NSLog(@"start py");
    
    NSMutableDictionary * sj_params = [NSMutableDictionary dictionary];
    [sj_params setValue:[params objectForKey:Easter_IOS_PRODUCT_NAME] forKey:Usequence_PROTOCOL_PRODUCT_NAME];//商品名称，若无，则传商品价格
    [sj_params setValue:[params objectForKey:Easter_IOS_PRODUCT_ID] forKey:Usequence_PROTOCOL_PRODUCT_ID];//苹果内购id
    [sj_params setValue:[params objectForKey:Easter_IOS_PRODUCT_PRICE] forKey:Usequence_PROTOCOL_ACCOUNT];//商品价格
    [sj_params setValue:[[EasterUtils getSharedInstance] getEasterBundleId] forKey:Usequence_PROTOCOL_APP_NAME];//应用名称，由提供
    [sj_params setValue:self.userId forKey:Usequence_PROTOCOL_USER_ID];//用户id
    [sj_params setValue:[params objectForKey:Easter_IOS_ORDERID] forKey:Usequence_PROTOCOL_APP_ORDER_ID];//游戏内订单号
    [sj_params setValue:self.serverId forKey:Usequence_PROTOCOL_GATEWAY];//区服id
    [sj_params setValue:[params objectForKey:Easter_IOS_ORDERID] forKey:Usequence_PROTOCOL_EXTEND_INFO];//透传信息，若无，则传1
    [sj_params setValue:self.roleId forKey:Usequence_PROTOCOL_ROLE_ID];//角色id
    [sj_params setValue:self.roleLevel forKey:Usequence_PROTOCOL_ROLE_LEVEL];//角色level
    [UsequenceSdk startPUsequencey:[self getEasterCurrentViewController] landscapeUsequence:[[EasterUtils getSharedInstance] getEasterInfoPlist_Landscape] paramsUsequence:sj_params successUsequence:^(NSString * info) {
        NSLog(@"py:%@",info);
        [self.delegate channel_RegchargEasterSuccess:@{@"code":@"0",@"msg":info}];
        
    } failedUsequence:^(int error) {
        NSLog(@"error:%d",error);
        NSString *err = [[NSString alloc] initWithFormat:@"%d", error];
        [self.delegate channel_RegchargEasterFail:@{@"code":@"-2",@"msg":err}];
    }];
    
    
}

-(void)doEasterChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Easter_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Easter_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Easter_ROLE_LEVEL]];
    if([dataPoint isEqualToString:Easter_SUBMIT_ROLE_CREATE]){
        [UsequenceSdk createRoleUsequence:[data objectForKey:Easter_SERVER_ID] userIdUsequence:self.userId roleIdUsequence:[data objectForKey:Easter_ROLE_ID] roleLevelUsequence:[data objectForKey:Easter_ROLE_LEVEL] successUsequence:^(NSString *success) {
            NSLog(@"createRole:%@",success);
        } failedUsequence:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Easter_SUBMIT_ROLE_LEVELUP]){
        
        [UsequenceSdk levelupUsequence:[data objectForKey:Easter_ROLE_LEVEL] serverNameUsequence:[data objectForKey:Easter_SERVER_NAME] serveridUsequence:[data objectForKey:Easter_SERVER_ID] userIdUsequence:self.userId role_idUsequence:[data objectForKey:Easter_ROLE_ID] roleNameUsequence:[data objectForKey:Easter_ROLE_NAME] successUsequence:^(NSString *success) {
            NSLog(@"roleLevelUp:%@",success);
        } failedUsequence:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Easter_SUBMIT_ROLE_ENTERSERVER]){
        [UsequenceSdk loginRoleUsequence:[data objectForKey:Easter_SERVER_ID] userIdUsequence:self.userId roleIdUsequence:[data objectForKey:Easter_ROLE_ID]  roleLevelUsequence:[data objectForKey:Easter_ROLE_LEVEL] successUsequence:^(NSString *success) {
            NSLog(@"loginRole:%@",success);
            
        } failedUsequence:^(int code) {
            
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
