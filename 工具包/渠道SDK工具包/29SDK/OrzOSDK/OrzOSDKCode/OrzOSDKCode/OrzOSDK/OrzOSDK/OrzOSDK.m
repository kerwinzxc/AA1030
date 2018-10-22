

#import "OrzOSDK.h"
#import "OrzOSDKBranch.h"
#import "OrzOSDKUtils.h"
#import "OrzOSDKNoticeView.h"
#import "OrzOSDKReachability.h"
#import "startOrzOSDKIapProcess.h"

@interface OrzOSDK()<OrzOSDKBranchDelegate, UIAlertViewDelegate>


@end

@implementation OrzOSDK

+(OrzOSDK*)getSharedInstance
{
    static __strong OrzOSDK * targetSDK = nil;
    if (targetSDK == nil)
    {
        targetSDK = [OrzOSDK alloc];
    }
    
    return targetSDK;
}


//监听弹出框的按钮点击事件,点击重新连接按钮
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString * btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if([btnTitle isEqualToString:@"重新连接"]){
        NSLog(@"点击重新连接按钮");
        if([self isOrzOSDKConnectionAvailable] == NO){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络问题" message:@"网络连接失败，请检查您的网络连接后重试。" delegate:self cancelButtonTitle:@"重新连接" otherButtonTitles:nil];
            
            [alertView show];
        }else{
            //检测结果
            //发送激活数据
            [[OrzOSDKUtils getSharedInstance] postOrzOSDKActiveData];
            
            
            //渠道初始化
            [OrzOSDKBranch getSharedInstance].delegate = self;
            [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelInit];
        }

    }
}

