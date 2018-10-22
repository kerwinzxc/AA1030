
#import <Foundation/Foundation.h>

#import "QroughtBindIdentifyViewController.h"
#import "UIImage+QroughtSdk.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "QroughtProgressHUD.h"
#import "QroughtSdkImp.h"
#import "QroughtWebInterface.h"
#import  "QroughtSdkImp.h"
@interface QroughtBindIdentifyViewController ()

@property (nonatomic, strong) UIView *container;

@property (nonatomic)int cooldown;
@property(nonatomic, strong) NSTimer * buttonTimer;
@property(nonatomic) BOOL verifing;
@property(nonatomic) BOOL binding;
@property (strong, nonatomic) QroughtProgressHUD *process;
@property(nonatomic,strong) QroughtBindIdentifyViewController *bindIdentifyVew;


@end

@implementation QroughtBindIdentifyViewController

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
    
    [self addNotification];
    
    if (ios8) {
        
    }else{
        if (self.landscape == true) {
            screenSize = CGSizeMake(screenSize.height, screenSize.width);
        }
    }
    
    
    //    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithRed:0.1176 green:0.5255 blue:0.855 alpha:1.0] cornerRadius:3.0f sizeOfdialog:CGSizeMake(screenSize.width, 44)];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:130.0/255.0 blue:180.0/255.0 alpha:1.0] ];
    
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y + 20, screenSize.width, 30)];
    containerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *grayImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, screenSize.width, 2)];
    grayImageView.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [containerView addSubview:grayImageView];
    
    
    UIImageView *serviceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 76, 17)];
    serviceImageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_icon_meun_shiming.png"]];
    
    UIImageView *blueBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, serviceImageView.frame.size.width + serviceImageView.frame.origin.x, 2)];
    blueBar.backgroundColor = [UIColor colorWithRed:0.0 green:0.576 blue:1.0 alpha:1];
    [containerView addSubview:blueBar];
    
    [containerView addSubview:serviceImageView];
    [self.view addSubview:containerView];
    
    self.container = containerView;
    
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
    [identifyNumberField resignFirstResponder];
    [identifyNameField resignFirstResponder];
    
}

- (void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘自动上移====end



-(id)initWithLandscape:(Boolean)landscape
{
    self = [super init];
    if (self) {
        self.landscape = landscape;
    }
    return self;
}

-(void)getVerifyDespatch {
    self.process = [[QroughtProgressHUD alloc] initWithView:self.view];
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
    [identifyNameField resignFirstResponder];
    [identifyNumberField resignFirstResponder];
    
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
    identifyNameField.delegate = self;
    identifyNumberField.delegate = self;
    
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
    
    UIImageView *verticalLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 2,80)];
    verticalLine2.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine2];
    
    UIImageView *verticalLine3 = [[UIImageView alloc]initWithFrame:CGRectMake(subView.frame.size.width - 2, 0, 2, 80)];
    verticalLine3.backgroundColor = [UIColor colorWithRed:0.8382 green:0.8382 blue:0.8382 alpha:1.0];;
    [backContainer addSubview:verticalLine3];
    
    
    
    UILabel *identifyNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 68, 38)];
    identifyNameLabel.contentMode = UIViewContentModeBottomRight;
    identifyNameLabel.font = [UIFont systemFontOfSize:12];
    [identifyNameLabel setText:@"真实姓名"];
    identifyNameLabel.textAlignment = NSTextAlignmentCenter;
    [backContainer addSubview:identifyNameLabel];
    
    
    identifyNameField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line1.frame.origin.y + line1.frame.size.height, 156, 38)];
    identifyNameField.font = [UIFont systemFontOfSize:13];
    identifyNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    identifyNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    identifyNameField.textAlignment = NSTextAlignmentLeft;
    identifyNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    identifyNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    identifyNameField.returnKeyType = UIReturnKeyNext;
    identifyNameField.placeholder = @"请输入身份证上的姓名";
    identifyNameField.delegate=self;
