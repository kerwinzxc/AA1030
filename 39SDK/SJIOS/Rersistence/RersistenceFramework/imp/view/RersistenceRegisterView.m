

#import "RersistenceRegisterView.h"
#import "UIColor+RersistenceSdk.h"
#import "UIImage+RersistenceSdk.h"

#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "RersistenceWebInterface.h"
#import "RersistenceProgressHUD.h"
#import "RersistenceSdkMd5.h"
#import "RersistenceSdkImp.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define Rersistence_USER_AGREEMENT_URL @"https://www.3975.com/public/web/39XY.html"

@interface RersistenceRegisterView()<UIAlertViewDelegate>

@property(nonatomic, strong) UITextField* username;
@property(nonatomic, strong) UITextField* password;
@property(nonatomic,strong)  UITextField* secondPassword;

@property(nonatomic, strong) Rersistence_RV_Complete_Callback complete;
@property(nonatomic) Boolean registering;
@property (nonatomic, strong)RersistenceProgressHUD *myProcess;


@property(nonatomic,strong) UIButton *choose;
@property(nonatomic) Boolean agree;

@property(nonatomic,strong) RersistenceRegisterView *ymRegisterView;//帐号注册界面

@end

@implementation RersistenceRegisterView

- (id)initWithBlock:(Rersistence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape
{
    if(landscape){
        //横屏
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
        
    }else{
        //竖屏
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landscape ];
    }
    
    if (self) {
        // Initialization code
        self.complete = complete;
        self.registering = false;
        
        self.agree = true;
        
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
    [self setRandomAccount];
    return self;
}

//横屏状态下的默认登录界面
-(void)setLandScapeView{
    
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame =  CGRectMake(170, 5, 128, 52);
    [self.alertContainer addSubview:logoView];
    
    //注册返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_ym_back.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_registerBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(65, 55, 330, 38)];
    username.borderStyle = UITextBorderStyleNone;
    username.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    username.placeholder = @"请输入用户名";
    username.font = [UIFont systemFontOfSize:16];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    if(Rersistence_TEXTCOLOR_BLACK == YES){
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
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_r.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(5, 6, 20, 20);
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 33)];
    [usernameLeftView addSubview:logoRView];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    username.delegate = self;
    
    [self.alertContainer addSubview:username];
    [self.alertContainer bringSubviewToFront:username];
    self.username = username;
    
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(65, 95, 330, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    password.font = [UIFont systemFontOfSize:16];
    password.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.textAlignment = UITextAlignmentLeft;
    // password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
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
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(5, 6, 20, 20);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 33)];
    [passwordLeftView addSubview:logoSView];
    password.leftView = passwordLeftView;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    password.delegate = self;
    
    [self.alertContainer addSubview:password];
    [self.alertContainer bringSubviewToFront:password];
    self.password = password;
    
    
    
    UITextField * secondpassword = [[UITextField alloc] initWithFrame:CGRectMake(65, 135, 330, 38)];
    secondpassword.borderStyle = UITextBorderStyleNone;
    secondpassword.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    secondpassword.placeholder = @"请重新输入密码";
    secondpassword.font = [UIFont systemFontOfSize:16];
    secondpassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    secondpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    secondpassword.textAlignment = UITextAlignmentLeft;
    //secondpassword.secureTextEntry = YES;
    secondpassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    secondpassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    secondpassword.returnKeyType = UIReturnKeyDone;
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        secondpassword.textColor = [UIColor blackColor];
        // 默认文本颜色
        [secondpassword setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        secondpassword.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [secondpassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    UIImage *logo_p=[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
    UIImageView *logoPView=[[UIImageView alloc]initWithImage:logo_p];
    logoPView.frame = CGRectMake(5, 6, 20, 20);
    UIView * secondpasswordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 33)];
    [secondpasswordLeftView addSubview:logoPView];
    secondpassword.leftView = secondpasswordLeftView;
    secondpassword.leftViewMode = UITextFieldViewModeAlways;
    
    secondpassword.delegate = self;
    
    [self.alertContainer addSubview:secondpassword];
    [self.alertContainer bringSubviewToFront:secondpassword];
    self.secondPassword=secondpassword;
    

    
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 195, 130, 38)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_login_button.png"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(normalPressed) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius=5;
    registerButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    registerButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [self.alertContainer addSubview:registerButton];
    
}

