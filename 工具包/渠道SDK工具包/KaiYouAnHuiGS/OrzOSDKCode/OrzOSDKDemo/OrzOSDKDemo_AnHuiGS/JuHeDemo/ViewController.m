

#import "ViewController.h"
#import "OrzOSDK.h"
#import "OrzOSDKUtils.h"

@interface ViewController()<OrzOSDKDelegate>



@end

@implementation ViewController

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
    
    
}

-(void)action_init{
    [OrzOSDK getSharedInstance].OrzOSDKDelegate = self;
    [[OrzOSDK getSharedInstance] initOrzOSDK];
    
}


-(void)action_login{
    if(self.bInitSuccess == true){
        [[OrzOSDK getSharedInstance] startOrzOSDKLogin];
    }

}

-(void)action_logout{
    [[OrzOSDK getSharedInstance] startOrzOSDKLogout];
}

-(void)action_showfloat{
    [[OrzOSDK getSharedInstance] showOrzOSDKFloatView];
}

-(void)action_hidefloat{
    [[OrzOSDK getSharedInstance] hideOrzOSDKFloatView];
}

-(void)action_pay{
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString* orderId = [NSString stringWithFormat:@"demo%f", a];
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"600商品" forKey:OrzOSDK_IOS_PRODUCT_NAME];//必传，商品名称
    [data setValue:@"com.sanjiu.cqwz.gold600" forKey:OrzOSDK_IOS_PRODUCT_ID];//必传，商品id，由提供
    [data setValue:orderId forKey:OrzOSDK_IOS_CP_ORDERID];//必传，CP订单号，若无，则传时间戳
    [data setValue:@"OrzOSDK_IOS_PRODUCT_DESC" forKey:OrzOSDK_IOS_PRODUCT_DESC];//必传，若无，则传商品名称
    [data setValue:@"6" forKey:OrzOSDK_IOS_PRODUCT_PRICE];//必传，商品价格，单位：元
    [data setValue:@"1" forKey:OrzOSDK_IOS_GOODS_NUM];//必传，商品购买数量；一般传1
    [data setValue:@"OrzOSDK_IOS_EXTRA" forKey:OrzOSDK_IOS_EXTRA];//可选，扩展信息，若无，则传空
    [data setValue:@"OrzOSDK_IOS_ROLE_ID" forKey:OrzOSDK_IOS_ROLE_ID];//可选，角色id，若无，则传空
    [data setValue:@"OrzOSDK_IOS_ROLE_NAME" forKey:OrzOSDK_IOS_ROLE_NAME];//可选，角色名称，若无，则传空
    [data setValue:@"OrzOSDK_IOS_ROLE_LEVEL" forKey:OrzOSDK_IOS_ROLE_LEVEL];//可选，角色等级，若无，则传空
    [data setValue:@"OrzOSDK_IOS_SERVER_ID" forKey:OrzOSDK_IOS_SERVER_ID];//可选，服务器id，若无，则传空
    [data setValue:@"OrzOSDK_IOS_SERVER_NAME" forKey:OrzOSDK_IOS_SERVER_NAME];//可选，服务器名称，若无，则传空
    [[OrzOSDK getSharedInstance] startOrzOSDKRegcharg:data];
    
}

-(void)action_createrole{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"1" forKey:OrzOSDK_ROLE_ID];//必传，角色ID
    [data setValue:@"1" forKey:OrzOSDK_ROLE_LEVEL];//必传，角色等级
    [data setValue:@"roleName" forKey:OrzOSDK_ROLE_NAME];//必传，角色名称
    [data setValue:@"roleCreateTime" forKey:OrzOSDK_ROLE_CREATE_TIME];//必传，角色创建时间
    [data setValue:@"1" forKey:OrzOSDK_SERVER_ID];//必传，服务器id
    [data setValue:@"serverName" forKey:OrzOSDK_SERVER_NAME];//必传，服务器名称
    [[OrzOSDK getSharedInstance] sendOrzOSDKData:OrzOSDK_SUBMIT_ROLE_CREATE data:data];
}

