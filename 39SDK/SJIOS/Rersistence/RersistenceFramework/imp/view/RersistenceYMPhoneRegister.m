#import "UIImage+RersistenceSdk.h"
#import "UIColor+RersistenceSdk.h"
#import "RersistenceWebInterface.h"
#import "RersistenceSdkMd5.h"
#import "RersistenceSdkImp.h"
#import "RersistenceProgressHUD.h"
#import "RersistenceDataBase.h"
#import "RersistenceRegisterView.h"
#import "RersistenceYMPhoneRegister.h"
#import "RersistenceYMPhoneRegisterView.h"
#import "RersistenceProgressHUD.h"


#define Rersistence_USER_AGREEMENT_URL @"https://www.3975.com/public/web/39XY.html"
@interface RersistenceYMPhoneRegister()

@property(nonatomic, strong) UITextField * username;
@property(nonatomic, strong) UITextField * password;
@property(nonatomic, strong) Rersistence_SUCCESS_Callback success;
@property(nonatomic, strong) Rersistence_FAILED_Callback failed;
@property(nonatomic) Boolean logining;
@property (nonatomic, strong) UITableView * dropdown;
@property (nonatomic, strong) UIButton * users;
@property (nonatomic, strong) NSMutableArray * data;
@property(nonatomic, strong) NSString* code;

//@property (nonatomic,strong)  RersistenceQuickLogin *quidklogin;
@property (nonatomic,strong) RersistenceDefaultLogin *defaultLogin;

@property(nonatomic,strong) UIButton *choose;
@property(nonatomic) Boolean agree;
@property(nonatomic,strong) NSString *token;
@property (nonatomic, strong) NSMutableArray *dataList;//用户列表
@property(nonatomic,strong)  UIImageView *userArrow;//下拉箭头
@property (nonatomic,strong) RersistenceUserInfo *loginInfo;
@property(nonatomic)BOOL login;//是否登录过
@property(nonatomic,strong)UIView *scroll;//用户列表
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong)UIButton *defaultButton;
@property(nonatomic,strong)  RersistenceRegisterView *registerView;//注册
@property(nonatomic,strong)  RersistenceYMPhoneRegister *ymPhoneRegister;//注册
@property(nonatomic,strong)  RersistenceYMPhoneRegisterView *ymPhoneRegisterView;//注册
@property(nonatomic) Boolean SHOWPROCESS;


@property (nonatomic, strong) UITextField *verifyField;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) UILabel *verifyLabel;
@property (nonatomic)int cooldown;
@property(nonatomic, strong) NSTimer * buttonTimer;
@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL binding;
//@property (strong, nonatomic) RersistenceProgressHUD *process;

@property(nonatomic,strong) NSString *ymPhoneNumber;//手机号码
//@property(nonatomic,strong) NSString *ymPassword;//手机密码
@property(nonatomic, strong) Rersistence_RV_Complete_Callback complete;
@property(nonatomic) Boolean registering;//是否注册过
@property (nonatomic, strong)RersistenceProgressHUD *myProcess;


@end

static int isFirstLogin = YES;

@implementation RersistenceYMPhoneRegister



