

#import "Gharge.h"
#import "GhargeBranch.h"
#import "GhargeUtils.h"
#import "GhargeNoticeView.h"
#import "GhargeReachability.h"
#import "startGhargeIapProcess.h"

@interface Gharge()<GhargeBranchDelegate>


@end

@implementation Gharge

+(Gharge*)getSharedInstance
{
    static __strong Gharge * targetSDK = nil;
    if (targetSDK == nil)
    {
        targetSDK = [Gharge alloc];
    }
    
    return targetSDK;
}


-(void)initGharge{
    //检测网络状态
    self.GhargenetWorkIsOK = [self isGhargeConnectionAvailable];
    if(self.GhargenetWorkIsOK == YES){
        //检测结果
        //发送激活数据
        [[GhargeUtils getSharedInstance] postGhargeActiveData];
        
        
        //渠道初始化
        [GhargeBranch getSharedInstance].delegate = self;
        [[GhargeBranch getSharedInstance] doGhargeChannelInit];
    }else{
       
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"网络问题" message:@"网络连接失败，请检查您的网络连接后重试。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"重新连接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //响应事件
            [self initGharge];
        }];
        [alert addAction:defaultAction];
        [[[GhargeBranch getSharedInstance] getGhargeCurrentViewController] presentViewController:alert animated:YES completion:nil];
    }

    
    
    
    NSLog(@"getGhargeNetIsp : %@" , [[GhargeUtils getSharedInstance] getGhargeNetIsp]);
    NSLog(@"getGhargeNetworktype : %@" , [[GhargeUtils getSharedInstance] getGhargeNetworktype]);
    NSLog(@"getGhargeSystemVersion : %@" , [[GhargeUtils getSharedInstance] getGhargeSystemVersion]);
    NSLog(@"getGhargeIdfa : %@" , [[GhargeUtils getSharedInstance] getGhargeIdfa]);
    NSLog(@"getGhargeIdfv : %@" , [[GhargeUtils getSharedInstance] getGhargeIdfv]);
    NSLog(@"getGhargeUUID : %@" , [[GhargeUtils getSharedInstance] getGhargeUUID]);
    
    NSLog(@"getGhargePhoneUserName : %@" , [[GhargeUtils getSharedInstance] getGhargePhoneUserName]);
    NSLog(@"getGhargeDeviceName : %@" , [[GhargeUtils getSharedInstance] getGhargeDeviceName]);
    NSLog(@"getGhargeDeviceModel : %@" , [[GhargeUtils getSharedInstance] getGhargeDeviceModel]);
    NSLog(@"getGhargeLocalPhoneModel : %@" , [[GhargeUtils getSharedInstance] getGhargeLocalPhoneModel]);
    NSLog(@"getGhargeBundleId : %@" , [[GhargeUtils getSharedInstance] getGhargeBundleId]);
    NSLog(@"getGhargeAppName : %@" , [[GhargeUtils getSharedInstance] getGhargeAppName]);
    NSLog(@"getGhargeAppVersion : %@" , [[GhargeUtils getSharedInstance] getGhargeAppVersion]);
    NSLog(@"getGhargeAppBuildVersion : %@" , [[GhargeUtils getSharedInstance] getGhargeAppBuildVersion]);
    NSLog(@"getGhargeVersion : %@" , [[GhargeUtils getSharedInstance] getGhargeVersion]);
    NSLog(@"getGhargeChannelSdkVersion : %@" , [[GhargeUtils getSharedInstance] getGhargeChannelSdkVersion]);
    
    
    
    
}

-(void)startGhargeLogin{
    [[GhargeBranch getSharedInstance] doGhargeChannelLogin];
}

-(void)startGhargeSwitchAccount{
    [[GhargeBranch getSharedInstance] doGhargeChannelSwitchAccount];
}

-(void)startGhargeLogout{
    [[GhargeBranch getSharedInstance] doGhargeChannelLogout];
}

-(void)showGhargeGameCenter{
    [[GhargeBranch getSharedInstance] doChannelshowGhargeGameCenter];
}

-(void)showGhargeFloatView{
    [[GhargeBranch getSharedInstance] doChannelshowGhargeFloatView];
}

