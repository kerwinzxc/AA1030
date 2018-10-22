

#import "ViewController.h"
#import <XLSDK/XLSDK.h>
#import <XLSDK/XLSDKUtils.h>

@interface ViewController()<XLSDKDelegate>



@end

@implementation ViewController

- (BOOL)shouldAutorotate {
    return YES;
}
//支持的方向 因为界面A我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    self.bInitSuccess = false;
    
    
    UIButton *btn_init = [UIButton buttonWithType:0];
    btn_init.frame = CGRectMake(20, 20, 100, 30);
    btn_init.backgroundColor = [UIColor blueColor];
    [btn_init setTitle:@"初始化" forState:UIControlStateNormal];
    [btn_init addTarget:self action:@selector(action_init) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_init];
    
    
    UIButton *btn_login = [UIButton buttonWithType:0];
    btn_login.frame = CGRectMake(20, 70, 100, 30);
    btn_login.backgroundColor = [UIColor blueColor];
    [btn_login setTitle:@"登录" forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(action_login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_login];
    
    
    UIButton *btn_logout = [UIButton buttonWithType:0];
    btn_logout.frame = CGRectMake(20, 120, 100, 30);
    btn_logout.backgroundColor = [UIColor blueColor];
    [btn_logout setTitle:@"登出" forState:UIControlStateNormal];
    [btn_logout addTarget:self action:@selector(action_logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_logout];
    
    
    UIButton *btn_showfloat = [UIButton buttonWithType:0];
    btn_showfloat.frame = CGRectMake(150, 20, 100, 30);
    btn_showfloat.backgroundColor = [UIColor blueColor];
    [btn_showfloat setTitle:@"显示浮标" forState:UIControlStateNormal];
    [btn_showfloat addTarget:self action:@selector(action_showfloat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_showfloat];
    
    
    UIButton *btn_hidefloat = [UIButton buttonWithType:0];
    btn_hidefloat.frame = CGRectMake(150, 70, 100, 30);
    btn_hidefloat.backgroundColor = [UIColor blueColor];
    [btn_hidefloat setTitle:@"隐藏浮标" forState:UIControlStateNormal];
    [btn_hidefloat addTarget:self action:@selector(action_hidefloat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_hidefloat];
    
    UIButton *btn_pay = [UIButton buttonWithType:0];
    btn_pay.frame = CGRectMake(150, 120, 100, 30);
    btn_pay.backgroundColor = [UIColor blueColor];
    [btn_pay setTitle:@"支付" forState:UIControlStateNormal];
    [btn_pay addTarget:self action:@selector(action_pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_pay];
    
    
    UIButton *btn_createrole = [UIButton buttonWithType:0];
    btn_createrole.frame = CGRectMake(20, 170, 100, 30);
    btn_createrole.backgroundColor = [UIColor blueColor];
    [btn_createrole setTitle:@"创建角色" forState:UIControlStateNormal];
    [btn_createrole addTarget:self action:@selector(action_createrole) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_createrole];
    
    UIButton *btn_rolelogin = [UIButton buttonWithType:0];
    btn_rolelogin.frame = CGRectMake(150, 170, 100, 30);
    btn_rolelogin.backgroundColor = [UIColor blueColor];
    [btn_rolelogin setTitle:@"角色登陆" forState:UIControlStateNormal];
    [btn_rolelogin addTarget:self action:@selector(action_rolelogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_rolelogin];
    
    UIButton *btn_levelup = [UIButton buttonWithType:0];
    btn_levelup.frame = CGRectMake(20, 220, 100, 30);
    btn_levelup.backgroundColor = [UIColor blueColor];
    [btn_levelup setTitle:@"角色升级" forState:UIControlStateNormal];
    [btn_levelup addTarget:self action:@selector(action_levelup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_levelup];
    
    
//    SEL selectorsasd = NSSelectorFromString(@"wolegeca");
//    [self performSelector:selectorsasd];
//
//    SEL selectorsasd1 = NSSelectorFromString(@"wolegecab:");
//    NSMutableDictionary *params_final = [[NSMutableDictionary alloc] initWithDictionary:nil];
//    [params_final setValue:@"11" forKey:@"1"];
//    [params_final setValue:@"22" forKey:@"2"];
//    [self performSelector:selectorsasd1 withObject:params_final];
    
}

//-(void)wolegeca{
//    NSLog(@"wolegeca");
//}
//
//-(void)wolegecab:(NSDictionary *)str{
//    NSLog(@"wolegeca  %@", str);
//}

-(void)action_init{
    [XLSDK getSharedInstance].xlSDKDelegate = self;
    [[XLSDK getSharedInstance] initXLSDK];

}


-(void)action_login{

    [[XLSDK getSharedInstance] startXLSDKLogin];
}

-(void)action_logout{
    [[XLSDK getSharedInstance] startXLSDKLogout];
}

-(void)action_showfloat{
    [[XLSDK getSharedInstance] showXLSDKFloatView];
}

-(void)action_hidefloat{
    [[XLSDK getSharedInstance] hideXLSDKFloatView];

}

-(void)action_pay{
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString* orderId = [NSString stringWithFormat:@"demo%f", a];
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"60yuanbao" forKey:XLSDK_IOS_PRODUCT_NAME];//必传，商品名称
    [data setValue:@"6" forKey:XLSDK_IOS_PRODUCT_ID];//必传，商品id，由运营提供
    [data setValue:orderId forKey:XLSDK_IOS_CP_ORDERID];//必传，CP订单号，若无，则传时间戳
    [data setValue:@"OrzOSDK_IOS_PRODUCT_DESC" forKey:XLSDK_IOS_PRODUCT_DESC];//必传，若无，则传商品名称
    [data setValue:@"6" forKey:XLSDK_IOS_PRODUCT_PRICE];//必传，商品价格，单位：元,不带小数点
    [data setValue:@"1" forKey:XLSDK_IOS_GOODS_NUM];//必传，商品购买数量；一般传1
    [data setValue:@"OrzOSDK_IOS_EXTRA" forKey:XLSDK_IOS_EXTRA];//可选，扩展信息，若无，则传空
    [data setValue:@"OrzOSDK_IOS_ROLE_ID" forKey:XLSDK_IOS_ROLE_ID];//可选，角色id，若无，则传空
    [data setValue:@"OrzOSDK_IOS_ROLE_NAME" forKey:XLSDK_IOS_ROLE_NAME];//可选，角色名称，若无，则传空
    [data setValue:@"OrzOSDK_IOS_ROLE_LEVEL" forKey:XLSDK_IOS_ROLE_LEVEL];//可选，角色等级，若无，则传空
    [data setValue:@"OrzOSDK_IOS_SERVER_ID" forKey:XLSDK_IOS_SERVER_ID];//可选，服务器id，若无，则传空
    [data setValue:@"OrzOSDK_IOS_SERVER_NAME" forKey:XLSDK_IOS_SERVER_NAME];//可选，服务器名称，若无，则传空
    [[XLSDK getSharedInstance] startXLSDKRegcharg:data];
    
}

-(void)action_createrole{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"1" forKey:XLSDK_ROLE_ID];//必传，角色ID
    [data setValue:@"1" forKey:XLSDK_ROLE_LEVEL];//必传，角色等级
    [data setValue:@"roleName" forKey:XLSDK_ROLE_NAME];//必传，角色名称
    [data setValue:@"roleCreateTime" forKey:XLSDK_ROLE_CREATE_TIME];//必传，角色创建时间，时间戳，精确到秒
    [data setValue:@"1" forKey:XLSDK_SERVER_ID];//必传，服务器id
    [data setValue:@"serverName" forKey:XLSDK_SERVER_NAME];//必传，服务器名称
    [[XLSDK getSharedInstance] sendXLSDKData:XLSDK_SUBMIT_ROLE_CREATE data:data];
}

-(void)action_rolelogin{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"1" forKey:XLSDK_ROLE_ID];//必传，角色ID
    [data setValue:@"1" forKey:XLSDK_ROLE_LEVEL];//必传，角色等级
    [data setValue:@"roleName" forKey:XLSDK_ROLE_NAME];//必传，角色名称
    [data setValue:@"roleCreateTime" forKey:XLSDK_ROLE_CREATE_TIME];//必传，角色创建时间，时间戳，精确到秒
    [data setValue:@"1" forKey:XLSDK_SERVER_ID];//必传，服务器id
    [data setValue:@"serverName" forKey:XLSDK_SERVER_NAME];//必传，服务器名称
    [[XLSDK getSharedInstance] sendXLSDKData:XLSDK_SUBMIT_ROLE_ENTERSERVER data:data];
}

-(void)action_levelup{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"1" forKey:XLSDK_ROLE_ID];//必传，角色ID
    [data setValue:@"1" forKey:XLSDK_ROLE_LEVEL];//必传，角色等级
    [data setValue:@"roleName" forKey:XLSDK_ROLE_NAME];//必传，角色名称
    [data setValue:@"roleCreateTime" forKey:XLSDK_ROLE_CREATE_TIME];//必传，角色创建时间，时间戳，精确到秒
    [data setValue:@"1" forKey:XLSDK_SERVER_ID];//必传，服务器id
    [data setValue:@"serverName" forKey:XLSDK_SERVER_NAME];//必传，服务器名称
    [[XLSDK getSharedInstance] sendXLSDKData:XLSDK_SUBMIT_ROLE_LEVELUP data:data];
}

//---------------OrzOSDKDelegate---------------
-(void)initXLSDKSuccess:(NSDictionary *)result{
    NSLog(@"initSuccess : %@", result);
    /*
     initSuccess : {
     "channel_id" = 111;
     code = 0;
     msg = "init success!";
     serverid = "xx";
     }*/
    [[XLSDK getSharedInstance] startXLSDKLogin];
}

-(void)initXLSDKFail:(NSDictionary *)result{
    NSLog(@"initFail : %@", result);
}

-(void)loginXLSDKSuccess:(NSDictionary *)result{
    NSLog(@"loginSuccess : %@", result);
    
    /*loginSuccess : {
     "channel_id" = 19;
     "channel_name" = juhesdk;
     "channel_userid" = xxx;
     code = 0;
     "juhe_nickname" = xxx;
     "juhe_userid" = 6;
     "juhe_username" = "xxx.juhe";
     "juhe_token" = "xxx";
     msg = "login success";
     }*/
    [[XLSDK getSharedInstance] showXLSDKFloatView];
}

-(void)loginXLSDKFail:(NSDictionary *)result{
    NSLog(@"loginFail , result = %@", result);
}

-(void)logoutXLSDKSuccess:(NSDictionary *)result{
    NSLog(@"logoutSuccess , result = %@", result);
}

-(void)logoutXLSDKFail:(NSDictionary *)result{
    NSLog(@"logoutFail , result = %@", result);
}

-(void)RegchargXLSDKSuccess:(NSDictionary *)result{
    NSLog(@" result = %@", result);
}

-(void)RegchargXLSDKFail:(NSDictionary *)result{
    NSLog(@"result = %@", result);
}

-(void)openXLSDKUserCenter{
    NSLog(@"openUserCenter");
}
-(void)closeXLSDKUserCenter{
    NSLog(@"closeUserCenter");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
