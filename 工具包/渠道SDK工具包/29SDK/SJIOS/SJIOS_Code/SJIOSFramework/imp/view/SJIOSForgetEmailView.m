

#import "SJIOSForgetEmailView.h"
#import "UIColor+SJIOSSdk.h"
#import "UIImage+SJIOSSdk.h"

#import "SJIOSCommonApi.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSSdkImp.h"

#import "SJIOSSdkMd5.h"
#import "SJIOSForgetView.h"



@interface SJIOSForgetEmailView()

@property(nonatomic, strong) UITextField* username;
@property(nonatomic, strong) UITextField* password;
@property(nonatomic, strong) UITextField* verify;
@property(nonatomic, strong) UIButton* getVerify;
@property(nonatomic, strong) NSTimer * buttonTimer;

@property(nonatomic, strong)UIView *littleContainer;

@property(nonatomic) int cooldown;

@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL reseting;

@property(nonatomic,strong) SJIOSForgetView *forgetPhoneView;//手机找回密码界面
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *qq;

@end

@implementation SJIOSForgetEmailView

- (id)initWithLandscape:(Boolean)landscape
                  phone:(NSString*)phone
                     qq:(NSString*)qq
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
            self.phone = phone;
            self.qq = qq;
            NSLog(@"phone==%@::qq==%@",self.phone,self.qq);
            [self setLandScapeView];
            
            
            
        }else{
            self.phone = phone;
            self.qq = qq;
            NSLog(@"phone==%@::qq==%@",self.phone,self.qq);
            [self setPortraitView];
        }
 
        
    }
    return self;
}


//横屏状态下的默认登录界面
-(void)setLandScapeView{
    
    //    self.alertContainer.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    //    self.alertContainer.layer.borderWidth = 2;
    
    self.alertContainer.backgroundColor = [UIColor whiteColor];
    
    self.alertContainer.userInteractionEnabled = YES;
    UITapGestureRecognizer *resignTaper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    [self.alertContainer addGestureRecognizer:resignTaper];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_shensuForgetBack) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    //忘记密码一栏，绑定手机找回界面
    UIButton *bindPhoneFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(85, 15, 120, 38)];
    UIImage *bindPhonebackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]] ;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [imageView setImage:bindPhonebackImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [label setText:@"绑定手机找回"];
    [label sizeToFit];
    label.center = CGPointMake(bindPhoneFindPasswordButton.bounds.size.width/2, bindPhoneFindPasswordButton.bounds.size.height/2);
    [bindPhoneFindPasswordButton addSubview:imageView];
    [bindPhoneFindPasswordButton addSubview:label];
    [bindPhoneFindPasswordButton addTarget:self action:@selector(ym_bindPhoneForgetClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.alertContainer addSubview:bindPhoneFindPasswordButton];
    
    //申诉找回密码按钮
    UIButton *shensuFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(230, 15, 120, 38)];
    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    [shensuFindPasswordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shensuFindPasswordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    shensuFindPasswordButton.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    shensuFindPasswordButton.layer.borderWidth = 1;
    
    [self.alertContainer addSubview:shensuFindPasswordButton];
    
    
    //客服公告栏
    UITextView * shensuView = [[UITextView alloc]initWithFrame:CGRectMake(65, 60, 330, 140)];
    shensuView.backgroundColor = [UIColor grayColor];
    shensuView.text = @"      亲爱的用户，若您的帐号未绑定手机，请通过以下方式联系我们的客服进行帐号找回。";
    shensuView.textColor = [UIColor whiteColor];
    shensuView.font = [UIFont systemFontOfSize:15.f];
    shensuView.textAlignment = NSTextAlignmentLeft;
    shensuView.editable = NO;
    shensuView.selectable = NO;
    shensuView.allowsEditingTextAttributes = NO;
    [self.alertContainer addSubview:shensuView];
    
    UILabel *servicePhone = [[UILabel alloc]initWithFrame:CGRectMake(50, 60, 60, 30)];
    [servicePhone setFont:[UIFont systemFontOfSize:15]];
    [servicePhone setText:@"客服热线:"];
    [servicePhone sizeToFit];
    servicePhone.textColor = [UIColor whiteColor];
    [shensuView addSubview:servicePhone];
    
    UILabel *qqContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 50, 30)];
    [qqContentLabel setText:self.phone];
    qqContentLabel.textColor = [UIColor whiteColor];
    [qqContentLabel sizeToFit];
    [qqContentLabel setFont:[UIFont systemFontOfSize:15]];
    [shensuView addSubview:qqContentLabel];
    
    UILabel *serviceQQ = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 50, 30)];
    [serviceQQ setText:@"客服QQ:"];
    [serviceQQ setFont:[UIFont systemFontOfSize:15]];
    [serviceQQ sizeToFit];
    serviceQQ.textColor = [UIColor whiteColor];
    [shensuView addSubview:serviceQQ];
    
    UILabel *serviceQQValue = [[UILabel alloc]initWithFrame:CGRectMake(110, 100, 50, 30)];
    [serviceQQValue setFont:[UIFont systemFontOfSize:15]];
    [serviceQQValue setText:self.qq];
    [serviceQQValue sizeToFit];
    serviceQQValue.textColor = [UIColor whiteColor];
    [shensuView addSubview:serviceQQValue];
    
    
    
    //确定
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 210, 120, 38)];
    UIImage *surebackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_login_button.png"]] ;
    //    [shensuFindPasswordButton setImage:shengsubackImage forState:UIControlStateNormal];
    //    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    UIImageView *sureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [sureImageView setImage:surebackImage];
    UILabel *sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 38)];
    [sureLabel setText:@"确定"];
    [sureLabel sizeToFit];
    sureLabel.center = CGPointMake(sureButton.bounds.size.width/2, sureButton.bounds.size.height/2);
    [sureButton addSubview:sureImageView];
    [sureButton addSubview:sureLabel];
    [sureButton addTarget:self action:@selector(ym_shensuSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:sureButton];
    
}