- (id)initWithBlock:(Rersistence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum
{
    
    
    if(landscape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landscape ];
    }
    
    self.ymPhoneNumber=ymPhoneNum;
    
    if (self) {
        // Initialization code
        self.complete = complete;
        self.logining = false;
        self.registering = false;
        self.agree = true;
        
        self.landscape = landscape;
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


//横屏状态下的登录界面
-(void)setLandScapeView{

    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(150, 20, 166, 68);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(login_backButton) forControlEvents:UIControlEventTouchUpInside];
    
    //即将登录的手机号提示
    UILabel* labelphone = [[UILabel alloc] initWithFrame:CGRectMake(65,70, 130, 38)];
    labelphone.text = @"即将注册的手机号：";
    labelphone.font = [UIFont fontWithName:@"Arial" size:14];
    //labelphone.textColor = [UIColor grayColor];
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        [labelphone setTextColor:[UIColor grayColor]];
    }else{
        [labelphone setTextColor:[UIColor whiteColor]];
    }
    
    UILabel* userPhone = [[UILabel alloc] initWithFrame:CGRectMake(180,70, 120, 38)];
    userPhone.text = self.ymPhoneNumber;
    userPhone.font = [UIFont fontWithName:@"Arial" size:14];
    //userPhone.textColor = [UIColor grayColor];
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        [userPhone setTextColor:[UIColor grayColor]];
    }else{
        [userPhone setTextColor:[UIColor whiteColor]];
    }
    [self.alertContainer addSubview:labelphone];
    [self.alertContainer addSubview:userPhone];
    
    
    //请输入验证码
    self.verifyField = [[UITextField alloc] initWithFrame:CGRectMake(65, 98, 210, 38)];
    self.verifyField.borderStyle = UITextBorderStyleNone;
    UIImage *edit_up_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    
    self.verifyField.background = edit_up_image;
    self.verifyField.placeholder = @"请输入验证码";
    //[self.verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        self.verifyField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [self.verifyField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        self.verifyField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [self.verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    self.verifyField.font = [UIFont systemFontOfSize:20];
    self.verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.verifyField.returnKeyType = UIReturnKeyNext;
    self.verifyField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(8, 6, 25, 25);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [usernameLeftView addSubview:logoRView];
    self.verifyField.leftView = usernameLeftView;
    self.verifyField.leftViewMode = UITextFieldViewModeAlways;
    self.verifyField.delegate = self;
    
    [self.alertContainer addSubview:self.verifyField];
    [self.alertContainer bringSubviewToFront:self.verifyField];
    self.username = self.verifyField;
    
    
    //获取验证码按钮
    self.verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(275, 98, 120, 38)];
    UIImage *verifybackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_login_button.png"]] ;
    //    [shensuFindPasswordButton setImage:shengsubackImage forState:UIControlStateNormal];
    //    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [verifyImageView setImage:verifybackImage];
    
    
    self.verifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 38)];
    [self.verifyLabel setText:@"获取验证码"];
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        [self.verifyLabel setTextColor:[UIColor grayColor]];
    }else{
        [self.verifyLabel setTextColor:[UIColor whiteColor]];
    }
    [self.verifyLabel sizeToFit];
    self.verifyLabel.center = CGPointMake(self.verifyButton.bounds.size.width/2, self.verifyButton.bounds.size.height/2);
    
    [self.verifyButton addTarget:self action:@selector(ym_verifyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.verifyButton addSubview:verifyImageView];
    [self.verifyButton addSubview:self.verifyLabel];
    
    [self.alertContainer addSubview:self.verifyButton];
    
    //请输入密码
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(65, 138, 330, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    //[password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if(Rersistence_TEXTCOLOR_BLACK == YES){
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
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
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
    
    

    
    
    //手机注册按钮
    UIButton * ymloginButton=[[UIButton alloc]initWithFrame:CGRectMake(160, 200, 130, 38)];
    UIImage *ymLoginBackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_login_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:ymLoginBackImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [label setText:@"注册"];
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        [label setTextColor:[UIColor blackColor]];
    }else{
        [label setTextColor:[UIColor whiteColor]];
    }
    [label sizeToFit];
    label.center = CGPointMake(ymloginButton.bounds.size.width/2, ymloginButton.bounds.size.height/2);
    [ymloginButton addSubview:imageView];
    [ymloginButton addSubview:label];
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    //    [ymloginButton addTarget:self action:@selector(ym_phoneRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [ymloginButton addTarget:self action:@selector(ym_phoneRegisterPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:ymloginButton];
    
    
    
    
}

