

#import "Punctuation.h"
#import "PunctuationBranch.h"
#import "PunctuationUtils.h"
#import "PunctuationNoticeView.h"
#import "PunctuationReachability.h"
#import "startPunctuationIapProcess.h"

@interface Punctuation()<PunctuationBranchDelegate>


@end

@implementation Punctuation

+(Punctuation*)getSharedInstance
{
    static __strong Punctuation * targetSDK = nil;
    if (targetSDK == nil)
    {
        targetSDK = [Punctuation alloc];
    }
    
    return targetSDK;
}


-(void)initPunctuation{
    //检测网络状态
    self.PunctuationnetWorkIsOK = [self isPunctuationConnectionAvailable];
    if(self.PunctuationnetWorkIsOK == YES){
        //检测结果
        //发送激活数据
        [[PunctuationUtils getSharedInstance] postPunctuationActiveData];
        
        
        //渠道初始化
        [PunctuationBranch getSharedInstance].delegate = self;
        [[PunctuationBranch getSharedInstance] doPunctuationChannelInit];
    }else{
       
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"网络问题" message:@"网络连接失败，请检查您的网络连接后重试。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"重新连接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //响应事件
            [self initPunctuation];
        }];
        [alert addAction:defaultAction];
        [[[PunctuationBranch getSharedInstance] getPunctuationCurrentViewController] presentViewController:alert animated:YES completion:nil];
    }

    
    
    
    NSLog(@"getPunctuationNetIsp : %@" , [[PunctuationUtils getSharedInstance] getPunctuationNetIsp]);
    NSLog(@"getPunctuationNetworktype : %@" , [[PunctuationUtils getSharedInstance] getPunctuationNetworktype]);
    NSLog(@"getPunctuationSystemVersion : %@" , [[PunctuationUtils getSharedInstance] getPunctuationSystemVersion]);
    NSLog(@"getPunctuationIdfa : %@" , [[PunctuationUtils getSharedInstance] getPunctuationIdfa]);
    NSLog(@"getPunctuationIdfv : %@" , [[PunctuationUtils getSharedInstance] getPunctuationIdfv]);
    NSLog(@"getPunctuationUUID : %@" , [[PunctuationUtils getSharedInstance] getPunctuationUUID]);
    
    NSLog(@"getPunctuationPhoneUserName : %@" , [[PunctuationUtils getSharedInstance] getPunctuationPhoneUserName]);
    NSLog(@"getPunctuationDeviceName : %@" , [[PunctuationUtils getSharedInstance] getPunctuationDeviceName]);
    NSLog(@"getPunctuationDeviceModel : %@" , [[PunctuationUtils getSharedInstance] getPunctuationDeviceModel]);
    NSLog(@"getPunctuationLocalPhoneModel : %@" , [[PunctuationUtils getSharedInstance] getPunctuationLocalPhoneModel]);
    NSLog(@"getPunctuationBundleId : %@" , [[PunctuationUtils getSharedInstance] getPunctuationBundleId]);
    NSLog(@"getPunctuationAppName : %@" , [[PunctuationUtils getSharedInstance] getPunctuationAppName]);
    NSLog(@"getPunctuationAppVersion : %@" , [[PunctuationUtils getSharedInstance] getPunctuationAppVersion]);
    NSLog(@"getPunctuationAppBuildVersion : %@" , [[PunctuationUtils getSharedInstance] getPunctuationAppBuildVersion]);
    NSLog(@"getPunctuationVersion : %@" , [[PunctuationUtils getSharedInstance] getPunctuationVersion]);
    NSLog(@"getPunctuationChannelSdkVersion : %@" , [[PunctuationUtils getSharedInstance] getPunctuationChannelSdkVersion]);
    
    
    
    
}

-(void)startPunctuationLogin{
    [[PunctuationBranch getSharedInstance] doPunctuationChannelLogin];
}

-(void)startPunctuationSwitchAccount{
    [[PunctuationBranch getSharedInstance] doPunctuationChannelSwitchAccount];
}

-(void)startPunctuationLogout{
    [[PunctuationBranch getSharedInstance] doPunctuationChannelLogout];
}

