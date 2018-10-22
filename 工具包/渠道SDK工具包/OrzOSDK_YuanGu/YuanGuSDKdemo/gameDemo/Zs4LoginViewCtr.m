//
//  Zs4LoginViewCtr.m
//
//  Created by aXiBa on 16/5/13.
//  Copyright © 2016年 aXiBa. All rights reserved.
//

#import "Zs4LoginViewCtr.h"

#import <ZS4Game/Zs4GameHeader.h>

#import <CommonCrypto/CommonDigest.h>
#import "Zs4CreateRoleViewCtr.h"


@interface Zs4LoginViewCtr ()

@end

@implementation Zs4LoginViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录页面";
    
    self.view.backgroundColor = [UIColor redColor];
    
    tfAccount = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, 100)];
    tfAccount.text = @"这句话没有变成用户信息 \n 就说明没有登陆成功哦~";
    tfAccount.numberOfLines = 4;
    tfAccount.font = [UIFont systemFontOfSize:14.0f];
    tfAccount.textColor = [UIColor blackColor];
    tfAccount.backgroundColor = [UIColor whiteColor];
    tfAccount.userInteractionEnabled = NO;
    [self.view addSubview:tfAccount];
    
    
    [self ZYGameUser];
    
//        [[Zs4Game sharedInstance] login];
    //
    //捕获登录消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Zs4GAMELoginNotificationResult:)
                                                 name:Zs4GAMELoginNotification
                                               object:nil];
    
    //捕获注销消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Zs4GAMELogoutNotificationResult:)
                                                 name:Zs4GAMELogoutNotification
                                               object:nil];
    
    //捕获iap支付消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Zs4GAMEPayNotificationResult:)
                                                 name:Zs4GAMEPayNotification
                                               object:nil];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10,50, 100, 44)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"账号中心" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAccountAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10,100 , 100, 44)];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"客服中心" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 addTarget:self action:@selector(btnOnlineAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(10,150 , 100, 44)];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"登录" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor whiteColor];
    [btn3 addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn41 = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 80, 44)];
    btn41.center = self.view.center;
    [btn41 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn41 setTitle:@"下一页" forState:UIControlStateNormal];
    btn41.backgroundColor = [UIColor whiteColor];
    [btn41 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn41];
//    [btn3 setHidden:YES];
    
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(140,50, 100, 44)];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn5 setTitle:@"iap支付" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(btnPayAction) forControlEvents:UIControlEventTouchUpInside];
    btn5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [[UIButton alloc]initWithFrame:CGRectMake(260,50, 100, 44)];
    [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn6 setTitle:@"支付方式" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(btnPayTypeAction) forControlEvents:UIControlEventTouchUpInside];
    btn6.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn6];
    
}

-(void)btnLoginAction
{
    if([[Zs4Game sharedInstance] isShowLoginView]){
        NSLog(@"点击登录");
        }else{
            NSLog(@"你已经退出游戏了哦，需要重新登陆哦！=====");
            [[Zs4Game sharedInstance] login];
        }
}

-(void)btnPayAction
{
    // 测试的使用，正常这个接口会在登录游戏角色后调用
    [[Zs4Game sharedInstance] setServId:@"10001" ServName:@"TEST" RoleId:@"1001" RoleName:@"test user" RoleGrade:1];
    // start pay
    [[Zs4Game sharedInstance] payforProduct:@"shisamenrui6" Expand_Data:@"test data"];
}

