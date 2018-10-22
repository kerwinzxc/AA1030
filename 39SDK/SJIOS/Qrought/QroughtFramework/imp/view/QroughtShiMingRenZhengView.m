#import <Foundation/Foundation.h>
#import "QroughtShiMingRenZhengView.h"
#import "QroughtSdkImp.h"
#import "UIControl+ZHW.h"
#import "QroughtWebInterface.h"


@interface QroughtShiMingRenZhengView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *parentView_QroughtShiMingRenZhengView;
@property (nonatomic, strong) UIView *alterView_QroughtShiMingRenZhengView;

@property (nonatomic, assign) Boolean landscape_QroughtShiMingRenZhengView;
@property (nonatomic, strong) NSString *accessToken_QroughtShiMingRenZhengView;

@property (nonatomic, strong) UITextField *nameFiled_QroughtShiMingRenZhengView;
@property (nonatomic, strong) UITextField *numberFiled_QroughtShiMingRenZhengView;

@property (nonatomic, strong) QroughtShiMingRenZhengView *ShiMingRenZhengView;

@property(nonatomic, strong) Qrought_COMMON_BLOCK callback;

@end

@implementation QroughtShiMingRenZhengView

-(id)initQroughtShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Qrought_COMMON_BLOCK)callback{
    self = [super initWithFrame:CGRectZero];
    self.landscape_QroughtShiMingRenZhengView = landscape;
    self.accessToken_QroughtShiMingRenZhengView = accessToken;
    self.callback = callback;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"ShiMingRenZhengView width:%d",width);
        NSLog(@"ShiMingRenZhengView height:%d",height);
        
        self.parentView_QroughtShiMingRenZhengView = NULL;
        if(self.landscape_QroughtShiMingRenZhengView){
            self.alterView_QroughtShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, 450, 250)];
            self.alterView_QroughtShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_QroughtShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_QroughtShiMingRenZhengView];
            
            [self showLandQroughtShiMingRenZhengView];
        }else{
            self.alterView_QroughtShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, 260, 260)];
            self.alterView_QroughtShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_QroughtShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_QroughtShiMingRenZhengView];
            [self showPortraitQroughtShiMingRenZhengView];
        }
        [self setupQroughtShiMingRenZhengView];
        [self addNotificationQroughtShiMingRenZhengView];
    }
    
    return self;
}

-(void)showLandQroughtShiMingRenZhengView{

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(161, 5, 128, 30)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_QroughtShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(415, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_QroughtShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtQroughtShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_QroughtShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 40, 310, 38)];
    self.nameFiled_QroughtShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_edit_background.png"]];
    self.nameFiled_QroughtShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_QroughtShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_QroughtShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_QroughtShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_QroughtShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_QroughtShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_QroughtShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_QroughtShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_QroughtShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_QroughtShiMingRenZhengView.delegate=self;
    [self.alterView_QroughtShiMingRenZhengView addSubview:self.nameFiled_QroughtShiMingRenZhengView];
    
    
    self.numberFiled_QroughtShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 95, 310, 38)];
    self.numberFiled_QroughtShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_edit_background.png"]];
    self.numberFiled_QroughtShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_QroughtShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_QroughtShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_QroughtShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_QroughtShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_QroughtShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_QroughtShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_QroughtShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_QroughtShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.numberFiled_QroughtShiMingRenZhengView.delegate=self;
    [self.alterView_QroughtShiMingRenZhengView addSubview:self.numberFiled_QroughtShiMingRenZhengView];
    
    NSLog(@"msg = %@", [[[QroughtSdkImp sharedInstance] getQroughtShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(70, 138, 310, 60)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:12];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[QroughtSdkImp sharedInstance] getQroughtShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_QroughtShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 203, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtQroughtShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_QroughtShiMingRenZhengView addSubview:sureButton];
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(260, 203, 130, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtQroughtShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_QroughtShiMingRenZhengView addSubview:cancelBt];
}

