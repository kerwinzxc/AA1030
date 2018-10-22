

#import "RersistenceQuickLogin.h"
#import "RersistenceRegisterView.h"
#import "RersistenceSdkImp.h"
#import "RersistenceUserInfo.h"
#import "RersistenceProgressHUD.h"
#import "RersistenceWebInterface.h"
#import "RersistenceSdkMd5.h"
#import "RersistenceDataBase.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RersistenceYMPhoneRegisterView.h"//跳转到手机注册
#import "RersistenceYMLoginView.h"//跳转到登录界面
#import "RersistenceYMBindPhoneView.h"//跳转到手机绑定
#import "RersistenceNavViewController.h"

#define IS_SHOW_AGREE false//修改这的值来选择是否显示协议
#define Rersistence_USER_AGREEMENT_URL @"https://www.3975.com/public/web/39XY.html"

@interface RersistenceQuickLogin() <UIAlertViewDelegate>

@property(nonatomic, strong) Rersistence_SUCCESS_Callback success;
@property(nonatomic, strong) Rersistence_FAILED_Callback failed;
@property(nonatomic,strong)  RersistenceRegisterView *registerView;
@property(nonatomic,strong) RersistenceProgressHUD *process;
@property(nonatomic,strong) RersistenceYMPhoneRegisterView *ymPhoneRegister;//跳转到手机注册

@property (strong, nonatomic) RersistenceYMBindPhoneView * ymBindPhoneView;//跳转到手机绑定
@property(nonatomic,strong) RersistenceYMLoginView *ymLoginView;//跳转到帐号登录页面
@property(nonatomic,strong) UIButton *choose;

@property(nonatomic,strong) NSString *token;
@property(nonatomic) Boolean SHOWPROCESS;

@property(nonatomic) Boolean isRegister;
@property(nonatomic) Boolean agree;

@property(nonatomic) Boolean landcape;

@end

@implementation RersistenceQuickLogin


- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed landScape:(Boolean)landcape {

    if(landcape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landcape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landcape ];
    }
    
    self.isRegister = NO;
    if (self) {
        self.success=success;
        self.failed=failed;
        self.SHOWPROCESS = false;
        self.landcape = landcape;
        
        self.agree = true;
        
        if(self.landcape){//横屏状态下显示
            
            //logo
            UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 20, 166, 68)];
            logoView.image=[UIImage imageNamed:@"Rersistence.bundle/Rersistence_logo.png"];
            [self.alertContainer addSubview:logoView];
            
            //一键注册
            UIButton *quickLogin=[[UIButton alloc]initWithFrame:CGRectMake(48 , 98, 83, 99)];
            [quickLogin setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_quick_register.png"] forState:UIControlStateNormal];
            [quickLogin addTarget:self action:@selector(quickQuickClick) forControlEvents:UIControlEventTouchUpInside];
            [self.alertContainer addSubview:quickLogin];
            
            //手机注册
            UIButton *cellphoneRegistButton=[[UIButton alloc]initWithFrame:CGRectMake(quickLogin.frame.origin.x+135, 98, 83, 99)];
            [cellphoneRegistButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_phone_register.png"] forState:UIControlStateNormal];
            [cellphoneRegistButton addTarget:self action:@selector(ym_phoneRegister) forControlEvents:UIControlEventTouchUpInside];
            [self.alertContainer addSubview:cellphoneRegistButton];
            
            //登录
            UIButton *ymLoginButton=[[UIButton alloc]initWithFrame:CGRectMake(cellphoneRegistButton.frame.origin.x+135, 98, 83, 99)];
            [ymLoginButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_login.png"] forState:UIControlStateNormal];
            [ymLoginButton addTarget:self action:@selector(ymLogin) forControlEvents:UIControlEventTouchUpInside];
            [self.alertContainer addSubview:ymLoginButton];
            
            UILabel *sdkversion = [[UILabel alloc]initWithFrame:CGRectMake(28, 220, 50, 20)];
            [sdkversion setFont:[UIFont systemFontOfSize:10]];
            [sdkversion setText:Rersistence_SDK_VERSION];
            if(Rersistence_TEXTCOLOR_BLACK == NO){
                sdkversion.textColor = [UIColor whiteColor];
            }
            [sdkversion sizeToFit];
            [self.alertContainer addSubview:sdkversion];
            
            if(IS_SHOW_AGREE){
                self.choose = [[UIButton alloc] initWithFrame:CGRectMake(120, ymLoginButton.frame.origin.y + 115, 20, 20)];
                [self.choose setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_read.png"] forState:
                 UIControlStateNormal];
                [self.choose addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
                [self.alertContainer addSubview:self.choose];
            
                UILabel *agree1 = [[UILabel alloc]initWithFrame:CGRectMake(145, ymLoginButton.frame.origin.y + 118, 85, 18)];
                [agree1 setFont:[UIFont systemFontOfSize:12]];
                [agree1 setText:@"我已阅读并同意"];
                [agree1 sizeToFit];
                [self.alertContainer addSubview:agree1];
            
                UILabel *agree2 = [[UILabel alloc]initWithFrame:CGRectMake(231, ymLoginButton.frame.origin.y + 118, 50, 18)];
                [agree2 setFont:[UIFont systemFontOfSize:12]];
                [agree2 setText:@"《用户协议》"];
                if(Rersistence_TEXTCOLOR_BLACK == YES){
                    [agree2 setTextColor:[UIColor blueColor]];
                }else{
                    [agree2 setTextColor:[UIColor whiteColor]];
                }
                [agree2 sizeToFit];
            
                UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agree2)];
                [agree2 addGestureRecognizer:labelTapGestureRecognizer];
                agree2.userInteractionEnabled = YES; // 可以理解为设置label可被点击
                [self.alertContainer addSubview:agree2];
            }
            
        }else{//竖屏状态下显示
            
            //logo
//            UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 17, 95, 38)];
            UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 30, 160, 62)];
            logoView.image=[UIImage imageNamed:@"Rersistence.bundle/Rersistence_logo.png"];
            [self.alertContainer addSubview:logoView];
            

            
            
            //一键注册
            UIButton *quickLogin=[[UIButton alloc]initWithFrame:CGRectMake(10, 120, 70, 80)];
            [quickLogin setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_quick_register.png"] forState:UIControlStateNormal];
            [quickLogin addTarget:self action:@selector(quickQuickClick) forControlEvents:UIControlEventTouchUpInside];
            [self.alertContainer addSubview:quickLogin];
            
            
            //手机注册
            UIButton *cellphoneRegistButton=[[UIButton alloc]initWithFrame:CGRectMake(quickLogin.frame.origin.x+85, 120, 70, 80)];
            [cellphoneRegistButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_phone_register.png"] forState:UIControlStateNormal];
            [cellphoneRegistButton addTarget:self action:@selector(ym_phoneRegister) forControlEvents:UIControlEventTouchUpInside];
            [self.alertContainer addSubview:cellphoneRegistButton];
            
            
            //登录
            UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake(cellphoneRegistButton.frame.origin.x+85, 120, 70, 80)];
            [loginButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_login.png"] forState:UIControlStateNormal];
            [loginButton addTarget:self action:@selector(ymLogin) forControlEvents:UIControlEventTouchUpInside];
            [self.alertContainer addSubview:loginButton];
            
            
            UILabel *sdkversion = [[UILabel alloc]initWithFrame:CGRectMake(10, 230, 50, 20)];
            [sdkversion setFont:[UIFont systemFontOfSize:10]];
            [sdkversion setText:Rersistence_SDK_VERSION];
            if(Rersistence_TEXTCOLOR_BLACK == NO){
                sdkversion.textColor = [UIColor whiteColor];
            }
            [sdkversion sizeToFit];
            [self.alertContainer addSubview:sdkversion];
            

            
        }
        
    }
    return self;
    
}

  

-(void)agree2{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Rersistence_USER_AGREEMENT_URL]];
}

-(void) chooseClick{
    if(self.agree == true){
        self.agree = false;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_noread.png"] forState:
         UIControlStateNormal];
    }else{
        self.agree = true;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_read.png"] forState:
         UIControlStateNormal];
    }
}




