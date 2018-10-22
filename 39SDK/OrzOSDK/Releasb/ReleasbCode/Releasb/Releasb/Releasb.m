

#import "Releasb.h"
#import "ReleasbBranch.h"
#import "ReleasbUtils.h"
#import "ReleasbNoticeView.h"
#import "ReleasbReachability.h"
#import "startReleasbIapProcess.h"

@interface Releasb()<ReleasbBranchDelegate>


@end

@implementation Releasb

+(Releasb*)getSharedInstance
{
    static __strong Releasb * targetSDK = nil;
    if (targetSDK == nil)
    {
        targetSDK = [Releasb alloc];
    }
    
    return targetSDK;
}


-(void)initReleasb{
    //检测网络状态
    self.ReleasbnetWorkIsOK = [self isReleasbConnectionAvailable];
    if(self.ReleasbnetWorkIsOK == YES){
        //检测结果
        //发送激活数据
        [[ReleasbUtils getSharedInstance] postReleasbActiveData];
        
        
        //渠道初始化
        [ReleasbBranch getSharedInstance].delegate = self;
        [[ReleasbBranch getSharedInstance] doReleasbChannelInit];
    }else{
       
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"网络问题" message:@"网络连接失败，请检查您的网络连接后重试。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"重新连接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //响应事件
            [self initReleasb];
        }];
        [alert addAction:defaultAction];
        [[[ReleasbBranch getSharedInstance] getReleasbCurrentViewController] presentViewController:alert animated:YES completion:nil];
    }

    
    
    
    NSLog(@"getReleasbNetIsp : %@" , [[ReleasbUtils getSharedInstance] getReleasbNetIsp]);
    NSLog(@"getReleasbNetworktype : %@" , [[ReleasbUtils getSharedInstance] getReleasbNetworktype]);
    NSLog(@"getReleasbSystemVersion : %@" , [[ReleasbUtils getSharedInstance] getReleasbSystemVersion]);
    NSLog(@"getReleasbIdfa : %@" , [[ReleasbUtils getSharedInstance] getReleasbIdfa]);
    NSLog(@"getReleasbIdfv : %@" , [[ReleasbUtils getSharedInstance] getReleasbIdfv]);
    NSLog(@"getReleasbUUID : %@" , [[ReleasbUtils getSharedInstance] getReleasbUUID]);
    
    NSLog(@"getReleasbPhoneUserName : %@" , [[ReleasbUtils getSharedInstance] getReleasbPhoneUserName]);
    NSLog(@"getReleasbDeviceName : %@" , [[ReleasbUtils getSharedInstance] getReleasbDeviceName]);
    NSLog(@"getReleasbDeviceModel : %@" , [[ReleasbUtils getSharedInstance] getReleasbDeviceModel]);
    NSLog(@"getReleasbLocalPhoneModel : %@" , [[ReleasbUtils getSharedInstance] getReleasbLocalPhoneModel]);
    NSLog(@"getReleasbBundleId : %@" , [[ReleasbUtils getSharedInstance] getReleasbBundleId]);
    NSLog(@"getReleasbAppName : %@" , [[ReleasbUtils getSharedInstance] getReleasbAppName]);
    NSLog(@"getReleasbAppVersion : %@" , [[ReleasbUtils getSharedInstance] getReleasbAppVersion]);
    NSLog(@"getReleasbAppBuildVersion : %@" , [[ReleasbUtils getSharedInstance] getReleasbAppBuildVersion]);
    NSLog(@"getReleasbVersion : %@" , [[ReleasbUtils getSharedInstance] getReleasbVersion]);
    NSLog(@"getReleasbChannelSdkVersion : %@" , [[ReleasbUtils getSharedInstance] getReleasbChannelSdkVersion]);
    
    
    
    
}

-(void)startReleasbLogin{
    [[ReleasbBranch getSharedInstance] doReleasbChannelLogin];
}

-(void)startReleasbSwitchAccount{
    [[ReleasbBranch getSharedInstance] doReleasbChannelSwitchAccount];
}

-(void)startReleasbLogout{
    [[ReleasbBranch getSharedInstance] doReleasbChannelLogout];
}

-(void)showReleasbGameCenter{
    [[ReleasbBranch getSharedInstance] doChannelshowReleasbGameCenter];
}

