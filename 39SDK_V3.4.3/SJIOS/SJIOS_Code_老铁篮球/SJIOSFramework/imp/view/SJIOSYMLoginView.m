

#import "SJIOSYMLoginView.h"
#import "UIImage+SJIOSSdk.h"
#import "UIColor+SJIOSSdk.h"
#import "SJIOSWebInterface.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSSdkImp.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSDataBase.h"
#import "SJIOSRegisterView.h"
#import "SJIOSForgetView.h"
#import "SJIOSBaseView.h"
#define SJIOS_USER_AGREEMENT_URL @"https://www.3975.com/public/web/39XY.html"

@interface SJIOSYMLoginView()

@property(nonatomic, strong) UITextField * username;
@property(nonatomic, strong) UITextField * password;
@property(nonatomic, strong) SJIOS_SUCCESS_Callback success;
@property(nonatomic, strong) SJIOS_FAILED_Callback failed;
@property(nonatomic) Boolean logining;
@property (nonatomic, strong) UITableView * dropdown;
@property (nonatomic, strong) UIButton * users;
@property (nonatomic, strong) NSMutableArray * data;
@property(nonatomic, strong) NSString* code;
@property (nonatomic, strong) SJIOSProgressHUD *process;
@property (nonatomic,strong)  SJIOSQuickLogin *quidklogin;
@property (nonatomic,strong) SJIOSDefaultLogin *defaultLogin;

@property(nonatomic,strong) UIButton *choose;
@property(nonatomic) Boolean agree;

@property(nonatomic,strong) NSString *token;
@property (nonatomic, strong) NSMutableArray *dataList;//用户列表
@property(nonatomic,strong)  UIImageView *userArrow;//下拉箭头
@property (nonatomic,strong) SJIOSUserInfo *loginInfo;
@property(nonatomic)BOOL login;//是否登录过
@property(nonatomic,strong)UIView *scroll;//用户列表
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)UIButton *defaultButton;
@property(nonatomic,strong)  SJIOSRegisterView *registerView;//注册
@property(nonatomic,strong) SJIOSForgetView *forgetPhoneView;//手机找回密码界面
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) SJIOSBaseView *baseView;
@property(nonatomic,strong) SJIOSYMLoginView *ymLoginView;//登录界面
@property(nonatomic)BOOL textIsphoneNumber;//输入的是否是手机号

@property (nonatomic,strong) NSString *username_history;
@property (nonatomic) Boolean isRegister;

@end





@implementation SJIOSYMLoginView


- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape view:(SJIOSQuickLogin*) view
{
    self.isRegister = NO;
    if(landcape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landcape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landcape ];
    }
    
    self.agree = true;
    if (self) {
        self.success = success;
        self.failed = failed;
        self.logining = false;
        self.quidklogin=view;
        self.landscape = landcape;
        self.login=NO;
        
        
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

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape view:(SJIOSQuickLogin*) view username:(NSString *)username
{
    self.username_history = username;
    if(landcape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landcape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landcape ];
    }
    
    self.agree = true;
    if (self) {
        self.success = success;
        self.failed = failed;
        self.logining = false;
        self.quidklogin=view;
        self.landscape = landcape;
        self.login=NO;
        
        
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


//==========================界面   start==========================//
//横屏状态下的登录界面
-(void)setLandScapeView{

    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(150, 20, 166, 68);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(login_backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(50, 98, 340, 38)];
    username.borderStyle = UITextBorderStyleNone;
    UIImage *edit_up_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    
    username.background = edit_up_image;
    username.placeholder = @"请输入用户名";
    if(SJIOS_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        username.textColor = [UIColor blackColor];
        // 默认文本颜色
        [username setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        username.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    username.font = [UIFont systemFontOfSize:20];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    //    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    if(self.username_history != NULL){
        username.text = self.username_history;
    }
    
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo_r.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(8, 6, 25, 25);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [usernameLeftView addSubview:logoRView];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    username.delegate = self;
    
    [self.alertContainer addSubview:username];
    [self.alertContainer bringSubviewToFront:username];
    self.username = username;
    
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(50, 148, 340, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    //[password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if(SJIOS_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        password.textColor = [UIColor blackColor];
        // 默认文本颜色
        [password setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        password.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    password.font = [UIFont systemFontOfSize:20];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.textAlignment = UITextAlignmentLeft;
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
    self.password = password;
    
    //横屏状态登录界面的立即注册label
    UILabel *login_register = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 68, 20)];
    login_register.font = [UIFont systemFontOfSize:15];
    [login_register setText:@"注册帐号"];
    if(SJIOS_TEXTCOLOR_BLACK == NO){
        login_register.textColor = [UIColor blueColor];
        NSLog(@"blueColor");
    }else{
        login_register.textColor = [UIColor blackColor];
        NSLog(@"blackColor");
    }
    [login_register sizeToFit];
    UITapGestureRecognizer* registTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ymRegister)];
    login_register.userInteractionEnabled = YES;
    [login_register addGestureRecognizer:registTapGestureRecognizer];
    [self.alertContainer addSubview:login_register];
    
    //横屏状态登录界面的忘记密码label
    UILabel *ym_fogetPassword = [[UILabel alloc] initWithFrame:CGRectMake(360, 220, 68, 20)];
    [ym_fogetPassword setText:@"忘记密码" ];
    ym_fogetPassword.font = [UIFont systemFontOfSize:15];
    
    if(SJIOS_TEXTCOLOR_BLACK == NO){
        ym_fogetPassword.textColor = [UIColor blueColor];
    }else{
        login_register.textColor = [UIColor blackColor];
    }
    [ym_fogetPassword sizeToFit];
    //    ym_fogetPassword.center = CGPointMake(ym_fogetPassword.bounds.size.width/2, ym_fogetPassword.bounds.size.height/2);
    [ym_fogetPassword addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fogetPassword)]];
    ym_fogetPassword.userInteractionEnabled = YES;
    [self.alertContainer addSubview:ym_fogetPassword];
    
    //登录按钮
    UIButton * ymloginButton=[[UIButton alloc]initWithFrame:CGRectMake(160, 198, 130, 38)];

    UIImage *ymLoginBackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:ymLoginBackImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    
    if(SJIOS_TEXTCOLOR_BLACK == YES){
        [label setTextColor:[UIColor blackColor]];
    }else{
        [label setTextColor:[UIColor whiteColor]];
    }
    [label setText:@"立即登录"];
    [label sizeToFit];
    label.center = CGPointMake(ymloginButton.bounds.size.width/2, ymloginButton.bounds.size.height/2);
    [ymloginButton addSubview:imageView];
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [ymloginButton addSubview:label];
    [ymloginButton addTarget:self action:@selector(judgeUserName) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:ymloginButton];
    
    
}

