
#import "UIImage+SJIOSSdk.h"
#import "UIColor+SJIOSSdk.h"
#import "SJIOSCommonApi.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSSdkImp.h"
#import "SJIOSProgressHUD.h"

#import "SJIOSDataBase.h"
#import "SJIOSRegisterView.h"
#import "SJIOSYMPhoneLogin.h"
#import "SJIOSYMPhoneRegisterView.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSForgetView.h"
#define SJIOS_USER_AGREEMENT_URL @"http://www.3975.com/public/web/39XY.html"

@interface SJIOSYMPhoneLogin()

@property(nonatomic, strong) UITextField * username;
@property(nonatomic, strong) UITextField * password;
@property(nonatomic, strong) SJIOS_SUCCESS_Callback success;
@property(nonatomic, strong) SJIOS_FAILED_Callback failed;
@property(nonatomic) Boolean logining;
@property (nonatomic, strong) UITableView * dropdown;
@property (nonatomic, strong) UIButton * users;
@property (nonatomic, strong) NSMutableArray * data;
@property(nonatomic, strong) NSString* code;

@property (nonatomic,strong)  SJIOSQuickLogin *quidklogin;
@property (nonatomic,strong) SJIOSDefaultLogin *defaultLogin;

@property(nonatomic,strong) UIButton *choose;
@property(nonatomic) Boolean agree;

@property(nonatomic,strong) NSString *token;
@property (nonatomic, strong) NSMutableArray *dataList;//用户列表
@property(nonatomic,strong)  UIImageView *userArrow;//下拉箭头
@property (nonatomic,strong) SJIOSUserInfo *loginInfo;
//@property(nonatomic)BOOL login;//是否登录过
@property(nonatomic,strong)UIView *scroll;//用户列表
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)UIButton *defaultButton;
@property(nonatomic,strong)  SJIOSRegisterView *registerView;//注册
@property(nonatomic,strong)  SJIOSYMPhoneLogin *ymPhoneLogin;//手机登录
@property(nonatomic,strong)  SJIOSYMPhoneRegisterView *ymPhoneRegisterView;//注册
@property(nonatomic) Boolean SHOWPROCESS;


@property (nonatomic, strong) UITextField *verifyField;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) UILabel *verifyLabel;
@property (nonatomic)int cooldown;
@property(nonatomic, strong) NSTimer * buttonTimer;
@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL binding;
//@property (strong, nonatomic) SJIOSProgressHUD *process;

@property(nonatomic,strong) NSString *ymPhoneNumber;//手机号码
//@property(nonatomic,strong) NSString *ymPassword;//手机密码
@property(nonatomic) Boolean registering;//是否注册过
@property(nonatomic, strong) SJIOS_RV_Complete_Callback complete;
@property (nonatomic, strong)SJIOSProgressHUD *myProcess;
@property(nonatomic,strong) SJIOSForgetView *forgetPhoneView;//手机找回密码界面
@property (nonatomic, strong) SJIOSProgressHUD *process;


@end

static int isFirstLogin = YES;

@implementation SJIOSYMPhoneLogin



- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landscape  view:(SJIOSQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum

{
    if(landscape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landscape ];
    }
    
    self.ymPhoneNumber=ymPhoneNum;
    self.username.text = ymPhoneNum;
    
    if (self) {
        // Initialization code
//        self.complete = complete;
        self.logining = false;
        self.registering = false;
        self.agree = true;
        
        self.landscape = landscape;
//        self.login=NO;
        self.success = success;
        self.failed = failed;
        self.quidklogin=view;

        
        if(self.landscape){
            [self setLandScapeView];
            [self setupView];
            [self addNotification];
        }else{
            [self setPortraitView];
//            [self setupView];
//            [self addNotification];
        }
        
        
    }
    
    return self;
}