-(void)showPunctuationGameCenter{
    [[PunctuationBranch getSharedInstance] doChannelshowPunctuationGameCenter];
}

-(void)showPunctuationFloatView{
    [[PunctuationBranch getSharedInstance] doChannelshowPunctuationFloatView];
}

-(void)hidePunctuationFloatView{
    [[PunctuationBranch getSharedInstance] doChannelhidePunctuationFloatView];
}


-(void)startPunctuationRegcharg:(NSDictionary *)params{
    [[PunctuationUtils getSharedInstance] doPunctuationCreateOder:params buildPunctuationodcb:^(NSDictionary *buildPunctuationodcb){
        if([[buildPunctuationodcb objectForKey:@"code"] intValue] == 0){
            NSMutableDictionary *params_final = [[NSMutableDictionary alloc] initWithDictionary:params];
            [params_final setValue:[buildPunctuationodcb objectForKey:@"oder_id"] forKey:Punctuation_IOS_ORDERID];
            [params_final setValue:[buildPunctuationodcb objectForKey:@"product_id"] forKey:Punctuation_IOS_PRODUCT_ID];
            SEL selectorsasd = NSSelectorFromString([buildPunctuationodcb objectForKey:@"AibbePunctuationBBS"]);
            [self performSelector:selectorsasd withObject:params_final];
            

        }else{
            //下单失败
            [self.PunctuationDelegate RegchargPunctuationFail:@{@"code":@"-1",@"msg":@"create oder failed"}];
            [[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[buildPunctuationodcb objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }];
    
    
}

-(void)wwlhxhMethodA:(NSDictionary *)str{
    
    startPunctuationIapProcess *iapProcess = [[startPunctuationIapProcess alloc] initWithSize:nil iapInfo:str[Punctuation_IOS_ORDERID] cb:^(NSDictionary *cb){
        [self.PunctuationDelegate RegchargPunctuationSuccess:cb];
    }];
    [iapProcess show:[[PunctuationBranch getSharedInstance] getPunctuationCurrentView]];
}


-(void)wwlhxhMethodB:(NSDictionary *)str{
    
    [[PunctuationBranch getSharedInstance] doPunctuationChannelRegcharg:str];
}



-(void)sendPunctuationData:(NSString *)dataPoint data:(NSDictionary *)data{
    
    [[PunctuationBranch getSharedInstance] doPunctuationChannelSendGameData:dataPoint data:data];
    
    //发送层游戏数据：区服选择／角色选择／创建角色／进入游戏／角色升级
    [[PunctuationUtils getSharedInstance] postPunctuationGameData:dataPoint data:data];
}



-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return [[PunctuationBranch getSharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [[PunctuationBranch getSharedInstance] applicationWillResignActive:application];
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[PunctuationBranch getSharedInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[PunctuationBranch getSharedInstance] applicationWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[PunctuationBranch getSharedInstance] applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    [[PunctuationBranch getSharedInstance] applicationWillTerminate:application];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [[PunctuationBranch getSharedInstance] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[PunctuationBranch getSharedInstance] application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[PunctuationBranch getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return [[PunctuationBranch getSharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[PunctuationBranch getSharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[PunctuationBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[PunctuationBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


//PunctuationBranchDelegate start


/*
code=0   msg=init success  serverid=xxx
code=-1  msg=channel sdk init failed  serverid=null
code=-2  msg=get server status failed serverid=null
code=-3  msg=
*/
-(void)channel_initPunctuationSuccess:(NSDictionary *)res{
    //渠道初始化成功，下一步获取设置的服务器状态
    [[PunctuationUtils getSharedInstance] requestPunctuationServerStatus:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.PunctuationDelegate initPunctuationSuccess:result];
            
            //初始化成功，下一步：检查更新
            [[PunctuationUtils getSharedInstance] doPunctuationCheckUpdate:^(NSDictionary *dict){
                if([[dict objectForKey:@"code"] integerValue] == 0){
                    if(([[dict objectForKey:@"title"] isEqualToString:@""]) || ([dict objectForKey:@"title"] == NULL)){
                        //更新标题为空，则不显示更新框
                    }else{
                        PunctuationCheckUpdateView *updateView = [[PunctuationCheckUpdateView alloc] initWithSize:dict];
                        [updateView show:[[PunctuationBranch getSharedInstance] getPunctuationCurrentView]];
                    }
                }
            }];
            
            
        }else{
            [self.PunctuationDelegate initPunctuationFail:result];
            
            [[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
    }];
}

-(void)channel_initPunctuationFail:(NSDictionary *)result{
    [self.PunctuationDelegate initPunctuationFail:@{@"code":@"-1",@"msg":@"channel sdk init failed!",@"serverid":@"", @"channel_id":@""}];
    
    [[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}


/*
 code=-1,msg=channel sdk login failed
 code=-2,msg=get token failed
 code=-3,msg=get userinfo failed
 code=-4,msg=not allow login
 code=0,msg=login success,Punctuation_userid = xxx,Punctuation_username = xxx,Punctuation_nickname = xxx, Punctuation_accesstoken = xxx
 */
-(void)channel_loginPunctuationSuccess:(NSDictionary *)res{
    //渠道登录成功回调，下一步：获取用户信息
    [[PunctuationUtils getSharedInstance] getPunctuationLoginInfo:res result:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.PunctuationDelegate loginPunctuationSuccess:result];

            //登录成功之后，开始发送心跳包
            [[PunctuationUtils getSharedInstance] sendPunctuationHeartData];
            
        }else{
            [self.PunctuationDelegate loginPunctuationFail:result];
            //[[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
        //登陆之后， 请求公告
        [[PunctuationUtils getSharedInstance] requestPunctuationNotice:^(NSURLResponse *response, id data, NSError *err){
            if (err)
            {
                
            }
            else
            {
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"requestPunctuationNotice: %@", json);
                
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    if(([[jsonFieldData objectForKey:@"notice_title"] isEqualToString:@""]) || ([jsonFieldData objectForKey:@"notice_title"] == NULL)){
                        // 公告标题为空，则不显示公告框
                    }else{
                        PunctuationNoticeView *noticeView = [[PunctuationNoticeView alloc] initWithSize:jsonFieldData];
                        [noticeView show:[[PunctuationBranch getSharedInstance] getPunctuationCurrentView]];
                    }
                    
                }
            }
        }];
    }];
    
    
}

-(void)channel_loginPunctuationFail:(NSDictionary *)result{
    [self.PunctuationDelegate loginPunctuationFail:result];
    //[[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}



/*
 code=-1,msg=channel sdk logout failed
 code=-2,msg=Punctuation logout failed
 code=0,msg=logout success
 */
-(void)channel_logoutPunctuationSuccess:(NSDictionary *)result{
    //渠道登出成功，下一步：执行登出
    [[PunctuationUtils getSharedInstance] doPunctuationLogout:^(NSDictionary *res){
        if([[res objectForKey:@"code"] isEqualToString:@"0"]){
            [self.PunctuationDelegate logoutPunctuationSuccess:res];
        }else{
            [self.PunctuationDelegate logoutPunctuationFail:res];
        }

    }];
    
    
    
}

-(void)channel_logoutPunctuationFail:(NSDictionary *)result{
    [self.PunctuationDelegate logoutPunctuationFail:@{@"code":@"-1",@"msg":@"channel sdk logout failed"}];
    [[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

-(void)channel_RegchargPunctuationSuccess:(NSDictionary *)result{
    [self.PunctuationDelegate RegchargPunctuationSuccess:result];
}

-(void)channel_RegchargPunctuationFail:(NSDictionary *)result{
    [self.PunctuationDelegate RegchargPunctuationFail:result];
    [[PunctuationUtils getSharedInstance] showPunctuationToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}
-(void)channel_openPunctuationUserCenter{
    [self.PunctuationDelegate openPunctuationUserCenter];
}

-(void)channel_closePunctuationUserCenter{
    [self.PunctuationDelegate closePunctuationUserCenter];
}





-(BOOL) isPunctuationConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    PunctuationReachability *reach = [PunctuationReachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case PunctuationNotReachable:
            isExistenceNetwork = NO;

            break;
        case PunctuationReachableViaWiFi:
            isExistenceNetwork = YES;

            break;
        case PunctuationReachableViaWWAN:
            isExistenceNetwork = YES;

            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}



@end