-(void) quickQuickClick{
    if(self.agree == false){
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请详细阅读并同意用户协议"];
        return;
    }
    NSMutableArray *user=[[[RersistenceDataBase alloc]init] getTestList];
    if (user!=nil&&user.count>0) {
        for (int i=0;i<[user count]; i++) {
        RersistenceUserInfo *userinfo=[user objectAtIndex:i];
        if (userinfo.tourist) {
            
            [self startLogin:userinfo];
            break;
        }
    }
    }else{
        [self fastRegister];
    }
}


//登录按钮方法
-(void) ymLogin{
    
    if(self.agree == false){
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    if (self.ymLoginView==nil) {
        self.ymLoginView=[[RersistenceYMLoginView alloc]initWithBlock:self.success failed:self.failed landScape:self.landscape view:self];
    }
    [self.ymLoginView show:self];
}

//手机注册方法
-(void) ym_phoneRegister{
    
    if(self.agree == false){
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    if (self.ymPhoneRegister==nil) {
        self.ymPhoneRegister=[[RersistenceYMPhoneRegisterView alloc]initWithBlock:self.success failed:self.failed landScape:self.landscape view:self];
    }
    [self.ymPhoneRegister show:self];
}





- ( UIImage *)createShareImage:( NSString *)str

{
    
    UIImage *image = [ UIImage imageNamed : @"Rersistence.bundle/Rersistence_buttombackground"];
    UIImage *imagelogo = [ UIImage imageNamed : @"Rersistence.bundle/Rersistence_Rersistence_logo"];
    
    CGSize size= CGSizeMake (image. size . width , image. size . height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions (size, NO , 0.0 );
    
    [image drawAtPoint : CGPointMake ( 0 , 0 )];
    
    [imagelogo drawAtPoint : CGPointMake ( 60 , 20 )];
    // 获得一个位图图形上下文
    
    CGContextRef context= UIGraphicsGetCurrentContext ();
    
    CGContextDrawPath (context, kCGPathStroke );
    
    // 画 打败了多少用户
    [@"快速登录帐号ID" drawAtPoint:CGPointMake(70,imagelogo.size.height +30) withAttributes:@{NSFontAttributeName:[ UIFont fontWithName:@"Arial-BoldMT" size:25], NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [str drawAtPoint : CGPointMake (100 , imagelogo.size.height + 80) withAttributes : @{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 12 ], NSForegroundColorAttributeName :[UIColor blackColor]} ];
    
    
    [@"向客服提供图中帐号ID，可以找回帐号！" drawAtPoint : CGPointMake (8 , image.size.height - 30) withAttributes : @{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 13 ], NSForegroundColorAttributeName :[UIColor redColor]} ];
    //画自己想画的内容。。。。。
    
    // 返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}

-(void)savePhoto: ( NSString *)userid

{
    
    
    UIImage * image = [self createShareImage:userid];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingResult:contextInfo:), nil);
    

}





-(void) image:(UIImage *)image didFinishSavingResult:(NSError *)error contextInfo:(void *)contentInfo
{
    if(error == nil){
        NSLog(@"save success");
        

        
      //  [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"帐号为快速登录帐号,请尽快绑定手机号,以免帐号丢失!\n帐号信息截图已保存到相册中，请妥善保管！"];
        
    }else{
        NSLog(@"save error");

        
      //  [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"该帐号为快速登录帐号,请尽快绑定手机号,以免帐号丢失!"];
    }
}

//点击弹框的取消按钮
-(NSString*)cancelBtnTitle{
    return @"取消";
}

//点击弹框的绑定手机按钮
-(NSString*)otherBtnTitle{
    return @"绑定手机";
}






-(void)fastRegister{
    self.SHOWPROCESS = true;
    [self processRersistenceShow];
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {

            if (dictionary == nil)
            {
                self.SHOWPROCESS = false;
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
                return;
            }
            
            NSLog(@"res = %@", dictionary);
            //"is_register" = 0;不是注册   1注册
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString * user_id = [dictionary valueForKey:@"user_id"];
                NSString * password=[dictionary valueForKey:@"password"];
                NSString * type= [NSString stringWithFormat:@"%@", [dictionary valueForKey:@"type"]];
                NSString * is_register= [NSString stringWithFormat:@"%@", [dictionary valueForKey:@"is_register"]];
                
                NSString *bind;
                if ([type isEqualToString:@"1"]) {//type=1没绑定手机 type=0已绑定手机
                    
                    bind=@"0";
                    
                    if([is_register isEqualToString:@"1"]){
                        //创建一个消息对象
                        NSNotification * notice = [NSNotification notificationWithName:@"registerOK" object:nil userInfo:[dictionary valueForKey:@"id"]];
                        //发送消息
                        [[NSNotificationCenter defaultCenter]postNotification:notice];
                        
                        [[RersistenceSdkImp sharedInstance] sjRersistenceRegister:[dictionary valueForKey:@"id"]];
                        
                        self.isRegister = YES;
                    }
                    
                    
                    
                    
                    [self savePhoto:[dictionary valueForKey:@"id"]];
                    
                }else{
                    
                    bind=@"1";
                }
                
                 RersistenceUserInfo *userinfo=[[RersistenceUserInfo alloc]initWithInfo:user_id password:password bind:bind tourist:@"1" loginTime:[[RersistenceSdkImp sharedInstance]getRersistenceTimeUserNow] phoneNumber:@"0"];
                [self startLogin:userinfo];
            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                self.SHOWPROCESS = false;

            }
            //self.SHOWPROCESS = false;
        }
        @catch(NSException * e)
        {
            
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误"];
            self.SHOWPROCESS = false;
            
        }
        @finally
        {
            //self.SHOWPROCESS = false;
        }
    };
    [[RersistenceWebInterface sharedInstance]fastRersistenceRegisterRersistence:successCallback

         failCallbackRersistence:^(NSError * code) {
             self.SHOWPROCESS = false;
             self.failed(-100);
             [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
    }];
}


- (void) startLogin:(RersistenceUserInfo *) userinfo
{
    NSString *password;
    if ([userinfo.tourist  isEqual:@"1"]) {
        password=userinfo.password;
    }else{
        password =[RersistenceSdkMd5 md5:userinfo.password];
    }
    
    Rersistence_VSD_BLOCK getUserIdCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        
        @try{

            if (dictionary == nil)
            {
                self.SHOWPROCESS=false;
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                //判断是否是注册用户，如果是，则跳实名认证界面
                if(self.isRegister == YES && [[RersistenceSdkImp sharedInstance] getRersistenceShiMingRenZhengFlag] == YES){
                    [[RersistenceSdkImp sharedInstance] showRersistenceShiMingRenZhengView:self.token callbackRersistence:^(NSString *callbackssss){
                        NSString * userid = [dictionary valueForKey:@"id"];
                        
                        NSDictionary *userInfo = [NSMutableDictionary dictionary];
                        [userInfo setValue:self.token forKey:@"accesstoken"];
                        [userInfo setValue:userid forKey:@"userid"];
                        [userInfo setValue:userinfo.username forKey:@"username"];
                        self.success(userInfo);
                        [[RersistenceWebInterface sharedInstance] RersistencesendHeart:userid];
                        self.SHOWPROCESS=false;
                        
                        [[RersistenceSdkImp sharedInstance] addRersistenceUser:userinfo.username passwordRersistence:userinfo.password bindRersistence:userinfo.bind touristRersistence:userinfo.tourist phoneNumberRersistence:userinfo.phoneNumber];
                        
                        //                [self checkAccountIdentity:self.token];//检查有没有实名
                        
                        [self dismissWithAnimation:YES];//取消消失的baseview，不然不能显示手机绑定界面
                    }];
                    self.isRegister = NO;
                }else{
                    NSString * userid = [dictionary valueForKey:@"id"];
                    
                    NSDictionary *userInfo = [NSMutableDictionary dictionary];
                    [userInfo setValue:self.token forKey:@"accesstoken"];
                    [userInfo setValue:userid forKey:@"userid"];
                    [userInfo setValue:userinfo.username forKey:@"username"];
                    self.success(userInfo);
                    [[RersistenceWebInterface sharedInstance] RersistencesendHeart:userid];
                    self.SHOWPROCESS=false;
                    
                    [[RersistenceSdkImp sharedInstance] addRersistenceUser:userinfo.username passwordRersistence:userinfo.password bindRersistence:userinfo.bind touristRersistence:userinfo.tourist phoneNumberRersistence:userinfo.phoneNumber];
                    
                    //                [self checkAccountIdentity:self.token];//检查有没有实名
                    
                    [self dismissWithAnimation:YES];//取消消失的baseview，不然不能显示手机绑定界面
                }
                
                
                
                
                
                
            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                self.SHOWPROCESS=false;
                
            }
        }@catch(NSException * e)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误" ];
            self.SHOWPROCESS=false;
        }
        @finally
        {
            self.SHOWPROCESS=false;
       //     [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
        }
    };
    
    Rersistence_VSD_BLOCK getTokenCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.SHOWPROCESS=false;
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString * access_token = [dictionary valueForKey:@"access_token"];
                self.token = [[NSString alloc] initWithFormat:@"%@", access_token];
                
                NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
                NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
                if(tokenDic == nil){
                    tokenDic = [NSMutableDictionary dictionary];
                    [tokenDic setValue:access_token forKey:@"ACCESS_TOKEN"];
                    [tokenDic writeToFile:token atomically:YES];
                    
                }else{
                    [tokenDic setValue:access_token forKey:@"ACCESS_TOKEN"];
                    [tokenDic writeToFile:token atomically:YES];
                    
                }
                
                _process.labelText = @"正在获取信息";
                [[RersistenceWebInterface sharedInstance] getRersistenceUserId:access_token
                                          successCallbackRersistence:getUserIdCompletionBlock
                                              failCallbackRersistence:^(NSError *error){
                                                  self.SHOWPROCESS=false;
                                                  self.failed(-101);
                                                  [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
                                              }];
            }
            else
            {
                self.SHOWPROCESS=false;
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                
            }
        }@catch(NSException * e)
        {
            self.SHOWPROCESS=false;
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误" ];
            
        }
        @finally
        {
          //  self.SHOWPROCESS=false;
         //   [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
        }
    };
    
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        
        @try
        {

            if (dictionary == nil)
            {
                self.SHOWPROCESS=false;
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                
                
                _process.labelText = @"正在验证";
                [[RersistenceWebInterface sharedInstance] getRersistenceAccessTokenRersistence:[dictionary valueForKey:@"code"]
                                               successCallbackRersistence:getTokenCompletionBlock
                                                   failCallbackRersistence:^(NSError *error){
                                                       self.SHOWPROCESS=false;
                                                       self.failed(-102);
                                                       [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
                                                   }];
                
                
                

            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                self.SHOWPROCESS=false;

            }
        }
        @catch(NSException * e)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误" ];
                    self.SHOWPROCESS=false;
        }
        @finally
        {
       //     [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
          //  self.SHOWPROCESS=false;
        }
    };

    [[RersistenceWebInterface sharedInstance] loginRersistence:userinfo.username
                                 passwordRersistence:password
                          successCallbackRersistence:successCallback
                              failCallbackRersistence:^(NSError * error) {
                                  self.SHOWPROCESS=false;
                                  self.failed(-103);
                                  [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
                              }
     ];
    
    
}

