

#import "SJIOSBindPhoneViewController.h"
#import "UIImage+SJIOSSdk.h"

#import "SJIOSSdkCommonDefine.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSSdkImp.h"
#import "SJIOSWebInterface.h"
#import  "SJIOSSdkImp.h"
@interface SJIOSBindPhoneViewController ()


@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITextField *phoneNumberField;
@property (nonatomic, strong) UITextField *verifyField;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic)int cooldown;
@property(nonatomic, strong) NSTimer * buttonTimer;
@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL binding;
@property (strong, nonatomic) SJIOSProgressHUD *process;
@property(nonatomic)BOOL textIsphoneNumber;//输入的是否是手机号

@end

@implementation SJIOSBindPhoneViewController

-(void)initNavigation {
    UIImage *backNormalImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_back.png"]];
    UIImage *backHighImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_back_cl.png"]];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:backNormalImage forState:UIControlStateNormal];
    [backButton setImage:backHighImage forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    CGSize screenSize = [[UIScreen mainScreen]bounds].size;
    
    [self addNotification];
    if (ios8) {
        
    }else{
         if (self.landscape == true) {
        screenSize = CGSizeMake(screenSize.height, screenSize.width);
    }
    }
   
      [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:130.0/255.0 blue:180.0/255.0 alpha:1.0] ];
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y + 20, screenSize.width, 30)];
    containerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *grayImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, screenSize.width, 2)];
    grayImageView.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [containerView addSubview:grayImageView];
    
    
    UIImageView *serviceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 76, 17)];
    serviceImageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_icon_meun_bangding.png"]];
    
    UIImageView *blueBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, serviceImageView.frame.size.width + serviceImageView.frame.origin.x, 2)];
    blueBar.backgroundColor = [UIColor colorWithRed:0.0 green:0.576 blue:1.0 alpha:1];
    [containerView addSubview:blueBar];
    
    [containerView addSubview:serviceImageView];
    [self.view addSubview:containerView];
    
    self.container = containerView;
}



-(void)verifyPressed:(id)sender {
    
    
    if (self.buttonTimer != nil) {
        return;
    }
    

    NSString* phone = self.phoneNumberField.text;
    
    
    
    if (phone.length != 11)
    {
        self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.process];
        [self.view bringSubviewToFront:self.process];
        self.process.labelText = @"请输入正确的手机号";
        self.process.mode = SJIOSProgressHUDModeCustomView;
        self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        [self.process showAnimated:YES whileExecutingBlock:^{
             [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [self.process removeFromSuperview];
        }];
        return;
    }
    

    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}|(1705)\\d{7}$";

    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(166)|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";

    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9])|(199))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:phone];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:phone];
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:phone];
    
  
    if(isMatch1 || isMatch2 || isMatch3){
        
        self.textIsphoneNumber = YES;
        
    }
    
    
    self.verifyButton.enabled = NO;
    self.cooldown = 60;
    
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.verifing = NO;
        self.verifyButton.enabled = YES;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                [self.verifyButton setTitle:@"60秒" forState:UIControlStateNormal];
                NSTimer * buttonTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                         target:self
                                                                       selector:@selector(timerFired:)
                                                                       userInfo:nil
                                                                        repeats:YES];
                
                self.buttonTimer = buttonTimer;
                
                self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                self.process.labelText = @"获取验证码成功";
                self.process.mode = SJIOSProgressHUDModeCustomView;
                self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [self.process removeFromSuperview];
                }];

            }
            else
            {
                self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.process.labelText = [[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]];
                self.process.mode = SJIOSProgressHUDModeCustomView;
                self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
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
        
    
        [[SJIOSWebInterface sharedInstance] bindSJIOSPhone:self.accessToken
                       phoneSJIOS:phone
             successCallbackSJIOS:successCallback
                 failCallbackSJIOS:^(NSError *error) {
                     self.verifing = NO;
                     
                 }
         ];
        
        }
    
    self.verifing = YES;
    
    [NSThread  detachNewThreadSelector:@selector(getVerifyDespatch) toTarget:self withObject:nil];

}

-(id)initWithLandscape:(Boolean)landscape
{
    self = [super init];
    if (self) {
        self.landscape = landscape;
    }
    return self;
}

