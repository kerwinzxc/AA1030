
#import "QroughtChangePasswordViewController.h"
#import "UIImage+QroughtSdk.h"

#import "QroughtSdkImp.h"
#import "QroughtProgressHUD.h"
#import "QroughtWebInterface.h"
#import "QroughtSdkMd5.h"
#import "QroughtDataBase.h"
#import "QroughtSdkImp.h"
@interface QroughtChangePasswordViewController ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITextField * oldPasswordField;
@property (nonatomic, strong) UITextField * nowPasswordField;
@property (nonatomic, strong) UITextField * nowConfirmPasswordField;
@property (nonatomic) BOOL changing;


@end

@implementation QroughtChangePasswordViewController

-(void)initNavigation {
    UIImage *backNormalImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_back.png"]];
    UIImage *backHighImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_back_cl.png"]];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:backNormalImage forState:UIControlStateNormal];
    [backButton setImage:backHighImage forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    CGSize screenSize = [[UIScreen mainScreen]bounds].size;
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
    grayImageView.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    
    [containerView addSubview:grayImageView];
    
    UIImageView *serviceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 76, 17)];
    serviceImageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_icon_meun_change_pw.png"]];
    
    UIImageView *blueBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, serviceImageView.frame.size.width + serviceImageView.frame.origin.x, 2)];
    blueBar.backgroundColor = [UIColor colorWithRed:0.0 green:0.576 blue:1.0 alpha:1];
    [containerView addSubview:blueBar];
    
    [containerView addSubview:serviceImageView];
    [self.view addSubview:containerView];
    self.container = containerView;
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigation];
    [self addSubview];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *data=[[[[QroughtDataBase alloc]init] getTestList] sortedArrayUsingComparator:^NSComparisonResult(QroughtUserInfo *obj1, QroughtUserInfo  *obj2) {
        return [obj2.loginTime compare:obj1.loginTime];
    }];
    userinfo=[data objectAtIndex:0];
    
    if([userinfo.tourist isEqualToString:@"1"]){
        
        [self.oldPasswordField setText:userinfo.password];
    }else{

    }
    
    
    
    
    self.nowConfirmPasswordField.text =@"";
    self.nowPasswordField.text = @"";
}

