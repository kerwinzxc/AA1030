
#import "UsequenceForgetView.h"
#import "UIColor+UsequenceSdk.h"
#import "UIImage+UsequenceSdk.h"
#import "UsequenceWebInterface.h"
#import "UsequenceSdkMd5.h"
#import "UsequenceProgressHUD.h"
#import "UsequenceSdkImp.h"
#import "UsequenceForgetEmailView.h"


@interface UsequenceForgetView()

@property(nonatomic, strong) UITextField* username;
@property(nonatomic, strong) UITextField* password;
@property(nonatomic, strong) UITextField* verify;
@property(nonatomic, strong) UIButton* getVerify;
@property(nonatomic, strong) NSTimer * buttonTimer;

@property(nonatomic, strong)UIView *littleContainer;

@property(nonatomic) int cooldown;

@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL reseting;

@property(nonatomic,strong) UsequenceForgetView *ymForgetView;//忘记密码找回界面
@property(nonatomic, strong) UILabel * getVeryCode;//获取验证码文字
//@property(nonatomic)BOOL textIsphoneNumber;//输入的是否是手机号

@property(nonatomic,strong) NSString *homePage;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *qq;
@property(nonatomic,strong) NSString *qqgroup;
@property(nonatomic,strong) NSString *message;

@end

@implementation UsequenceForgetView

- (id)initWithLandscape:(Boolean)landscape
{
    if(landscape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landscape ];
    }
    
    
    if (self) {
        
        
        if(self.landscape){
            [self setLandScapeView];
            [self setupView];
            [self addNotification];
//            self.textIsphoneNumber = NO;
            
        }else{
            [self setPortraitView];
//            [self setupView];
//            [self addNotification];
//            self.textIsphoneNumber = NO;
        }

        
        
    }
    return self;
}

//横屏状态下的默认登录界面
-(void)setLandScapeView{
    
    self.alertContainer.userInteractionEnabled = YES;
    UITapGestureRecognizer *resignTaper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    [self.alertContainer addGestureRecognizer:resignTaper];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_phoneForgetBack) forControlEvents:UIControlEventTouchUpInside];
    

    
    //忘记密码一栏，绑定手机找回界面
    UIButton *bindPhoneFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(85, 15, 120, 38)];
    [bindPhoneFindPasswordButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    [bindPhoneFindPasswordButton setTitle:@"绑定手机找回" forState:UIControlStateNormal];
    [bindPhoneFindPasswordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    bindPhoneFindPasswordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    bindPhoneFindPasswordButton.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    bindPhoneFindPasswordButton.layer.borderWidth = 1;
    [self.alertContainer addSubview:bindPhoneFindPasswordButton];
    
    //申诉找回密码按钮
    UIButton *shensuFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(230, 15, 120, 38)];
    [shensuFindPasswordButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [label setText:@"客服申诉找回"];
    [label sizeToFit];
    if(Usequence_TEXTCOLOR_BLACK == YES){
        [label setTextColor:[UIColor blackColor]];
    }else{
        [label setTextColor:[UIColor whiteColor]];
    }
    label.center = CGPointMake(shensuFindPasswordButton.bounds.size.width/2, shensuFindPasswordButton.bounds.size.height/2);
//    [shensuFindPasswordButton addSubview:imageView];
    [shensuFindPasswordButton addSubview:label];
    
    [self.alertContainer addSubview:shensuFindPasswordButton];
    [shensuFindPasswordButton addTarget:self action:@selector(ym_shensuForgetClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UITextField *accountField = [[UITextField alloc]initWithFrame:CGRectMake(65, 70, 330, 38)];
    accountField.borderStyle = UITextBorderStyleNone;
    accountField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_register_edit_background.png"]];
    accountField.placeholder = @"请输入手机号码";
    //[accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if(Usequence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        accountField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [accountField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        accountField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    accountField.font = [UIFont systemFontOfSize:15];
    accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    accountField.textAlignment = UITextAlignmentLeft;
    accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    accountField.returnKeyType = UIReturnKeyNext;
    accountField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    accountField.delegate=self;
    self.username=accountField;
    
    [self.alertContainer addSubview:self.username];

    
    UITextField * verifyField = [[UITextField alloc] initWithFrame:CGRectMake(65, 115, 210, 38)];
    verifyField.borderStyle = UITextBorderStyleNone;
    verifyField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_register_edit_background.png"]];
    verifyField.placeholder = @" 请输入验证码";
    //[verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if(Usequence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        verifyField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [verifyField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        verifyField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    verifyField.font = [UIFont systemFontOfSize:15];
    verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    verifyField.textAlignment = UITextAlignmentLeft;
    verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    verifyField.returnKeyType = UIReturnKeyNext;
    verifyField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    verifyField.delegate=self;
    
    self.verify=verifyField;
    [self.alertContainer addSubview:self.verify];
    
    //获取验证码按钮
    UIButton *verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(280, 115, 110, 38)];
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifyButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(verifyPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:verifyButton];
    self.getVerify = verifyButton;

    
    
    UITextField *newPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(65, 160,330,38)];
    newPasswordField.borderStyle = UITextBorderStyleNone;
    newPasswordField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_register_edit_background.png"]];
    newPasswordField.placeholder = @" 请输入新密码";
   // [newPasswordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    if(Usequence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        newPasswordField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [newPasswordField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        newPasswordField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [newPasswordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    newPasswordField.font = [UIFont systemFontOfSize:15];
    newPasswordField.secureTextEntry = YES;
    newPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    newPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    newPasswordField.textAlignment = UITextAlignmentLeft;
    newPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    newPasswordField.returnKeyType = UIReturnKeyDone;
    newPasswordField.delegate=self;
    
    self.password=newPasswordField;
    [self.alertContainer addSubview:self.password];

    
    //确定按钮
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 205, 120, 38)];
    UIImage *surebackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_login_button.png"]] ;
    //    [shensuFindPasswordButton setImage:shengsubackImage forState:UIControlStateNormal];
    //    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    UIImageView *sureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [sureImageView setImage:surebackImage];
    UILabel *sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [sureLabel setText:@"确定"];
    if(Usequence_TEXTCOLOR_BLACK == YES){
        [sureLabel setTextColor:[UIColor blackColor]];
    }else{
        [sureLabel setTextColor:[UIColor whiteColor]];
    }
    [sureLabel sizeToFit];
    sureButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    sureButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    sureLabel.center = CGPointMake(sureButton.bounds.size.width/2, sureButton.bounds.size.height/2);
    [sureButton addSubview:sureImageView];
    [sureButton addSubview:sureLabel];
    [sureButton addTarget:self action:@selector(normalPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:sureButton];
    
    
}