-(void) show:(UIView *)view{
    [super show:view];
}


//检查身份验证
-(void)checkAccountIdentity:(NSString *)access_token{
    
    [[RersistenceWebInterface sharedInstance] checkRersistenceIdentify:access_token successCallbackRersistence:^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                [self dismissWithAnimation:YES];
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *unknown = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"unknown"]];
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                
                if ([unknown isEqualToString:@"1"])
                {
                    self.sjValidateIdentity = [[SJ_ValidateIdentity alloc] initWithBlock:access_token complete:^(NSString *str1, NSString *str2){
                        [self dismissWithAnimation:YES];
                    } landscape:self.landcape];
                    [self.sjValidateIdentity show:self];
                    
                }else
                {
                    [self dismissWithAnimation:YES];
                    
                }
            }
            
        }
        @catch(NSException * e)
        {
            [self dismissWithAnimation:YES];
        }
    } failCallbackRersistence:^(NSError *code) {
        [self dismissWithAnimation:YES];
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"获取身份证认证信息失败" ];
    }];
}



//关闭按钮
- (void) closeLogin{
    [super dismissWithAnimation:YES];
}

-(void)processRersistenceShow {
    if (self.process == nil) {
        self.process = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
        
    }
    [self.alertContainer addSubview:_process];
    _process.labelText = @"正在登录";
    
    [_process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESS)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } successCallback:^{
        [_process removeFromSuperview];
    }];
    
    
    
}
@end