-(void)hideGhargeFloatView{
    [[GhargeBranch getSharedInstance] doChannelhideGhargeFloatView];
}


-(void)startGhargeRegcharg:(NSDictionary *)params{
    [[GhargeUtils getSharedInstance] doGhargeCreateOder:params buildGhargeodcb:^(NSDictionary *buildGhargeodcb){
        if([[buildGhargeodcb objectForKey:@"code"] intValue] == 0){
            NSMutableDictionary *params_final = [[NSMutableDictionary alloc] initWithDictionary:params];
            [params_final setValue:[buildGhargeodcb objectForKey:@"oder_id"] forKey:Gharge_IOS_ORDERID];
            [params_final setValue:[buildGhargeodcb objectForKey:@"product_id"] forKey:Gharge_IOS_PRODUCT_ID];
            SEL selectorsasd = NSSelectorFromString([buildGhargeodcb objectForKey:@"AibbeGhargeBBS"]);
            [self performSelector:selectorsasd withObject:params_final];
            

        }else{
            //下单失败
            [self.GhargeDelegate RegchargGhargeFail:@{@"code":@"-1",@"msg":@"create oder failed"}];
            [[GhargeUtils getSharedInstance] showGhargeToastMsg:[buildGhargeodcb objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }];
    
    
}

-(void)wwlhxhMethodA:(NSDictionary *)str{
    
    startGhargeIapProcess *iapProcess = [[startGhargeIapProcess alloc] initWithSize:nil iapInfo:str[Gharge_IOS_ORDERID] cb:^(NSDictionary *cb){
        [self.GhargeDelegate RegchargGhargeSuccess:cb];
    }];
    [iapProcess show:[[GhargeBranch getSharedInstance] getGhargeCurrentView]];
}


-(void)wwlhxhMethodB:(NSDictionary *)str{
    
    [[GhargeBranch getSharedInstance] doGhargeChannelRegcharg:str];
}



-(void)sendGhargeData:(NSString *)dataPoint data:(NSDictionary *)data{
    
    [[GhargeBranch getSharedInstance] doGhargeChannelSendGameData:dataPoint data:data];
    
    //发送层游戏数据：区服选择／角色选择／创建角色／进入游戏／角色升级
    [[GhargeUtils getSharedInstance] postGhargeGameData:dataPoint data:data];
}



-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return [[GhargeBranch getSharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [[GhargeBranch getSharedInstance] applicationWillResignActive:application];
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[GhargeBranch getSharedInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[GhargeBranch getSharedInstance] applicationWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[GhargeBranch getSharedInstance] applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    [[GhargeBranch getSharedInstance] applicationWillTerminate:application];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [[GhargeBranch getSharedInstance] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[GhargeBranch getSharedInstance] application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[GhargeBranch getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return [[GhargeBranch getSharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[GhargeBranch getSharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[GhargeBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[GhargeBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


//GhargeBranchDelegate start


/*
code=0   msg=init success  serverid=xxx
code=-1  msg=channel sdk init failed  serverid=null
code=-2  msg=get server status failed serverid=null
code=-3  msg=
*/
-(void)channel_initGhargeSuccess:(NSDictionary *)res{
    //渠道初始化成功，下一步获取设置的服务器状态
    [[GhargeUtils getSharedInstance] requestGhargeServerStatus:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.GhargeDelegate initGhargeSuccess:result];
            
            //初始化成功，下一步：检查更新
            [[GhargeUtils getSharedInstance] doGhargeCheckUpdate:^(NSDictionary *dict){
                if([[dict objectForKey:@"code"] integerValue] == 0){
                    if(([[dict objectForKey:@"title"] isEqualToString:@""]) || ([dict objectForKey:@"title"] == NULL)){
                        //更新标题为空，则不显示更新框
                    }else{
                        GhargeCheckUpdateView *updateView = [[GhargeCheckUpdateView alloc] initWithSize:dict];
                        [updateView show:[[GhargeBranch getSharedInstance] getGhargeCurrentView]];
                    }
                }
            }];
            
            
        }else{
            [self.GhargeDelegate initGhargeFail:result];
            
            [[GhargeUtils getSharedInstance] showGhargeToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
    }];
}

-(void)channel_initGhargeFail:(NSDictionary *)result{
    [self.GhargeDelegate initGhargeFail:@{@"code":@"-1",@"msg":@"channel sdk init failed!",@"serverid":@"", @"channel_id":@""}];
    
    [[GhargeUtils getSharedInstance] showGhargeToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}


/*
 code=-1,msg=channel sdk login failed
 code=-2,msg=get token failed
 code=-3,msg=get userinfo failed
 code=-4,msg=not allow login
 code=0,msg=login success,Gharge_userid = xxx,Gharge_username = xxx,Gharge_nickname = xxx, Gharge_accesstoken = xxx
 */
-(void)channel_loginGhargeSuccess:(NSDictionary *)res{
    //渠道登录成功回调，下一步：获取用户信息
    [[GhargeUtils getSharedInstance] getGhargeLoginInfo:res result:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.GhargeDelegate loginGhargeSuccess:result];

            //登录成功之后，开始发送心跳包
            [[GhargeUtils getSharedInstance] sendGhargeHeartData];
            
        }else{
            [self.GhargeDelegate loginGhargeFail:result];
            //[[GhargeUtils getSharedInstance] showGhargeToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
        //登陆之后， 请求公告
        [[GhargeUtils getSharedInstance] requestGhargeNotice:^(NSURLResponse *response, id data, NSError *err){
            if (err)
            {
                
            }
            else
            {
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"requestGhargeNotice: %@", json);
                
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    if(([[jsonFieldData objectForKey:@"notice_title"] isEqualToString:@""]) || ([jsonFieldData objectForKey:@"notice_title"] == NULL)){
                        // 公告标题为空，则不显示公告框
                    }else{
                        GhargeNoticeView *noticeView = [[GhargeNoticeView alloc] initWithSize:jsonFieldData];
                        [noticeView show:[[GhargeBranch getSharedInstance] getGhargeCurrentView]];
                    }
                    
                }
            }
        }];
    }];
    
    
}

-(void)channel_loginGhargeFail:(NSDictionary *)result{
    [self.GhargeDelegate loginGhargeFail:result];
    //[[GhargeUtils getSharedInstance] showGhargeToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}



/*
 code=-1,msg=channel sdk logout failed
 code=-2,msg=Gharge logout failed
 code=0,msg=logout success
 */
-(void)channel_logoutGhargeSuccess:(NSDictionary *)result{
    //渠道登出成功，下一步：执行登出
    [[GhargeUtils getSharedInstance] doGhargeLogout:^(NSDictionary *res){
        if([[res objectForKey:@"code"] isEqualToString:@"0"]){
            [self.GhargeDelegate logoutGhargeSuccess:res];
        }else{
            [self.GhargeDelegate logoutGhargeFail:res];
        }

    }];
    
    
    
}

-(void)channel_logoutGhargeFail:(NSDictionary *)result{
    [self.GhargeDelegate logoutGhargeFail:@{@"code":@"-1",@"msg":@"channel sdk logout failed"}];
    [[GhargeUtils getSharedInstance] showGhargeToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

-(void)channel_RegchargGhargeSuccess:(NSDictionary *)result{
    [self.GhargeDelegate RegchargGhargeSuccess:result];
}

-(void)channel_RegchargGhargeFail:(NSDictionary *)result{
    [self.GhargeDelegate RegchargGhargeFail:result];
    [[GhargeUtils getSharedInstance] showGhargeToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}
-(void)channel_openGhargeUserCenter{
    [self.GhargeDelegate openGhargeUserCenter];
}

-(void)channel_closeGhargeUserCenter{
    [self.GhargeDelegate closeGhargeUserCenter];
}





-(BOOL) isGhargeConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    GhargeReachability *reach = [GhargeReachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case GhargeNotReachable:
            isExistenceNetwork = NO;

            break;
        case GhargeReachableViaWiFi:
            isExistenceNetwork = YES;

            break;
        case GhargeReachableViaWWAN:
            isExistenceNetwork = YES;

            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}



@end
