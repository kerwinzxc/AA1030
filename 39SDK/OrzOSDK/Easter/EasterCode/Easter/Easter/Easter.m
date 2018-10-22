

#import "Easter.h"
#import "EasterBranch.h"
#import "EasterUtils.h"
#import "EasterNoticeView.h"
#import "EasterReachability.h"
#import "startEasterIapProcess.h"

@interface Easter()<EasterBranchDelegate>


@end

@implementation Easter

+(Easter*)getSharedInstance
{
    static __strong Easter * targetSDK = nil;
    if (targetSDK == nil)
    {
        targetSDK = [Easter alloc];
    }
    
    return targetSDK;
}


-(void)initEaster{
    //检测网络状态
    self.EasternetWorkIsOK = [self isEasterConnectionAvailable];
    if(self.EasternetWorkIsOK == YES){
        //检测结果
        //发送激活数据
        [[EasterUtils getSharedInstance] postEasterActiveData];
        
        
        //渠道初始化
        [EasterBranch getSharedInstance].delegate = self;
        [[EasterBranch getSharedInstance] doEasterChannelInit];
    }else{
       
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"网络问题" message:@"网络连接失败，请检查您的网络连接后重试。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"重新连接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //响应事件
            [self initEaster];
        }];
        [alert addAction:defaultAction];
        [[[EasterBranch getSharedInstance] getEasterCurrentViewController] presentViewController:alert animated:YES completion:nil];
    }

    
    
    
    NSLog(@"getEasterNetIsp : %@" , [[EasterUtils getSharedInstance] getEasterNetIsp]);
    NSLog(@"getEasterNetworktype : %@" , [[EasterUtils getSharedInstance] getEasterNetworktype]);
    NSLog(@"getEasterSystemVersion : %@" , [[EasterUtils getSharedInstance] getEasterSystemVersion]);
    NSLog(@"getEasterIdfa : %@" , [[EasterUtils getSharedInstance] getEasterIdfa]);
    NSLog(@"getEasterIdfv : %@" , [[EasterUtils getSharedInstance] getEasterIdfv]);
    NSLog(@"getEasterUUID : %@" , [[EasterUtils getSharedInstance] getEasterUUID]);
    
    NSLog(@"getEasterPhoneUserName : %@" , [[EasterUtils getSharedInstance] getEasterPhoneUserName]);
    NSLog(@"getEasterDeviceName : %@" , [[EasterUtils getSharedInstance] getEasterDeviceName]);
    NSLog(@"getEasterDeviceModel : %@" , [[EasterUtils getSharedInstance] getEasterDeviceModel]);
    NSLog(@"getEasterLocalPhoneModel : %@" , [[EasterUtils getSharedInstance] getEasterLocalPhoneModel]);
    NSLog(@"getEasterBundleId : %@" , [[EasterUtils getSharedInstance] getEasterBundleId]);
    NSLog(@"getEasterAppName : %@" , [[EasterUtils getSharedInstance] getEasterAppName]);
    NSLog(@"getEasterAppVersion : %@" , [[EasterUtils getSharedInstance] getEasterAppVersion]);
    NSLog(@"getEasterAppBuildVersion : %@" , [[EasterUtils getSharedInstance] getEasterAppBuildVersion]);
    NSLog(@"getEasterVersion : %@" , [[EasterUtils getSharedInstance] getEasterVersion]);
    NSLog(@"getEasterChannelSdkVersion : %@" , [[EasterUtils getSharedInstance] getEasterChannelSdkVersion]);
    
    
    
    
}

-(void)startEasterLogin{
    [[EasterBranch getSharedInstance] doEasterChannelLogin];
}

-(void)startEasterSwitchAccount{
    [[EasterBranch getSharedInstance] doEasterChannelSwitchAccount];
}

-(void)startEasterLogout{
    [[EasterBranch getSharedInstance] doEasterChannelLogout];
}

-(void)showEasterGameCenter{
    [[EasterBranch getSharedInstance] doChannelshowEasterGameCenter];
}

