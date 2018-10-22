

#import "SJIOSYMBindPhoneView.h"
#import "UIColor+SJIOSSdk.h"
#import "UIImage+SJIOSSdk.h"
#import "SJIOSCommonApi.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSSdkImp.h"
#import "SJIOSForgetEmailView.h"


@interface SJIOSYMBindPhoneView()

@property(nonatomic, strong) UITextField* username;
@property(nonatomic, strong) UITextField* password;
@property(nonatomic, strong) UITextField* verify;
@property(nonatomic, strong) UIButton* getVerify;
@property(nonatomic, strong) NSTimer * buttonTimer;

@property(nonatomic, strong)UIView *littleContainer;

@property(nonatomic) int cooldown;

@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL reseting;
@property (nonatomic,strong) SJIOSQuickLogin *quidklogin;
@property (nonatomic,strong) SJIOSDefaultLogin *defaultLogin;
@property(nonatomic,strong) SJIOSYMBindPhoneView *ymBindPhoneView;//忘记密码找回界面
@property(nonatomic, strong) UILabel * getVeryCode;//获取验证码文字
@property(nonatomic)BOOL textIsphoneNumber;//输入的是否是手机号
@property(nonatomic) BOOL binding;//是否绑定
@property (strong, nonatomic) SJIOSProgressHUD *process;

@end

@implementation SJIOSYMBindPhoneView

- (id)initWithLandscape:(Boolean)landscape
{
    //横屏
    self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
    
    //竖屏
    //self = [super initWithSize:CGSizeMake(260, 260) landScape:landcape ];
    
    
    if (self) {
        
        
        if(self.landscape){
            [self setLandScapeView];
            [self setupView];
            [self addNotification];
            self.textIsphoneNumber = NO;
            
        }else{
//            [self setPortraitView];
        }

        
        
    }
    return self;
}



//横屏状态下的默认登录界面
-(void)setLandScapeView{
    
    self.alertContainer.backgroundColor = [UIColor whiteColor];
    
    
    self.alertContainer.userInteractionEnabled = YES;
    UITapGestureRecognizer *resignTaper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    [self.alertContainer addGestureRecognizer:resignTaper];
    

    
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame = CGRectMake(150, 20, 166, 68);
    [self.alertContainer addSubview:logoView];
    
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(410, 10, 30, 25)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_ym_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_phoneForgetClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(70, 60, 310, 38)];
    label.contentMode = UIViewContentModeBottomRight;
    label.font = [UIFont fontWithName:@"Arial" size:14];
    label.textColor = [UIColor redColor];
    label.text = @"请绑定手机号";
    [self.alertContainer addSubview:label];
    
    
    UITextField *accountField = [[UITextField alloc]initWithFrame:CGRectMake(70, 88, 310, 38)];
    accountField.borderStyle = UITextBorderStyleNone;
    accountField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    accountField.placeholder = @" 请输入手机号码";
    [accountField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    accountField.font = [UIFont systemFontOfSize:15];
    accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    accountField.textAlignment = UITextAlignmentLeft;
    accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    accountField.returnKeyType = UIReturnKeyNext;
    accountField.delegate=self;
    self.username=accountField;
    [self.alertContainer addSubview:self.username];
    
    
    UITextField * verifyField = [[UITextField alloc] initWithFrame:CGRectMake(70, 138, 210, 38)];
    verifyField.borderStyle = UITextBorderStyleNone;
    verifyField.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_register_edit_background.png"]];
    verifyField.placeholder = @" 请输入验证码";
    [verifyField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    verifyField.font = [UIFont systemFontOfSize:15];
    verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //    verifyField.textAlignment = UITextAlignmentLeft;
    verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    verifyField.returnKeyType = UIReturnKeyDone;
    verifyField.delegate=self;
    
    self.verify=verifyField;
    [self.alertContainer addSubview:self.verify];
    
    //获取验证码按钮
    UIButton *verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(282, 138, 100, 38)];
    UIImage *verifybackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]] ;
    //    [shensuFindPasswordButton setImage:shengsubackImage forState:UIControlStateNormal];
    //    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 38)];
    [verifyImageView setImage:verifybackImage];
    UILabel *verifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
    self.getVeryCode = verifyLabel;
    [self.getVeryCode setText:@"获取验证码"];
    [self.getVeryCode sizeToFit];
    self.getVeryCode.center = CGPointMake(verifyButton.bounds.size.width/2, verifyButton.bounds.size.height/2);
    [verifyButton addSubview:verifyImageView];
    [verifyButton addSubview:verifyLabel];
    [verifyButton addTarget:self action:@selector(verifyPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.alertContainer addSubview:verifyButton];
    self.getVerify = verifyButton;
    
    
    //确定按钮
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 188, 130, 38)];
    UIImage *surebackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]] ;
    UIImageView *sureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 130, 38)];
    [sureImageView setImage:surebackImage];
    UILabel *sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 130, 38)];
    [sureLabel setText:@"绑定"];
    [sureLabel sizeToFit];
    sureLabel.center = CGPointMake(sureButton.bounds.size.width/2, sureButton.bounds.size.height/2);
    [sureButton addSubview:sureImageView];
    [sureButton addSubview:sureLabel];
    [sureButton addTarget:self action:@selector(normalPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:sureButton];
    
    
}



