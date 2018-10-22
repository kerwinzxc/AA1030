

#import "OrzOSDKBranch_39.h"
#import <SJIOS/SJIOSSdk.h>




@implementation OrzOSDKBranch_39

-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"3.4.3";
    
}


-(void)doOrzOSDKChannelInit{
    NSLog(@"OrzOSDKBranch_SanJHY doChannelInit !");
    
    self.isLogined = NO;
    self.loginViewIsShowing = NO;
    
    NSDictionary *NsDictionary = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
    
    [SJIOSSdk initSJIOS:[[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_Landscape]
            SJIOS_Appid:[NsDictionary objectForKey:@"OrzOSDK_APPID"]
           SJIOS_Appkey:[NsDictionary objectForKey:@"OrzOSDK_APPKEY"]
          SJIOS_Channel:[NsDictionary objectForKey:@"OrzOSDK_Channel"]
        SJIOS_Appsecret:[NsDictionary objectForKey:@"OrzOSDK_SecretKey"]
              SJIOS_Gid:[NsDictionary objectForKey:@"OrzOSDK_GID"]
         SJIOS_RYAppkey:[NsDictionary objectForKey:@"OrzOSDK_ReYun"]
        SJIOS_PackageId:[[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_PackageId]
                success:^(NSString* info){
                    NSLog(@"init success %@", info);
                    [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
                    
                    [SJIOSSdk checkSJIOSUpdate:[self getOrzOSDKCurrentView] successSJIOS:^(NSString * result) {
                        NSLog(@"checkUpdate success %@", result);
                    } failedSJIOS:^(int code){
                        NSLog(@"checkUpdate failed %d", code);
                    } landscapeSJIOS:YES];
                    
                } failed:^(int error){
                    NSLog(@"init failed %d", error);
                    [self.delegate channel_initOrzOSDKFail:@{@"code":@"-2",@"msg":@"failed"}];
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
    [self.delegate channel_openOrzOSDKUserCenter];
    
}


-(void)closeSJUserCenter:(NSNotification *)notification{
    NSLog(@"---closeSJUserCenter----");
    [self.delegate channel_closeOrzOSDKUserCenter];
    
}

-(void)doOrzOSDKChannelLogin{
    
    NSLog(@"OrzOSDKBranch doChannelLogin");
    if(self.loginViewIsShowing == NO){
        self.loginViewIsShowing = YES;
        [SJIOSSdk loginSJIOS:[self getOrzOSDKCurrentView] landscapeSJIOS:[[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_Landscape] successSJIOS:^(NSString* userInfo){
            
            
            NSError *error = nil;
            NSDictionary *dictionary = (NSDictionary *)userInfo;
            if (dictionary == nil)
            {
                NSLog(@"333");
                [self.delegate channel_loginOrzOSDKFail:@{@"code":@"-1",@"msg":@"loginfailed"}];
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
            
            [self.delegate channel_loginOrzOSDKSuccess:@{@"channel_uid":[dictionary objectForKey:@"userid"],
                                                         @"channel_username":@"",
                                                         @"channel_token":[dictionary objectForKey:@"accesstoken"],
                                                         @"channel_deviceid":@""}];
            [self doChannelhideOrzOSDKFloatView];
            [self doChannelshowOrzOSDKFloatView];
            
        } failedSJIOS:^(int error){
            NSLog(@"222");
            [self.delegate channel_loginOrzOSDKFail:@{@"code":@"-2",@"msg":@"loginfailed"}];
        }];
        
    }
    
    
}

-(void)doOrzOSDKChannelRealNameRegister:(int)flag callback:(OrzOSDKShiMimgRenZhengCallback)callbackxxx{
    [SJIOSSdk showSJIOSShiMingRenZhengView:self.accesstoken callbackSJIOS:^(NSString *callback){
        if(flag == 1){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_loginOrzOSDKSuccess:@{@"channel_uid":self.userId,
                                                             @"channel_username":@"",
                                                             @"channel_token":self.accesstoken,
                                                             @"channel_deviceid":@""}];
            }else{
                [self.delegate channel_loginOrzOSDKFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"1");
        }else if(flag == 2){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":@"请重新下单"}];
            }else{
                [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"2");
        }
    }];
}

-(void)doOrzOSDKChannelSwitchAccount{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [SJIOSSdk logoutSJIOS:[self getOrzOSDKCurrentView] successSJIOS:^(NSString *info){
            NSLog(@"logout success");
            
            [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
        }failedSJIOS:^(int error){
            NSLog(@"logout failed");
            
            [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"-1",@"msg":@"switch account failed"}];
        }];
    }
}


-(void)doOrzOSDKChannelLogout{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [self.delegate channel_logoutOrzOSDKSuccess:@{@"code":@"1",@"msg":@"logout success"}];
        [self doChannelhideOrzOSDKFloatView];
    }
    
}

-(void)doChannelshowOrzOSDKGameCenter{
    
}

-(void)doChannelshowOrzOSDKFloatView{
    [SJIOSSdk executeSJIOS:[self getOrzOSDKCurrentViewController] landscapeSJIOS:[[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_Landscape]];
}

-(void)doChannelhideOrzOSDKFloatView{
    [SJIOSSdk hideFloatSJIOS];
}

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params{
    
    NSLog(@"start py");
    
    NSMutableDictionary * sj_params = [NSMutableDictionary dictionary];
    [sj_params setValue:[params objectForKey:OrzOSDK_IOS_PRODUCT_NAME] forKey:SJIOS_PROTOCOL_PRODUCT_NAME];//商品名称，若无，则传商品价格
    [sj_params setValue:[params objectForKey:OrzOSDK_IOS_PRODUCT_ID] forKey:SJIOS_PROTOCOL_PRODUCT_ID];//苹果内购id
    [sj_params setValue:[params objectForKey:OrzOSDK_IOS_PRODUCT_PRICE] forKey:SJIOS_PROTOCOL_ACCOUNT];//商品价格
    [sj_params setValue:[[OrzOSDKUtils getSharedInstance] getOrzOSDKBundleId] forKey:SJIOS_PROTOCOL_APP_NAME];//应用名称，由提供
    [sj_params setValue:self.userId forKey:SJIOS_PROTOCOL_USER_ID];//用户id
    [sj_params setValue:[params objectForKey:OrzOSDK_IOS_ORDERID] forKey:SJIOS_PROTOCOL_APP_ORDER_ID];//游戏内订单号
    [sj_params setValue:self.serverId forKey:SJIOS_PROTOCOL_GATEWAY];//区服id
    [sj_params setValue:[params objectForKey:OrzOSDK_IOS_ORDERID] forKey:SJIOS_PROTOCOL_EXTEND_INFO];//透传信息，若无，则传1
    [sj_params setValue:self.roleId forKey:SJIOS_PROTOCOL_ROLE_ID];//角色id
    [sj_params setValue:self.roleLevel forKey:SJIOS_PROTOCOL_ROLE_LEVEL];//角色level
    [SJIOSSdk startPSJIOSy:[self getOrzOSDKCurrentViewController] landscapeSJIOS:[[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_Landscape] paramsSJIOS:sj_params successSJIOS:^(NSString * info) {
        NSLog(@"py:%@",info);
        [self.delegate channel_RegchargOrzOSDKSuccess:@{@"code":@"0",@"msg":info}];
        
    } failedSJIOS:^(int error) {
        NSLog(@"error:%d",error);
        NSString *err = [[NSString alloc] initWithFormat:@"%d", error];
        [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":err}];
    }];
    
    
}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_LEVEL]];
    if([dataPoint isEqualToString:OrzOSDK_SUBMIT_ROLE_CREATE]){
        [SJIOSSdk createRoleSJIOS:[data objectForKey:OrzOSDK_SERVER_ID] userIdSJIOS:self.userId roleIdSJIOS:[data objectForKey:OrzOSDK_ROLE_ID] roleLevelSJIOS:[data objectForKey:OrzOSDK_ROLE_LEVEL] successSJIOS:^(NSString *success) {
            NSLog(@"createRole:%@",success);
        } failedSJIOS:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:OrzOSDK_SUBMIT_ROLE_LEVELUP]){
        
        [SJIOSSdk levelupSJIOS:[data objectForKey:OrzOSDK_ROLE_LEVEL] serverNameSJIOS:[data objectForKey:OrzOSDK_SERVER_NAME] serveridSJIOS:[data objectForKey:OrzOSDK_SERVER_ID] userIdSJIOS:self.userId role_idSJIOS:[data objectForKey:OrzOSDK_ROLE_ID] roleNameSJIOS:[data objectForKey:OrzOSDK_ROLE_NAME] successSJIOS:^(NSString *success) {
            NSLog(@"roleLevelUp:%@",success);
        } failedSJIOS:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:OrzOSDK_SUBMIT_ROLE_ENTERSERVER]){
        [SJIOSSdk loginRoleSJIOS:[data objectForKey:OrzOSDK_SERVER_ID] userIdSJIOS:self.userId roleIdSJIOS:[data objectForKey:OrzOSDK_ROLE_ID]  roleLevelSJIOS:[data objectForKey:OrzOSDK_ROLE_LEVEL] successSJIOS:^(NSString *success) {
            NSLog(@"loginRole:%@",success);
            
        } failedSJIOS:^(int code) {
            
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