//竖屏状态下的登录界面
-(void)setPortraitView{

    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(50, 15, 160 , 62);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(login_backButton) forControlEvents:UIControlEventTouchUpInside];
    
    //即将登录的手机号提示
    UILabel* labelphone = [[UILabel alloc] initWithFrame:CGRectMake(15,70, 130, 38)];
    labelphone.text = @"即将注册的手机号：";
    labelphone.font = [UIFont fontWithName:@"Arial" size:14];
    labelphone.textColor = [UIColor grayColor];
    
    UILabel* userPhone = [[UILabel alloc] initWithFrame:CGRectMake(130,70, 120, 38)];
    userPhone.text = self.ymPhoneNumber;
    userPhone.font = [UIFont fontWithName:@"Arial" size:14];
    userPhone.textColor = [UIColor grayColor];
    [self.alertContainer addSubview:labelphone];
    [self.alertContainer addSubview:userPhone];
    
    
    //请输入验证码
    self.verifyField = [[UITextField alloc] initWithFrame:CGRectMake(15, 98, 130, 38)];
    self.verifyField.borderStyle = UITextBorderStyleNone;
    UIImage *edit_up_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    
    self.verifyField.background = edit_up_image;
    self.verifyField.placeholder = @"请输入验证码";
    [self.verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.verifyField.font = [UIFont systemFontOfSize:13];
    self.verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.verifyField.returnKeyType = UIReturnKeyNext;
    self.verifyField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(10, 10, 15, 15);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [usernameLeftView addSubview:logoRView];
    self.verifyField.leftView = usernameLeftView;
    self.verifyField.leftViewMode = UITextFieldViewModeAlways;
    self.verifyField.delegate = self;
    
    [self.alertContainer addSubview:self.verifyField];
    [self.alertContainer bringSubviewToFront:self.verifyField];
    self.username = self.verifyField;
    
    
    //获取验证码按钮
    self.verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(145, 98, 100, 38)];
    UIImage *verifybackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_login_button.png"]] ;
    //    [shensuFindPasswordButton setImage:shengsubackImage forState:UIControlStateNormal];
    //    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 38)];
    [verifyImageView setImage:verifybackImage];
    
    
    self.verifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
    [self.verifyLabel setText:@"获取验证码"];
    [self.verifyLabel setTextColor:[UIColor whiteColor]];
    [self.verifyLabel sizeToFit];
    self.verifyLabel.center = CGPointMake(self.verifyButton.bounds.size.width/2, self.verifyButton.bounds.size.height/2);
    
    [self.verifyButton addTarget:self action:@selector(ym_verifyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.verifyButton addSubview:verifyImageView];
    [self.verifyButton addSubview:self.verifyLabel];
    
    [self.alertContainer addSubview:self.verifyButton];
    
    //请输入密码
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(15, 138, 230, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    password.font = [UIFont systemFontOfSize:13];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
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
    
    
    //阅读协议
    self.choose = [[UIButton alloc] initWithFrame:CGRectMake(15, self.verifyButton.frame.origin.y + 82, 20, 20)];
    [self.choose setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_read.png"] forState:
     UIControlStateNormal];
    [self.choose addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:self.choose];
    
    UILabel *agree1 = [[UILabel alloc]initWithFrame:CGRectMake(36, self.verifyButton.frame.origin.y + 85, 85, 18)];
    [agree1 setFont:[UIFont systemFontOfSize:12]];
    [agree1 setText:@"我已阅读并同意"];
    [agree1 sizeToFit];
    [self.alertContainer addSubview:agree1];
    
    UILabel *agree2 = [[UILabel alloc]initWithFrame:CGRectMake(121, self.verifyButton.frame.origin.y + 85, 50, 18)];
    [agree2 setFont:[UIFont systemFontOfSize:12]];
    [agree2 setText:@"《用户服务注册协议》"];
    if(Rersistence_TEXTCOLOR_BLACK == NO){
        [agree2 setTextColor:[UIColor whiteColor]];
    }else{
        [agree2 setTextColor:[UIColor blueColor]];
    }
    [agree2 sizeToFit];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agree2)];
    [agree2 addGestureRecognizer:labelTapGestureRecognizer];
    agree2.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    [self.alertContainer addSubview:agree2];
    
    //手机注册按钮
    UIButton *ymloginButton = [[UIButton alloc]initWithFrame:CGRectMake(65, 200, 130, 38)];
    [ymloginButton setTitle:@"注册" forState:UIControlStateNormal];
    ymloginButton.titleLabel.font=[UIFont systemFontOfSize:13];
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [ymloginButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_login_button.png"] forState:UIControlStateNormal];
    [ymloginButton addTarget:self action:@selector(ym_phoneRegisterPressed) forControlEvents:UIControlEventTouchUpInside];
    ymloginButton.layer.cornerRadius=5;
    [self.alertContainer addSubview:ymloginButton];
    
}



