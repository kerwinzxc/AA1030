

#import "UsequenceBindEmailViewController.h"
#import "UIImage+UsequenceSdk.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "UsequenceProgressHUD.h"
#import "UsequenceSdkImp.h"
#import "UsequenceWebInterface.h"
#import  "UsequenceSdkImp.h"
@interface UsequenceBindEmailViewController ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITextField *phoneNumberField;
@property (nonatomic)int cooldown;
@property(nonatomic, strong) NSTimer * buttonTimer;
@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL binding;
@property (strong, nonatomic) UsequenceProgressHUD *process;


@end

@implementation UsequenceBindEmailViewController

-(void)initNavigation {
    UIImage *backNormalImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_back.png"]];
    UIImage *backHighImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_back_cl.png"]];
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
    serviceImageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_icon_meun_bangemail.png"]];
    
    UIImageView *blueBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, serviceImageView.frame.size.width + serviceImageView.frame.origin.x, 2)];
    blueBar.backgroundColor = [UIColor colorWithRed:0.0 green:0.576 blue:1.0 alpha:1];
    [containerView addSubview:blueBar];
    
    [containerView addSubview:serviceImageView];
    [self.view addSubview:containerView];
    
    self.container = containerView;
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
    self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
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



- (void)timerFired:(NSTimer*)sender
{
    --self.cooldown;
    if (self.cooldown <= 0)
    {
        [self.buttonTimer invalidate];
        self.buttonTimer = nil;
        
         }
    else
    {
        NSString * title = [[NSString alloc] initWithFormat:@"%d秒", self.cooldown];
      
    }
}

-(void)back {
    if (self.buttonTimer != nil) {
        [self.buttonTimer invalidate];
        self.buttonTimer = nil;
    }
    
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
    
    UIView *backContainer = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, subView.frame.size.width, 40)];
    backContainer.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9176 alpha:1.0];
    
    [subView addSubview:backContainer];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, subView.frame.size.width, 2)];
    line1.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, line1.frame.origin.y + 40, subView.frame.size.width, 2)];
    line2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:line2];
    


    
    UIImageView *verticalLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2, 40)];
    verticalLine1.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine1];
    
    UIImageView *verticalLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 2,40)];
    verticalLine2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine2];
    
    UIImageView *verticalLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(subView.frame.size.width - 2, 0, 2, 40)];
    verticalLine3.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine3];
    
    UILabel *phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 68, 38)];
    phoneNumberLabel.contentMode = UIViewContentModeBottomRight;
    phoneNumberLabel.font = [UIFont systemFontOfSize:12];
    [phoneNumberLabel setText:@"电子邮箱"];
    phoneNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    [backContainer addSubview:phoneNumberLabel];
    
    
    self.phoneNumberField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line1.frame.origin.y + line1.frame.size.height, 156, 38)];
    self.phoneNumberField.font = [UIFont systemFontOfSize:13];
    self.phoneNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumberField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneNumberField.textAlignment = NSTextAlignmentLeft;
    self.phoneNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumberField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.phoneNumberField.returnKeyType = UIReturnKeyDone;
    self.phoneNumberField.keyboardType = UIKeyboardTypeEmailAddress;//输入邮件键盘
    self.phoneNumberField.placeholder = @"请输入电子邮件";
    self.phoneNumberField.delegate=self;
    [backContainer addSubview:self.phoneNumberField];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y + line2.frame.size.height + 20, 125, 25)];
    cancelButton.backgroundColor=[UIColor colorWithRed:0.0588 green:0.525 blue:0.902 alpha:1.0];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [subView addSubview:cancelButton];
    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(subView.frame.size.width - 125, cancelButton.frame.origin.y, 125, 25)];
    sureButton.backgroundColor=[UIColor colorWithRed:0.91 green:0.498 blue:0 alpha:1.0];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(normalPressed) forControlEvents:UIControlEventTouchUpInside];
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


//键盘自动上移====start

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
    
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘自动上移====end


- (void)normalPressed
{
    NSString* verify = self.phoneNumberField.text;
    if (verify.length == 0)
    {
        if (self.process == nil) {
            self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
        }
        
        [self.view addSubview:self.process];
        [self.view bringSubviewToFront:self.process];
        self.process.labelText = @"请输入邮箱";
        [self.process showAnimated:YES whileExecutingBlock:^{
            
             [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [self.process removeFromSuperview];
        }];
 
        return;
    }else if([verify rangeOfString:@"@"].location ==NSNotFound){
        if (self.process == nil) {
            self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
        }
        
        [self.view addSubview:self.process];
        [self.view bringSubviewToFront:self.process];
        self.process.labelText = @"请输入正确的邮箱的地址";
        [self.process showAnimated:YES whileExecutingBlock:^{
            
            [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [self.process removeFromSuperview];
        }];
        
        return;

    }
    
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSLog(@"bind email dictionary==%@",dictionary);
            
            
            NSString *value = [dictionary objectForKey:@"error"];
            
            
            if ((NSNull *)value == nil)
            {
                NSString *ok = [dictionary objectForKey:@"ok"];
                if (ok != nil)
                {
                    self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
    
                    self.process.labelText = @"请尽快到邮箱绑定你的帐号";
                    self.process.mode = UsequenceProgressHUDModeCustomView;
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
                        self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
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
            else if([value isEqualToString:@"access_denied"]){
                    self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
                    
                    self.process.labelText = @"请勿重复申请绑定,返回即可查看绑定状态";
                    self.process.mode = UsequenceProgressHUDModeCustomView;
                    self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                    [self.process showAnimated:YES whileExecutingBlock:^{
                        sleep(3);
                    } successCallback:^{
                        [self.process removeFromSuperview];
                    }];
            }else if([value isEqualToString:@"duplicate_email"]){
                self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                
                self.process.labelText = @"该邮箱已经绑定过其他帐号，请输入其他邮箱";
                self.process.mode = UsequenceProgressHUDModeCustomView;
                self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    sleep(3);
                } successCallback:^{
                    [self.process removeFromSuperview];
                }];
                
            }else
            {
                if (self.process == nil) {
                    self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
                }
                
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                self.process.labelText = [[UsequenceSdkImp sharedInstance] translateUsequence:[dictionary valueForKey:@"error"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    
                     [NSThread sleepForTimeInterval:3];
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
    
     [[UsequenceWebInterface sharedInstance] bindUsequenceMail:self.accessToken emailUsequence:verify successUsequenceCallback:successCallback failUsequenceCallback:^(NSError *error) {
        
         
                 if (self.process == nil) {
                     self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
                 }
                 [self.view addSubview:self.process];
                 [self.view bringSubviewToFront:self.process];
                 self.process.labelText = @"内部错误";
                 [self.process showAnimated:YES whileExecutingBlock:^{
                     
                     [NSThread sleepForTimeInterval:1];
                 } successCallback:^{
                     [self.process removeFromSuperview];
                 }];
         
     }];
}

-(void)bindDespatch {
    self.process = [[UsequenceProgressHUD alloc] initWithView:self.view];
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
    [self.phoneNumberField resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumberField)
    {
        [self.phoneNumberField resignFirstResponder];
        
        NSString * username = self.phoneNumberField.text;
        if ([username length] == 0)
        {
            
            [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"邮箱为空"];
            
            return YES;
        }

        [self normalPressed];
    }
        return YES;
}


@end