-(void)action_rolelogin{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"429501024580076" forKey:OrzOSDK_ROLE_ID];//必传，角色ID
    [data setValue:@"1" forKey:OrzOSDK_ROLE_LEVEL];//必传，角色等级
    [data setValue:@"寒恒树·乾扬" forKey:OrzOSDK_ROLE_NAME];//必传，角色名称
    [data setValue:@"1518066017" forKey:OrzOSDK_ROLE_CREATE_TIME];//必传，角色创建时间
    [data setValue:@"1" forKey:OrzOSDK_SERVER_ID];//必传，服务器id
    [data setValue:@"重装1区(新)" forKey:OrzOSDK_SERVER_NAME];//必传，服务器名称
    [[OrzOSDK getSharedInstance] sendOrzOSDKData:OrzOSDK_SUBMIT_ROLE_ENTERSERVER data:data];
}

-(void)action_levelup{
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"429501024580076" forKey:OrzOSDK_ROLE_ID];//必传，角色ID
    [data setValue:@"1" forKey:OrzOSDK_ROLE_LEVEL];//必传，角色等级
    [data setValue:@"寒恒树·乾扬" forKey:OrzOSDK_ROLE_NAME];//必传，角色名称
    [data setValue:@"1518066017" forKey:OrzOSDK_ROLE_CREATE_TIME];//必传，角色创建时间
    [data setValue:@"1" forKey:OrzOSDK_SERVER_ID];//必传，服务器id
    [data setValue:@"重装1区(新)" forKey:OrzOSDK_SERVER_NAME];//必传，服务器名称
    [[OrzOSDK getSharedInstance] sendOrzOSDKData:OrzOSDK_SUBMIT_ROLE_LEVELUP data:data];
}

//---------------OrzOSDKDelegate---------------
-(void)initOrzOSDKSuccess:(NSDictionary *)result{
    /*initSuccess : {
        code = 0;
        msg = "init success!";
        serverid = release;
    }*/
    NSLog(@"initSuccess : %@", result);
    
    self.bInitSuccess = true;
    
    //初始化成功回调内有serverid，此参数为后台配置的服务器状态。
    //游戏研发可以通过此参数来切换提审服和正式服。
    //具体取值可以双方商定。
    NSString *serverid = [[NSString alloc] initWithFormat:@"%@", [result objectForKey:@"serverid"]];
    
    [self action_login];
}

-(void)initOrzOSDKFail:(NSDictionary *)result{
    NSLog(@"initFail : %@", result);
    self.bInitSuccess = false;
}

-(void)loginOrzOSDKSuccess:(NSDictionary *)result{
    NSLog(@"loginSuccess : %@", result);
    
    /*loginSuccess : {
        "channel_id" = 19;
        "channel_name" = juhesdk;
        "channel_userid" = xxx;
        code = 0;
        "juhe_nickname" = xxx;
        "juhe_token" = 9487e62efaa669fbcccadf1d39a74c01;
        "juhe_userid" = 6;
        "juhe_username" = "xxx.juhe";
        msg = "login success";
    }*/
}

-(void)loginOrzOSDKFail:(NSDictionary *)result{
    NSLog(@"loginFail , result = %@", result);
}

-(void)logoutOrzOSDKSuccess:(NSDictionary *)result{
    NSLog(@"logoutSuccess , result = %@", result);
}

-(void)logoutOrzOSDKFail:(NSDictionary *)result{
    NSLog(@"logoutFail , result = %@", result);
}

-(void)RegchargOrzOSDKSuccess:(NSDictionary *)result{
    NSLog(@"IOSSuccess , result = %@", result);
}

-(void)RegchargOrzOSDKFail:(NSDictionary *)result{
    NSLog(@"IOSFail , result = %@", result);
}

-(void)openOrzOSDKUserCenter{
    NSLog(@"openUserCenter");
}
-(void)closeOrzOSDKUserCenter{
    NSLog(@"closeUserCenter");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