-(void)showPortraitQroughtShiMingRenZhengView{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(82, 5, 95 , 38)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_QroughtShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_QroughtShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtQroughtShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_QroughtShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 48, 200, 35)];
    self.nameFiled_QroughtShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_edit_background.png"]];
    self.nameFiled_QroughtShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_QroughtShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_QroughtShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_QroughtShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_QroughtShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_QroughtShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_QroughtShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_QroughtShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_QroughtShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_QroughtShiMingRenZhengView.delegate=self;
    [self.alterView_QroughtShiMingRenZhengView addSubview:self.nameFiled_QroughtShiMingRenZhengView];

    
    self.numberFiled_QroughtShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, 200, 35)];
    self.numberFiled_QroughtShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_edit_background.png"]];
    self.numberFiled_QroughtShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_QroughtShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_QroughtShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_QroughtShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_QroughtShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_QroughtShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_QroughtShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_QroughtShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_QroughtShiMingRenZhengView.returnKeyType = UIReturnKeyDone;
    self.numberFiled_QroughtShiMingRenZhengView.delegate=self;
    [self.alterView_QroughtShiMingRenZhengView addSubview:self.numberFiled_QroughtShiMingRenZhengView];
    
    
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 200, 75)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:10];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[QroughtSdkImp sharedInstance] getQroughtShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_QroughtShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(25, 209, 90, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtQroughtShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_QroughtShiMingRenZhengView addSubview:sureButton];
    
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(145, 209, 90, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtQroughtShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_QroughtShiMingRenZhengView addSubview:cancelBt];
}

-(void)setupQroughtShiMingRenZhengView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ShiMingRenZhengView addGestureRecognizer:tapGesture];
}

-(void)addNotificationQroughtShiMingRenZhengView{
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
        self.alterView_QroughtShiMingRenZhengView.transform = CGAffineTransformMakeTranslation(0, -65);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alterView_QroughtShiMingRenZhengView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.nameFiled_QroughtShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_QroughtShiMingRenZhengView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameFiled_QroughtShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_QroughtShiMingRenZhengView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameFiled_QroughtShiMingRenZhengView)
    {
        [self.numberFiled_QroughtShiMingRenZhengView becomeFirstResponder];
    }
    else if(textField==self.numberFiled_QroughtShiMingRenZhengView)
    {
        [textField resignFirstResponder];
        

        [self sureClickAtQroughtShiMingRenZhengView];
    }
    return YES;
}

-(void)cancelClickAtQroughtShiMingRenZhengView{
    [[QroughtSdkImp sharedInstance] showQroughtToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissQroughtShiMingRenZhengView:YES];
}

-(void)sureClickAtQroughtShiMingRenZhengView{
    if(_nameFiled_QroughtShiMingRenZhengView.text.length == 0){
        [[QroughtSdkImp sharedInstance] showQroughtToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = _numberFiled_QroughtShiMingRenZhengView.text;
    if (verify.length == 0)
    {
        
        [[QroughtSdkImp sharedInstance] showQroughtToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [[QroughtSdkImp sharedInstance] showQroughtToast:@"身份证号码有误"];
        
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
                    
//                    self.callback(@"success");
//                    [self dismissQroughtShiMingRenZhengView:YES];
                    if([[dictionary objectForKey:@"flag"] boolValue] == NO){
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[dictionary objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //响应事件
                            NSLog(@"action = %@", action);
                            self.callback(@"success");
                            [self dismissQroughtShiMingRenZhengView:YES];
                        }];
                        [alert addAction:defaultAction];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    }else{
                        self.callback(@"success");
                        [self dismissQroughtShiMingRenZhengView:YES];
                    }
                }else{
                        [[QroughtSdkImp sharedInstance] showQroughtToast:value];
                }
            }else
            {
                [[QroughtSdkImp sharedInstance] showQroughtToast:value];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[QroughtWebInterface sharedInstance] startQroughtIdentify:self.accessToken_QroughtShiMingRenZhengView nameQrought:_nameFiled_QroughtShiMingRenZhengView.text identifyNumberQrought:_numberFiled_QroughtShiMingRenZhengView.text successCallbackQrought:successCallback failCallbackQrought:^(NSError *error) {
        
        
        [[QroughtSdkImp sharedInstance] showQroughtToast:@"请重新登录帐号"];
        
    }];
}

-(void)backClickAtQroughtShiMingRenZhengView{
    [[QroughtSdkImp sharedInstance] showQroughtToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissQroughtShiMingRenZhengView:YES];
}

-(void)showQroughtShiMingRenZhengView:(UIView *)view{
    NSLog(@"showQroughtShiMingRenZhengView");
    self.parentView_QroughtShiMingRenZhengView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissQroughtShiMingRenZhengView:(BOOL)animated{
    NSLog(@"dismissQroughtShiMingRenZhengView");
    [super removeFromSuperview];
}

@end
