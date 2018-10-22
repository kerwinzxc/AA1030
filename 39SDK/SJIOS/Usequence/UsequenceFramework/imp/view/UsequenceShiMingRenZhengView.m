#import <Foundation/Foundation.h>
#import "UsequenceShiMingRenZhengView.h"
#import "UsequenceSdkImp.h"
#import "UIControl+ZHW.h"
#import "UsequenceWebInterface.h"


@interface UsequenceShiMingRenZhengView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *parentView_UsequenceShiMingRenZhengView;
@property (nonatomic, strong) UIView *alterView_UsequenceShiMingRenZhengView;

@property (nonatomic, assign) Boolean landscape_UsequenceShiMingRenZhengView;
@property (nonatomic, strong) NSString *accessToken_UsequenceShiMingRenZhengView;

@property (nonatomic, strong) UITextField *nameFiled_UsequenceShiMingRenZhengView;
@property (nonatomic, strong) UITextField *numberFiled_UsequenceShiMingRenZhengView;

@property (nonatomic, strong) UsequenceShiMingRenZhengView *ShiMingRenZhengView;

@property(nonatomic, strong) Usequence_COMMON_BLOCK callback;

@end

@implementation UsequenceShiMingRenZhengView

-(id)initUsequenceShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Usequence_COMMON_BLOCK)callback{
    self = [super initWithFrame:CGRectZero];
    self.landscape_UsequenceShiMingRenZhengView = landscape;
    self.accessToken_UsequenceShiMingRenZhengView = accessToken;
    self.callback = callback;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"ShiMingRenZhengView width:%d",width);
        NSLog(@"ShiMingRenZhengView height:%d",height);
        
        self.parentView_UsequenceShiMingRenZhengView = NULL;
        if(self.landscape_UsequenceShiMingRenZhengView){
            self.alterView_UsequenceShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, 450, 250)];
            self.alterView_UsequenceShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_UsequenceShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_UsequenceShiMingRenZhengView];
            
            [self showLandUsequenceShiMingRenZhengView];
        }else{
            self.alterView_UsequenceShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, 260, 260)];
            self.alterView_UsequenceShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_UsequenceShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_UsequenceShiMingRenZhengView];
            [self showPortraitUsequenceShiMingRenZhengView];
        }
        [self setupUsequenceShiMingRenZhengView];
        [self addNotificationUsequenceShiMingRenZhengView];
    }
    
    return self;
}

-(void)showLandUsequenceShiMingRenZhengView{

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(161, 5, 128, 30)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(415, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_UsequenceShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtUsequenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_UsequenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 40, 310, 38)];
    self.nameFiled_UsequenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_edit_background.png"]];
    self.nameFiled_UsequenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_UsequenceShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_UsequenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_UsequenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_UsequenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_UsequenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_UsequenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_UsequenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_UsequenceShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_UsequenceShiMingRenZhengView.delegate=self;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:self.nameFiled_UsequenceShiMingRenZhengView];
    
    
    self.numberFiled_UsequenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 95, 310, 38)];
    self.numberFiled_UsequenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_edit_background.png"]];
    self.numberFiled_UsequenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_UsequenceShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_UsequenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_UsequenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_UsequenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_UsequenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_UsequenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_UsequenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_UsequenceShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.numberFiled_UsequenceShiMingRenZhengView.delegate=self;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:self.numberFiled_UsequenceShiMingRenZhengView];
    
    NSLog(@"msg = %@", [[[UsequenceSdkImp sharedInstance] getUsequenceShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(70, 138, 310, 60)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:12];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[UsequenceSdkImp sharedInstance] getUsequenceShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 203, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtUsequenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_UsequenceShiMingRenZhengView addSubview:sureButton];
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(260, 203, 130, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtUsequenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_UsequenceShiMingRenZhengView addSubview:cancelBt];
}