-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self.ymBindPhoneView action:@selector(onBackClicked:)];
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
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -120);
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



//跳转到客服申诉界面
-(void)ym_shensuForgetClick
{
    SJIOSForgetEmailView *forgetView = [[SJIOSForgetEmailView alloc]initWithLandscape:self.landscape];
    [forgetView show:self.parent];
    [super dismissWithAnimation:YES];
}

-(void)resign{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
}

//获取验证码
- (void)verifyPressed
{
    if (self.buttonTimer != nil) {
        return;
    }
    
    
    NSString* phone = self.username.text;
    
    
    
    if (phone.length == 0)
    {
        
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请输入手机号"];
        return;
    }
    

    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";

    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";

    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:phone];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:phone];
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:phone];
    
    
    if(!(isMatch1 || isMatch2 || isMatch3)){
        self.textIsphoneNumber = NO;
         [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"无效的手机号码,请重新输入..."];

        return;
    }else{
        
        self.textIsphoneNumber = YES;

    }
    
    
    self.getVerify.enabled = NO;
    self.cooldown = 60;
    [self.getVeryCode setText:@""];
    
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.verifing = NO;
        self.getVerify.enabled = YES;
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
                
                self.process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:self.process];
                [self.alertContainer bringSubviewToFront:self.process];
                self.process.labelText = @"获取验证码成功";
                self.process.mode = SJIOSProgressHUDModeCustomView;
                self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:1];
                } completionBlock:^{
                    [self.process removeFromSuperview];
                }];

            }
            else
            {
                
               self.process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:self.process];
                [self.alertContainer bringSubviewToFront:self.process];
                [self.getVerify setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.process.labelText = [[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]];
                self.process.mode = SJIOSProgressHUDModeCustomView;
                self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:3];
                } completionBlock:^{
                    [self.process removeFromSuperview];
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
    
    
    if(self.textIsphoneNumber){
        
        [[SJIOSCommonApi sharedInstance] bindSJIOSPhone:self.accessToken
                                            phone:phone
                                  completionBlock:completionBlock
                                      failedBlock:^(NSError *error) {
                                          self.verifing = NO;
                                          
                                      }
         ];
        
    }
    
    self.verifing = YES;
    
    [NSThread  detachNewThreadSelector:@selector(getVerifyDespatch) toTarget:self withObject:nil];
}


-(void)getVerifyDespatch {
    
    self.process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
    [self.alertContainer addSubview:self.process];
    [self.alertContainer bringSubviewToFront:self.process];
    self.process.labelText = @"获取验证码";
    
    [self.process showAnimated:YES whileExecutingBlock:^{
        while (self.verifing)
        {
            usleep(50000);
        }
    } completionBlock:^{
        [self.process removeFromSuperview];
    }];
}

