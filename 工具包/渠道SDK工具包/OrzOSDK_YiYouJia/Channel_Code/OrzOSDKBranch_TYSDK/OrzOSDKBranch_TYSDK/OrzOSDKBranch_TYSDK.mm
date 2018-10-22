

#import "OrzOSDKBranch_TYSDK.h"
#import <UIKit/UIKit.h>
#import "TYSDK.h"
#import "TYReceiveDataModel.h"

@implementation OrzOSDKBranch_TYSDK


-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"1.0.0";
}

//初始化
-(void)doOrzOSDKChannelInit{
    NSLog(@"OrzOSDKBranch_TYSDK doChannelInit  !");
    NSDictionary *dict = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
    NSDictionary *channel_config = [dict objectForKey:@"ChannelParams"];
    self.appKey_tysdk = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_tysdk_appKey"]];
    self.rate = [[NSString alloc] initWithFormat:@"%@", [channel_config objectForKey:@"channel_tysdk_rate"]];
    NSLog(@"appKey = %@",self.appKey_tysdk);
    [[TYSDK sharedSDK] TYSDKinitAndAppKey:self.appKey_tysdk];
    
    [self.delegate channel_initOrzOSDKSuccess:@{@"code":@"1",@"msg":@"success"}];
    
}


//登入
-(void)doOrzOSDKChannelLogin{
    NSLog(@"OrzOSDKBranch_TYSDK doChannelLogin");
    [[TYSDK sharedSDK] TYaddController:[self getOrzOSDKCurrentViewController]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidloggoNotifcation:) name:TYAppDidloginNotification object:nil];
}


//登录回调消息
- (void)DidloggoNotifcation:(NSNotification*)notification{
    NSLog(@">>>>>>>>>>%@",notification.userInfo);
    
    [self.delegate channel_loginOrzOSDKSuccess:@{@"channel_uid":notification.userInfo[@"userid"],
                                                 @"channel_username":notification.userInfo[@"userid"],
                                                 @"channel_token":notification.userInfo[@"vkey"],
                                                 @"channel_deviceid":@""}];
    
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
    NSLog(@"OrzOSDKBranch_TYSDK doOrzOSDKChannelRegcharg");
    /*
     @param serverid 游戏区服
     @param roleid 游戏角色id
     @param amt 充值实收金额
     @param goodsid 商品id
     @param paygold 游戏币
     @param cporder cp方订单号  长度64位以内
     @param customParameter 自定义参数(可透传，默认@"") 不建议使用特殊字符
     */
    TYReceiveDataModel *mode = [TYReceiveDataModel new];
    mode.TYCustomParameter = [params objectForKey:OrzOSDK_IOS_CP_ORDERID];
    mode.TYServerid = [params objectForKey:OrzOSDK_SERVER_ID];
    //充值比例
    NSInteger TYPaygold = [mode.TYPaygold integerValue];
    TYPaygold =  [[params objectForKey:OrzOSDK_IOS_PRODUCT_PRICE] intValue] * [self.rate intValue];
    mode.TYGoodsid = [params objectForKey:OrzOSDK_IOS_PRODUCT_ID];//内购ID
    mode.TYCporder = [params objectForKey:OrzOSDK_IOS_ORDERID];
    mode.TYRoleid = [params objectForKey:OrzOSDK_IOS_ROLE_ID];
    mode.TYAmt =  [params objectForKey:OrzOSDK_IOS_PRODUCT_PRICE];
    [[TYSDK sharedSDK]TYJoinUpIapPassModel:mode addController:[self getOrzOSDKCurrentViewController]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppDidPaymentNotification:) name:TYAppDidPaymentNotification object:nil];
}
- (void)AppDidPaymentNotification:(NSNotification*)notification{
    NSString *resultStr = nil;
    if ([[notification.userInfo valueForKey:@"TYResult"] integerValue] == 0) {
        resultStr = @"支付取消";
        [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":resultStr}];
    }
    if ([[notification.userInfo valueForKey:@"TYResult"] integerValue] == 1) {
        resultStr = @"支付成功";
        [self.delegate channel_RegchargOrzOSDKSuccess:@{@"code":@"0",@"msg":resultStr}];
    }
    if ([[notification.userInfo valueForKey:@"TYResult"] integerValue] == -1) {
        resultStr = @"支付失败";
        [self.delegate channel_RegchargOrzOSDKFail:@{@"code":@"-2",@"msg":resultStr}];
    }
    NSLog(@"resultStr = %@",resultStr);
}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    /*
     mark 统计备注
     @param roleid 角色id
     @param rolename 角色昵称
     @param rolelevel 角色等级
     @param zoneid 区服id
     @param zonename 区服名称
     */
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_LEVEL]];
    self.roleName = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_NAME]];
    self.serverName = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_NAME]];
    if([dataPoint isEqualToString:OrzOSDK_SUBMIT_ROLE_ENTERSERVER]){
        TYReceiveStatisticsDataModel *mode = [[TYReceiveStatisticsDataModel alloc]init];
        mode.TYMark = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
        mode.TYRoleid = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
        mode.TYZoneid = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_ID]];
        mode.TYRolename = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_ROLE_NAME]];
        mode.TYZonename = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_NAME]];
        mode.TYRolelevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:OrzOSDK_SERVER_ID]];
        [[TYSDK sharedSDK]TYJoinUpStatisticsModel:mode];
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

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return TRUE;
}


@end