//横屏状态下的登录界面
-(void)setLandScapeView{

    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(150, 20, 166, 68);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(login_backButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //即将登录的手机号提示
    UILabel* labelphone = [[UILabel alloc] initWithFrame:CGRectMake(50,72, 130, 38)];
    labelphone.text = @"即将登录的手机号：";
    labelphone.font = [UIFont fontWithName:@"Arial" size:14];
    labelphone.textColor = [UIColor grayColor];
    
    UILabel* userPhone = [[UILabel alloc] initWithFrame:CGRectMake(165,72, 120, 38)];
    userPhone.text = self.ymPhoneNumber;
    userPhone.font = [UIFont fontWithName:@"Arial" size:14];
    userPhone.textColor = [UIColor grayColor];

    [self.alertContainer addSubview:labelphone];
    [self.alertContainer addSubview:userPhone];
    self.username.text = self.ymPhoneNumber;
    
    
    //请输入密码
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 310, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    password.font = [UIFont systemFontOfSize:20];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(8, 6, 25, 25);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [passwordLeftView addSubview:logoSView];
    password.leftView = passwordLeftView;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    password.delegate = self;
    
    [self.alertContainer addSubview:password];
    [self.alertContainer bringSubviewToFront:password];
    self.password = password;//输入的密码
    
    
    
    //登录界面的忘记密码label
    UILabel *ym_fogetPassword = [[UILabel alloc] initWithFrame:CGRectMake(360, 110, 20, 38)];
    [ym_fogetPassword setText:@"忘记密码" ];
    ym_fogetPassword.textColor = [UIColor blueColor];
    [ym_fogetPassword sizeToFit];
    //    ym_fogetPassword.center = CGPointMake(ym_fogetPassword.bounds.size.width/2, ym_fogetPassword.bounds.size.height/2);
    [ym_fogetPassword addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ymFogetPassword)]];
    ym_fogetPassword.userInteractionEnabled = YES;
    [self.alertContainer addSubview:ym_fogetPassword];
    

    
    
    
    //手机登录按钮
    UIButton * ymloginButton=[[UIButton alloc]initWithFrame:CGRectMake(160, 170, 130, 38)];
    UIImage *ymLoginBackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:ymLoginBackImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [label setText:@"登录"];
    [label sizeToFit];
    label.center = CGPointMake(ymloginButton.bounds.size.width/2, ymloginButton.bounds.size.height/2);
    [ymloginButton addSubview:imageView];
    [ymloginButton addSubview:label];
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    //    [ymloginButton addTarget:self action:@selector(ym_phoneRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [ymloginButton addTarget:self action:@selector(YMloginPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:ymloginButton];
    
}

//竖屏状态下的登录界面
-(void)setPortraitView{

    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(50, 15, 160 , 62);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(login_backButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    //即将登录的手机号提示
    UILabel* labelphone = [[UILabel alloc] initWithFrame:CGRectMake(15,70, 130, 38)];
    labelphone.text = @"即将登录的手机号：";
    labelphone.font = [UIFont fontWithName:@"Arial" size:14];
    labelphone.textColor = [UIColor grayColor];
    
    UILabel* userPhone = [[UILabel alloc] initWithFrame:CGRectMake(130,70, 120, 38)];
    userPhone.text = self.ymPhoneNumber;
    userPhone.font = [UIFont fontWithName:@"Arial" size:14];
    userPhone.textColor = [UIColor grayColor];
    
    [self.alertContainer addSubview:labelphone];
    [self.alertContainer addSubview:userPhone];
    self.username.text = self.ymPhoneNumber;
    
    
    //请输入密码
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(15, 98, 230, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    password.font = [UIFont systemFontOfSize:13];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(10, 10, 15, 15);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [passwordLeftView addSubview:logoSView];
    password.leftView = passwordLeftView;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    password.delegate = self;
    
    [self.alertContainer addSubview:password];
    [self.alertContainer bringSubviewToFront:password];
    self.password = password;//输入的密码
    
    
    
    //登录界面的忘记密码label
    UILabel *ym_fogetPassword = [[UILabel alloc] initWithFrame:CGRectMake(190, 136, 20, 20)];
    [ym_fogetPassword setText:@"忘记密码" ];
    ym_fogetPassword.font = [UIFont systemFontOfSize:13];
    ym_fogetPassword.textColor = [UIColor blueColor];
    [ym_fogetPassword sizeToFit];
    //    ym_fogetPassword.center = CGPointMake(ym_fogetPassword.bounds.size.width/2, ym_fogetPassword.bounds.size.height/2);
    [ym_fogetPassword addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ymFogetPassword)]];
    ym_fogetPassword.userInteractionEnabled = YES;
    [self.alertContainer addSubview:ym_fogetPassword];
    
    //阅读协议
    self.choose = [[UIButton alloc] initWithFrame:CGRectMake(15, 155, 20, 20)];
    [self.choose setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_read.png"] forState:
     UIControlStateNormal];
    [self.choose addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:self.choose];
    
    UILabel *agree1 = [[UILabel alloc]initWithFrame:CGRectMake(36, 158, 85, 18)];
    [agree1 setFont:[UIFont systemFontOfSize:12]];
    [agree1 setText:@"我已阅读并同意"];
    [agree1 sizeToFit];
    [self.alertContainer addSubview:agree1];
    
    UILabel *agree2 = [[UILabel alloc]initWithFrame:CGRectMake(121, 158, 50, 18)];
    [agree2 setFont:[UIFont systemFontOfSize:12]];
    [agree2 setText:@"《用户服务登录协议》"];
    agree2.enabled = NO;
    [agree2 setTextColor:[UIColor blueColor]];
    [agree2 sizeToFit];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agree2)];
    [agree2 addGestureRecognizer:labelTapGestureRecognizer];
    agree2.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    [self.alertContainer addSubview:agree2];
    

    //手机登录按钮
    UIButton *ymloginButton = [[UIButton alloc]initWithFrame:CGRectMake(65, 200, 130, 38)];
    [ymloginButton setTitle:@"登录" forState:UIControlStateNormal];
    ymloginButton.titleLabel.font=[UIFont systemFontOfSize:13];
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [ymloginButton setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_login_button.png"] forState:UIControlStateNormal];
    [ymloginButton addTarget:self action:@selector(YMloginPressed) forControlEvents:UIControlEventTouchUpInside];
    ymloginButton.layer.cornerRadius=5;
    [self.alertContainer addSubview:ymloginButton];
    
}