-(void)showPortraitUsequenceShiMingRenZhengView{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(82, 5, 95 , 38)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_UsequenceShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtUsequenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_UsequenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 48, 200, 35)];
    self.nameFiled_UsequenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_edit_background.png"]];
    self.nameFiled_UsequenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_UsequenceShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_UsequenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_UsequenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_UsequenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_UsequenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_UsequenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_UsequenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_UsequenceShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_UsequenceShiMingRenZhengView.delegate=self;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:self.nameFiled_UsequenceShiMingRenZhengView];

    
    self.numberFiled_UsequenceShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, 200, 35)];
    self.numberFiled_UsequenceShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_edit_background.png"]];
    self.numberFiled_UsequenceShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_UsequenceShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_UsequenceShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_UsequenceShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_UsequenceShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_UsequenceShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_UsequenceShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_UsequenceShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_UsequenceShiMingRenZhengView.returnKeyType = UIReturnKeyDone;
    self.numberFiled_UsequenceShiMingRenZhengView.delegate=self;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:self.numberFiled_UsequenceShiMingRenZhengView];
    
    
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 200, 75)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:10];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[UsequenceSdkImp sharedInstance] getUsequenceShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_UsequenceShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(25, 209, 90, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtUsequenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_UsequenceShiMingRenZhengView addSubview:sureButton];
    
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(145, 209, 90, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtUsequenceShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_UsequenceShiMingRenZhengView addSubview:cancelBt];
}

-(void)setupUsequenceShiMingRenZhengView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ShiMingRenZhengView addGestureRecognizer:tapGesture];
}

-(void)addNotificationUsequenceShiMingRenZhengView{
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
        self.alterView_UsequenceShiMingRenZhengView.transform = CGAffineTransformMakeTranslation(0, -65);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alterView_UsequenceShiMingRenZhengView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.nameFiled_UsequenceShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_UsequenceShiMingRenZhengView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameFiled_UsequenceShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_UsequenceShiMingRenZhengView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameFiled_UsequenceShiMingRenZhengView)
    {
        [self.numberFiled_UsequenceShiMingRenZhengView becomeFirstResponder];
    }
    else if(textField==self.numberFiled_UsequenceShiMingRenZhengView)
    {
        [textField resignFirstResponder];
        

        [self sureClickAtUsequenceShiMingRenZhengView];
    }
    return YES;
}

-(void)cancelClickAtUsequenceShiMingRenZhengView{
    [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissUsequenceShiMingRenZhengView:YES];
}

-(void)sureClickAtUsequenceShiMingRenZhengView{
    if(_nameFiled_UsequenceShiMingRenZhengView.text.length == 0){
        [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = _numberFiled_UsequenceShiMingRenZhengView.text;
    if (verify.length == 0)
    {
        
        [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"身份证号码有误"];
        
        return;
    }
    
    Usequence_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
//                    [self dismissUsequenceShiMingRenZhengView:YES];
                    if([[dictionary objectForKey:@"flag"] boolValue] == NO){
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[dictionary objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //响应事件
                            NSLog(@"action = %@", action);
                            self.callback(@"success");
                            [self dismissUsequenceShiMingRenZhengView:YES];
                        }];
                        [alert addAction:defaultAction];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    }else{
                        self.callback(@"success");
                        [self dismissUsequenceShiMingRenZhengView:YES];
                    }
                }else{
                        [[UsequenceSdkImp sharedInstance] showUsequenceToast:value];
                }
            }else
            {
                [[UsequenceSdkImp sharedInstance] showUsequenceToast:value];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[UsequenceWebInterface sharedInstance] startUsequenceIdentify:self.accessToken_UsequenceShiMingRenZhengView nameUsequence:_nameFiled_UsequenceShiMingRenZhengView.text identifyNumberUsequence:_numberFiled_UsequenceShiMingRenZhengView.text successCallbackUsequence:successCallback failCallbackUsequence:^(NSError *error) {
        
        
        [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"请重新登录帐号"];
        
    }];
}

-(void)backClickAtUsequenceShiMingRenZhengView{
    [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissUsequenceShiMingRenZhengView:YES];
}

-(void)showUsequenceShiMingRenZhengView:(UIView *)view{
    NSLog(@"showUsequenceShiMingRenZhengView");
    self.parentView_UsequenceShiMingRenZhengView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissUsequenceShiMingRenZhengView:(BOOL)animated{
    NSLog(@"dismissUsequenceShiMingRenZhengView");
    [super removeFromSuperview];
}

@end
