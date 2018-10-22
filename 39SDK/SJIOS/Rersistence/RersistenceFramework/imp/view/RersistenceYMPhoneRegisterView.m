

#import "RersistenceYMPhoneRegisterView.h"
#import "UIImage+RersistenceSdk.h"
#import "UIColor+RersistenceSdk.h"
#import "RersistenceWebInterface.h"
#import "RersistenceSdkMd5.h"
#import "RersistenceSdkImp.h"
#import "RersistenceProgressHUD.h"
#import "RersistenceDataBase.h"
#import "RersistenceRegisterView.h"
#import "RersistenceYMPhoneRegister.h"
#import "RersistenceYMPhoneLogin.h"
#define Rersistence_USER_AGREEMENT_URL @"https://www.3975.com/public/web/39XY.html"

@interface RersistenceYMPhoneRegisterView()

@property(nonatomic, strong) UITextField * username;
@property(nonatomic, strong) UITextField * password;
@property(nonatomic, strong) Rersistence_SUCCESS_Callback success;
@property(nonatomic, strong) Rersistence_FAILED_Callback failed;
@property(nonatomic) Boolean logining;
@property (nonatomic, strong) UITableView * dropdown;
@property (nonatomic, strong) UIButton * users;
@property (nonatomic, strong) NSMutableArray * data;
@property(nonatomic, strong) NSString* code;
@property (nonatomic, strong) RersistenceProgressHUD *process;
@property (nonatomic,strong)  RersistenceQuickLogin *quidklogin;
@property (nonatomic,strong) RersistenceDefaultLogin *defaultLogin;

@property(nonatomic,strong) UIButton *choose;
@property(nonatomic) Boolean agree;

@property(nonatomic) Boolean isRegister;

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
@property(nonatomic,strong)  RersistenceYMPhoneLogin *ymPhoneLogin;//注册
@property(nonatomic,strong) RersistenceYMPhoneRegisterView *ymPhoneView;//登录界面
@property(nonatomic) BOOL isPhoneRegister;//是否注册过



@property(nonatomic) Boolean SHOWPROCESS;





@end

static int isFirstLogin = YES;

@implementation RersistenceYMPhoneRegisterView


- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape view:(RersistenceQuickLogin*) view
{
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
        self.isRegister = NO;
        
        
        if(self.landscape){
            [self setLandScapeView];
            [self setupView];
            [self addNotification];
            
        }else{
            [self setPortraitView];

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
    
    //请输入手机号码
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(60, 110, 310, 38)];
    username.borderStyle = UITextBorderStyleNone;
    UIImage *edit_up_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    
    username.background = edit_up_image;
    username.placeholder = @"请输入手机号码";

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
    username.font = [UIFont systemFontOfSize:20];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    username.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_r.png"]];
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
    self.ymPhoneNum = username;
    
    
    //下一步按钮
    UIButton * ymloginButton=[[UIButton alloc]initWithFrame:CGRectMake(160, 170, 130, 38)];
    UIImage *ymLoginBackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_login_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:ymLoginBackImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [label setText:@"下一步"];
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
    [ymloginButton addTarget:self action:@selector(ym_phoneNextButton) forControlEvents:UIControlEventTouchUpInside];
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
    //请输入手机号码
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(15, 110, 230, 38)];
    username.borderStyle = UITextBorderStyleNone;
    UIImage *edit_up_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_register_edit_background.png"]];
    
    username.background = edit_up_image;
    username.placeholder = @"请输入手机号码";
    if(Rersistence_TEXTCOLOR_BLACK == YES){
        username.textColor = [UIColor blackColor];
        [username setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }else{
        username.textColor = [UIColor whiteColor];
        [username setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    username.font = [UIFont systemFontOfSize:16];
    
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.textAlignment = UITextAlignmentLeft;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyDone;
    username.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_logo_r.png"]];
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
    self.ymPhoneNum = username;
    //下一步按钮
    UIButton * ymloginButton=[[UIButton alloc]initWithFrame:CGRectMake(65, 180, 130, 38)];
    [ymloginButton setTitle:@"下一步" forState:UIControlStateNormal];
    ymloginButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [ymloginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ymloginButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    ymloginButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [ymloginButton setBackgroundImage:[UIImage imageNamed:@"Rersistence.bundle/Rersistence_login_button.png"] forState:UIControlStateNormal];
    [ymloginButton addTarget:self action:@selector(ym_phoneNextButton) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:ymloginButton];
}


//键盘自动上移====start
-(void)setupView{
    NSLog(@"调用setupView");
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ymPhoneView addGestureRecognizer:tapGesture];
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

//    //获取键盘高度
//    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardFrame.size.height;
//    [self.window makeKeyAndVisible];
//
//   // 输入框上移角度=屏幕高度-键盘高度-输入框底部高度
//    CGFloat X  = [[UIScreen mainScreen] bounds].size.height-height-330;

    //0, -keyboardHeight
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0,-55);
        NSLog(@"屏幕高度 == %f",[[UIScreen mainScreen] bounds].size.height);
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


//点击下一步判断是否已经注册过，已经注册过就弹出提示框，“返回登录页面直接登录”，未注册过就跳转到获取验证码并输入密码注册的界面

-(void)ym_phoneNextButton
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

    
    //判断手机号是否有效
    if(!(isMatch1 || isMatch2 || isMatch3)){
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"无效的手机号码,请重新输入..."];
        return;
    }
   
    //判断手机号是否已经注册过
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.isPhoneRegister = YES;
        self.logining = false;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSLog(@"register_dictionary:::===%@",dictionary);
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [dictionary objectForKey:@"ok"];
                if (ok != nil)
                {

                    [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"此号码未注册过，请注册登录"];
                    
                    
                         self.ymPhoneRegister = [[RersistenceYMPhoneRegister alloc]initWithBlock:^(NSString * username, NSString * password){
                                    RersistenceUserInfo *userinfo=[[RersistenceUserInfo alloc]initWithInfo:username password:password bind:@"1" tourist:@"0" loginTime:0 phoneNumber:@"1"];
                         self.loginInfo=userinfo;

                         [self startLogin];
                             
                             self.isRegister = YES;
                             
                         }landscape:self.landscape ymPhoneNumber:self.ymPhoneNum.text];
                                

                            [self.ymPhoneRegister show:self];
                    
                }
                
            }else if((NSNull *)value != nil){
                
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"此号码已经注册过，请输入密码直接登录"];
     
                if (self.ymPhoneLogin==nil) {
                    self.ymPhoneLogin=[[RersistenceYMPhoneLogin alloc]initWithBlock:self.success failed:self.failed landScape:self.landscape view:self.quidklogin ymPhoneNumber:self.ymPhoneNum.text];
                    
                }
                [self.ymPhoneLogin show:self];
                
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[RersistenceWebInterface sharedInstance] checkRersistencePhoneRegist:self.ymPhoneNum.text
                                 successCallbackRersistence:successCallback
                                     failCallbackRersistence:^(NSError * error) {
                                         if (self.process == nil) {
                                             self.process = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
                                         }
                                         
                                         [self.alertContainer addSubview:self.process];
                                         [self.alertContainer bringSubviewToFront:self.process];
                                         self.process.labelText = @"内部错误";
                                         [self.process showAnimated:YES whileExecutingBlock:^{
                                             
                                             [NSThread sleepForTimeInterval:1];
                                         } successCallback:^{
                                             [self.process removeFromSuperview];
                                         }];
                                         self.isPhoneRegister = YES;
                                     }
     ];
    
    self.isPhoneRegister = NO;
    
    self.logining = true;
    
    [self processRersistenceShow];


}



//重写textfield的getter方法
-(UITextField *)textField{
    if(!_ymPhoneNum){
        self.ymPhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(55,80, 210, 38)];
        _ymPhoneNum.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _ymPhoneNum;
}


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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.username)
    {
        [textField resignFirstResponder];
        
        NSString * username = self.username.text;
        if ([username length] == 0)
        {
            
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请输入正确的手机号"];
            
            return YES;
        }
        
        
        [self ym_phoneNextButton];
    }
    return YES;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}