//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self.ymPhoneLogin action:@selector(onBackClicked:)];
    [self.alertContainer addGestureRecognizer:tapGesture];
}

-(void)addNotification{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(onKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)onKeyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration  = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    //    CGRect keyboardRect  = [userInfoDic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardHeight = MIN(CGRectGetWidth(keyboardRect), CGRectGetHeight(keyboardRect));
    
    //0, -keyboardHeight
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -10);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.username resignFirstResponder];
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘自动上移====end


-(void)agree2{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SJIOS_USER_AGREEMENT_URL]];
}

-(void) chooseClick{
    if(self.agree == true){
        self.agree = false;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_unOK.png"] forState:
         UIControlStateNormal];
    }else{
        self.agree = true;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_OK.png"] forState:
         UIControlStateNormal];
    }
}

-(void)show:(UIView *)view
{
    
    [super show:view];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

//登录框
- (void) YMloginPressed
{
 
    [self.username resignFirstResponder];//键盘隐藏
    [self.password resignFirstResponder];//键盘隐藏
    
    NSString* password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

 
    //判断密码输入框是否为空
    if([password length]== 0){
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请输入密码"];
        return;
    }
    
    //判断密码框是否大于6位小于20位
    
    if ([password length]< 6 || [password length] > 20) {
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"密码长度为6到20位"];
        return;
    }
    
    
    if ([password length] == 0)
    {
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"密码不能为空"];
        
        return;
    }
    
    [self ymPhoneStartLogin];
}



//手机登录方法
- (void) ymPhoneStartLogin
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    NSString * username = self.ymPhoneNumber;
    NSString * password = self.password.text;

    
    SJIOS_VSD_BLOCK getUserIdCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                self.logining = false;
                return;
            }

            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString * userid = [dictionary valueForKey:@"id"];

              [[SJIOSSdkImp sharedInstance] addSJIOSUser:username password:password bind:@"1" tourist:@"0" phoneNumber:@"1"];

                self.logining = false;
                self.code = userid;
                

                
//                [self checkAccountIdentity:self.token];//检查有没有实名
                [self ymdismissWithAnimation:YES];
                
                if (self.quidklogin!=nil) {
                    [self.quidklogin dismissWithAnimation:YES];
                }else{
                    [self.defaultLogin dismissWithAnimation:YES];
                }
                
                
                
            }
            else
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:[[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]]];
                self.logining = false;
            }
        }@catch(NSException * e)
        {
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"内部错误" ];
            self.logining = false;
        }
        @finally
        {
            self.logining = false;
        }
    };
    
    SJIOS_VSD_BLOCK getTokenCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                self.logining = false;
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
                [[SJIOSCommonApi sharedInstance] getSJIOSUserId:access_token
                                          completionBlock:getUserIdCompletionBlock
                                              failedBlock:^(NSError *error){
                                                  self.logining = false;
                                                  self.failed(-107);
                                                  [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                              }];
            }
            else
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:[[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]]];
                self.logining = false;
            }
        }@catch(NSException * e)
        {
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"内部错误" ];
            self.logining = false;
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    

    
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                self.logining = false;
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                
                _process.labelText = @"正在验证";
                [[SJIOSCommonApi sharedInstance] getSJIOSAccessToken:[dictionary valueForKey:@"code"]
                                               completionBlock:getTokenCompletionBlock
                                                   failedBlock:^(NSError *error){
                                                       self.logining = false;
                                                       self.failed(-108);
                                                       [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                                   }];
                
            }
            else
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:[[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]]];
                self.logining = false;
            }
        }
        @catch(NSException * e)
        {
            [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"内部错误"];
            self.logining = false;
        }
        @finally
        {
            //self.logining = false;
        }
    };
    

        [[SJIOSCommonApi sharedInstance] phoneSJIOSLogin:username
                                   password:password
                                   completionBlock:completionBlock failedBlock:^(NSError * error) {
                                       self.logining = false;
                                       self.failed(-109);
                                       [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                   }];

    self.logining = true;
    
    //[NSThread detachNewThreadSelector:@selector(processShow) toTarget:self withObject:nil];
    [self processShowLogin];

}