-(void)back {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(id)initWithLandscape:(Boolean)landscape
{
    self = [super init];
    if (self) {
        self.landscape = landscape;
    }
    return self;
}

-(void)addSubview {
    CGRect mainScreen = [[UIScreen mainScreen]bounds];
    if(ios8)
    {
        
    }else{
        if (self.landscape == true) {
            mainScreen = CGRectMake(mainScreen.origin.x, mainScreen.origin.y, mainScreen.size.height, mainScreen.size.width);
        }
    }
    
    
    
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(10, self.container.frame.origin.y + self.container.frame.size.height + 30, mainScreen.size.width - 20, 300)];
    
    subView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:subView];
    
    UIView *subSubView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, subView.frame.size.width, 120)];
    subSubView.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9176 blue:0.9176 alpha:1.0];
    
    
    [subView addSubview:subSubView];
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, subView.frame.size.width, 2)];
    line1.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, line1.frame.origin.y + 40, subView.frame.size.width, 2)];
    line2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:line2];
    
    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y + 40, subView.frame.size.width, 2)];
    line3.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:line3];
    
    UIImageView *line4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, line3.frame.origin.y + 40, subView.frame.size.width, 2)];
    line4.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:line4];
    
    UIImageView *verticalLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2, 120)];
    verticalLine1.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:verticalLine1];
    
    UIImageView *verticalLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 2, 120)];
    verticalLine2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:verticalLine2];
    
    UIImageView *verticalLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(subView.frame.size.width - 2, 0, 2, 120)];
    verticalLine3.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];
    [subSubView addSubview:verticalLine3];
    
    
    UILabel *nowPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 68, 38)];
    nowPasswordLabel.contentMode = UIViewContentModeBottomRight;
    nowPasswordLabel.font = [UIFont systemFontOfSize:12];
    [nowPasswordLabel setText:@"当前密码"];
    nowPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [subSubView addSubview:nowPasswordLabel];
    
    UILabel *newPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, line2.frame.origin.y + line2.frame.size.height, 68, 38)];
    newPasswordLabel.contentMode = UIViewContentModeCenter;
    newPasswordLabel.font = [UIFont systemFontOfSize:12];
    [newPasswordLabel setText:@"新的密码"];
    newPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [subSubView addSubview:newPasswordLabel];
    
    UILabel *conformPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, line3.frame.origin.y + line3.frame.size.height, 68, 38)];
    conformPasswordLabel.font = [UIFont systemFontOfSize:12];
    [conformPasswordLabel setText:@"确认密码"];
    conformPasswordLabel.textAlignment = NSTextAlignmentCenter;
    [subSubView addSubview:conformPasswordLabel];
    
    
    self.oldPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, 2, 226, 38)];
    self.oldPasswordField.font = [UIFont systemFontOfSize:15];
    self.oldPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.oldPasswordField.textAlignment = NSTextAlignmentLeft;
    self.oldPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.oldPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.oldPasswordField.placeholder = @"请输入当前密码";
    self.oldPasswordField.returnKeyType = UIReturnKeyNext;
    self.oldPasswordField.borderStyle = UITextBorderStyleNone;
    self.oldPasswordField.delegate=self;
    [subView addSubview:self.oldPasswordField];
    
    
    
    self.nowPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line2.frame.origin.y + line2.frame.size.height, 226, 38)];
    self.nowPasswordField.font = [UIFont systemFontOfSize:15];
    self.nowPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nowPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nowPasswordField.textAlignment = NSTextAlignmentLeft;
    self.nowPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nowPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nowPasswordField.placeholder = @"请输入新密码";
    self.nowPasswordField.returnKeyType = UIReturnKeyNext;
    self.nowPasswordField.borderStyle = UITextBorderStyleNone;
    self.nowPasswordField.delegate=self;
    [subView addSubview:self.nowPasswordField];
    
    
    self.nowConfirmPasswordField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line3.frame.origin.y + line3.frame.size.height, 226, 38)];
    self.nowConfirmPasswordField.font = [UIFont systemFontOfSize:15];
    self.nowConfirmPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nowConfirmPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nowConfirmPasswordField.textAlignment = NSTextAlignmentLeft;
    self.nowConfirmPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nowConfirmPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nowConfirmPasswordField.returnKeyType = UIReturnKeyDone;
    self.nowConfirmPasswordField.borderStyle = UITextBorderStyleNone;
    self.nowConfirmPasswordField.delegate=self;
    self.nowConfirmPasswordField.placeholder = @"请确认新密码";
    
    [subView addSubview:self.nowConfirmPasswordField];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, line4.frame.origin.y + line4.frame.size.height + 20, 125, 25)];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:10];
    cancelButton.backgroundColor=[UIColor colorWithRed:0.0588 green:0.525 blue:0.902 alpha:1.0];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:cancelButton];
    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(subSubView.frame.size.width - 125, cancelButton.frame.origin.y, 125, 25)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [sureButton addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor=[UIColor colorWithRed:0.91 green:0.498 blue:0 alpha:1.0];
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
    [self.oldPasswordField resignFirstResponder];
    [self.nowPasswordField resignFirstResponder];
    [self.nowConfirmPasswordField resignFirstResponder];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

-(void)changePassword {
    NSString *newPassword  = self.nowPasswordField.text;
    if ([newPassword length] == 0) {
        QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:process];
        [self.view bringSubviewToFront:process];
        process.mode = QroughtProgressHUDModeCustomView;
        process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        process.labelText = @"新密码不能为空";
        [process showAnimated:YES whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [process removeFromSuperview];
        }];
        return;
    }
    
    NSString *confirmPassword = self.nowConfirmPasswordField.text;
    if ([confirmPassword length] == 0) {
        QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:process];
        [self.view bringSubviewToFront:process];
        process.mode = QroughtProgressHUDModeCustomView;
        process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        process.labelText = @"确认密码不能为空";
        [process showAnimated:YES whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [process removeFromSuperview];
        }];
        return;
    }
    if ([newPassword length] < 6 || [newPassword length] > 20) {
        QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:process];
        [self.view bringSubviewToFront:process];
        process.mode = QroughtProgressHUDModeCustomView;
        process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        process.labelText = @"新密码长度为6-20位字母+数字";
        [process showAnimated:YES whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1];
            
        } successCallback:^{
            [process removeFromSuperview];
        }];
        return;
    }
    
    if (![newPassword isEqualToString:confirmPassword]) {
        QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:process];
        [self.view bringSubviewToFront:process];
        process.mode = QroughtProgressHUDModeCustomView;
        process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
        process.labelText = @"请确认两次密码输入是否一致";
        [process showAnimated:YES whileExecutingBlock:^{
            [NSThread sleepForTimeInterval:1];
        } successCallback:^{
            [process removeFromSuperview];
        }];
        return;
    }
    
    Qrought_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        self.changing = NO;
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *nowPassword;
                if([userinfo.tourist isEqualToString:@"1"]){
                    
                    nowPassword=[QroughtSdkMd5 md5:self.nowPasswordField.text];
                }else{
                    
                    nowPassword=self.nowPasswordField.text;
                }
                
                [[[QroughtDataBase alloc]init]updateQroughtPassword:nowPassword userName:userinfo.username];
                self.oldPasswordField.text = @"";
                self.nowPasswordField.text = @"";
                self.nowConfirmPasswordField.text = @"";
                QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:process];
                [self.view bringSubviewToFront:process];
                process.mode = QroughtProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                process.labelText = @"修改成功";
                [process showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:1];

                } successCallback:^{
                    [self dismissViewControllerAnimated:YES completion:^{
                    }];
                    [process removeFromSuperview];
                    NSLog(@"changepassword  success 222222");
                }];
                
            }
            else
            {
                
                QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:process];
                [self.view bringSubviewToFront:process];
                process.mode = QroughtProgressHUDModeCustomView;
                process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                process.labelText = @"输入有误，请重新输入";
                [process showAnimated:YES whileExecutingBlock:^{
                    [NSThread sleepForTimeInterval:1];
                } successCallback:^{
                    [process removeFromSuperview];
                }];
            }
        }
        @catch(NSException * e)
        {
            QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:process];
            [self.view bringSubviewToFront:process];
            process.mode = QroughtProgressHUDModeCustomView;
            process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
            process.labelText = @"内部错误";
            [process showAnimated:YES whileExecutingBlock:^{
                [NSThread sleepForTimeInterval:1];
            } successCallback:^{
                [process removeFromSuperview];
            }];
        }
        @finally
        {
            
        }
    };
    
    self.changing = YES;
    
    
    NSString *oldPassword;
    if([userinfo.tourist isEqualToString:@"1"]){

        oldPassword=self.oldPasswordField.text;
    }else{

        oldPassword = [QroughtSdkMd5 md5:self.oldPasswordField.text];
    }
    
    [[QroughtWebInterface sharedInstance]changeQroughtPasswordWithTokenQrought:self.accessToken oldPasswordQrought:oldPassword newPasswordQrought:[QroughtSdkMd5 md5:newPassword] successCallbackQrought:successCallback failCallbackQrought:^(NSError *a) {
        
    }];
    
    [self bindDespatch];
}

-(void)bindDespatch {
    QroughtProgressHUD *process = [[QroughtProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:process];
    [self.view bringSubviewToFront:process];
    process.labelText = @"修改中";
    [process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.changing)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 5) {
                QroughtProgressHUD *errorHud = [[QroughtProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:errorHud];
                [self.view bringSubviewToFront:errorHud];
                errorHud.labelText = @"网络不太好，请重试！！！";
                errorHud.mode = QroughtProgressHUDModeCustomView;
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


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.oldPasswordField resignFirstResponder];
    [self.nowConfirmPasswordField resignFirstResponder];
    [self.nowPasswordField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
