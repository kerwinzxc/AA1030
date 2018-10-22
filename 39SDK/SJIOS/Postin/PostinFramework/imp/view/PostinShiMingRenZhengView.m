#import <Foundation/Foundation.h>
#import "PostinShiMingRenZhengView.h"
#import "PostinSdkImp.h"
#import "UIControl+ZHW.h"
#import "PostinWebInterface.h"


@interface PostinShiMingRenZhengView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *parentView_PostinShiMingRenZhengView;
@property (nonatomic, strong) UIView *alterView_PostinShiMingRenZhengView;

@property (nonatomic, assign) Boolean landscape_PostinShiMingRenZhengView;
@property (nonatomic, strong) NSString *accessToken_PostinShiMingRenZhengView;

@property (nonatomic, strong) UITextField *nameFiled_PostinShiMingRenZhengView;
@property (nonatomic, strong) UITextField *numberFiled_PostinShiMingRenZhengView;

@property (nonatomic, strong) PostinShiMingRenZhengView *ShiMingRenZhengView;

@property(nonatomic, strong) Postin_COMMON_BLOCK callback;

@end

@implementation PostinShiMingRenZhengView

-(id)initPostinShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Postin_COMMON_BLOCK)callback{
    self = [super initWithFrame:CGRectZero];
    self.landscape_PostinShiMingRenZhengView = landscape;
    self.accessToken_PostinShiMingRenZhengView = accessToken;
    self.callback = callback;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"ShiMingRenZhengView width:%d",width);
        NSLog(@"ShiMingRenZhengView height:%d",height);
        
        self.parentView_PostinShiMingRenZhengView = NULL;
        if(self.landscape_PostinShiMingRenZhengView){
            self.alterView_PostinShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, 450, 250)];
            self.alterView_PostinShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_PostinShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_PostinShiMingRenZhengView];
            
            [self showLandPostinShiMingRenZhengView];
        }else{
            self.alterView_PostinShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, 260, 260)];
            self.alterView_PostinShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_PostinShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_PostinShiMingRenZhengView];
            [self showPortraitPostinShiMingRenZhengView];
        }
        [self setupPostinShiMingRenZhengView];
        [self addNotificationPostinShiMingRenZhengView];
    }
    
    return self;
}

-(void)showLandPostinShiMingRenZhengView{

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(161, 5, 128, 30)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_PostinShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(415, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_PostinShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtPostinShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_PostinShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 40, 310, 38)];
    self.nameFiled_PostinShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_edit_background.png"]];
    self.nameFiled_PostinShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_PostinShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_PostinShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_PostinShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_PostinShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_PostinShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_PostinShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_PostinShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_PostinShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_PostinShiMingRenZhengView.delegate=self;
    [self.alterView_PostinShiMingRenZhengView addSubview:self.nameFiled_PostinShiMingRenZhengView];
    
    
    self.numberFiled_PostinShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(70, 95, 310, 38)];
    self.numberFiled_PostinShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_edit_background.png"]];
    self.numberFiled_PostinShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_PostinShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_PostinShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_PostinShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_PostinShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_PostinShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_PostinShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_PostinShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_PostinShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.numberFiled_PostinShiMingRenZhengView.delegate=self;
    [self.alterView_PostinShiMingRenZhengView addSubview:self.numberFiled_PostinShiMingRenZhengView];
    
    NSLog(@"msg = %@", [[[PostinSdkImp sharedInstance] getPostinShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(70, 138, 310, 60)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:12];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[PostinSdkImp sharedInstance] getPostinShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_PostinShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(60, 203, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtPostinShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_PostinShiMingRenZhengView addSubview:sureButton];
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(260, 203, 130, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtPostinShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_PostinShiMingRenZhengView addSubview:cancelBt];
}

-(void)showPortraitPostinShiMingRenZhengView{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(82, 5, 95 , 38)];
    title.contentMode = UIViewContentModeBottomRight;
    title.font = [UIFont systemFontOfSize:20];
    [title setText:@"实名认证"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.alterView_PostinShiMingRenZhengView addSubview:title];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 10, 30, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ym_close.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_PostinShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtPostinShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_PostinShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 48, 200, 35)];
    self.nameFiled_PostinShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_edit_background.png"]];
    self.nameFiled_PostinShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_PostinShiMingRenZhengView.placeholder = @"请输入您的真实姓名";
    [self.nameFiled_PostinShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_PostinShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_PostinShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_PostinShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_PostinShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_PostinShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_PostinShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_PostinShiMingRenZhengView.delegate=self;
    [self.alterView_PostinShiMingRenZhengView addSubview:self.nameFiled_PostinShiMingRenZhengView];

    
    self.numberFiled_PostinShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, 200, 35)];
    self.numberFiled_PostinShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_edit_background.png"]];
    self.numberFiled_PostinShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_PostinShiMingRenZhengView.placeholder = @"请输入您的身份证号码";
    [self.numberFiled_PostinShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_PostinShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_PostinShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_PostinShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_PostinShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_PostinShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_PostinShiMingRenZhengView.returnKeyType = UIReturnKeyDone;
    self.numberFiled_PostinShiMingRenZhengView.delegate=self;
    [self.alterView_PostinShiMingRenZhengView addSubview:self.numberFiled_PostinShiMingRenZhengView];
    
    
    UILabel *FcmMsg = [[UILabel alloc]initWithFrame:CGRectMake(30, 130, 200, 75)];
    FcmMsg.contentMode = UIViewContentModeTopLeft;
    FcmMsg.numberOfLines = 0;
    FcmMsg.font = [UIFont systemFontOfSize:10];
    FcmMsg.textColor = [UIColor grayColor];
    [FcmMsg setText:[[[PostinSdkImp sharedInstance] getPostinShiMingRenZhengMsg] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    FcmMsg.textAlignment = NSTextAlignmentLeft;
    [self.alterView_PostinShiMingRenZhengView addSubview:FcmMsg];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(25, 209, 90, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtPostinShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_PostinShiMingRenZhengView addSubview:sureButton];
    
    
    UIButton * cancelBt = [[UIButton alloc]initWithFrame:CGRectMake(145, 209, 90, 38)];
    UIImage *cancelImg = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_button.png"]];
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
    [cancelBt addTarget:self action:@selector(cancelClickAtPostinShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_PostinShiMingRenZhengView addSubview:cancelBt];
}

-(void)setupPostinShiMingRenZhengView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ShiMingRenZhengView addGestureRecognizer:tapGesture];
}

-(void)addNotificationPostinShiMingRenZhengView{
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
        self.alterView_PostinShiMingRenZhengView.transform = CGAffineTransformMakeTranslation(0, -65);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alterView_PostinShiMingRenZhengView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.nameFiled_PostinShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_PostinShiMingRenZhengView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameFiled_PostinShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_PostinShiMingRenZhengView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameFiled_PostinShiMingRenZhengView)
    {
        [self.numberFiled_PostinShiMingRenZhengView becomeFirstResponder];
    }
    else if(textField==self.numberFiled_PostinShiMingRenZhengView)
    {
        [textField resignFirstResponder];
        

        [self sureClickAtPostinShiMingRenZhengView];
    }
    return YES;
}