-(void)processShowLogin {
    if (self.process == nil) {
        self.process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
        
    }
    [self.alertContainer addSubview:_process];
    _process.labelText = @"正在登录中";
    
    [_process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.logining)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } completionBlock:^{
        [_process removeFromSuperview];
    }];
}


-(void)checkAccountIdentity:(NSString *)access_token{
    [[SJIOSCommonApi sharedInstance] checkSJIOSIdentify:access_token completionBlock:^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                [self ymdismissWithAnimation:YES];
                
                if (self.quidklogin!=nil) {
                    [self.quidklogin dismissWithAnimation:YES];
                }else{
                    [self.defaultLogin dismissWithAnimation:YES];
                }
                return;
            }
            NSLog(@"checkAccountIdentity dictionary = %@", dictionary);
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *unknown = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"unknown"]];
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([unknown isEqualToString:@"1"])
                {

                    self.sjValidateIdentity = [[SJ_ValidateIdentity alloc] initWithBlock:access_token complete:^(NSString *str1, NSString *str2){

                        [self ymdismissWithAnimation:YES];
                        
                        if (self.quidklogin!=nil) {
                            [self.quidklogin dismissWithAnimation:YES];
                        }else{
                            [self.defaultLogin dismissWithAnimation:YES];
                        }
                    } landscape:self.landscape];
                    [self.sjValidateIdentity show:self];
                    
                }else
                {

                    [self ymdismissWithAnimation:YES];
                    
                    if (self.quidklogin!=nil) {
                        [self.quidklogin dismissWithAnimation:YES];
                    }else{
                        [self.defaultLogin dismissWithAnimation:YES];
                    }
                    
                }
            }
            
        }
        @catch(NSException * e)
        {
            [self dismissWithAnimation:YES];
        }
    } failedBlock:^(NSError *code) {
        [self dismissWithAnimation:YES];
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"获取身份证认证信息失败" ];
    }];
}




-(void)ymdismissWithAnimation:(BOOL)animated
{
    NSDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:self.token forKey:@"accesstoken"];
    [userInfo setValue:self.code forKey:@"userid"];
    [userInfo setValue:self.ymPhoneNumber forKey:@"username"];

    self.success(userInfo);


    [[SJIOSSdkImp sharedInstance] showSJIOSWelcome:self.ymPhoneNumber];

    [super dismissWithAnimation:animated];
}


- ( UIImage *)createShareImage:( NSString *)str

{
    
    UIImage *image = [ UIImage imageNamed : @"SJIOS.bundle/SJIOS_buttombackground"];
    UIImage *imagelogo = [ UIImage imageNamed : @"SJIOS.bundle/SJIOS_SJIOS_logo"];
    
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

//保存图片
-(void)savePhoto

{
    
    UIImage * image = [self captureImageFromView:self];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSaving:contextInfo:), nil);
    
}

-(void) image:(UIImage *)image didFinishSaving:(NSError *)error contextInfo:(void *)contentInfo
{
    if(error == nil){
        NSLog(@"save success");
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"注册成功！帐号信息截图已保存到相册中，帐号丢失可以查看截图找回，请妥善保管！" message:@"" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
//
//        [alertView show];
        
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"注册成功！帐号信息截图已保存到相册中，帐号丢失可以查看截图找回，请妥善保管！"];
    }else{
        NSLog(@"save error");
        
    }
}

//截图功能

-(UIImage *)captureImageFromView:(UIView *)view

{
    
    CGRect screenRect = [view bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


-(void)savePhoto: ( NSString *)userid

{
    
    
    UIImage * image = [self createShareImage:userid];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingResult:contextInfo:), nil);
    
    
}



-(void)dismissWithAnimation:(BOOL)animated
{
    NSDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:self.token forKey:@"accesstoken"];
    [userInfo setValue:self.code forKey:@"userid"];
    [userInfo setValue:self.username.text forKey:@"username"];

    self.success(userInfo);

    [[SJIOSSdkImp sharedInstance] showSJIOSWelcome:[self.username text]];
    [super dismissWithAnimation:animated];
}



-(void)login_backButton{
    [super dismissWithAnimation:YES];
}

//登录关闭按钮
-(void)ym_loginCloseButton{
    [super dismissWithAnimation:YES];
}

//点击忘记密码直接跳转到手机找回密码界面
-(void)ymFogetPassword
{
    if(self.agree == false){
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    if (self.forgetPhoneView == nil) {
        self.forgetPhoneView = [[SJIOSForgetView alloc] initWithLandscape:self.landscape];
    }
    [self.forgetPhoneView show:self];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if(textField==self.password)
    {
        [textField resignFirstResponder];
        
        NSString * password = self.password.text;
        if ([password length] == 0)
        {
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"密码为空"];
            
            return YES;
        }
        
        [self YMloginPressed];
    }
    return YES;
}




@end