-(void)getVerifyDespatch {
    self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.process];
    [self.view bringSubviewToFront:self.process];
    self.process.labelText = @"获取验证码";
    
    [self.process showAnimated:YES whileExecutingBlock:^{
        while (self.verifing)
        {
            usleep(50000);
        }
    } successCallback:^{
        [self.process removeFromSuperview];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField==self.phoneNumberField) {
        [self.verifyField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)timerFired:(NSTimer*)sender
{
    --self.cooldown;
    if (self.cooldown <= 0)
    {
        [self.buttonTimer invalidate];
        self.buttonTimer = nil;
        
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        NSString * title = [[NSString alloc] initWithFormat:@"%d秒", self.cooldown];
        [self.verifyButton setTitle:title forState:UIControlStateNormal];
    }
}

-(void)back {
    if (self.buttonTimer != nil) {
        [self.buttonTimer invalidate];
        self.buttonTimer = nil;
    }
    
    [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigation];
    [self addSubview];
}


-(void)addSubview {
    CGRect mainScreen = [[UIScreen mainScreen]bounds];
    if (ios8) {
     
    }else{
         if (self.landscape == true) {
        mainScreen = CGRectMake(mainScreen.origin.x, mainScreen.origin.y, mainScreen.size.height, mainScreen.size.width);
    }
    }
   
    
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(10, self.container.frame.origin.y + self.container.frame.size.height + 30, mainScreen.size.width - 20, 300)];
    
    subView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:subView];
    
    UIView *backContainer = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, subView.frame.size.width, 80)];
    backContainer.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9176 alpha:1.0];
    
    [subView addSubview:backContainer];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, subView.frame.size.width, 2)];
    line1.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, line1.frame.origin.y + 40, subView.frame.size.width, 2)];
    line2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:line2];
    
    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y + 40, subView.frame.size.width, 2)];
    line3.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:line3];

    
    UIImageView *verticalLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2, 80)];
    verticalLine1.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine1];
    
    UIImageView *verticalLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 2, 80)];
    verticalLine2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine2];
    
    UIImageView *verticalLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(subView.frame.size.width - 2, 0, 2, 80)];
    verticalLine3.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine3];
    
    UILabel *phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 68, 38)];
    phoneNumberLabel.contentMode = UIViewContentModeBottomRight;
    phoneNumberLabel.font = [UIFont systemFontOfSize:12];
    [phoneNumberLabel setText:@"手机号码"];
    phoneNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    [backContainer addSubview:phoneNumberLabel];
    
    UILabel *conformLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, line2.frame.origin.y + line2.frame.size.height, 68, 38)];
    conformLabel.contentMode = UIViewContentModeCenter;
    conformLabel.font = [UIFont systemFontOfSize:12];
    [conformLabel setText:@"验证码"];
    conformLabel.textAlignment = NSTextAlignmentCenter;
    [backContainer addSubview:conformLabel];
    
    self.phoneNumberField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line1.frame.origin.y + line1.frame.size.height, 156, 38)];
    self.phoneNumberField.font = [UIFont systemFontOfSize:13];
    self.phoneNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneNumberField.textAlignment = NSTextAlignmentLeft;
    self.phoneNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumberField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.phoneNumberField.returnKeyType = UIReturnKeyNext;
    self.phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;//输入数字键盘
    self.phoneNumberField.placeholder = @"请输入手机号码";
    self.phoneNumberField.delegate=self;
    
    [backContainer addSubview:self.phoneNumberField];
    
    self.verifyButton = [[UIButton alloc]initWithFrame:CGRectMake(subView.frame.size.width - 63, self.phoneNumberField.frame.origin.y + 5, 60, 28)];
    

    [self.verifyButton setTitle:@"验证码" forState:UIControlStateNormal];
    self.verifyButton.backgroundColor=[UIColor colorWithRed:0.0588 green:0.525 blue:0.902 alpha:1.0];
    self.verifyButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.verifyButton addTarget:self action:@selector(verifyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [backContainer addSubview:self.verifyButton];
    
    
    self.verifyField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line2.frame.origin.y + line2.frame.size.height, 226, 38)];
    self.verifyField.font = [UIFont systemFontOfSize:13];
    self.verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.verifyField.textAlignment = NSTextAlignmentLeft;
    self.verifyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.verifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.verifyField.returnKeyType = UIReturnKeyDone;
    self.verifyField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    self.verifyField.delegate=self;
    
    [backContainer addSubview:self.verifyField];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, line3.frame.origin.y + line3.frame.size.height + 20, 125, 25)];

    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
    cancelButton.backgroundColor=[UIColor colorWithRed:0.0588 green:0.525 blue:0.902 alpha:1.0];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [subView addSubview:cancelButton];
    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(subView.frame.size.width - 125, cancelButton.frame.origin.y, 125, 25)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.backgroundColor=[UIColor colorWithRed:0.91 green:0.498 blue:0 alpha:1.0];
    [sureButton addTarget:self action:@selector(normalPressed:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [subView addSubview:sureButton];
    [self setupView];
    [self addNotification];
}

//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.view addGestureRecognizer:tapGesture];
}
//注册键盘出现的通知,为了动态获取键盘高度
-(void)addNotification{
    
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(onKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}



- (void)onKeyboardWillShow:(NSNotification *)aNotification {
    

    NSDictionary *userInfoDic = aNotification.userInfo;
    
    NSTimeInterval duration  = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -50);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}