-(void)showReleasbFloatView{
    [[ReleasbBranch getSharedInstance] doChannelshowReleasbFloatView];
}

-(void)hideReleasbFloatView{
    [[ReleasbBranch getSharedInstance] doChannelhideReleasbFloatView];
}


-(void)startReleasbRegcharg:(NSDictionary *)params{
    [[ReleasbUtils getSharedInstance] doReleasbCreateOder:params buildReleasbodcb:^(NSDictionary *buildReleasbodcb){
        if([[buildReleasbodcb objectForKey:@"code"] intValue] == 0){
            NSMutableDictionary *params_final = [[NSMutableDictionary alloc] initWithDictionary:params];
            [params_final setValue:[buildReleasbodcb objectForKey:@"oder_id"] forKey:Releasb_IOS_ORDERID];
            [params_final setValue:[buildReleasbodcb objectForKey:@"product_id"] forKey:Releasb_IOS_PRODUCT_ID];
            SEL selectorsasd = NSSelectorFromString([buildReleasbodcb objectForKey:@"AibbeReleasbBBS"]);
            [self performSelector:selectorsasd withObject:params_final];
            

        }else{
            //下单失败
            [self.ReleasbDelegate RegchargReleasbFail:@{@"code":@"-1",@"msg":@"create oder failed"}];
            [[ReleasbUtils getSharedInstance] showReleasbToastMsg:[buildReleasbodcb objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }];
    
    
}

-(void)wwlhxhMethodA:(NSDictionary *)str{
    
    startReleasbIapProcess *iapProcess = [[startReleasbIapProcess alloc] initWithSize:nil iapInfo:str[Releasb_IOS_ORDERID] cb:^(NSDictionary *cb){
        [self.ReleasbDelegate RegchargReleasbSuccess:cb];
    }];
    [iapProcess show:[[ReleasbBranch getSharedInstance] getReleasbCurrentView]];
}


-(void)wwlhxhMethodB:(NSDictionary *)str{
    
    [[ReleasbBranch getSharedInstance] doReleasbChannelRegcharg:str];
}



-(void)sendReleasbData:(NSString *)dataPoint data:(NSDictionary *)data{
    
    [[ReleasbBranch getSharedInstance] doReleasbChannelSendGameData:dataPoint data:data];
    
    //发送层游戏数据：区服选择／角色选择／创建角色／进入游戏／角色升级
    [[ReleasbUtils getSharedInstance] postReleasbGameData:dataPoint data:data];
}



-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return [[ReleasbBranch getSharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [[ReleasbBranch getSharedInstance] applicationWillResignActive:application];
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[ReleasbBranch getSharedInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[ReleasbBranch getSharedInstance] applicationWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[ReleasbBranch getSharedInstance] applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    [[ReleasbBranch getSharedInstance] applicationWillTerminate:application];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [[ReleasbBranch getSharedInstance] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[ReleasbBranch getSharedInstance] application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[ReleasbBranch getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return [[ReleasbBranch getSharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[ReleasbBranch getSharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[ReleasbBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[ReleasbBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


//ReleasbBranchDelegate start


/*
code=0   msg=init success  serverid=xxx
code=-1  msg=channel sdk init failed  serverid=null
code=-2  msg=get server status failed serverid=null
code=-3  msg=
*/
-(void)channel_initReleasbSuccess:(NSDictionary *)res{
    //渠道初始化成功，下一步获取设置的服务器状态
    [[ReleasbUtils getSharedInstance] requestReleasbServerStatus:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.ReleasbDelegate initReleasbSuccess:result];
            
            //初始化成功，下一步：检查更新
            [[ReleasbUtils getSharedInstance] doReleasbCheckUpdate:^(NSDictionary *dict){
                if([[dict objectForKey:@"code"] integerValue] == 0){
                    if(([[dict objectForKey:@"title"] isEqualToString:@""]) || ([dict objectForKey:@"title"] == NULL)){
                        //更新标题为空，则不显示更新框
                    }else{
                        ReleasbCheckUpdateView *updateView = [[ReleasbCheckUpdateView alloc] initWithSize:dict];
                        [updateView show:[[ReleasbBranch getSharedInstance] getReleasbCurrentView]];
                    }
                }
            }];
            
            
        }else{
            [self.ReleasbDelegate initReleasbFail:result];
            
            [[ReleasbUtils getSharedInstance] showReleasbToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
    }];
}

-(void)channel_initReleasbFail:(NSDictionary *)result{
    [self.ReleasbDelegate initReleasbFail:@{@"code":@"-1",@"msg":@"channel sdk init failed!",@"serverid":@"", @"channel_id":@""}];
    
    [[ReleasbUtils getSharedInstance] showReleasbToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}


/*
 code=-1,msg=channel sdk login failed
 code=-2,msg=get token failed
 code=-3,msg=get userinfo failed
 code=-4,msg=not allow login
 code=0,msg=login success,Releasb_userid = xxx,Releasb_username = xxx,Releasb_nickname = xxx, Releasb_accesstoken = xxx
 */
-(void)channel_loginReleasbSuccess:(NSDictionary *)res{
    //渠道登录成功回调，下一步：获取用户信息
    [[ReleasbUtils getSharedInstance] getReleasbLoginInfo:res result:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.ReleasbDelegate loginReleasbSuccess:result];

            //登录成功之后，开始发送心跳包
            [[ReleasbUtils getSharedInstance] sendReleasbHeartData];
            
        }else{
            [self.ReleasbDelegate loginReleasbFail:result];
            //[[ReleasbUtils getSharedInstance] showReleasbToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
        //登陆之后， 请求公告
        [[ReleasbUtils getSharedInstance] requestReleasbNotice:^(NSURLResponse *response, id data, NSError *err){
            if (err)
            {
                
            }
            else
            {
                NSDictionary* json = (NSDictionary*)data;
                NSLog(@"requestReleasbNotice: %@", json);
                
                if([[json objectForKey:@"success"] integerValue] == 1){
                    NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                    if(([[jsonFieldData objectForKey:@"notice_title"] isEqualToString:@""]) || ([jsonFieldData objectForKey:@"notice_title"] == NULL)){
                        // 公告标题为空，则不显示公告框
                    }else{
                        ReleasbNoticeView *noticeView = [[ReleasbNoticeView alloc] initWithSize:jsonFieldData];
                        [noticeView show:[[ReleasbBranch getSharedInstance] getReleasbCurrentView]];
                    }
                    
                }
            }
        }];
    }];
    
    
}

-(void)channel_loginReleasbFail:(NSDictionary *)result{
    [self.ReleasbDelegate loginReleasbFail:result];
    //[[ReleasbUtils getSharedInstance] showReleasbToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}



/*
 code=-1,msg=channel sdk logout failed
 code=-2,msg=Releasb logout failed
 code=0,msg=logout success
 */
-(void)channel_logoutReleasbSuccess:(NSDictionary *)result{
    //渠道登出成功，下一步：执行登出
    [[ReleasbUtils getSharedInstance] doReleasbLogout:^(NSDictionary *res){
        if([[res objectForKey:@"code"] isEqualToString:@"0"]){
            [self.ReleasbDelegate logoutReleasbSuccess:res];
        }else{
            [self.ReleasbDelegate logoutReleasbFail:res];
        }

    }];
    
    
    
}

-(void)channel_logoutReleasbFail:(NSDictionary *)result{
    [self.ReleasbDelegate logoutReleasbFail:@{@"code":@"-1",@"msg":@"channel sdk logout failed"}];
    [[ReleasbUtils getSharedInstance] showReleasbToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

-(void)channel_RegchargReleasbSuccess:(NSDictionary *)result{
    [self.ReleasbDelegate RegchargReleasbSuccess:result];
}

-(void)channel_RegchargReleasbFail:(NSDictionary *)result{
    [self.ReleasbDelegate RegchargReleasbFail:result];
    [[ReleasbUtils getSharedInstance] showReleasbToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}
-(void)channel_openReleasbUserCenter{
    [self.ReleasbDelegate openReleasbUserCenter];
}

-(void)channel_closeReleasbUserCenter{
    [self.ReleasbDelegate closeReleasbUserCenter];
}





-(BOOL) isReleasbConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    ReleasbReachability *reach = [ReleasbReachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case ReleasbNotReachable:
            isExistenceNetwork = NO;

            break;
        case ReleasbReachableViaWiFi:
            isExistenceNetwork = YES;

            break;
        case ReleasbReachableViaWWAN:
            isExistenceNetwork = YES;

            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}



@end