//检查身份验证
-(void)checkAccountIdentity:(NSString *)access_token{
    
    [[SJIOSCommonApi sharedInstance] checkSJIOSIdentify:access_token completionBlock:^(NSDictionary *dictionary, NSDictionary *headers) {
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
                    } landscape:self.landscape];
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
    } failedBlock:^(NSError *code) {
        [self dismissWithAnimation:YES];
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"获取身份证认证信息失败" ];
    }];
}


- (void)normalPressed
{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    
    NSString* username = self.username.text;
    
    //正则表达式匹配11位手机号码
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:_username.text];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:_username.text];
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:_username.text];
    
    //有效的手机号
    if(!(isMatch1 || isMatch2 || isMatch3)){

        self.textIsphoneNumber = NO;
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"无效的手机号码,请重新输入..."];

        return;
    }else{
        
        self.textIsphoneNumber = YES;

    }
    
    
    if (username.length == 0)
    {
        
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"手机号或者密码为空"];
        return;
    }
    

    NSString* verify = self.verify.text;

    if (verify.length == 0)
    {
        [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"请输入验证码"];
        return;

    }
    
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.binding = NO;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                
                NSString *ok = [dictionary objectForKey:@"ok"];
                if (ok != nil)
                {
                    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                    [self.alertContainer addSubview:process];
                    [self.alertContainer bringSubviewToFront:process];
                    
                    process.labelText = @"绑定成功";
                    process.mode = SJIOSProgressHUDModeCustomView;
                    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                    [process showAnimated:YES whileExecutingBlock:^{
                        sleep(2);
                    } completionBlock:^{
                        [process removeFromSuperview];
                    }];
                    
                    
//                    [self checkAccountIdentity:self.accessToken];//检查有没有实名
                    
                    [self dismissWithAnimation:YES];
                    
                    if (self.quidklogin!=nil) {
                        
                         [self.quidklogin dismissWithAnimation:YES];
                        
                        }else{
                          [self.defaultLogin dismissWithAnimation:YES];
                            
                        }
  
                }
                else
                {
                    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                    [self.alertContainer addSubview:process];
                    [self.alertContainer bringSubviewToFront:process];
                    process.labelText = @"验证码错误";
                    [process showAnimated:YES whileExecutingBlock:^{
                        
                        [NSThread sleepForTimeInterval:1];
                    } completionBlock:^{
                        [process removeFromSuperview];
                    }];
                    
                }
            }
            else
            {
                SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                [self.alertContainer bringSubviewToFront:process];

                process.labelText = [[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]];
                [process showAnimated:YES whileExecutingBlock:^{
                    
                    [NSThread sleepForTimeInterval:1];
                } completionBlock:^{
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
    
    [[SJIOSCommonApi sharedInstance] confirmSJIOSPhone:self.accessToken
                                          verify:verify
                                 completionBlock:completionBlock
                                     failedBlock:^(NSError * error) {
                                    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];

                                         [self.alertContainer addSubview:process];
                                         [self.alertContainer bringSubviewToFront:process];
                                         process.labelText = @"内部错误";
                                         [process showAnimated:YES whileExecutingBlock:^{
                                             
                                             [NSThread sleepForTimeInterval:1];
                                         } completionBlock:^{
                                             [process removeFromSuperview];
                                         }];
                                         self.binding = NO;
                                     }
     ];
    
    self.binding = YES;
    
    [NSThread  detachNewThreadSelector:@selector(bindDespatch) toTarget:self withObject:nil];
}

-(void)bindDespatch {
    
    self.process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
    [self.alertContainer addSubview:self.process];
    [self.alertContainer bringSubviewToFront:self.process];
    self.process.labelText = @"验证中";
    [self.process showAnimated:YES whileExecutingBlock:^{
        while (self.binding)
        {
            usleep(50000);
        }
    } completionBlock:^{
        [self.process removeFromSuperview];
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
        
       [textField resignFirstResponder];
        
        NSString * username = self.username.text;
        
        if ([username length] == 0)
        {
            
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"手机号为空"];
            
            return YES;
        }
        
        NSString * verify = self.verify.text;
        
        if ([verify length] == 0)
        {
            
            [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"验证码为空"];
            
            return YES;
        }
        
        
        [self normalPressed];
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
}


@end
