

#import "ViewController.h"
#import <SJIOS/SJIOSSdk.h>

@interface ViewController()



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
    
    
    
    
}

-(void)action_init{
    [SJIOSSdk initSJIOS:YES
            SJIOS_Appid:@"appid_littledemo"
           SJIOS_Appkey:@"appkey_littledemo"
          SJIOS_Channel:@"default"
        SJIOS_Appsecret:@"appsecret_littledemo"
              SJIOS_Gid:@"0"
         SJIOS_RYAppkey:@"0"
        SJIOS_PackageId:@"0"
                success:^(NSString* info){
                    
                    NSLog(@"init success %@", info);
                    
                    [self action_login];
                } failed:^(int error){
                    NSLog(@"init failed %d", error);
                    
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
    
    
}


-(void)closeSJUserCenter:(NSNotification *)notification{
    NSLog(@"---closeSJUserCenter----");
    
    
}

-(void)action_login{
    [SJIOSSdk loginSJIOS:self.view landscapeSJIOS:YES successSJIOS:^(NSString* userInfo){
        NSDictionary *dictionary = (NSDictionary *)userInfo;
        if (dictionary == nil)
        {
            NSLog(@"333");
            
            return;
        }
        //self.IsClickedLogin = NO;
        self.userid = [dictionary objectForKey:@"userid"];
        self.token = [dictionary objectForKey:@"accesstoken"];
        NSLog(@"111  userid = %@", [dictionary objectForKey:@"userid"]);
        NSLog(@"111  accesstoken = %@", [dictionary objectForKey:@"accesstoken"]);
        NSLog(@"111  username = %@", [dictionary objectForKey:@"username"]);
        
        [SJIOSSdk executeSJIOS:self landscapeSJIOS:YES];
        
    } failedSJIOS:^(int error){
        NSLog(@"222");
        
    }];
    
}

-(void)action_logout{
    [SJIOSSdk logoutSJIOS:self.view successSJIOS:^(NSString *info){
        NSLog(@"logout success");
        
        
    }failedSJIOS:^(int error){
        NSLog(@"logout failed");
        
    }];
}

-(void)action_showfloat{
    
}

-(void)action_hidefloat{
    

}

-(void)action_pay{
    NSMutableDictionary * sj_params = [NSMutableDictionary dictionary];
    [sj_params setValue:@"1yuanbao" forKey:SJIOS_PROTOCOL_PRODUCT_NAME];//商品名称，若无，则传商品价格
    [sj_params setValue:@"cn.gamegod.littlegame.diamond60.1" forKey:SJIOS_PROTOCOL_PRODUCT_ID];//苹果内购id
    [sj_params setValue:@"6" forKey:SJIOS_PROTOCOL_ACCOUNT];//商品价格
    [sj_params setValue:@"demo" forKey:SJIOS_PROTOCOL_APP_NAME];//应用名称，由提供
    [sj_params setValue:self.userid forKey:SJIOS_PROTOCOL_USER_ID];//用户id
    [sj_params setValue:[self getSJIOSTimeUserNow] forKey:SJIOS_PROTOCOL_APP_ORDER_ID];//游戏内订单号
    [sj_params setValue:@"1" forKey:SJIOS_PROTOCOL_GATEWAY];//区服id
    [sj_params setValue:@"0" forKey:SJIOS_PROTOCOL_EXTEND_INFO];//透传信息，若无，则传1
    [sj_params setValue:@"1" forKey:SJIOS_PROTOCOL_ROLE_ID];//角色id
    [sj_params setValue:@"1" forKey:SJIOS_PROTOCOL_ROLE_LEVEL];//角色level
    [SJIOSSdk startPSJIOSy:self landscapeSJIOS:YES paramsSJIOS:sj_params successSJIOS:^(NSString * info) {
        NSLog(@"py:%@",info);
        
        
    } failedSJIOS:^(int error) {
        NSLog(@"error:%d",error);
        
        
    }];
    
}

-(NSString*) getSJIOSTimeUserNow
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dataFormate=[[NSDateFormatter alloc]init];
    [dataFormate setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dataFormate stringFromDate:senddate];
    return locationString;
}

-(void)action_createrole{
    
}

-(void)action_rolelogin{
    
}

-(void)action_levelup{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