- (void) startLogin
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    Rersistence_VSD_BLOCK getUserIdCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                self.login = NO;
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"网络不太好，请重试！！！" ];
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
                        [userInfo setValue:self.loginInfo.username forKey:@"username"];
                        
                        self.success(userInfo);
                        [[RersistenceWebInterface sharedInstance] RersistencesendHeart:userid];
                        
                        [[RersistenceSdkImp sharedInstance] addRersistenceUser:self.loginInfo.username passwordRersistence:self.loginInfo.password bindRersistence:@"1" touristRersistence:@"0" phoneNumberRersistence:@"1"];
                        
                        
                        
                        //                [self checkAccountIdentity:self.token];//检查有没有实名
                        [self dismissWithAnimation:YES];
                        
                        if (self.quidklogin!=nil) {
                            [self.quidklogin dismissWithAnimation:YES];
                        }else{
                            [self.defaultLogin dismissWithAnimation:YES];
                        }
                        self.login = NO;
                    }];
                    self.isRegister = NO;
                }else{//如果不是注册用户，则直接回调登录成功
                    NSString * userid = [dictionary valueForKey:@"id"];
                    
                    NSDictionary *userInfo = [NSMutableDictionary dictionary];
                    [userInfo setValue:self.token forKey:@"accesstoken"];
                    [userInfo setValue:userid forKey:@"userid"];
                    [userInfo setValue:self.loginInfo.username forKey:@"username"];
                    
                    self.success(userInfo);
                    [[RersistenceWebInterface sharedInstance] RersistencesendHeart:userid];
                    
                    
                    [[RersistenceSdkImp sharedInstance] addRersistenceUser:self.loginInfo.username passwordRersistence:self.loginInfo.password bindRersistence:@"1" touristRersistence:@"0" phoneNumberRersistence:@"1"];
                    
                    
                    
                    //                [self checkAccountIdentity:self.token];//检查有没有实名
                    [self dismissWithAnimation:YES];
                    
                    if (self.quidklogin!=nil) {
                        [self.quidklogin dismissWithAnimation:YES];
                    }else{
                        [self.defaultLogin dismissWithAnimation:YES];
                    }
                    self.login = NO;
                }
                
            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
        
            }
            self.login = NO;
        }@catch(NSException * e)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误" ];
            self.login = NO;
        }
        @finally
        {
            self.login = NO;
        }
    };
    
    
    
    Rersistence_VSD_BLOCK getTokenCompletionBlock = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{
            if (dictionary == nil)
            {
                self.login = NO;
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"网络不太好，请重试！！！" ];
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
                                                  self.login = NO;
                                                  self.failed(-104);
                                                  [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
                                              }];
            }
            else
            {
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance] translateRersistence:[dictionary valueForKey:@"error"]]];
                self.login = NO;
                
            }
        }@catch(NSException * e)
        {
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"内部错误" ];
            self.login = NO;
            
        }
        @finally
        {
        }
    };
    
    
    
    
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        // self.login = NO;
        @try
        {
            if (dictionary == nil)
            {
                self.login = NO;
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"网络不太好，请重试！！！" ];
                return;
            }

            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                
                _process.labelText = @"正在验证";
                [[RersistenceWebInterface sharedInstance] getRersistenceAccessTokenRersistence:[dictionary valueForKey:@"code"]
                                               successCallbackRersistence:getTokenCompletionBlock
                                                   failCallbackRersistence:^(NSError *error){
                                                       self.login = NO;
                                                       self.failed(-105);
                                                       [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
                                                   }];
                
                
            }else
            {
                
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:[[RersistenceSdkImp sharedInstance]translateRersistence:[dictionary valueForKey:@"error"]] ];
                self.login = NO;
            }
        }
        @catch(NSException * e)
        {

            [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"内部错误"];
            self.login = NO;
            
        }
        @finally
        {
            //self.login = NO;
        }
    };
    
    
        [[RersistenceWebInterface sharedInstance] phoneRersistenceLogin:self.ymPhoneNum.text
                                          passwordRersistence:self.loginInfo.password
                                   successCallbackRersistence:successCallback failCallbackRersistence:^(NSError * error) {
            self.login = NO;
            self.failed(-106);
            [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"请检查网络连接！"];
        }];


    self.login = YES;
    
    
    [self processRersistenceShowLogin];
}

-(void)processRersistenceShowLogin {
    if (self.process == nil) {
        self.process = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
        
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
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } successCallback:^{
        [_process removeFromSuperview];
    }];

}

-(void)checkAccountIdentity:(NSString *)access_token{
    [[RersistenceWebInterface sharedInstance] checkRersistenceIdentify:access_token successCallbackRersistence:^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                [self dismissWithAnimation:YES];
                
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

                        [self dismissWithAnimation:YES];
                        
                        if (self.quidklogin!=nil) {
                            [self.quidklogin dismissWithAnimation:YES];
                        }else{
                            [self.defaultLogin dismissWithAnimation:YES];
                        }
                    } landscape:self.landscape];
                    [self.sjValidateIdentity show:self];
                    
                }else
                {

                    [self dismissWithAnimation:YES];
                    
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
    } failCallbackRersistence:^(NSError *code) {
        [self dismissWithAnimation:YES];
        [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"获取身份证认证信息失败" ];
    }];
}





-(void)processRersistenceShow {
    if (self.process == nil) {
        self.process = [[RersistenceProgressHUD alloc] initWithView:self.alertContainer];
        
    }
    [self.alertContainer addSubview:_process];
    _process.labelText = @"号码验证中";
    
    [_process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.logining)
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


-(void)login_backButton{
    [super dismissWithAnimation:YES];
}

//登录关闭按钮
-(void)ym_loginCloseButton{
    [super dismissWithAnimation:YES];
}

@end