//竖屏状态下的登录界面
-(void)setPortraitView{

    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(85, 15, 95, 38);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(login_backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(15, logoView.frame.size.height+35, 230, 38)];
    username.borderStyle = UITextBorderStyleNone;
    UIImage *edit_up_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    
    username.background = edit_up_image;
    username.placeholder = @"请输入用户名";
    if(SJIOS_TEXTCOLOR_BLACK == YES){
        username.textColor = [UIColor blackColor];
        [username setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        username.textColor = [UIColor whiteColor];
        [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    //    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    if(self.username_history != NULL){
        username.text = self.username_history;
    }
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo_r.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(10, 12, 15, 15);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [usernameLeftView addSubview:logoRView];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    username.delegate = self;
    
    [self.alertContainer addSubview:username];
    [self.alertContainer bringSubviewToFront:username];
    self.username = username;
    
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(15, username.frame.size.height+username.frame.origin.y+10, 230, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    if(SJIOS_TEXTCOLOR_BLACK == YES){
        password.textColor = [UIColor blackColor];
        [password setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        password.textColor = [UIColor whiteColor];
        [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    password.font = [UIFont systemFontOfSize:15];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.textAlignment = UITextAlignmentLeft;
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(10, 12, 15, 15);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [passwordLeftView addSubview:logoSView];
    password.leftView = passwordLeftView;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    password.delegate = self;
    
    [self.alertContainer addSubview:password];
    [self.alertContainer bringSubviewToFront:password];
    self.password = password;
    
    
    //登录按钮
    UIButton * ymloginButton=[[UIButton alloc]initWithFrame:CGRectMake(65, 173, 130, 38)];
    UIImage *ymLoginBackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:ymLoginBackImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"立即登录"];
    [label sizeToFit];
    label.center = CGPointMake(ymloginButton.bounds.size.width/2, ymloginButton.bounds.size.height/2);
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [ymloginButton addSubview:imageView];
    [ymloginButton addSubview:label];
    [ymloginButton addTarget:self action:@selector(judgeUserName) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:ymloginButton];
    
    
    //竖屏状态登录界面的立即注册label
    UILabel *login_register = [[UILabel alloc] initWithFrame:CGRectMake(15, 230, 50, 20)];
    login_register.font = [UIFont systemFontOfSize:13];
    [login_register setText:@"注册帐号"];
    if(SJIOS_TEXTCOLOR_BLACK == NO){
        login_register.textColor = [UIColor blueColor];
    }else{
        login_register.textColor = [UIColor blackColor];
    }
    [login_register sizeToFit];
    UITapGestureRecognizer* registTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ymRegister)];
    login_register.userInteractionEnabled = YES;
    [login_register addGestureRecognizer:registTapGestureRecognizer];
    [self.alertContainer addSubview:login_register];
    
    //竖屏状态登录界面的忘记密码label
    UILabel *ym_fogetPassword = [[UILabel alloc] initWithFrame:CGRectMake(190, 230, 50, 1)];
    [ym_fogetPassword setText:@"忘记密码" ];
//    UIView *ym_fogetPasswordline=[[UIView alloc]initWithFrame:CGRectMake(160,260,68,1)];
//    [self.alertContainer addSubview:ym_fogetPasswordline];
    ym_fogetPassword.font = [UIFont systemFontOfSize:13];
    if(SJIOS_TEXTCOLOR_BLACK == NO){
        ym_fogetPassword.textColor = [UIColor blueColor];
    }else{
        ym_fogetPassword.textColor = [UIColor blackColor];
    }
    [ym_fogetPassword sizeToFit];
    [ym_fogetPassword addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fogetPassword)]];
    ym_fogetPassword.userInteractionEnabled = YES;
    [self.alertContainer addSubview:ym_fogetPassword];

}



//键盘自动上移====start
-(void)setupView{
    NSLog(@"调用setupView");
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ymLoginView addGestureRecognizer:tapGesture];
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
    
    
    //0, -keyboardHeight
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -65);
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
    [self.password resignFirstResponder];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
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
- (void)judgeUserName
{
    [self.username resignFirstResponder];//键盘隐藏
    [self.password resignFirstResponder];//键盘隐藏
    [[UIApplication sharedApplication].keyWindow endEditing:YES];

    //正则表达式匹配11位手机号码
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}|(1705)\\d{7}$";
    
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(166)|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9])|(199))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:_username.text];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:_username.text];
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:_username.text];
    
    //有效的手机号
    if(isMatch1 || isMatch2 || isMatch3){
  
        self.textIsphoneNumber = YES;

    }


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

    
    NSString * username = self.username.text;
    if ([username length] == 0)
    {
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"用户名不能为空"];
        return;
    }

    if ([password length] == 0)
    {
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"密码不能为空"];
        
        return;
    }
    
    [self ymStartLogin];
}