//竖屏状态下的默认登录界面
-(void)setPortraitView{
    
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame =  CGRectMake(85, 15, 95 , 38);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_ym_back.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_registerBack) forControlEvents:UIControlEventTouchUpInside];
    

    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(15, logoView.frame.size.height+15, 230, 38)];
    username.borderStyle = UITextBorderStyleNone;
    username.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    username.placeholder = @"请输入用户名";
    username.font = [UIFont systemFontOfSize:16];
    username.clearButtonMode = UITextFieldViewModeAlways;
    username.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_r.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(10, 10, 15, 15);
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [usernameLeftView addSubview:logoRView];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    if(Rersistence_TEXTCOLOR_BLACK == YES){
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
    
    
    username.delegate = self;
    
    [self.alertContainer addSubview:username];
    [self.alertContainer bringSubviewToFront:username];
    self.username = username;
    
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(15, username.frame.size.height+username.frame.origin.y+5, 230, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    password.font = [UIFont systemFontOfSize:16];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.textAlignment = UITextAlignmentLeft;
    password.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(10, 10, 15, 15);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [passwordLeftView addSubview:logoSView];
    password.leftView = passwordLeftView;
    password.leftViewMode = UITextFieldViewModeAlways;
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
    
    password.delegate = self;
    
    [self.alertContainer addSubview:password];
    [self.alertContainer bringSubviewToFront:password];
    self.password = password;
    
    
    
    UITextField * secondpassword = [[UITextField alloc] initWithFrame:CGRectMake(15, password.frame.size.height+password.frame.origin.y+5, 230, 38)];
    secondpassword.borderStyle = UITextBorderStyleNone;
    secondpassword.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    secondpassword.placeholder = @"请重新输入密码";
    secondpassword.font = [UIFont systemFontOfSize:16];
    secondpassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    secondpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    secondpassword.textAlignment = UITextAlignmentLeft;
    secondpassword.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    secondpassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    secondpassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    secondpassword.returnKeyType = UIReturnKeyDone;
    
    UIImage *logo_p=[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_s.png"]];
    UIImageView *logoPView=[[UIImageView alloc]initWithImage:logo_p];
    logoPView.frame = CGRectMake(10, 10, 15, 15);
    UIView * secondpasswordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [secondpasswordLeftView addSubview:logoPView];
    secondpassword.leftView = secondpasswordLeftView;
    secondpassword.leftViewMode = UITextFieldViewModeAlways;
    
    secondpassword.delegate = self;
    
    [self.alertContainer addSubview:secondpassword];
    [self.alertContainer bringSubviewToFront:secondpassword];
    self.secondPassword=secondpassword;
    
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        // 输入文本颜色
        secondpassword.textColor = [UIColor blackColor];
        // 默认文本颜色
        [secondpassword setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        // 输入文本颜色
        secondpassword.textColor = [UIColor whiteColor];
        // 默认文本颜色
        [secondpassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(65, secondpassword.frame.origin.y+secondpassword.frame.size.height+20, 130, 38)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_login_button.png"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(normalPressed) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius=5;
    registerButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    registerButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [self.alertContainer addSubview:registerButton];
    
    
}




//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self.ymRegisterView action:@selector(onBackClicked:)];
    [self.alertContainer addGestureRecognizer:tapGesture];
}

-(void)addNotification{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(onKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)onKeyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    // ============================================================
    
    NSTimeInterval duration  = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    //    CGRect keyboardRect  = [userInfoDic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardHeight = MIN(CGRectGetWidth(keyboardRect), CGRectGetHeight(keyboardRect));
    
    //0, -keyboardHeight
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -55);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;

    // ============================================================
    
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
    [self.secondPassword resignFirstResponder];
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end




//注册关闭按钮
-(void)ym_registerClose{
    [super dismissWithAnimation:YES];
}

//注册返回按钮
- (void)ym_registerBack
{
    [super dismissWithAnimation:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.secondPassword resignFirstResponder];
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

- (void)setRandomAccount
{
    int v1 = arc4random() % 1000000;
    int v2 = arc4random() % 1000000;
    int v3 = arc4random() % 10000;
    NSString *randomAccount = [[NSString alloc] initWithFormat:@"sjhy%d%d", v1, v2];
    NSString *randomPassword = [[NSString alloc] initWithFormat:@"sjhyp%d", v3];
    self.username.text = randomAccount;
    self.password.text = randomPassword;
    self.secondPassword.text = randomPassword;
}


-(void)savePhoto
{

    
    UIImage * image = [self captureImageFromView:self];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingResult:contextInfo:), nil);
    
    
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

-(void) image:(UIImage *)image didFinishSavingResult:(NSError *)error contextInfo:(void *)contentInfo
{
    if(error == nil){
        NSLog(@"save success");
        
        
        
    }else{
        NSLog(@"save error");
        
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"clickedButtonAtIndex 0");

    }else{
        NSLog(@"clickedButtonAtIndex 1");
    }
}


- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (void)normalPressed
{
    
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.secondPassword resignFirstResponder];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    if(self.agree == false){
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    NSString * username = self.username.text;
    if ([username length] == 0)
    {
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"用户名为空"];
        return;
    }
    
    
    
    //判断roadTitleLab.text 是否含有qingjoin
    if([username rangeOfString:@" "].location !=NSNotFound)//_roaldSearchText
    {
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"用户名中不能有空格"];
        return;
    }
    else
    {
    }
    
    
    NSString * password = self.password.text;
    if ([password length] == 0)
    {
      [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"密码为空"];
        
        return;
    }
    BOOL ret = [self isPureInt:username];
    if (ret == YES) {
        
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"账户不能为纯数字"];

        return;
    }
    
    
    
    if ([username length] <6 || [username length] > 20) {
        
          [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"账户长度为6到20位"];
            return;
    }
    
    if ([password length]< 6 || [password length] > 20) {
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"密码长度为6到20位"];
        return;
    }
    if (![password isEqualToString:self.secondPassword.text]) {
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"对不起你两次输入的密码不匹配"];
        return;
    }
    
    //只能输入由26个英文字母组成的字符串：^[A-Za-z]+$
    //NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    
    if(![pred evaluateWithObject: self.username.text])
    {
        NSLog(@"self.username.text==%@",self.username.text);
        [[RersistenceSdkImp sharedInstance] showRersistenceToast: @"用户名只能由字母+数字组成,并且字母在数字前面"];
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
                [self savePhoto];
                
                [self dismissWithAnimationWitComplete:YES];
            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                
                [self setRandomAccount];
                
            }
            self.registering = false;
            
            
        }
        @catch(NSException * e)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误,请重新注册"];
            self.registering = false;
        }
        @finally
        {
            self.registering = false;
        }
    };
    
    self.registering = true;
    [[RersistenceWebInterface sharedInstance] normalRersistenceRegister:username
                     passwordRersistence:[RersistenceSdkMd5 md5:password]
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
    NSString * username = self.username.text;
    NSString * password = self.password.text;
    
    self.alertContainer.transform = CGAffineTransformIdentity;
    
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.secondPassword resignFirstResponder];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.alertContainer.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.complete(username, password);
        [self removeFromSuperview];
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username){
        
        [self.password becomeFirstResponder];
        
    }else if(textField==self.password){
        
        [self.secondPassword becomeFirstResponder];
        
    }else if(textField==self.secondPassword){
        
        [textField resignFirstResponder];
        
        NSString * username = self.username.text;
        
        if ([username length] == 0)
        {
            
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"账户为空"];
            
            return YES;
        }
        
        NSString * password = self.password.text;
        
        if ([password length] == 0)
        {
            
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"密码为空"];
            
            return YES;
        }
        
        NSString * secondPassword = self.secondPassword.text;
        if ([secondPassword length] == 0)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"重复密码为空"];
            
            return YES;
        }
        
        [self normalPressed];
    }
    return YES;

}


@end
