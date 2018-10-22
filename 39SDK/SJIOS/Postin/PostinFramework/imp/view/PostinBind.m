

#import "PostinBind.h"
#import "PostinProgressHUD.h"

#import "PostinSdkMd5.h"
#import "PostinWebInterface.h"
#import "PostinSdkImp.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIControl+ZHW.h"

#define Postin_USER_AGREEMENT_URL @"https://www.3975.com/public/web/39XY.html"

@interface PostinBind()
@property(nonatomic, strong) UITextField* username;
@property(nonatomic, strong) UITextField* password;
@property(nonatomic,strong)  UITextField* secondPassword;

@property(nonatomic, strong) Postin_RV_Complete_Callback complete;
@property(nonatomic) Boolean registering;
@property (nonatomic, strong)PostinProgressHUD *myProcess;
@property (nonatomic,strong) NSString* bindname;

@property(nonatomic,strong) UIButton *choose;
@property(nonatomic) Boolean agree;

@property(nonatomic,strong) PostinBind *ymBind;//绑定正式帐号界面

@end


@implementation PostinBind


- (id)initWithBlock:(Postin_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname
{
    if(landscape){
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
    }else{
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landscape ];
    }
    
    
    if (self) {
        // Initialization code
        
        self.complete = complete;
        self.registering = false;
        self.bindname=bindname;
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
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame =  CGRectMake(170, 5, 128, 52);
    [self.alertContainer addSubview:logoView];
    
    //绑定返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_bindBack) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(65, 55, 330, 38)];
    username.borderStyle = UITextBorderStyleNone;
    username.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    username.placeholder = @"请输入用户名";
    if(Postin_TEXTCOLOR_BLACK == YES){
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
    username.font = [UIFont systemFontOfSize:16];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_r.png"]];
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
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    password.font = [UIFont systemFontOfSize:16];
    if(Postin_TEXTCOLOR_BLACK == YES){
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
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.textAlignment = UITextAlignmentLeft;
    //  password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_s.png"]];
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
    secondpassword.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    secondpassword.placeholder = @"请重新输入密码";
    secondpassword.font = [UIFont systemFontOfSize:16];
    secondpassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    secondpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    //    secondpassword.textAlignment = UITextAlignmentLeft;
    // secondpassword.secureTextEntry = YES;
    if(Postin_TEXTCOLOR_BLACK == YES){
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
    secondpassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    secondpassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    secondpassword.returnKeyType = UIReturnKeyDone;
    
    UIImage *logo_p=[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_s.png"]];
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
    [registerButton setBackgroundImage:[UIImage imageNamed:@"Postin.bundle/Postin_login_button.png"] forState:UIControlStateNormal];
    [registerButton setTitle:@"绑定" forState:UIControlStateNormal];
    if(Postin_TEXTCOLOR_BLACK == YES){
        [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }else{
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    
    [registerButton addTarget:self action:@selector(bindPressed) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius=5;
    registerButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    registerButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [self.alertContainer addSubview:registerButton];
    
    
}

//竖屏状态下的默认登录界面
-(void)setPortraitView{
    
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame =  CGRectMake(85, 15, 95 , 38);
    [self.alertContainer addSubview:logoView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ym_back.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_bindBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(15, logoView.frame.size.height+15, 230, 38)];
    username.borderStyle = UITextBorderStyleNone;
    username.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    username.placeholder = @"请输入用户名";
    username.font = [UIFont systemFontOfSize:16];
    username.clearButtonMode = UITextFieldViewModeAlways;
    username.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_r.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(10, 10, 15, 15);
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [usernameLeftView addSubview:logoRView];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    username.delegate = self;
    
    [self.alertContainer addSubview:username];
    [self.alertContainer bringSubviewToFront:username];
    self.username = username;
    
    UITextField * password = [[UITextField alloc] initWithFrame:CGRectMake(15, username.frame.size.height+username.frame.origin.y+5, 230, 38)];
    password.borderStyle = UITextBorderStyleNone;
    password.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    password.placeholder = @"请输入密码";
    password.font = [UIFont systemFontOfSize:16];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.textAlignment = UITextAlignmentLeft;
    password.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(10, 10, 15, 15);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [passwordLeftView addSubview:logoSView];
    password.leftView = passwordLeftView;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    password.delegate = self;
    
    [self.alertContainer addSubview:password];
    [self.alertContainer bringSubviewToFront:password];
    self.password = password;
    
    
    
    UITextField * secondpassword = [[UITextField alloc] initWithFrame:CGRectMake(15, password.frame.size.height+password.frame.origin.y+5, 230, 38)];
    secondpassword.borderStyle = UITextBorderStyleNone;
    secondpassword.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    secondpassword.placeholder = @"请重新输入密码";
    secondpassword.font = [UIFont systemFontOfSize:16];
    secondpassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    secondpassword.autocorrectionType = UITextAutocorrectionTypeNo;
    secondpassword.textAlignment = UITextAlignmentLeft;
    secondpassword.keyboardType = UIKeyboardTypeAlphabet;//输入字母键盘
    secondpassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    secondpassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    secondpassword.returnKeyType = UIReturnKeyDone;
    
    UIImage *logo_p=[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_s.png"]];
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
    
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(65, secondpassword.frame.origin.y+secondpassword.frame.size.height+5, 130, 38)];
    [registerButton setTitle:@"绑定" forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"Postin.bundle/Postin_login_button.png"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(bindPressed) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius=5;
    registerButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    registerButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [self.alertContainer addSubview:registerButton];
    
    
    
    self.choose = [[UIButton alloc] initWithFrame:CGRectMake(15, registerButton.frame.origin.y + 47, 20, 20)];
    [self.choose setBackgroundImage:[UIImage imageNamed:@"Postin.bundle/Postin_read.png"] forState:
     UIControlStateNormal];
    [self.choose addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:self.choose];
    
    UILabel *agree1 = [[UILabel alloc]initWithFrame:CGRectMake(36, registerButton.frame.origin.y + 50, 85, 18)];
    [agree1 setFont:[UIFont systemFontOfSize:12]];
    [agree1 setText:@"我已阅读并同意"];
    [agree1 sizeToFit];
    [self.alertContainer addSubview:agree1];
    
    UILabel *agree2 = [[UILabel alloc]initWithFrame:CGRectMake(121, registerButton.frame.origin.y + 50, 50, 18)];
    [agree2 setFont:[UIFont systemFontOfSize:12]];
    [agree2 setText:@"《用户服务注册协议》"];
    if(Postin_TEXTCOLOR_BLACK == NO){
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


//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self.ymBind action:@selector(onBackClicked:)];
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
    [self.password resignFirstResponder];
    [self.secondPassword resignFirstResponder];
    
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.secondPassword resignFirstResponder];
}


-(void)agree2{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Postin_USER_AGREEMENT_URL]];
}

-(void) ym_bindChooseClick{
    if(self.agree == true){
        self.agree = false;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"Postin.bundle/Postin_noread.png"] forState:
         UIControlStateNormal];
    }else{
        self.agree = true;
        [self.choose setBackgroundImage:[UIImage imageNamed:@"Postin.bundle/Postin_read.png"] forState:
         UIControlStateNormal];
    }
}


- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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

-(void) image:(UIImage *)image didFinishSavingResult:(NSError *)error contextInfo:(void *)contentInfo
{
    if(error == nil){
        NSLog(@"save success");

        [[PostinSdkImp sharedInstance] showPostinToast:@"绑定成功！帐号信息截图已保存到相册中，帐号丢失可以查看截图找回，请妥善保管！"];
        
    }else{
        NSLog(@"save error");
        
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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


- (void)bindPressed
{
    if(self.agree == false){
        [[PostinSdkImp sharedInstance] showPostinToast:@"请详细阅读并同意用户协议"];
        return;
    }
    
    NSString * username = self.username.text;
    if ([username length] == 0)
    {
        
        [[PostinSdkImp sharedInstance]showPostinToast:@"用户名为空" ];
            return;
    }
    
    NSString * password = self.password.text;
    if ([password length] == 0)
    {
        [[PostinSdkImp sharedInstance]showPostinToast:@"密码为空"];
                return;
    }
    BOOL ret = [self isPureInt:username];
    if (ret == YES) {
        
         [[PostinSdkImp sharedInstance]showPostinToast: @"账户不能为纯数字"];
        
        
        return;
    }
    
    
    
    if ([username length] <6 || [username length] > 20) {
         [[PostinSdkImp sharedInstance]showPostinToast: @"账户长度为6到20位"];
        return;
    }
    
    if ([password length]< 6 || [password length] > 20) {
         [[PostinSdkImp sharedInstance]showPostinToast: @"密码长度为6到20位"];
            return;
 
    }
    
    NSString * secondPassword=[self.secondPassword text];
    if(![secondPassword isEqualToString:password]){
        
        [[PostinSdkImp sharedInstance]showPostinToast: @"对不起你两次输入的密码不匹配"];
        return;
        
    }
    
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    
    if(![pred evaluateWithObject: self.username.text])
    {
        NSLog(@"self.username.text==%@",self.username.text);
        [[PostinSdkImp sharedInstance] showPostinToast: @"用户名只能由字母跟数字组成"];
        return;
    }
    
    
    
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.registering = false;
        @try
        {

            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {

                [self.myProcess removeFromSuperview];

                [self savePhoto];

                [self dismissWithAnimationWitComplete:YES];
            }
            else
            { 
                [[PostinSdkImp sharedInstance]showPostinToast: [[PostinSdkImp sharedInstance] translatePostin:[dictionary valueForKey:@"error"]]];
                
                }
        }
        @catch(NSException * e)
        {
            
            [[PostinSdkImp sharedInstance]showPostinToast: @"内部错误"];
}
        @finally
        {
            
        }
    };
    
    self.registering = true;
    [[PostinWebInterface sharedInstance] bindPostinRegister:username
                                          passwordPostin:[PostinSdkMd5 md5:password]
                                    bindUsernamePostin:self.bindname
                                   successCallbackPostin:successCallback
                                       failCallbackPostin:^(NSError * error) {
                                           self.registering = false;
                                           [[PostinSdkImp sharedInstance]showPostinToast:@"请检查网络连接！"];
                                       }
     ];
    [self process];
    
}

-(void)process {
    if (self.myProcess == nil) {
        self.myProcess = [[PostinProgressHUD alloc] initWithView:self.alertContainer];
    }
    
    [self.alertContainer addSubview:self.myProcess];
    //process.dimBackground = YES;
    self.myProcess.labelText = @"绑定中";
    [self.myProcess showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.registering)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 5) {
                [[PostinSdkImp sharedInstance]showPostinToast:@"网络不太好，请重试！！！"];
                                
                break;
            }
        }
        
    } successCallback:^{
        [self.myProcess removeFromSuperview];
        
    }];
    
}

//绑定关闭按钮
-(void)ym_bindClose{
    [super dismissWithAnimation:YES];
}

//绑定返回按钮
- (void)ym_bindBack
{
    [super dismissWithAnimation:YES];
}

- (void)dismissWithAnimationWitComplete:(BOOL)animated
{
    //todo delegate
    NSString * username = self.username.text;
    NSString * password = self.password.text;
    
    self.alertContainer.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.2f animations:^{
        self.alertContainer.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.complete(username, password);
        [self removeFromSuperview];
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username)
    {
        [self.password becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        self.username.rightViewMode = UITextFieldViewModeAlways;
    }
    return YES;
}

@end