//    [self textFieldDidBeginEditing:identifyNameField];
    [backContainer addSubview:identifyNameField];
    
    
    
    UILabel *identifyNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 42, 68, 38)];
    identifyNumberLabel.contentMode = UIViewContentModeBottomRight;
    identifyNumberLabel.font = [UIFont systemFontOfSize:12];
    [identifyNumberLabel setText:@"身份证号码"];
    identifyNumberLabel.textAlignment = NSTextAlignmentCenter;

    [backContainer addSubview:identifyNumberLabel];
    
    
    identifyNumberField = [[UITextField alloc]initWithFrame:CGRectMake(verticalLine2.frame.origin.x + verticalLine2.frame.size.width, line2.frame.origin.y + line2.frame.size.height, 156, 38)];
    identifyNumberField.font = [UIFont systemFontOfSize:13];
    identifyNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    identifyNumberField.autocorrectionType = UITextAutocorrectionTypeNo;
    identifyNumberField.textAlignment = NSTextAlignmentLeft;
    identifyNumberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    identifyNumberField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    identifyNumberField.returnKeyType = UIReturnKeyDone;
    identifyNumberField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;//输入数字键盘
    identifyNumberField.placeholder = @"请输入身份证号码";
    identifyNumberField.delegate=self;
//    [self textFieldDidBeginEditing:identifyNumberField];
    [backContainer addSubview:identifyNumberField];
    
    
    
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, line3.frame.origin.y + line2.frame.size.height + 20, 125, 25)];
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
}

-(void)showQroughtToast:(NSString *)msg{
    if (self.process == nil) {
        self.process = [[QroughtProgressHUD alloc] initWithView:self.view];
    }
    
    [self.view addSubview:self.process];
    [self.view bringSubviewToFront:self.process];
    self.process.labelText = msg;
    [self.process showAnimated:YES whileExecutingBlock:^{
        
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [self.process removeFromSuperview];
    }];
}


- (void)normalPressed
{
    [identifyNameField resignFirstResponder];
    [identifyNumberField resignFirstResponder];
    
    if(identifyNameField.text.length == 0){
        [self showQroughtToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = identifyNumberField.text;
    if (verify.length == 0)
    {

        [self showQroughtToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [self showQroughtToast:@"身份证号码有误"];
        
        return;
    }
    
    
    
    Qrought_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            NSLog(@"startIdentify dictionary = %@", dictionary);
            NSString *value = [dictionary objectForKey:@"error"];
            
            if ((NSNull *)value == nil)
            {
                NSString *ok = [dictionary objectForKey:@"ok"];
                if (ok != nil)
                {
                    
                    [self showQroughtToast:@"认证成功，请返回"];
                    [self dismissViewControllerAnimated:YES completion:^{
                    }];

                }
                
                else{
                    
                    [self showQroughtToast:@"认证失败"];
                    
                    
                }
                
            }else if([value isEqualToString:@"invalid_request"]){
                
                [self showQroughtToast:@"身份证信息有误"];
                return;
            }
            else
            {
                
                [self showQroughtToast:[[QroughtSdkImp sharedInstance] translateQrought:[dictionary valueForKey:@"error"]]];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[QroughtWebInterface sharedInstance] startQroughtIdentify:self.accessToken nameQrought:identifyNameField.text identifyNumberQrought:identifyNumberField.text successCallbackQrought:successCallback failCallbackQrought:^(NSError *error) {
        
                
        [self showQroughtToast:@"请重新登录帐号"];
        
    }];
}

-(void)bindDespatch {
    self.process = [[QroughtProgressHUD alloc] initWithView:self.view];
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
    [identifyNameField resignFirstResponder];
    [identifyNumberField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == identifyNameField)
    {
        [identifyNumberField becomeFirstResponder];
    }
    else if(textField==identifyNumberField)
    {
        [textField resignFirstResponder];
        
        NSString * username = identifyNameField.text;
        if ([username length] == 0)
        {
            
            [[QroughtSdkImp sharedInstance]showQroughtToast:@"姓名为空"];
            
            return YES;
        }
        
        NSString * password = identifyNumberField.text;
        if ([password length] == 0)
        {
            [[QroughtSdkImp sharedInstance]showQroughtToast:@"身份证为空"];
            
            return YES;
        }
        
        [self normalPressed];
    }
    return YES;
}


@end