//普通帐号和手机帐号登录
-(void)ymStartLogin{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    NSString * username = self.username.text;
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
                NSString * username = [dictionary valueForKey:@"name"];
                
                NSDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setValue:self.token forKey:@"accesstoken"];
                [userInfo setValue:userid forKey:@"userid"];
                [userInfo setValue:username forKey:@"username"];
                [[SJIOSWebInterface sharedInstance] SJIOSsendHeart:userid];
                self.success(userInfo);
                
                
                
                NSLog(@"save pwd = %@", password);
                if(self.textIsphoneNumber){
                    [[SJIOSSdkImp sharedInstance] addSJIOSUser:username passwordSJIOS:password bindSJIOS:@"1" touristSJIOS:@"0" phoneNumberSJIOS:@"1"];
                }else{
                    [[SJIOSSdkImp sharedInstance] addSJIOSUser:username passwordSJIOS:password bindSJIOS:@"0" touristSJIOS:@"0" phoneNumberSJIOS:@"0"];
                }
                
                self.code = userid;
  
                self.logining = false;
                
                [[UIApplication sharedApplication].keyWindow endEditing:YES];
                [self ymdismissWithAnimation:YES];
                if (self.quidklogin!=nil) {
                    [self.quidklogin dismissWithAnimation:YES];
                }
                if(self.defaultLogin!=nil){
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
                [[SJIOSWebInterface sharedInstance] getSJIOSUserId:access_token
                                          successCallbackSJIOS:getUserIdCompletionBlock
                                              failCallbackSJIOS:^(NSError *error){
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
    
    
    
    
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        // self.logining = false;
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
                [[SJIOSWebInterface sharedInstance] getSJIOSAccessTokenSJIOS:[dictionary valueForKey:@"code"]
                                               successCallbackSJIOS:getTokenCompletionBlock
                                                   failCallbackSJIOS:^(NSError *error){
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
    
    
    SJIOS_VSD_BLOCK successCallback1 = ^(NSDictionary *dictionary, NSDictionary *headers) {
        // self.logining = false;
        @try
        {
            if (dictionary == nil)
            {
                self.logining = false;
                return;
            }
            
            NSLog(@"YMLoginView  successCallback1 ::dictionary==%@" ,dictionary);
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                
                _process.labelText = @"正在验证";
                [[SJIOSWebInterface sharedInstance] getSJIOSAccessTokenSJIOS:[dictionary valueForKey:@"code"]
                                               successCallbackSJIOS:getTokenCompletionBlock
                                                   failCallbackSJIOS:^(NSError *error){
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
    
    NSLog(@"self.textIsphoneNumber = %d", self.textIsphoneNumber);
    
    if(self.textIsphoneNumber){//手机号登录

        [[SJIOSWebInterface sharedInstance] phoneSJIOSLogin:username
                                          passwordSJIOS:password
                                   successCallbackSJIOS:successCallback1 failCallbackSJIOS:^(NSError * error) {
                                       self.logining = false;
                                       self.failed(-109);
                                       [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                   }];
    }else{

        [[SJIOSWebInterface sharedInstance] loginSJIOS:username
                                     passwordSJIOS:[SJIOSSdkMd5 md5:password]
                              successCallbackSJIOS:successCallback
                                  failCallbackSJIOS:^(NSError * error) {
                                      self.logining = false;
                                      self.failed(-109);
                                      [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                  }
         ];
    }
    
    
    self.logining = true;
    
    [self ymProcessShow];
    
}





-(void)ymProcessShow {
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
    } successCallback:^{
        [_process removeFromSuperview];
    }];
 
}




//登录界面的注册帐号成功后返回调用的登录方法
- (void) startLogin
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    SJIOS_VSD_BLOCK getUserIdCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.login = NO;
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"网络不太好，请重试！！！" ];
                return;
            }

            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                //判断是否是注册用户，如果是，则跳实名认证界面
                if(self.isRegister == YES && [[SJIOSSdkImp sharedInstance] getSJIOSShiMingRenZhengFlag] == YES){
                    [[SJIOSSdkImp sharedInstance] showSJIOSShiMingRenZhengView:self.token callbackSJIOS:^(NSString *callbackxxxx){
                        NSString * userid = [dictionary valueForKey:@"id"];
                        
                        NSDictionary *userInfo = [NSMutableDictionary dictionary];
                        [userInfo setValue:self.token forKey:@"accesstoken"];
                        [userInfo setValue:userid forKey:@"userid"];
                        [userInfo setValue:self.loginInfo.username forKey:@"username"];
                        
                        self.success(userInfo);
                        [[SJIOSWebInterface sharedInstance] SJIOSsendHeart:userid];
                        
                        [[UIApplication sharedApplication].keyWindow endEditing:YES];
                        if ([self.loginInfo.tourist isEqualToString:@"1"]&&[self.loginInfo.bind isEqualToString:@"0"]) {
                            
                            [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"该帐号为快速登录帐号,请尽快绑定,以免帐号丢失!"];
                        }
                        [[SJIOSSdkImp sharedInstance] addSJIOSUser:self.loginInfo.username passwordSJIOS:self.loginInfo.password bindSJIOS:self.loginInfo.bind    touristSJIOS:self.loginInfo.tourist phoneNumberSJIOS:self.loginInfo.phoneNumber];
                        [self accountClick];
                        
                        
                        self.login = NO;
                        
                        
                        [self.username resignFirstResponder];
                        [self.password resignFirstResponder];
                        [[UIApplication sharedApplication].keyWindow endEditing:YES];
                        [super removeFromSuperview];
                        if (self.quidklogin!=nil) {
                            [self.quidklogin removeFromSuperview];
                        }
                        if(self.defaultLogin!=nil){
                            [self.defaultLogin removeFromSuperview];
                        }
                    }];
                    self.isRegister = NO;
                }else{
                    NSString * userid = [dictionary valueForKey:@"id"];
                    
                    NSDictionary *userInfo = [NSMutableDictionary dictionary];
                    [userInfo setValue:self.token forKey:@"accesstoken"];
                    [userInfo setValue:userid forKey:@"userid"];
                    [userInfo setValue:self.loginInfo.username forKey:@"username"];
                    
                    self.success(userInfo);
                    [[SJIOSWebInterface sharedInstance] SJIOSsendHeart:userid];
                    
                    [[UIApplication sharedApplication].keyWindow endEditing:YES];
                    if ([self.loginInfo.tourist isEqualToString:@"1"]&&[self.loginInfo.bind isEqualToString:@"0"]) {
                        
                        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"该帐号为快速登录帐号,请尽快绑定,以免帐号丢失!"];
                    }
                    [[SJIOSSdkImp sharedInstance] addSJIOSUser:self.loginInfo.username passwordSJIOS:self.loginInfo.password bindSJIOS:self.loginInfo.bind    touristSJIOS:self.loginInfo.tourist phoneNumberSJIOS:self.loginInfo.phoneNumber];
                    [self accountClick];
                    
                    
                    self.login = NO;
                    
                    
                    [self.username resignFirstResponder];
                    [self.password resignFirstResponder];
                    [[UIApplication sharedApplication].keyWindow endEditing:YES];
                    [super removeFromSuperview];
                    if (self.quidklogin!=nil) {
                        [self.quidklogin removeFromSuperview];
                    }
                    if(self.defaultLogin!=nil){
                        [self.defaultLogin removeFromSuperview];
                    }
                }
                
                
                
                
                
            }
            else
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:[[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]]];
                
                
            }
            self.login = NO;
        }@catch(NSException * e)
        {
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"内部错误" ];
            self.login = NO;
        }
        @finally
        {
            self.login = NO;
        }
    };
    

    
    SJIOS_VSD_BLOCK getTokenCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                self.login = NO;
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"网络不太好，请重试！！！" ];
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
                
                [[SJIOSWebInterface sharedInstance] getSJIOSUserId:access_token
                                          successCallbackSJIOS:getUserIdCompletionBlock
                                              failCallbackSJIOS:^(NSError *error){
                                                  self.login = NO;
                                                  self.failed(-104);
                                                  [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                              }];
            }
            else
            {
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:[[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]]];
                self.login = NO;
                
            }
        }@catch(NSException * e)
        {
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"内部错误" ];
            self.login = NO;
            
        }
        @finally
        {
        }
    };
    

    
    
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        // self.login = NO;
        @try
        {
            if (dictionary == nil)
            {
                self.login = NO;
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"网络不太好，请重试！！！" ];
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                
                _process.labelText = @"正在验证";
                [[SJIOSWebInterface sharedInstance] getSJIOSAccessTokenSJIOS:[dictionary valueForKey:@"code"]
                                               successCallbackSJIOS:getTokenCompletionBlock
                                                   failCallbackSJIOS:^(NSError *error){
                                                       self.login = NO;
                                                       self.failed(-105);
                                                       [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                                   }];
                
                
            }else
            {
                
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:[[SJIOSSdkImp sharedInstance]translateSJIOS:[dictionary valueForKey:@"error"]] ];
                self.login = NO;
            }
        }
        @catch(NSException * e)
        {
            
            
            
            [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"内部错误"];
            self.login = NO;
            
        }
        @finally
        {
            //self.login = NO;
        }
    };

    //普通注册后的普通登录
        [[SJIOSWebInterface sharedInstance] loginSJIOS:self.loginInfo.username
                                     passwordSJIOS:[SJIOSSdkMd5 md5:self.loginInfo.password]
                              successCallbackSJIOS:successCallback
                                  failCallbackSJIOS:^(NSError * error) {
                                      self.login = NO;
                                      self.failed(-106);
                                      [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请检查网络连接！"];
                                  }
         ];

    self.login = YES;    
    
    [self processSJIOSShow];
}



