

#import "OrzOSDKBranch_LeYouSiHai.h"

@implementation OrzOSDKBranch_LeYouSiHai


-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"1.0.0";
}

-(void)doOrzOSDKChannelInit{
//    NSLog(@"OrzOSDKBranch_LeYouSiHai doChannelInit  !");
//    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
//    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
//    //SDK配置
//    BTGOConfig*config = [[BTGOConfig alloc] init];
//    //配置对应的appId
//    config.appId = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_LeYouSiHai_appid"]];
//    //配置对应的appKey
//    config.appKey = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_LeYouSiHai_appkey"]];
//    NSLog(@"appid = %@", config.appId);
//    NSLog(@"appkey = %@", config.appKey);
//
//    [BTGOSDK initSDKWithSetBTGOConfig:config target:self ];
//
//    [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
    NSLog(@"OrzOSDKBranch_LeYouSiHai doChannelInit  !");
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
    self.param_lysh_appid = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_LeYouSiHai_appid"]];
    
    //参数为AppID  App的唯一标识
    [[BBBGameManager shareManager] txy_initGameKey:[channel_config objectForKey:self.param_lysh_appid]];
    
    [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
    
}

-(void)completionHandler:(id)sender {
    NSDictionary *userInfo = [sender userInfo];
    NSInteger eventCode = [userInfo[KEY_EVENT_CODE] integerValue];
    NSDictionary *data = userInfo[KEY_DATA];
    switch (eventCode) {
            case BTGO_LOGIN_SUCCESS:
            //登录成功，游戏可从此获取账号信息
            NSLog(@"userid=%@", [data objectForKey:@"userid"]);
            NSLog(@"token=%@", [data objectForKey:@"token"]);
            NSLog(@"登录成功");
            [self.delegate channel_loginOrzOSDKSuccess:@{@"channel_uid":[data objectForKey:@"userid"],
                                                         @"channel_username":[data objectForKey:@"userid"],
                                                         @"channel_token":[data objectForKey:@"token"],
                                                         @"channel_deviceid":@""}];
            break;
            case BTGO_PAY_SUCCESS:
            //支付成功
            NSLog(@"支付成功,订单号：%@", data[EXTRA_OUT_ORDER_ID]);
            [self.delegate channel_RegchargOrzOSDKSuccess:@{@"code":@"0",@"msg":@"支付成功"}];
            break;
            case BTGO_PAY_CANCEL:
            //支付取消
            [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":@"支付取消"}];
            NSLog(@"支付取消");
            break;
            case BTGO_PAY_FAILED:
            //支付失败
            [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":@"支付失败"}];
            NSLog(@"支付失败");
            break;
        default:
            break;
    }
}

-(void)doOrzOSDKChannelLogin{
    
    NSLog(@"OrzOSDKBranch_LeYouSiHai doChannelLogin");
    [BTGOSDK login];
}

-(void)doOrzOSDKChannelRealNameRegister:(int)flag callback:(OrzOSDKShiMimgRenZhengCallback)callback{

}

-(void)doOrzOSDKChannelSwitchAccount{
    
}


-(void)doOrzOSDKChannelLogout{
    
}

-(void)doChannelshowOrzOSDKGameCenter{
    
}

-(void)doChannelshowOrzOSDKFloatView{
    
}

-(void)doChannelhideOrzOSDKFloatView{
    
}

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params{
    /******************充值调用 ******/
    BTGOPayInfo *model = [[BTGOPayInfo alloc]init];
    // 订单号，必须保证唯一性
    model.orderId =  [params objectForKey:OrzOSDK_IOS_ORDERID];
    // 充值金额，单位为分
    model.money =[[params objectForKey:OrzOSDK_IOS_PRODUCT_PRICE] intValue] *100;
    // 苹果IAP产品ID  注：如果需要上架AppStore 必须传对应的产品id，产品id命名规则建议 bundleID +游戏名称缩写+金额，
    model.productId = [params objectForKey:OrzOSDK_IOS_PRODUCT_ID];
    // 扩展字段，服务端会原样返回
    model.ext = [params objectForKey:OrzOSDK_IOS_ORDERID];
    // 角色ID
    model.roleId = self.roleId;
    // 角色名
    model.roleName = self.roleName;
    // 角色等级
    model.roleLevel = self.roleLevel;
    // 区服ID
    model.serverId = self.serverId;
    // 区服名
    model.serverName = self.serverName;
    
    [BTGOSDK payWithPayInfo:model];
}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_LEVEL]];
    self.roleName = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_NAME]];
    self.serverName = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_NAME]];
    if([dataPoint isEqualToString:OrzOSDK_SUBMIT_ROLE_ENTERSERVER]){
    //上传角色信息，进入游戏时调一次
        BTGORole *role = [[BTGORole alloc] init];
        //角色的id
        role.roleId = self.roleId;
        // 角色名
        role.roleName = self.roleName;
        // 角色等级
        role.roleLevel =self.roleLevel;
        // 区服ID
        role.serverId = self.serverId;
        // 区服名
        role.serverName = self.serverName;
        
        [BTGOSDK sendBTGORole:role];
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
    [BTGOSDK onEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}
- (void)applicationWillTerminate:(UIApplication *)application{
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [BTGOSDK onOpenUrl:url];
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [BTGOSDK onOpenUrl:url];
    return TRUE;
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return TRUE;
}


@end