//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self.ymPhoneRegister action:@selector(onBackClicked:)];
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

    
    //0, -keyboardHeight
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -50);
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
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Rersistence_USER_AGREEMENT_URL]];
}

-(void) chooseClick{
    if(self.agree == true){
        self.agree = false;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_unOK.png"] forState:
         UIControlStateNormal];
    }else{
        self.agree = true;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_OK.png"] forState:
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

//获取验证码方法
-(void)ym_verifyPressed:(id)sender {
    if (self.buttonTimer != nil) {
        return;
    }
    
    
    self.verifyButton.enabled = NO;
    self.cooldown = 60;
    
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.verifing = NO;
        self.verifyButton.enabled = YES;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            NSLog(@"ymphone_getverify::::%@",dictionary);
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                [self.verifyLabel setText:@"60秒"];
                [self.verifyLabel sizeToFit];
                self.verifyLabel.center = CGPointMake(self.verifyButton.bounds.size.width/2, self.verifyButton.bounds.size.height/2);
                NSTimer * buttonTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                         target:self
                                                                       selector:@selector(timerFired:)
                                                                       userInfo:nil
                                                                        repeats:YES];
                
                self.buttonTimer = buttonTimer;
                
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"获取验证码成功"];
                self.logining = false;
                
                
            }
            else
            {
                self.myProcess = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:self.myProcess];
                [self.alertContainer bringSubviewToFront:self.myProcess];
                self.myProcess.labelText = [[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]];
                self.myProcess.mode = RersistenceProgressHUDModeCustomView;
                self.myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [self.myProcess showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [self.myProcess removeFromSuperview];
                }];
                
                
            }
        }
        @catch(NSException * e)
        {
        }
        @finally
        {
            
        }
    };
    
    
    [[RersistenceWebInterface sharedInstance] phoneRersistenceRegistVerify:self.ymPhoneNumber
                                      successCallbackRersistence:successCallback
                                          failCallbackRersistence:^(NSError * error){
                                              if (self.myProcess == nil) {
                                                  self.myProcess = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
                                              }
                                              
                                              [self.alertContainer addSubview:self.myProcess];
                                              [self.alertContainer bringSubviewToFront:self.myProcess];
                                              self.myProcess.labelText = @"内部错误";
                                              [self.myProcess showAnimated:YES whileExecutingBlock:^{
                                                  
                                                  [NSThread sleepForTimeInterval:1];
                                              } successCallback:^{
                                                  [self.myProcess removeFromSuperview];
                                              }];
                                              self.verifing = YES;
                                          }
     ];
    
    self.verifing = YES;
    
    [NSThread  detachNewThreadSelector:@selector(getVerifyDespatch) toTarget:self withObject:nil];
    
}


- (void)timerFired:(NSTimer*)sender
{
    --self.cooldown;
    if (self.cooldown <= 0)
    {
        [self.buttonTimer invalidate];
        self.buttonTimer = nil;
        
        [self.verifyLabel setText:@"获取验证码"];
        [self.verifyLabel sizeToFit];
        self.verifyLabel.center = CGPointMake(self.verifyButton.bounds.size.width/2, self.verifyButton.bounds.size.height/2);
    }
    else
    {
        NSString * title = [[NSString alloc] initWithFormat:@"%d秒", self.cooldown];
        [self.verifyLabel setText:title];
        [self.verifyLabel sizeToFit];
        self.verifyLabel.center = CGPointMake(self.verifyButton.bounds.size.width/2, self.verifyButton.bounds.size.height/2);
    }
}

