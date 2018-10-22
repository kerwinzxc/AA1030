#import <Foundation/Foundation.h>
#import "RersistenceShiMingRenZhengView.h"
#import "RersistenceSdkImp.h"
#import "UIControl+ZHW.h"
#import "RersistenceWebInterface.h"


@interface RersistenceShiMingRenZhengView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *parentView_RersistenceShiMingRenZhengView;
@property (nonatomic, strong) UIView *alterView_RersistenceShiMingRenZhengView;

@property (nonatomic, assign) Boolean landscape_RersistenceShiMingRenZhengView;
@property (nonatomic, strong) NSString *accessToken_RersistenceShiMingRenZhengView;

@property (nonatomic, strong) UITextField *nameFiled_RersistenceShiMingRenZhengView;
@property (nonatomic, strong) UITextField *numberFiled_RersistenceShiMingRenZhengView;

@property (nonatomic, strong) RersistenceShiMingRenZhengView *ShiMingRenZhengView;

@property(nonatomic, strong) Rersistence_COMMON_BLOCK callback;

@end

@implementation RersistenceShiMingRenZhengView

-(id)initRersistenceShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Rersistence_COMMON_BLOCK)callback{
    self = [super initWithFrame:CGRectZero];
    self.landscape_RersistenceShiMingRenZhengView = landscape;
    self.accessToken_RersistenceShiMingRenZhengView = accessToken;
    self.callback = callback;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"ShiMingRenZhengView width:%d",width);
        NSLog(@"ShiMingRenZhengView height:%d",height);
        
        self.parentView_RersistenceShiMingRenZhengView = NULL;
        if(self.landscape_RersistenceShiMingRenZhengView){
            self.alterView_RersistenceShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, 450, 250)];
            self.alterView_RersistenceShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_RersistenceShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_RersistenceShiMingRenZhengView];
            
            [self showLandRersistenceShiMingRenZhengView];
        }else{
            self.alterView_RersistenceShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, 260, 260)];
            self.alterView_RersistenceShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_RersistenceShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_RersistenceShiMingRenZhengView];
            [self showPortraitRersistenceShiMingRenZhengView];
        }
        [self setupRersistenceShiMingRenZhengView];
        [self addNotificationRersistenceShiMingRenZhengView];
    }
    
    return self;
}

-(void)showLandRersistenceShiMingRenZhengView{

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(161, 5, 128, 30)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(415, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_RersistenceShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtRersistenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_RersistenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 40, 310, 38)];
    self.nameFiled_RersistenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_edit_background.png"]];
    self.nameFiled_RersistenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_RersistenceShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_RersistenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_RersistenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_RersistenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_RersistenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_RersistenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_RersistenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_RersistenceShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_RersistenceShiMingRenZhengView.delegate=self;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:self.nameFiled_RersistenceShiMingRenZhengView];
    
    
    self.numberFiled_RersistenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 95, 310, 38)];
    self.numberFiled_RersistenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_edit_background.png"]];
    self.numberFiled_RersistenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_RersistenceShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_RersistenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_RersistenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_RersistenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_RersistenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_RersistenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_RersistenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_RersistenceShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.numberFiled_RersistenceShiMingRenZhengView.delegate=self;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:self.numberFiled_RersistenceShiMingRenZhengView];
    
    NSLog(@"msg = %@", [[[RersistenceSdkImp sharedInstance] getRersistenceShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(70, 138, 310, 60)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:12];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[RersistenceSdkImp sharedInstance] getRersistenceShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 203, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:sureButtonImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"进行实名认证"];
    [label sizeToFit];
    label.center = CGPointMake(sureButton.bounds.size.width/2, sureButton.bounds.size.height/2);
    sureButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    sureButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [sureButton addSubview:imageView];
    [sureButton addSubview:label];
    [sureButton addTarget:self action:@selector(sureClickAtRersistenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_RersistenceShiMingRenZhengView addSubview:sureButton];
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(260, 203, 130, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_button.png"]];
    UIImageView *cabcelimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [cabcelimageView setImage:cancelImg];
    UILabel *cabcellabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [cabcellabel setTextColor:[UIColor whiteColor]];
    [cabcellabel setText:@"跳过"];
    [cabcellabel sizeToFit];
    cabcellabel.center = CGPointMake(cancelBt.bounds.size.width/2, cancelBt.bounds.size.height/2);
    cancelBt.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    cancelBt.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [cancelBt addSubview:cabcelimageView];
    [cancelBt addSubview:cabcellabel];
    [cancelBt addTarget:self action:@selector(cancelClickAtRersistenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_RersistenceShiMingRenZhengView addSubview:cancelBt];
}

-(void)showPortraitRersistenceShiMingRenZhengView{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(82, 5, 95 , 38)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_RersistenceShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtRersistenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_RersistenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 48, 200, 35)];
    self.nameFiled_RersistenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_edit_background.png"]];
    self.nameFiled_RersistenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_RersistenceShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_RersistenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_RersistenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_RersistenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_RersistenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_RersistenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_RersistenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_RersistenceShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_RersistenceShiMingRenZhengView.delegate=self;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:self.nameFiled_RersistenceShiMingRenZhengView];

    
    self.numberFiled_RersistenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, 200, 35)];
    self.numberFiled_RersistenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_edit_background.png"]];
    self.numberFiled_RersistenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_RersistenceShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_RersistenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_RersistenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_RersistenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_RersistenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_RersistenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_RersistenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_RersistenceShiMingRenZhengView.returnKeyType = UIReturnKeyDone;
    self.numberFiled_RersistenceShiMingRenZhengView.delegate=self;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:self.numberFiled_RersistenceShiMingRenZhengView];
    
    
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 200, 75)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:10];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[RersistenceSdkImp sharedInstance] getRersistenceShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_RersistenceShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(25, 209, 90, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 38)];
    [imageView setImage:sureButtonImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 38)];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"进行认证"];
    [label sizeToFit];
    label.center = CGPointMake(sureButton.bounds.size.width/2, sureButton.bounds.size.height/2);
    sureButton.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    sureButton.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [sureButton addSubview:imageView];
    [sureButton addSubview:label];
    [sureButton addTarget:self action:@selector(sureClickAtRersistenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_RersistenceShiMingRenZhengView addSubview:sureButton];
    
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(145, 209, 90, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_button.png"]];
    UIImageView *cabcelimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 38)];
    [cabcelimageView setImage:cancelImg];
    UILabel *cabcellabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 38)];
    [cabcellabel setTextColor:[UIColor whiteColor]];
    [cabcellabel setText:@"跳过"];
    [cabcellabel sizeToFit];
    cabcellabel.center = CGPointMake(cancelBt.bounds.size.width/2, cancelBt.bounds.size.height/2);
    cancelBt.zhw_ignoreEvent = NO;//yes不启用防止重复点击，NO启用防止重复点击
    cancelBt.zhw_acceptEventInterval = 3.0;//重复点击间隔时间
    [cancelBt addSubview:cabcelimageView];
    [cancelBt addSubview:cabcellabel];
    [cancelBt addTarget:self action:@selector(cancelClickAtRersistenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_RersistenceShiMingRenZhengView addSubview:cancelBt];
}