-(void)processSJIOSShow {
    if (self.process == nil) {
        self.process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
        
    }
    [self.alertContainer addSubview:_process];
    _process.labelText = @"正在登录中";
    
    [_process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.login)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } successCallback:^{
        [_process removeFromSuperview];
    }];
    
    
    
}

-(void)ymdismissWithAnimation:(BOOL)animated
{

    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    self.username_history = NULL;
    [[SJIOSSdkImp sharedInstance] showSJIOSWelcome:[self.username text]];
    [super dismissWithAnimation:animated];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username)
    {
        [self.password becomeFirstResponder];
    }
    else if(textField==self.password)
    {
        [textField resignFirstResponder];
        
        NSString * username = self.username.text;
        if ([username length] == 0)
        {
            
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"用户名为空"];
            
            return YES;
        }
        
        NSString * password = self.password.text;
        if ([password length] == 0)
        {
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"密码为空"];
            
            return YES;
        }
        
        [self judgeUserName];
    }
    return YES;
}

-(void)login_backButton{
    self.username_history = NULL;
    [super dismissWithAnimation:YES];
}

//登录关闭按钮
-(void)ym_loginCloseButton{
    self.username_history = NULL;
    [super dismissWithAnimation:YES];
}

//用户列表点击方法
-(void)accountClick{
    if (self.scroll.hidden) {
        self.scroll.hidden=NO;
    }else{
        self.scroll.hidden=YES;
    }
    CGAffineTransform transform =self.userArrow.transform;
    transform = CGAffineTransformRotate(transform, M_PI * (180) / 180.0);
    [UIView animateWithDuration:0.5f animations:^{
        self.userArrow.transform = transform;
    }];
}

//注册方法
-(void) ymRegister{
    if(self.agree == false){
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    if (self.registerView == nil) {

        
        self.registerView = [[SJIOSRegisterView alloc] initWithBlock:^(NSString * username, NSString * password) {

            
            SJIOSUserInfo *userinfo=[[SJIOSUserInfo alloc]initWithInfo:username password:password bind:@"0" tourist:@"0" loginTime:0 phoneNumber:@"0"];
            self.loginInfo=userinfo;

            self.isRegister = YES;
            [self startLogin];
        } landscape:self.landscape];
        
    }
    [self.registerView show:self]; 
}


//点击忘记密码直接跳转到手机找回密码界面
-(void)fogetPassword
{
    if(self.agree == false){
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    if (self.forgetPhoneView == nil) {
        self.forgetPhoneView = [[SJIOSForgetView alloc] initWithLandscape:self.landscape];
    }
    [self.forgetPhoneView show:self];
    
//    [super dismissWithAnimation:YES];//关闭当前界面
    
}

@end