- (void)onBackClicked:(id)sender {
    [self.phoneNumberField resignFirstResponder];
    [self.verifyField resignFirstResponder];
    
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘自动上移====end


- (void)normalPressed:(UIButton*)sender
{
    
    NSString* verify = self.verifyField.text;
      
    if (verify.length == 0)
    {
        if (self.process == nil) {
            self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
        }
        
        [self.view addSubview:self.process];
        [self.view bringSubviewToFront:self.process];
        self.process.labelText = @"请输入验证码";
        [self.process showAnimated:YES whileExecutingBlock:^{
            
             [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [self.process removeFromSuperview];
        }];
 
        return;
    }
    
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
                    self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
    
                    self.process.labelText = @"绑定成功";
                    self.process.mode = SJIOSProgressHUDModeCustomView;
                    self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                    [self.process showAnimated:YES whileExecutingBlock:^{
                        sleep(2);
                        
                    } successCallback:^{
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
                        [self.process removeFromSuperview];
                        
                    }];
                    
                }
                else
                {
                    if (self.process == nil) {
                        self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
                    }
                    
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
                    self.process.labelText = @"验证码错误";
                    [self.process showAnimated:YES whileExecutingBlock:^{
                        
                         [NSThread sleepForTimeInterval:1];
                    } successCallback:^{
                        [self.process removeFromSuperview];
                    }];

                }
            }
            else
            {
                if (self.process == nil) {
                    self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
                }
                
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                self.process.labelText = [[SJIOSSdkImp sharedInstance] translateSJIOS:[dictionary valueForKey:@"error"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    
                     [NSThread sleepForTimeInterval:1];
                } successCallback:^{
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
    
    [[SJIOSWebInterface sharedInstance] confirmSJIOSPhone:self.accessToken
                         verifySJIOS:verify
                successCallbackSJIOS:successCallback
                    failCallbackSJIOS:^(NSError * error) {
                        if (self.process == nil) {
                            self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
                        }
                        
                        [self.view addSubview:self.process];
                        [self.view bringSubviewToFront:self.process];
                        self.process.labelText = @"内部错误";
                        [self.process showAnimated:YES whileExecutingBlock:^{
                            
                            [NSThread sleepForTimeInterval:1];
                        } successCallback:^{
                            [self.process removeFromSuperview];
                        }];
                        self.binding = NO;
                    }
     ];
    
    self.binding = YES;
    
    
    
    [NSThread  detachNewThreadSelector:@selector(bindDespatch) toTarget:self withObject:nil];
}

-(void)bindDespatch {
    self.process = [[SJIOSProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.process];
    [self.view bringSubviewToFront:self.process];
    self.process.labelText = @"验证中";
    [self.process showAnimated:YES whileExecutingBlock:^{
        while (self.binding)
        {
            usleep(50000);
        }
    } successCallback:^{
        [self.process removeFromSuperview];
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.verifyField resignFirstResponder];
    [self.phoneNumberField resignFirstResponder];
}


@end
