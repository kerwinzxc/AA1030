#import <Foundation/Foundation.h>
#import "SJIOSShiMingRenZhengView.h"
#import "SJIOSSdkImp.h"
#import "UIControl+ZHW.h"
#import "SJIOSWebInterface.h"


@interface SJIOSShiMingRenZhengView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *parentView_SJIOSShiMingRenZhengView;
@property (nonatomic, strong) UIView *alterView_SJIOSShiMingRenZhengView;

@property (nonatomic, assign) Boolean landscape_SJIOSShiMingRenZhengView;
@property (nonatomic, strong) NSString *accessToken_SJIOSShiMingRenZhengView;

@property (nonatomic, strong) UITextField *nameFiled_SJIOSShiMingRenZhengView;
@property (nonatomic, strong) UITextField *numberFiled_SJIOSShiMingRenZhengView;

@property (nonatomic, strong) SJIOSShiMingRenZhengView *ShiMingRenZhengView;

@property(nonatomic, strong) SJIOS_COMMON_BLOCK callback;

@end

@implementation SJIOSShiMingRenZhengView

-(id)initSJIOSShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback{
    self = [super initWithFrame:CGRectZero];
    self.landscape_SJIOSShiMingRenZhengView = landscape;
    self.accessToken_SJIOSShiMingRenZhengView = accessToken;
    self.callback = callback;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"ShiMingRenZhengView width:%d",width);
        NSLog(@"ShiMingRenZhengView height:%d",height);
        
        self.parentView_SJIOSShiMingRenZhengView = NULL;
        if(self.landscape_SJIOSShiMingRenZhengView){
            self.alterView_SJIOSShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, 450, 250)];
            self.alterView_SJIOSShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_SJIOSShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_SJIOSShiMingRenZhengView];
            
            [self showLandSJIOSShiMingRenZhengView];
        }else{
            self.alterView_SJIOSShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, 260, 260)];
            self.alterView_SJIOSShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_SJIOSShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_SJIOSShiMingRenZhengView];
            [self showPortraitSJIOSShiMingRenZhengView];
        }
        [self setupSJIOSShiMingRenZhengView];
        [self addNotificationSJIOSShiMingRenZhengView];
    }
    
    return self;
}

-(void)showLandSJIOSShiMingRenZhengView{

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(161, 5, 128, 30)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(415, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_SJIOSShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtSJIOSShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_SJIOSShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 40, 310, 38)];
    self.nameFiled_SJIOSShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_edit_background.png"]];
    self.nameFiled_SJIOSShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_SJIOSShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_SJIOSShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_SJIOSShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_SJIOSShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_SJIOSShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_SJIOSShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_SJIOSShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_SJIOSShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_SJIOSShiMingRenZhengView.delegate=self;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:self.nameFiled_SJIOSShiMingRenZhengView];
    
    
    self.numberFiled_SJIOSShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 95, 310, 38)];
    self.numberFiled_SJIOSShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_edit_background.png"]];
    self.numberFiled_SJIOSShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_SJIOSShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_SJIOSShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_SJIOSShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_SJIOSShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_SJIOSShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_SJIOSShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_SJIOSShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_SJIOSShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.numberFiled_SJIOSShiMingRenZhengView.delegate=self;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:self.numberFiled_SJIOSShiMingRenZhengView];
    
    NSLog(@"msg = %@", [[[SJIOSSdkImp sharedInstance] getSJIOSShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(70, 138, 310, 60)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:12];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[SJIOSSdkImp sharedInstance] getSJIOSShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 203, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtSJIOSShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_SJIOSShiMingRenZhengView addSubview:sureButton];
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(260, 203, 130, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtSJIOSShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_SJIOSShiMingRenZhengView addSubview:cancelBt];
}

