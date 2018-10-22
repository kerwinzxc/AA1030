

#import "PunctuationBranch_39.h"
#import <Postin/PostinSdk.h>




@implementation PunctuationBranch_39

-(NSString *)getPunctuationChannelSdkVersion{
    return @"3.4.3";
    
}


-(void)doPunctuationChannelInit{
    NSLog(@"PunctuationBranch_SanJHY doChannelInit !");
    
    self.isLogined = NO;
    self.loginViewIsShowing = NO;
    
    NSDictionary *NsDictionary = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PunctuationParams"];
    
    [PostinSdk initPostin:[[PunctuationUtils getSharedInstance] getPunctuationInfoPlist_Landscape]
            Postin_Appid:[NsDictionary objectForKey:@"Punctuation_APPID"]
           Postin_Appkey:[NsDictionary objectForKey:@"Punctuation_APPKEY"]
          Postin_Channel:[NsDictionary objectForKey:@"Punctuation_Channel"]
        Postin_Appsecret:[NsDictionary objectForKey:@"Punctuation_SecretKey"]
              Postin_Gid:[NsDictionary objectForKey:@"Punctuation_GID"]
         Postin_RYAppkey:[NsDictionary objectForKey:@"Punctuation_ReYun"]
        Postin_PackageId:[[PunctuationUtils getSharedInstance] getPunctuationInfoPlist_PackageId]
                success:^(NSString* info){
                    NSLog(@"init success %@", info);
                    [self.delegate channel_initPunctuationSuccess:@{@"code":@"1",@"msg":@"success"}];
                    
                    [PostinSdk checkPostinUpdate:[self getPunctuationCurrentView] successPostin:^(NSString * result) {
                        NSLog(@"checkUpdate success %@", result);
                    } failedPostin:^(int code){
                        NSLog(@"checkUpdate failed %d", code);
                    } landscapePostin:YES];
                    
                } failed:^(int error){
                    NSLog(@"init failed %d", error);
                    [self.delegate channel_initPunctuationFail:@{@"code":@"-2",@"msg":@"failed"}];
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
    [self.delegate channel_openPunctuationUserCenter];
    
}


-(void)closeSJUserCenter:(NSNotification *)notification{
    NSLog(@"---closeSJUserCenter----");
    [self.delegate channel_closePunctuationUserCenter];
    
}

-(void)doPunctuationChannelLogin{
    
    NSLog(@"PunctuationBranch doChannelLogin");
    if(self.loginViewIsShowing == NO){
        self.loginViewIsShowing = YES;
        [PostinSdk loginPostin:[self getPunctuationCurrentView] landscapePostin:[[PunctuationUtils getSharedInstance] getPunctuationInfoPlist_Landscape] successPostin:^(NSString* userInfo){
            
            
            NSError *error = nil;
            NSDictionary *dictionary = (NSDictionary *)userInfo;
            if (dictionary == nil)
            {
                NSLog(@"333");
                [self.delegate channel_loginPunctuationFail:@{@"code":@"-1",@"msg":@"loginfailed"}];
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
            
            [self.delegate channel_loginPunctuationSuccess:@{@"channel_uid":[dictionary objectForKey:@"userid"],
                                                         @"channel_username":@"",
                                                         @"channel_token":[dictionary objectForKey:@"accesstoken"],
                                                         @"channel_deviceid":@""}];
            [self doChannelhidePunctuationFloatView];
            [self doChannelshowPunctuationFloatView];
            
        } failedPostin:^(int error){
            NSLog(@"222");
            [self.delegate channel_loginPunctuationFail:@{@"code":@"-2",@"msg":@"loginfailed"}];
        }];
        
    }
    
    
}

-(void)doPunctuationChannelRealNameRegister:(int)flag callback:(PunctuationShiMimgRenZhengCallback)callbackxxx{
    [PostinSdk showPostinShiMingRenZhengView:self.accesstoken callbackPostin:^(NSString *callback){
        if(flag == 1){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_loginPunctuationSuccess:@{@"channel_uid":self.userId,
                                                             @"channel_username":@"",
                                                             @"channel_token":self.accesstoken,
                                                             @"channel_deviceid":@""}];
            }else{
                [self.delegate channel_loginPunctuationFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"1");
        }else if(flag == 2){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_RegchargPunctuationFail:@{@"code":@"-2",@"msg":@"请重新下单"}];
            }else{
                [self.delegate channel_RegchargPunctuationFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"2");
        }
    }];
}

-(void)doPunctuationChannelSwitchAccount{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [PostinSdk logoutPostin:[self getPunctuationCurrentView] successPostin:^(NSString *info){
            NSLog(@"logout success");
            
            [self.delegate channel_logoutPunctuationSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
        }failedPostin:^(int error){
            NSLog(@"logout failed");
            
            [self.delegate channel_logoutPunctuationSuccess:@{@"code":@"-1",@"msg":@"switch account failed"}];
        }];
    }
}


-(void)doPunctuationChannelLogout{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [self.delegate channel_logoutPunctuationSuccess:@{@"code":@"1",@"msg":@"logout success"}];
        [self doChannelhidePunctuationFloatView];
    }
    
}