-(void)getVerifyDespatch {
    self.myProcess = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
    [self.alertContainer addSubview:self.myProcess];
    [self.alertContainer bringSubviewToFront:self.myProcess];
//    self.myProcess.labelText = @"获取验证码";
    
    [self.myProcess showAnimated:YES whileExecutingBlock:^{
        while (self.verifing)
        {
            usleep(50000);
        }
    } successCallback:^{
        [self.myProcess removeFromSuperview];
    }];
}


//手机注册方法
- (void)ym_phoneRegisterPressed
{
    NSString* verify = self.verifyField.text;
[[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [self.username resignFirstResponder];//键盘隐藏
    [self.password resignFirstResponder];//键盘隐藏
    
    
    if (verify.length == 0)
    {
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请输入验证码"];

        return;
    }
    
    NSString* password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    //判断密码输入框是否为空
    if([password length]== 0){
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请输入密码"];
        return;
    }
    
    //判断密码框是否大于6位小于20位
    
    if ([password length]< 6 || [password length] > 20) {
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"密码长度为6到20位"];
        return;
    }
    
    
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.registering = false;
        @try
        {
            if (dictionary == nil)
            {
                self.registering = false;
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"网络不太好，请重试！！！"];
                return;
            }

            
            
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                //创建一个消息对象
           NSNotification * notice = [NSNotification notificationWithName:@"registerOK" object:nil userInfo:[dictionary valueForKey:@"id"]];
                
                
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                [[RersistenceSdkImp sharedInstance] sjRersistenceRegister:[dictionary valueForKey:@"id"]];
                
                [self.myProcess removeFromSuperview];
                
                [self dismissWithAnimationWitComplete:YES];
            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                
//                [self setRandomAccount];
                
            }
            self.registering = false;
        
        }
        @catch(NSException * e)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误"];
            self.registering = false;
        }
        @finally
        {
            self.registering = false;
        }
    };
    
    self.registering = true;
    [[RersistenceWebInterface sharedInstance] phoneRersistenceRegist:self.ymPhoneNumber
                                            passwordRersistence:self.password.text
                                          verifyCodeRersistence:self.verifyField.text
                                     successCallbackRersistence:successCallback
                                         failCallbackRersistence:^(NSError * error) {
                                             self.registering = false;
                                             
                                             [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
                                         }
          ];
    
    //[NSThread detachNewThreadSelector:@selector(process) toTarget:self withObject:nil];
    [self process];
 
}



-(void)process {
    if (self.myProcess == nil) {
        self.myProcess = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
    }
    
    [self.alertContainer addSubview:self.myProcess];
    //process.dimBackground = YES;
    self.myProcess.labelText = @"注册中";
    [self.myProcess showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.registering)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 15) {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
        
    } successCallback:^{
        [self.myProcess removeFromSuperview];
    }];
    
}



- (void)dismissWithAnimationWitComplete:(BOOL)animated
{
    //todo delegate
    NSString * username = self.ymPhoneNumber;
    NSString * password = self.password.text;

    
    self.alertContainer.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.2f animations:^{
        self.alertContainer.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.complete(username, password);
        [self removeFromSuperview];
    }];
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
        
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"注册成功！帐号信息截图已保存到相册中，帐号丢失可以查看截图找回，请妥善保管！"];
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
    
    [[RersistenceWebInterface sharedInstance] RersistencesendHeart:self.code];
    
    [[RersistenceSdkImp sharedInstance] showRersistenceWelcome:[self.username text]];
    [super dismissWithAnimation:animated];
}



-(void)login_backButton{
    [super dismissWithAnimation:YES];
}

//登录关闭按钮
-(void)ym_loginCloseButton{
    [super dismissWithAnimation:YES];
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
            
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"验证码为空"];
            
            return YES;
        }
        
        NSString * password = self.password.text;
        if ([password length] == 0)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"密码为空"];
            
            return YES;
        }
        
        [self ym_phoneRegisterPressed];
    }
    return YES;
}






@end