//竖屏状态下的默认登录界面
-(void)setPortraitView{

    //边框线
    //        self.alertContainer.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    //        self.alertContainer.layer.borderWidth = 2;
    
    self.alertContainer.backgroundColor = [UIColor whiteColor];
    
    
    self.alertContainer.userInteractionEnabled = YES;
    UITapGestureRecognizer *resignTaper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    [self.alertContainer addGestureRecognizer:resignTaper];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_phoneForgetBack) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码一栏，绑定手机找回界面
    UIButton *bindPhoneFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 30, 100, 38)];
    [bindPhoneFindPasswordButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    [bindPhoneFindPasswordButton setTitle:@"绑定手机找回" forState:UIControlStateNormal];
     bindPhoneFindPasswordButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [bindPhoneFindPasswordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    bindPhoneFindPasswordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    bindPhoneFindPasswordButton.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    bindPhoneFindPasswordButton.layer.borderWidth = 1;
    [self.alertContainer addSubview:bindPhoneFindPasswordButton];
    
    //申诉找回密码按钮
    UIButton *shensuFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 30, 100, 38)];
    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    shensuFindPasswordButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [shensuFindPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shensuFindPasswordButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    [shensuFindPasswordButton addTarget:self action:@selector(ym_shensuForgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:shensuFindPasswordButton];
    

    UITextField *accountField = [[UITextField alloc]initWithFrame:CGRectMake(15, 73, 230, 38)];
    accountField.borderStyle = UITextBorderStyleNone;
    accountField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_register_edit_background.png"]];
    accountField.placeholder = @" 请输入手机号码";
    [accountField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    accountField.font = [UIFont systemFontOfSize:13];
    accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    accountField.textAlignment = UITextAlignmentLeft;
    accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    accountField.returnKeyType = UIReturnKeyNext;
    accountField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    accountField.delegate=self;
    self.username=accountField;
    if(Usequence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        accountField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [accountField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        accountField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    [self.alertContainer addSubview:self.username];
    
    
    UITextField * verifyField = [[UITextField alloc] initWithFrame:CGRectMake(15, 115, 130, 38)];
    verifyField.borderStyle = UITextBorderStyleNone;
    verifyField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_register_edit_background.png"]];
    verifyField.placeholder = @" 请输入验证码";
    [verifyField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    verifyField.font = [UIFont systemFontOfSize:13];
    verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    verifyField.textAlignment = UITextAlignmentLeft;
    verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    verifyField.returnKeyType = UIReturnKeyNext;
    verifyField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    verifyField.delegate=self;
    if(Usequence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        verifyField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [verifyField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        verifyField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    self.verify=verifyField;
    [self.alertContainer addSubview:self.verify];
    
    //获取验证码按钮
    UIButton *verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 115, 95, 38)];
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifyButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(verifyPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:verifyButton];
    self.getVerify = verifyButton;
    
    
    UITextField *newPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(15, 160, 230, 38)];
    newPasswordField.borderStyle = UITextBorderStyleNone;
    newPasswordField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_register_edit_background.png"]];
    newPasswordField.placeholder = @" 请输入新密码";
    [newPasswordField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    newPasswordField.font = [UIFont systemFontOfSize:13];
    newPasswordField.secureTextEntry = YES;
    newPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    newPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    //newPasswordField.textAlignment = UITextAlignmentLeft;
    newPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    newPasswordField.returnKeyType = UIReturnKeyDone;
    newPasswordField.delegate=self;
    
    if(Usequence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        newPasswordField.textColor = [UIColor blackColor];
        // 默认文本颜色
        [newPasswordField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        newPasswordField.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [newPasswordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    self.password=newPasswordField;
    [self.alertContainer addSubview:self.password];
    
    
    //确定按钮
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(65, 210, 130, 38)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"Usequence.bundle/Usequence_login_button.png"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(normalPressed) forControlEvents:UIControlEventTouchUpInside];
    sureButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    sureButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [self.alertContainer addSubview:sureButton];
    self.alertContainer.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_background_landscape.png"]]];

}





//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self.ymForgetView action:@selector(onBackClicked:)];
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
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -70);
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
    [self.verify resignFirstResponder];
    
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘自动上移====end



//手机找回密码返回按钮
-(void)ym_phoneForgetBack {
    [self dismissWithAnimation:YES];
}

//手机找回密码关闭按钮
-(void)ym_phoneForgetClose{
    [super dismissWithAnimation:YES];
}

//手机找回密码确定按钮
-(void)ym_phoneSureButtonClick{
    [super dismissWithAnimation:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
}


//跳转到客服申诉界面
-(void)ym_shensuForgetClick
{
    Usequence_VSD_BLOCK successBlock= ^(NSDictionary *dictionary, NSDictionary *header) {
        
        if ([dictionary objectForKey:@"error"] == nil) {
            NSDictionary *obj = [dictionary objectForKey:@"support"];
            NSLog(@"obj %@", obj);
            self.homePage = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"home"]];
            self.phone = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"phone"]];
            self.message = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"message"]];
            self.qq = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"qq"]];
            self.qqgroup = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"qq_group"]];
            
            
            
            NSLog(@"申诉 dictionary==%@",dictionary);
            
            UsequenceForgetEmailView *forgetView = [[UsequenceForgetEmailView alloc]initWithLandscape:self.landscape phone:self.phone qq:self.qq];
            [forgetView show:self.parent];
            [super dismissWithAnimation:YES];
            
        }
    };
    
    [[UsequenceWebInterface sharedInstance]getUsequenceSupport:[[UsequenceSdkImp sharedInstance]getUsequenceAppId] onSuccessUsequence:successBlock onFailedUsequence:^(NSError *error) {

    }];
}