-(void)btnPayTypeAction
{
    NSString * paytype = [Zs4Game getPayType];
    
    [[[UIAlertView alloc] initWithTitle:@"支付方式" message:paytype delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnAction1
{
    tfAccount.text = @"================";
    NSLog(@"你！===========================================================");

}

-(void)btnAction
{
    Zs4CreateRoleViewCtr *createRoleView = [[Zs4CreateRoleViewCtr alloc]init];
    [self.navigationController pushViewController:createRoleView animated:YES];
    
}

-(void)btnAccountAction
{
    if ([[Zs4Game sharedInstance] isLogined]) {
        
        
        [[Zs4Game sharedInstance] showAccountCenter];
        
        
        
    }
    
}


-(void)btnOnlineAction
{
    if ([[Zs4Game sharedInstance] isLogined]) {
        
        
        [[Zs4Game sharedInstance] showServiceCenter];
        
        
        
    }
}



# pragma mark - 捕获登录消息
//捕获登录消息
- (void)Zs4GAMELoginNotificationResult:(NSNotification *) notif
{
    NSDictionary *userinfo = [notif userInfo];
    if ([[Zs4Game sharedInstance] isLogined]) {
        // 登录成功后的操作
        
        [[Zs4Game sharedInstance]showLogo];
        // 获取用户id
        NSString *userid = [userinfo objectForKey:@"userid"];
        
        
        // 获取用户昵称
        NSString *nickname = [userinfo objectForKey:@"nickname"];
        // 获取用户usertoken
        NSString *usertoken = [userinfo objectForKey:@"usertoken"];
        
        
        [self TokenCheck:userid
                   token:usertoken];
        
        NSLog(@"userid %@ ,nickname %@ , usertoken %@",userid,nickname,usertoken);
        tfAccount.text = [NSString stringWithFormat:@"userid: %@ \nnickname: %@ \nusertoken: %@",userid,nickname,usertoken];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        btn1.center = self.view.center;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 setTitle:@"进入游戏" forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor whiteColor];
        [btn1 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn1];
        
        
        tfAccount.frame = CGRectMake(0,
                                     CGRectGetMaxY(btn1.frame)+10, 300, 100);
        
        
        
        NSString *sign = [NSString stringWithFormat:@"1000%@0a305ff02845aacdbf9a8dd75c3b8316",usertoken];
        
        NSString *md5 = [self Md5WithSign:sign];
        
        NSLog(@"加密前===： %@  加密后===： %@",sign,md5);
        
        
        NSLog(@"token验证===   http://sdk.Zs4game.com/user/token?app_id=1000&user_id=%@&token=%@&sign=%@",userid,usertoken,md5);
        
    }else {
        
    }
}


# pragma mark - 获取用户信息
- (void)ZYGameUser
{
    if ([[Zs4Game sharedInstance] isLogined]) {
        // 登录成功后的操作
        
        // 获取用户id
        NSString *userid = Zs4GameUser.userid;
        // 获取用户昵称
        NSString *nickname = Zs4GameUser.nickname;
        // 获取用户usertoken
        NSString *usertoken = Zs4GameUser.usertoken;
        
        [self TokenCheck:userid
                   token:usertoken];
        
        NSLog(@"userid %@ ,nickname %@ , usertoken %@",userid,nickname,usertoken);
        tfAccount.text = [NSString stringWithFormat:@"userid: %@ \nnickname: %@ \nusertoken: %@",userid,nickname,usertoken];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
        btn1.center = self.view.center;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 setTitle:@"进入游戏" forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor whiteColor];
        [btn1 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn1];
        
        tfAccount.frame = CGRectMake(0,
                                     CGRectGetMaxY(btn1.frame)+10, 300, 100);
        
        NSString *sign = [NSString stringWithFormat:@"1000%@0a305ff02845aacdbf9a8dd75c3b8316",usertoken];
        
        NSString *md5 = [self Md5WithSign:sign];
        
        NSLog(@"加密前===： %@  加密后===： %@",sign,md5);

        
        NSLog(@"token验证===   http://sdk.Zs4game.com/user/token?app_id=1000&user_id=%@&token=%@&sign=%@",userid,usertoken,md5);
        
    }else {
        
        
        
    }
}

# pragma mark - 捕获登出消息
- (void)Zs4GAMELogoutNotificationResult:(NSNotification *) notif {
    
    tfAccount.text = @"你已经退出游戏了哦，需要重新登陆哦！";

    NSLog(@"你已经退出游戏了哦，需要重新登陆哦！");
    if([[Zs4Game sharedInstance] isShowLoginView]){
    }else{
        NSLog(@"你已经退出游戏了哦，需要重新登陆哦！=====");
        [[Zs4Game sharedInstance] login];
    }
    NSLog(@"点击登录");

    //To do
    //Game  Logout
    //游戏退出
}

# pragma mark - 捕获支付消息
- (void)Zs4GAMEPayNotificationResult:(NSNotification *) notif {
    NSDictionary *payinfo = [notif userInfo];
    
    // 获取支付数据
    NSString *expand_data = [payinfo objectForKey:@"Expand_Data"];
    bool result = [[payinfo objectForKey:@"result"] boolValue];
    NSString *productId = [payinfo objectForKey:@"productId"];
    NSString *msg = [payinfo objectForKey:@"msg"];
    
    [[[UIAlertView alloc] initWithTitle:@"支付结果" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
}


-(void)TokenCheck:(NSString *)uid
            token:(NSString *)token
{
}

- (NSString *) Md5WithSign:(NSString *) input
{
    if(input == nil)
        return @"";
    else{
        
        NSString *inp = [input copy];
        const char *cStr = [inp UTF8String];
        unsigned char digest[16];
        CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", digest[i]];
        
        return  [output copy];
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