-(void)showPortraitSJIOSShiMingRenZhengView{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(82, 5, 95 , 38)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_SJIOSShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtSJIOSShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_SJIOSShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 48, 200, 35)];
    self.nameFiled_SJIOSShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_edit_background.png"]];
    self.nameFiled_SJIOSShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_SJIOSShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_SJIOSShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_SJIOSShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_SJIOSShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_SJIOSShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_SJIOSShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_SJIOSShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_SJIOSShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_SJIOSShiMingRenZhengView.delegate=self;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:self.nameFiled_SJIOSShiMingRenZhengView];

    
    self.numberFiled_SJIOSShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, 200, 35)];
    self.numberFiled_SJIOSShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_edit_background.png"]];
    self.numberFiled_SJIOSShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_SJIOSShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_SJIOSShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_SJIOSShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_SJIOSShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_SJIOSShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_SJIOSShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_SJIOSShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_SJIOSShiMingRenZhengView.returnKeyType = UIReturnKeyDone;
    self.numberFiled_SJIOSShiMingRenZhengView.delegate=self;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:self.numberFiled_SJIOSShiMingRenZhengView];
    
    
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 200, 75)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:10];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[SJIOSSdkImp sharedInstance] getSJIOSShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_SJIOSShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(25, 209, 90, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtSJIOSShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_SJIOSShiMingRenZhengView addSubview:sureButton];
    
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(145, 209, 90, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtSJIOSShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_SJIOSShiMingRenZhengView addSubview:cancelBt];
}

-(void)setupSJIOSShiMingRenZhengView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ShiMingRenZhengView addGestureRecognizer:tapGesture];
}

-(void)addNotificationSJIOSShiMingRenZhengView{
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
        self.alterView_SJIOSShiMingRenZhengView.transform = CGAffineTransformMakeTranslation(0, -65);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alterView_SJIOSShiMingRenZhengView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.nameFiled_SJIOSShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_SJIOSShiMingRenZhengView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameFiled_SJIOSShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_SJIOSShiMingRenZhengView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameFiled_SJIOSShiMingRenZhengView)
    {
        [self.numberFiled_SJIOSShiMingRenZhengView becomeFirstResponder];
    }
    else if(textField==self.numberFiled_SJIOSShiMingRenZhengView)
    {
        [textField resignFirstResponder];
        

        [self sureClickAtSJIOSShiMingRenZhengView];
    }
    return YES;
}

-(void)cancelClickAtSJIOSShiMingRenZhengView{
    [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissSJIOSShiMingRenZhengView:YES];
}

-(void)sureClickAtSJIOSShiMingRenZhengView{
    if(_nameFiled_SJIOSShiMingRenZhengView.text.length == 0){
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = _numberFiled_SJIOSShiMingRenZhengView.text;
    if (verify.length == 0)
    {
        
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"身份证号码有误"];
        
        return;
    }
    
    SJIOS_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
//                    [self dismissSJIOSShiMingRenZhengView:YES];
                    if([[dictionary objectForKey:@"flag"] boolValue] == NO){
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[dictionary objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //响应事件
                            NSLog(@"action = %@", action);
                            self.callback(@"success");
                            [self dismissSJIOSShiMingRenZhengView:YES];
                        }];
                        [alert addAction:defaultAction];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    }else{
                        self.callback(@"success");
                        [self dismissSJIOSShiMingRenZhengView:YES];
                    }
                }else{
                        [[SJIOSSdkImp sharedInstance] showSJIOSToast:value];
                }
            }else
            {
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:value];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[SJIOSWebInterface sharedInstance] startSJIOSIdentify:self.accessToken_SJIOSShiMingRenZhengView nameSJIOS:_nameFiled_SJIOSShiMingRenZhengView.text identifyNumberSJIOS:_numberFiled_SJIOSShiMingRenZhengView.text successCallbackSJIOS:successCallback failCallbackSJIOS:^(NSError *error) {
        
        
        [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请重新登录帐号"];
        
    }];
}

-(void)backClickAtSJIOSShiMingRenZhengView{
    [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissSJIOSShiMingRenZhengView:YES];
}

-(void)showSJIOSShiMingRenZhengView:(UIView *)view{
    NSLog(@"showSJIOSShiMingRenZhengView");
    self.parentView_SJIOSShiMingRenZhengView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissSJIOSShiMingRenZhengView:(BOOL)animated{
    NSLog(@"dismissSJIOSShiMingRenZhengView");
    [super removeFromSuperview];
}

@end