-(void)showEasterFloatView{
    [[EasterBranch getSharedInstance] doChannelshowEasterFloatView];
}

-(void)hideEasterFloatView{
    [[EasterBranch getSharedInstance] doChannelhideEasterFloatView];
}


-(void)startEasterRegcharg:(NSDictionary *)params{
    [[EasterUtils getSharedInstance] doEasterCreateOder:params buildEasterodcb:^(NSDictionary *buildEasterodcb){
        if([[buildEasterodcb objectForKey:@"code"] intValue] == 0){
            NSMutableDictionary *params_final = [[NSMutableDictionary alloc] initWithDictionary:params];
            [params_final setValue:[buildEasterodcb objectForKey:@"oder_id"] forKey:Easter_IOS_ORDERID];
            [params_final setValue:[buildEasterodcb objectForKey:@"product_id"] forKey:Easter_IOS_PRODUCT_ID];
            SEL selectorsasd = NSSelectorFromString([buildEasterodcb objectForKey:@"AibbeEasterBBS"]);
            [self performSelector:selectorsasd withObject:params_final];
            

        }else{
            //下单失败
            [self.EasterDelegate RegchargEasterFail:@{@"code":@"-1",@"msg":@"create oder failed"}];
            [[EasterUtils getSharedInstance] showEasterToastMsg:[buildEasterodcb objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }];
    
    
}

-(void)wwlhxhMethodA:(NSDictionary *)str{
    
    startEasterIapProcess *iapProcess = [[startEasterIapProcess alloc] initWithSize:nil iapInfo:str[Easter_IOS_ORDERID] cb:^(NSDictionary *cb){
        [self.EasterDelegate RegchargEasterSuccess:cb];
    }];
    [iapProcess show:[[EasterBranch getSharedInstance] getEasterCurrentView]];
}


-(void)wwlhxhMethodB:(NSDictionary *)str{
    
    [[EasterBranch getSharedInstance] doEasterChannelRegcharg:str];
}



-(void)sendEasterData:(NSString *)dataPoint data:(NSDictionary *)data{
    
    [[EasterBranch getSharedInstance] doEasterChannelSendGameData:dataPoint data:data];
    
    //发送层游戏数据：区服选择／角色选择／创建角色／进入游戏／角色升级
    [[EasterUtils getSharedInstance] postEasterGameData:dataPoint data:data];
}



-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return [[EasterBranch getSharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [[EasterBranch getSharedInstance] applicationWillResignActive:application];
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[EasterBranch getSharedInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[EasterBranch getSharedInstance] applicationWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[EasterBranch getSharedInstance] applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    [[EasterBranch getSharedInstance] applicationWillTerminate:application];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [[EasterBranch getSharedInstance] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[EasterBranch getSharedInstance] application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[EasterBranch getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return [[EasterBranch getSharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EasterBranch getSharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[EasterBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[EasterBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


//EasterBranchDelegate start


/*
code=0   msg=init success  serverid=xxx
code=-1  msg=channel sdk init failed  serverid=null
code=-2  msg=get server status failed serverid=null
code=-3  msg=
*/
-(void)channel_initEasterSuccess:(NSDictionary *)res{
    //渠道初始化成功，下一步获取设置的服务器状态
    [[EasterUtils getSharedInstance] requestEasterServerStatus:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.EasterDelegate initEasterSuccess:result];
            
            //初始化成功，下一步：检查更新
            [[EasterUtils getSharedInstance] doEasterCheckUpdate:^(NSDictionary *dict){
                if([[dict objectForKey:@"code"] integerValue] == 0){
                    if(([[dict objectForKey:@"title"] isEqualToString:@""]) || ([dict objectForKey:@"title"] == NULL)){
                        //更新标题为空，则不显示更新框
                    }else{
                        EasterCheckUpdateView *updateView = [[EasterCheckUpdateView alloc] initWithSize:dict];
                        [updateView show:[[EasterBranch getSharedInstance] getEasterCurrentView]];
                    }
                }
            }];
            
            
        }else{
            [self.EasterDelegate initEasterFail:result];
            
            [[EasterUtils getSharedInstance] showEasterToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
    }];
}

-(void)channel_initEasterFail:(NSDictionary *)result{
    [self.EasterDelegate initEasterFail:@{@"code":@"-1",@"msg":@"channel sdk init failed!",@"serverid":@"", @"channel_id":@""}];
    
    [[EasterUtils getSharedInstance] showEasterToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}


/*
 code=-1,msg=channel sdk login failed
 code=-2,msg=get token failed
 code=-3,msg=get userinfo failed
 code=-4,msg=not allow login
 code=0,msg=login success,Easter_userid = xxx,Easter_username = xxx,Easter_nickname = xxx, Easter_accesstoken = xxx
 */
-(void)channel_loginEasterSuccess:(NSDictionary *)res{
    //渠道登录成功回调，下一步：获取用户信息
    [[EasterUtils getSharedInstance] getEasterLoginInfo:res result:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.EasterDelegate loginEasterSuccess:result];

            //登录成功之后，开始发送心跳包
            [[EasterUtils getSharedInstance] sendEasterHeartData];
            
        }else{
            [self.EasterDelegate loginEasterFail:result];
            //[[EasterUtils getSharedInstance] showEasterToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
        //登陆之后， 请求公告
        [[EasterUtils getSharedInstance] requestEasterNotice:^(NSURLResponse *response, id data, NSError *err){
            if (err)
            {
                
            }
            else
            {
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"requestEasterNotice: %@", json);
                
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    if(([[jsonFieldData objectForKey:@"notice_title"] isEqualToString:@""]) || ([jsonFieldData objectForKey:@"notice_title"] == NULL)){
                        // 公告标题为空，则不显示公告框
                    }else{
                        EasterNoticeView *noticeView = [[EasterNoticeView alloc] initWithSize:jsonFieldData];
                        [noticeView show:[[EasterBranch getSharedInstance] getEasterCurrentView]];
                    }
                    
                }
            }
        }];
    }];
    
    
}

-(void)channel_loginEasterFail:(NSDictionary *)result{
    [self.EasterDelegate loginEasterFail:result];
    //[[EasterUtils getSharedInstance] showEasterToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}



/*
 code=-1,msg=channel sdk logout failed
 code=-2,msg=Easter logout failed
 code=0,msg=logout success
 */
-(void)channel_logoutEasterSuccess:(NSDictionary *)result{
    //渠道登出成功，下一步：执行登出
    [[EasterUtils getSharedInstance] doEasterLogout:^(NSDictionary *res){
        if([[res objectForKey:@"code"] isEqualToString:@"0"]){
            [self.EasterDelegate logoutEasterSuccess:res];
        }else{
            [self.EasterDelegate logoutEasterFail:res];
        }

    }];
    
    
    
}

-(void)channel_logoutEasterFail:(NSDictionary *)result{
    [self.EasterDelegate logoutEasterFail:@{@"code":@"-1",@"msg":@"channel sdk logout failed"}];
    [[EasterUtils getSharedInstance] showEasterToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

-(void)channel_RegchargEasterSuccess:(NSDictionary *)result{
    [self.EasterDelegate RegchargEasterSuccess:result];
}

-(void)channel_RegchargEasterFail:(NSDictionary *)result{
    [self.EasterDelegate RegchargEasterFail:result];
    [[EasterUtils getSharedInstance] showEasterToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}
-(void)channel_openEasterUserCenter{
    [self.EasterDelegate openEasterUserCenter];
}

-(void)channel_closeEasterUserCenter{
    [self.EasterDelegate closeEasterUserCenter];
}





-(BOOL) isEasterConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    EasterReachability *reach = [EasterReachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case EasterNotReachable:
            isExistenceNetwork = NO;

            break;
        case EasterReachableViaWiFi:
            isExistenceNetwork = YES;

            break;
        case EasterReachableViaWWAN:
            isExistenceNetwork = YES;

            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}



@end