-(void)resign{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)verifyPressed
{
    [self.username resignFirstResponder];//键盘隐藏
    [self.verify resignFirstResponder];//键盘隐藏
    [self.password resignFirstResponder];//键盘隐藏
    
    if(self.buttonTimer != nil)
    {
        return;
    }
    NSString* username = self.username.text;
    
    
    if (username.length == 0)
    {
        [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"手机号为空"];
        return;

    }
    
    //self.getVerify.enabled = NO;
    self.cooldown = 60;
    [self.getVeryCode setText:@""];//点击获取验证码按钮后文字消失
    
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.verifing = NO;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                [self.getVerify setTitle:@"60秒" forState:UIControlStateNormal];
                NSTimer * buttonTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                         target:self
                                                                       selector:@selector(timerFired:)
                                                                       userInfo:nil
                                                                        repeats:YES];
                
                self.buttonTimer = buttonTimer;
                
                UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                process.labelText = @"获取验证码成功";
                process.mode = UsequenceProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [process removeFromSuperview];
                }];
            }
            else
            {
                self.getVerify.enabled = YES;
                
                UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                [self.getVeryCode setText:@"获取验证码"];
                process.labelText = [[UsequenceSdkImp sharedInstance] translateUsequence:[dictionary valueForKey:@"error"]];
                process.mode = UsequenceProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [process removeFromSuperview];
                }];
            }
        }
        @catch(NSException * e)
        {
            self.getVerify.enabled = YES;
        }
        @finally
        {
            
        }
    };
    
    [[UsequenceWebInterface sharedInstance] changeUsequencePasswordByPhone:username
                     successCallbackUsequence:successCallback
                         failCallbackUsequence:^(NSError * error) {
                             self.verifing = NO;

                         }
     ];
    
    self.verifing = YES;
    UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
    [self.alertContainer addSubview:process];
    //process.dimBackground = YES;
    process.labelText = @"获取验证码";
    [process showAnimated:YES whileExecutingBlock:^{
        while (self.verifing)
        {
            usleep(50000);
        }
    } successCallback:^{
        [process removeFromSuperview];
    }];
}