-(void)initOrzOSDK{
    //检测网络状态
    self.OrzOSDKnetWorkIsOK = [self isOrzOSDKConnectionAvailable];
    if(self.OrzOSDKnetWorkIsOK == YES){
        //检测结果
        //发送激活数据
        [[OrzOSDKUtils getSharedInstance] postOrzOSDKActiveData];
        
        
        //渠道初始化
        [OrzOSDKBranch getSharedInstance].delegate = self;
        [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelInit];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络问题" message:@"网络连接失败，请检查您的网络连接后重试。" delegate:self cancelButtonTitle:@"重新连接" otherButtonTitles:nil];
    
        [alertView show];
    }

    
    
    
    NSLog(@"getOrzOSDKNetIsp : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKNetIsp]);
    NSLog(@"getOrzOSDKNetworktype : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKNetworktype]);
    NSLog(@"getOrzOSDKSystemVersion : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKSystemVersion]);
    NSLog(@"getOrzOSDKIdfa : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKIdfa]);
    NSLog(@"getOrzOSDKIdfv : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKIdfv]);
    NSLog(@"getOrzOSDKUUID : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKUUID]);
    
    NSLog(@"getOrzOSDKPhoneUserName : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKPhoneUserName]);
    NSLog(@"getOrzOSDKDeviceName : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKDeviceName]);
    NSLog(@"getOrzOSDKDeviceModel : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKDeviceModel]);
    NSLog(@"getOrzOSDKLocalPhoneModel : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKLocalPhoneModel]);
    NSLog(@"getOrzOSDKBundleId : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKBundleId]);
    NSLog(@"getOrzOSDKAppName : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKAppName]);
    NSLog(@"getOrzOSDKAppVersion : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKAppVersion]);
    NSLog(@"getOrzOSDKAppBuildVersion : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKAppBuildVersion]);
    NSLog(@"getOrzOSDKVersion : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKVersion]);
    NSLog(@"getOrzOSDKChannelSdkVersion : %@" , [[OrzOSDKUtils getSharedInstance] getOrzOSDKChannelSdkVersion]);
    
    
    
    
}

-(void)startOrzOSDKLogin{
    [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelLogin];
}

-(void)startOrzOSDKSwitchAccount{
    [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelSwitchAccount];
}

-(void)startOrzOSDKLogout{
    [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelLogout];
}

-(void)showOrzOSDKGameCenter{
    [[OrzOSDKBranch getSharedInstance] doChannelshowOrzOSDKGameCenter];
}

-(void)showOrzOSDKFloatView{
    [[OrzOSDKBranch getSharedInstance] doChannelshowOrzOSDKFloatView];
}

-(void)hideOrzOSDKFloatView{
    [[OrzOSDKBranch getSharedInstance] doChannelhideOrzOSDKFloatView];
}


-(void)startOrzOSDKRegcharg:(NSDictionary *)params{
    [[OrzOSDKUtils getSharedInstance] doOrzOSDKCreateOder:params buildOrzOSDKodcb:^(NSDictionary *buildOrzOSDKodcb){
        if([[buildOrzOSDKodcb objectForKey:@"code"] intValue] == 0){
            NSMutableDictionary *params_final = [[NSMutableDictionary alloc] initWithDictionary:params];
            [params_final setValue:[buildOrzOSDKodcb objectForKey:@"oder_id"] forKey:OrzOSDK_IOS_ORDERID];
            [params_final setValue:[buildOrzOSDKodcb objectForKey:@"product_id"] forKey:OrzOSDK_IOS_PRODUCT_ID];
            SEL selectorsasd = NSSelectorFromString([buildOrzOSDKodcb objectForKey:@"AibbeOrzOSDKBBS"]);
            [self performSelector:selectorsasd withObject:params_final];
            

        }else{
            //下单失败
            [self.OrzOSDKDelegate RegchargOrzOSDKFail:@{@"code":@"-1",@"msg":@"create oder failed"}];
            [[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[buildOrzOSDKodcb objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }];
    
    
}

-(void)wwlhxhMethodA:(NSDictionary *)str{
    
    startOrzOSDKIapProcess *iapProcess = [[startOrzOSDKIapProcess alloc] initWithSize:nil iapInfo:str[OrzOSDK_IOS_ORDERID] cb:^(NSDictionary *cb){
        [self.OrzOSDKDelegate RegchargOrzOSDKSuccess:cb];
    }];
    [iapProcess show:[[OrzOSDKBranch getSharedInstance] getOrzOSDKCurrentView]];
}


-(void)wwlhxhMethodB:(NSDictionary *)str{
    
    [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelRegcharg:str];
}



-(void)sendOrzOSDKData:(NSString *)dataPoint data:(NSDictionary *)data{
    
    [[OrzOSDKBranch getSharedInstance] doOrzOSDKChannelSendGameData:dataPoint data:data];
    
    //发送层游戏数据：区服选择／角色选择／创建角色／进入游戏／角色升级
    [[OrzOSDKUtils getSharedInstance] postOrzOSDKGameData:dataPoint data:data];
}



-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return [[OrzOSDKBranch getSharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application{
    [[OrzOSDKBranch getSharedInstance] applicationWillResignActive:application];
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[OrzOSDKBranch getSharedInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[OrzOSDKBranch getSharedInstance] applicationWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[OrzOSDKBranch getSharedInstance] applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication *)application{
    [[OrzOSDKBranch getSharedInstance] applicationWillTerminate:application];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [[OrzOSDKBranch getSharedInstance] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[OrzOSDKBranch getSharedInstance] application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[OrzOSDKBranch getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return [[OrzOSDKBranch getSharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[OrzOSDKBranch getSharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[OrzOSDKBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[OrzOSDKBranch getSharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


//OrzOSDKBranchDelegate start


/*
code=0   msg=init success  serverid=xxx
code=-1  msg=channel sdk init failed  serverid=null
code=-2  msg=get server status failed serverid=null
code=-3  msg=
*/
-(void)channel_initOrzOSDKSuccess:(NSDictionary *)res{
    //渠道初始化成功，下一步获取设置的服务器状态
    [[OrzOSDKUtils getSharedInstance] requestOrzOSDKServerStatus:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.OrzOSDKDelegate initOrzOSDKSuccess:result];
            
            //初始化成功，下一步：检查更新
            [[OrzOSDKUtils getSharedInstance] doOrzOSDKCheckUpdate:^(NSDictionary *dict){
                if([[dict objectForKey:@"code"] integerValue] == 0){
                    if(([[dict objectForKey:@"title"] isEqualToString:@""]) || ([dict objectForKey:@"title"] == NULL)){
                        //更新标题为空，则不显示更新框
                    }else{
                        OrzOSDKCheckUpdateView *updateView = [[OrzOSDKCheckUpdateView alloc] initWithSize:dict];
                        [updateView show:[[OrzOSDKBranch getSharedInstance] getOrzOSDKCurrentView]];
                    }
                }
            }];
            
            
        }else{
            [self.OrzOSDKDelegate initOrzOSDKFail:result];
            
            [[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
        
    }];
}

-(void)channel_initOrzOSDKFail:(NSDictionary *)result{
    [self.OrzOSDKDelegate initOrzOSDKFail:@{@"code":@"-1",@"msg":@"channel sdk init failed!",@"serverid":@"", @"channel_id":@""}];
    
    [[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}


/*
 code=-1,msg=channel sdk login failed
 code=-2,msg=get token failed
 code=-3,msg=get userinfo failed
 code=-4,msg=not allow login
 code=0,msg=login success,OrzOSDK_userid = xxx,OrzOSDK_username = xxx,OrzOSDK_nickname = xxx, OrzOSDK_accesstoken = xxx
 */
-(void)channel_loginOrzOSDKSuccess:(NSDictionary *)res{
    //渠道登录成功回调，下一步：获取用户信息
    [[OrzOSDKUtils getSharedInstance] getOrzOSDKLoginInfo:res result:^(NSDictionary *result){
        if([[result objectForKey:@"code"] isEqualToString:@"0"]){
            [self.OrzOSDKDelegate loginOrzOSDKSuccess:result];

            
            //登陆成功之后， 请求公告
            [[OrzOSDKUtils getSharedInstance] requestOrzOSDKNotice:^(NSURLResponse *response, id data, NSError *err){
                if (err)
                {
                    
                }
                else
                {
                    NSDictionary* json = (NSDictionary*)data;
                    NSLog(@"requestOrzOSDKNotice: %@", json);
                    
                    if([[json objectForKey:@"success"] integerValue] == 1){
                        NSDictionary* jsonFieldData = [json valueForKey:@"data"];
                        if(([[jsonFieldData objectForKey:@"notice_title"] isEqualToString:@""]) || ([jsonFieldData objectForKey:@"notice_title"] == NULL)){
                            // 公告标题为空，则不显示公告框
                        }else{
                            OrzOSDKNoticeView *noticeView = [[OrzOSDKNoticeView alloc] initWithSize:jsonFieldData];
                            [noticeView show:[[OrzOSDKBranch getSharedInstance] getOrzOSDKCurrentView]];
                        }
                        
                    }
                }
            }];
            
            //登录成功之后，开始发送心跳包
            [[OrzOSDKUtils getSharedInstance] sendOrzOSDKHeartData];
            
        }else{
            [self.OrzOSDKDelegate loginOrzOSDKFail:result];
            //[[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }];
    
    
}

-(void)channel_loginOrzOSDKFail:(NSDictionary *)result{
    [self.OrzOSDKDelegate loginOrzOSDKFail:result];
    //[[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}



/*
 code=-1,msg=channel sdk logout failed
 code=-2,msg=OrzOSDK logout failed
 code=0,msg=logout success
 */
-(void)channel_logoutOrzOSDKSuccess:(NSDictionary *)result{
    //渠道登出成功，下一步：执行登出
    [[OrzOSDKUtils getSharedInstance] doOrzOSDKLogout:^(NSDictionary *res){
        if([[res objectForKey:@"code"] isEqualToString:@"0"]){
            [self.OrzOSDKDelegate logoutOrzOSDKSuccess:res];
        }else{
            [self.OrzOSDKDelegate logoutOrzOSDKFail:res];
        }

    }];
    
    
    
}

-(void)channel_logoutOrzOSDKFail:(NSDictionary *)result{
    [self.OrzOSDKDelegate logoutOrzOSDKFail:@{@"code":@"-1",@"msg":@"channel sdk logout failed"}];
    [[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

-(void)channel_RegchargOrzOSDKSuccess:(NSDictionary *)result{
    [self.OrzOSDKDelegate RegchargOrzOSDKSuccess:result];
}

-(void)channel_RegchargOrzOSDKFail:(NSDictionary *)result{
    [self.OrzOSDKDelegate RegchargOrzOSDKFail:result];
    [[OrzOSDKUtils getSharedInstance] showOrzOSDKToastMsg:[result objectForKey:@"msg"] view:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}
-(void)channel_openOrzOSDKUserCenter{
    [self.OrzOSDKDelegate openOrzOSDKUserCenter];
}

-(void)channel_closeOrzOSDKUserCenter{
    [self.OrzOSDKDelegate closeOrzOSDKUserCenter];
}





-(BOOL) isOrzOSDKConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    OrzOSDKReachability *reach = [OrzOSDKReachability reachabilityForInternetConnection];
    switch ([reach currentReachabilityStatus]) {
        case OrzOSDKNotReachable:
            isExistenceNetwork = NO;

            break;
        case OrzOSDKReachableViaWiFi:
            isExistenceNetwork = YES;

            break;
        case OrzOSDKReachableViaWWAN:
            isExistenceNetwork = YES;

            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}



@end