-(void)doChannelshowPunctuationGameCenter{
    
}

-(void)doChannelshowPunctuationFloatView{
    [PostinSdk executePostin:[self getPunctuationCurrentViewController] landscapePostin:[[PunctuationUtils getSharedInstance] getPunctuationInfoPlist_Landscape]];
}

-(void)doChannelhidePunctuationFloatView{
    [PostinSdk hideFloatPostin];
}

-(void)doPunctuationChannelRegcharg:(NSDictionary *)params{
    
    NSLog(@"start py");
    
    NSMutableDictionary * sj_params = [NSMutableDictionary dictionary];
    [sj_params setValue:[params objectForKey:Punctuation_IOS_PRODUCT_NAME] forKey:Postin_PROTOCOL_PRODUCT_NAME];//商品名称，若无，则传商品价格
    [sj_params setValue:[params objectForKey:Punctuation_IOS_PRODUCT_ID] forKey:Postin_PROTOCOL_PRODUCT_ID];//苹果内购id
    [sj_params setValue:[params objectForKey:Punctuation_IOS_PRODUCT_PRICE] forKey:Postin_PROTOCOL_ACCOUNT];//商品价格
    [sj_params setValue:[[PunctuationUtils getSharedInstance] getPunctuationBundleId] forKey:Postin_PROTOCOL_APP_NAME];//应用名称，由提供
    [sj_params setValue:self.userId forKey:Postin_PROTOCOL_USER_ID];//用户id
    [sj_params setValue:[params objectForKey:Punctuation_IOS_ORDERID] forKey:Postin_PROTOCOL_APP_ORDER_ID];//游戏内订单号
    [sj_params setValue:self.serverId forKey:Postin_PROTOCOL_GATEWAY];//区服id
    [sj_params setValue:[params objectForKey:Punctuation_IOS_ORDERID] forKey:Postin_PROTOCOL_EXTEND_INFO];//透传信息，若无，则传1
    [sj_params setValue:self.roleId forKey:Postin_PROTOCOL_ROLE_ID];//角色id
    [sj_params setValue:self.roleLevel forKey:Postin_PROTOCOL_ROLE_LEVEL];//角色level
    [PostinSdk startPPostiny:[self getPunctuationCurrentViewController] landscapePostin:[[PunctuationUtils getSharedInstance] getPunctuationInfoPlist_Landscape] paramsPostin:sj_params successPostin:^(NSString * info) {
        NSLog(@"py:%@",info);
        [self.delegate channel_RegchargPunctuationSuccess:@{@"code":@"0",@"msg":info}];
        
    } failedPostin:^(int error) {
        NSLog(@"error:%d",error);
        NSString *err = [[NSString alloc] initWithFormat:@"%d", error];
        [self.delegate channel_RegchargPunctuationFail:@{@"code":@"-2",@"msg":err}];
    }];
    
    
}

-(void)doPunctuationChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Punctuation_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Punctuation_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Punctuation_ROLE_LEVEL]];
    if([dataPoint isEqualToString:Punctuation_SUBMIT_ROLE_CREATE]){
        [PostinSdk createRolePostin:[data objectForKey:Punctuation_SERVER_ID] userIdPostin:self.userId roleIdPostin:[data objectForKey:Punctuation_ROLE_ID] roleLevelPostin:[data objectForKey:Punctuation_ROLE_LEVEL] successPostin:^(NSString *success) {
            NSLog(@"createRole:%@",success);
        } failedPostin:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Punctuation_SUBMIT_ROLE_LEVELUP]){
        
        [PostinSdk levelupPostin:[data objectForKey:Punctuation_ROLE_LEVEL] serverNamePostin:[data objectForKey:Punctuation_SERVER_NAME] serveridPostin:[data objectForKey:Punctuation_SERVER_ID] userIdPostin:self.userId role_idPostin:[data objectForKey:Punctuation_ROLE_ID] roleNamePostin:[data objectForKey:Punctuation_ROLE_NAME] successPostin:^(NSString *success) {
            NSLog(@"roleLevelUp:%@",success);
        } failedPostin:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Punctuation_SUBMIT_ROLE_ENTERSERVER]){
        [PostinSdk loginRolePostin:[data objectForKey:Punctuation_SERVER_ID] userIdPostin:self.userId roleIdPostin:[data objectForKey:Punctuation_ROLE_ID]  roleLevelPostin:[data objectForKey:Punctuation_ROLE_LEVEL] successPostin:^(NSString *success) {
            NSLog(@"loginRole:%@",success);
            
        } failedPostin:^(int code) {
            
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