//竖屏状态下的默认登录界面
-(void)setPortraitView{
    
    //    self.alertContainer.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    //    self.alertContainer.layer.borderWidth = 2;
    
    self.alertContainer.backgroundColor = [UIColor whiteColor];
    
    self.alertContainer.userInteractionEnabled = YES;
    UITapGestureRecognizer *resignTaper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resign)];
    [self.alertContainer addGestureRecognizer:resignTaper];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_back.png"]] ;
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alertContainer addSubview:backButton];
    [backButton addTarget:self action:@selector(ym_shensuForgetBack) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码一栏，绑定手机找回界面
    UIButton *bindPhoneFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 30, 100, 38)];
    [bindPhoneFindPasswordButton setTitle:@"绑定手机找回" forState:UIControlStateNormal];
    bindPhoneFindPasswordButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [bindPhoneFindPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindPhoneFindPasswordButton setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_login_button.png"] forState:UIControlStateNormal];
    [bindPhoneFindPasswordButton addTarget:self action:@selector(ym_bindPhoneForgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:bindPhoneFindPasswordButton];
    
    //申诉找回密码按钮
    UIButton *shensuFindPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 30, 100, 38)];
    [shensuFindPasswordButton setTitle:@"客服申诉找回" forState:UIControlStateNormal];
    shensuFindPasswordButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [shensuFindPasswordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shensuFindPasswordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    shensuFindPasswordButton.layer.borderColor = [UIColor colorWithRed:0 green:0.44 blue:0.93 alpha:1.0].CGColor;
    shensuFindPasswordButton.layer.borderWidth = 1;
    [self.alertContainer addSubview:shensuFindPasswordButton];
    
    
    //客服公告栏
    UITextView * shensuView = [[UITextView alloc]initWithFrame:CGRectMake(15, 70, 230, 125)];
    shensuView.backgroundColor = [UIColor grayColor];
    shensuView.text = @"      亲爱的用户，若您的帐号未绑定手机，请通过以下方式联系我们的客服进行帐号找回。";
    shensuView.textColor = [UIColor whiteColor];
    shensuView.font = [UIFont systemFontOfSize:15.f];
    shensuView.textAlignment = NSTextAlignmentLeft;
    shensuView.editable = NO;
    shensuView.selectable = NO;
    shensuView.allowsEditingTextAttributes = NO;
    [self.alertContainer addSubview:shensuView];
    
    UILabel *servicePhone = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, 60, 30)];
    [servicePhone setFont:[UIFont systemFontOfSize:15]];
    [servicePhone setText:@"客服热线:"];
    [servicePhone sizeToFit];
    servicePhone.textColor = [UIColor whiteColor];
    [shensuView addSubview:servicePhone];
    
    UILabel *qqContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 50, 30)];
    [qqContentLabel setText:self.phone];
    qqContentLabel.textColor = [UIColor whiteColor];
    [qqContentLabel sizeToFit];
    [qqContentLabel setFont:[UIFont systemFontOfSize:15]];
    [shensuView addSubview:qqContentLabel];
    
    UILabel *serviceQQ = [[UILabel alloc]initWithFrame:CGRectMake(30, 90, 50, 30)];
    [serviceQQ setText:@"客服QQ:"];
    [serviceQQ setFont:[UIFont systemFontOfSize:15]];
    [serviceQQ sizeToFit];
    serviceQQ.textColor = [UIColor whiteColor];
    [shensuView addSubview:serviceQQ];
    
    UILabel *serviceQQValue = [[UILabel alloc]initWithFrame:CGRectMake(90, 90, 50, 30)];
    [serviceQQValue setFont:[UIFont systemFontOfSize:15]];
    [serviceQQValue setText:self.qq];
    [serviceQQValue sizeToFit];
    serviceQQValue.textColor = [UIColor whiteColor];
    [shensuView addSubview:serviceQQValue];
    
    
    //确定按钮
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(65, 205, 130, 38)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"SJIOS.bundle/SJIOS_login_button.png"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(ym_shensuSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:sureButton];
    

}