-(void)setupRersistenceShiMingRenZhengView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ShiMingRenZhengView addGestureRecognizer:tapGesture];
}

-(void)addNotificationRersistenceShiMingRenZhengView{
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
        self.alterView_RersistenceShiMingRenZhengView.transform = CGAffineTransformMakeTranslation(0, -65);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alterView_RersistenceShiMingRenZhengView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.nameFiled_RersistenceShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_RersistenceShiMingRenZhengView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameFiled_RersistenceShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_RersistenceShiMingRenZhengView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameFiled_RersistenceShiMingRenZhengView)
    {
        [self.numberFiled_RersistenceShiMingRenZhengView becomeFirstResponder];
    }
    else if(textField==self.numberFiled_RersistenceShiMingRenZhengView)
    {
        [textField resignFirstResponder];
        

        [self sureClickAtRersistenceShiMingRenZhengView];
    }
    return YES;
}

-(void)cancelClickAtRersistenceShiMingRenZhengView{
    [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissRersistenceShiMingRenZhengView:YES];
}

-(void)sureClickAtRersistenceShiMingRenZhengView{
    if(_nameFiled_RersistenceShiMingRenZhengView.text.length == 0){
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = _numberFiled_RersistenceShiMingRenZhengView.text;
    if (verify.length == 0)
    {
        
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"身份证号码有误"];
        
        return;
    }
    
    Rersistence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
                    
//                    self.callback(@"success");
//                    [self dismissRersistenceShiMingRenZhengView:YES];
                    if([[dictionary objectForKey:@"flag"] boolValue] == NO){
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[dictionary objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //响应事件
                            NSLog(@"action = %@", action);
                            self.callback(@"success");
                            [self dismissRersistenceShiMingRenZhengView:YES];
                        }];
                        [alert addAction:defaultAction];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    }else{
                        self.callback(@"success");
                        [self dismissRersistenceShiMingRenZhengView:YES];
                    }
                }else{
                        [[RersistenceSdkImp sharedInstance] showRersistenceToast:value];
                }
            }else
            {
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:value];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[RersistenceWebInterface sharedInstance] startRersistenceIdentify:self.accessToken_RersistenceShiMingRenZhengView nameRersistence:_nameFiled_RersistenceShiMingRenZhengView.text identifyNumberRersistence:_numberFiled_RersistenceShiMingRenZhengView.text successCallbackRersistence:successCallback failCallbackRersistence:^(NSError *error) {
        
        
        [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请重新登录帐号"];
        
    }];
}

-(void)backClickAtRersistenceShiMingRenZhengView{
    [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissRersistenceShiMingRenZhengView:YES];
}

-(void)showRersistenceShiMingRenZhengView:(UIView *)view{
    NSLog(@"showRersistenceShiMingRenZhengView");
    self.parentView_RersistenceShiMingRenZhengView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissRersistenceShiMingRenZhengView:(BOOL)animated{
    NSLog(@"dismissRersistenceShiMingRenZhengView");
    [super removeFromSuperview];
}

@end