- (void)normalPressed
{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
    NSString* username = self.username.text;
    
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
    
    
    //判断手机号是否有效
    if(!(isMatch1 || isMatch2 || isMatch3)){
        [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"无效的手机号码,请重新输入..."];
        return;
    }
    
    
    if (username.length == 0)
    {
        UsequenceProgressHUD *myProcess = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = UsequenceProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"账户或手机号为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    NSString* password = self.password.text;
    if (password.length == 0)
    {
        UsequenceProgressHUD *myProcess = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = UsequenceProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"密码为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    //判断密码框是否大于6位小于20位
    
    if ([password length]< 6 || [password length] > 20) {
        [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"密码长度为6到20位"];
        return;
    }
    
    
    NSString* verify = self.verify.text;
    if (verify.length == 0)
    {
        UsequenceProgressHUD *myProcess = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = UsequenceProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"验证码为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.reseting = NO;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                process.labelText = @"密码重设成功";
                process.mode = UsequenceProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [process removeFromSuperview];
                    [self dismissWithAnimation:YES];
                }];
            }
            else
            {
                UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
//                process.labelText = [[UsequenceSdkImp sharedInstance] translateUsequence:[dictionary valueForKey:@"error"]];
                process.labelText = @"输入有误，请重新输入";
                process.mode = UsequenceProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [process removeFromSuperview];
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

        [[UsequenceWebInterface sharedInstance] confirmchangeUsequencePasswordByPhone:username
                                                            passwordUsequence:[UsequenceSdkMd5 md5:password]
                                                              verifyUsequence:verify
                                                     successCallbackUsequence:successCallback
                                                         failCallbackUsequence:^(NSError * error) {
                                                             self.reseting = NO;
                                                         }
         ];
//    }
    
    
    
    
    self.reseting = YES;
    UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
    [self.alertContainer addSubview:process];
    //process.dimBackground = YES;
    process.labelText = @"重设密码中";
    [process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.reseting)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 5) {
                UsequenceProgressHUD *errorHud = [[UsequenceProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:errorHud];
                errorHud.labelText = @"网络不太好，请重试！！！";
                errorHud.mode = UsequenceProgressHUDModeCustomView;
                errorHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [errorHud showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [errorHud removeFromSuperview];
                }];
                
                break;
            }
        }

    } successCallback:^{
        [process removeFromSuperview];
    }];
}

- (void)backPressed:(UIButton*)sender
{
    [self dismissWithAnimation:YES];
}

- (void)timerFired:(NSTimer*)sender
{
    --self.cooldown;
    if (self.cooldown <= 0)
    {
        self.getVerify.enabled = YES;
        [self.buttonTimer invalidate];
        
        self.buttonTimer=nil;
        
        [self.getVerify setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        NSString * title = [[NSString alloc] initWithFormat:@"%d秒", self.cooldown];
        [self.getVerify setTitle:title forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username){
        
        [self.verify becomeFirstResponder];
        
    }else if(textField==self.verify){
        
        [self.password becomeFirstResponder];
        
    }else if(textField==self.password){

        [textField resignFirstResponder];
        
        NSString * username = self.username.text;
        
        if ([username length] == 0)
        {
            
            [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"手机号为空"];
            
            return YES;
        }
        
        NSString * verify = self.verify.text;
        
        if ([verify length] == 0)
        {
            
            [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"验证码为空"];
            
            return YES;
        }
        
        NSString * password = self.password.text;
        if ([password length] == 0)
        {
            [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"密码为空"];
            
            return YES;
        }
        
        [self normalPressed];
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