//手机找回密码返回按钮
-(void)ym_shensuForgetBack {
    [self dismissWithAnimation:YES];
}

//手机找回密码关闭按钮
-(void)ym_shensuForgetClose{
    [super dismissWithAnimation:YES];
}

//跳转到绑定手机找回密码界面
-(void)ym_bindPhoneForgetClick
{

    if (self.forgetPhoneView == nil) {
        self.forgetPhoneView = [[SJIOSForgetView alloc] initWithLandscape:self.landscape];
        [self.forgetPhoneView show:self.parent];
    }
    
    [super dismissWithAnimation:YES];
    
}





//申诉关闭按钮
-(void)ym_shensuSureButtonClick{
    [super dismissWithAnimation:YES];
}


-(void)back {
    [self dismissWithAnimation:YES];
}

-(void)resign{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)verifyPressed:(UIButton*)sender
{
    if(self.buttonTimer != nil)
    {
        return;
    }
    NSString* username = self.username.text;
    if (username.length == 0)
    {

        SJIOSProgressHUD *myProcess = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = SJIOSProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"账户或手机号为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
                 [NSThread sleepForTimeInterval:1];
        } completionBlock:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    //self.getVerify.enabled = NO;
    self.cooldown = 60;
    
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
                
                SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                process.labelText = @"请到邮箱查看";
                process.mode = SJIOSProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } completionBlock:^{
                    [process removeFromSuperview];
                }];
            }
            else
            {
                self.getVerify.enabled = YES;
                
                SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                process.labelText = [[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]];
                process.mode = SJIOSProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } completionBlock:^{
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
    
    [[SJIOSCommonApi sharedInstance] changeSJIOSPasswordByEmail:username
                     completionBlock:completionBlock
                         failedBlock:^(NSError * error) {
                            
                            self.verifing = NO;
                             
                         }
     ];
    
    self.verifing = YES;
    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
    [self.alertContainer addSubview:process];
    //process.dimBackground = YES;
    process.labelText = @"获取验证码";
    [process showAnimated:YES whileExecutingBlock:^{
        while (self.verifing)
        {
            usleep(50000);
        }
    } completionBlock:^{
        [process removeFromSuperview];
    }];
}


- (void)normalPressed:(UIButton*)sender
{
    [self.username resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
    NSString* username = self.username.text;
    if (username.length == 0)
    {
        SJIOSProgressHUD *myProcess = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = SJIOSProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"账户或手机号为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } completionBlock:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    NSString* password = self.password.text;
    if (password.length == 0)
    {
        SJIOSProgressHUD *myProcess = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = SJIOSProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"密码为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } completionBlock:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    NSString* verify = self.verify.text;
    if (verify.length == 0)
    {
        SJIOSProgressHUD *myProcess = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
        
        [self.alertContainer addSubview:myProcess];
        //process.dimBackground = YES;
        myProcess.mode = SJIOSProgressHUDModeCustomView;
        myProcess.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        myProcess.labelText = @"验证码为空";
        [myProcess showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } completionBlock:^{
            [myProcess removeFromSuperview];
        }];
        return;
    }
    
    SJIOS_VSD_BLOCK completionBlock = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
                SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                process.labelText = @"密码重设成功";
                process.mode = SJIOSProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } completionBlock:^{
                    [process removeFromSuperview];
                    [self dismissWithAnimation:YES];
                }];
            }
            else
            {
                SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:process];
                //process.dimBackground = YES;
                process.labelText = [[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]];
                process.mode = SJIOSProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
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
    
    [[SJIOSCommonApi sharedInstance] confirmSJIOSChangePasswordByEmail:username
                                   password:[SJIOSSdkMd5 md5:password]
                                     verify:verify
                            completionBlock:completionBlock
                                failedBlock:^(NSError * error) {
                                    
                                        self.reseting = NO;

                                 }
     ];
    
    self.reseting = YES;
    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
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
                SJIOSProgressHUD *errorHud = [[SJIOSProgressHUD alloc] initWithView:self.alertContainer];
                [self.alertContainer addSubview:errorHud];
                errorHud.labelText = @"网络不太好，请重试！！！";
                errorHud.mode = SJIOSProgressHUDModeCustomView;
                errorHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [errorHud showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:1];
                } completionBlock:^{
                    [errorHud removeFromSuperview];
                }];
                
                break;
            }
        }

    } completionBlock:^{
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
    if (textField == self.username)
    {
        [self.password becomeFirstResponder];
    }
    else if (textField == self.password)
    {
        [self.verify becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}



@end