-(void)cancelClickAtPostinShiMingRenZhengView{
    [[PostinSdkImp sharedInstance] showPostinToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissPostinShiMingRenZhengView:YES];
}

-(void)sureClickAtPostinShiMingRenZhengView{
    if(_nameFiled_PostinShiMingRenZhengView.text.length == 0){
        [[PostinSdkImp sharedInstance] showPostinToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = _numberFiled_PostinShiMingRenZhengView.text;
    if (verify.length == 0)
    {
        
        [[PostinSdkImp sharedInstance] showPostinToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [[PostinSdkImp sharedInstance] showPostinToast:@"身份证号码有误"];
        
        return;
    }
    
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
//                    [self dismissPostinShiMingRenZhengView:YES];
                    if([[dictionary objectForKey:@"flag"] boolValue] == NO){
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"防沉迷提醒" message:[dictionary objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            //响应事件
                            NSLog(@"action = %@", action);
                            self.callback(@"success");
                            [self dismissPostinShiMingRenZhengView:YES];
                        }];
                        [alert addAction:defaultAction];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    }else{
                        self.callback(@"success");
                        [self dismissPostinShiMingRenZhengView:YES];
                    }
                }else{
                        [[PostinSdkImp sharedInstance] showPostinToast:value];
                }
            }else
            {
                [[PostinSdkImp sharedInstance] showPostinToast:value];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[PostinWebInterface sharedInstance] startPostinIdentify:self.accessToken_PostinShiMingRenZhengView namePostin:_nameFiled_PostinShiMingRenZhengView.text identifyNumberPostin:_numberFiled_PostinShiMingRenZhengView.text successCallbackPostin:successCallback failCallbackPostin:^(NSError *error) {
        
        
        [[PostinSdkImp sharedInstance] showPostinToast:@"请重新登录帐号"];
        
    }];
}

-(void)backClickAtPostinShiMingRenZhengView{
    [[PostinSdkImp sharedInstance] showPostinToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissPostinShiMingRenZhengView:YES];
}

-(void)showPostinShiMingRenZhengView:(UIView *)view{
    NSLog(@"showPostinShiMingRenZhengView");
    self.parentView_PostinShiMingRenZhengView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissPostinShiMingRenZhengView:(BOOL)animated{
    NSLog(@"dismissPostinShiMingRenZhengView");
    [super removeFromSuperview];
}

@end
