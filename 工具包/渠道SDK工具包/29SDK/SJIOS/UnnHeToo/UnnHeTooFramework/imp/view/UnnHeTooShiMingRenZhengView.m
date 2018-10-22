#import <Foundation/Foundation.h>
#import "UnnHeTooShiMingRenZhengView.h"
#import "UnnHeTooSdkImp.h"
#import "UIControl+ZHW.h"
#import "UnnHeTooCommonApi.h"


@interface UnnHeTooShiMingRenZhengView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *parentView_UnnHeTooShiMingRenZhengView;
@property (nonatomic, strong) UIView *alterView_UnnHeTooShiMingRenZhengView;

@property (nonatomic, assign) Boolean landscape_UnnHeTooShiMingRenZhengView;
@property (nonatomic, strong) NSString *accessToken_UnnHeTooShiMingRenZhengView;

@property (nonatomic, strong) UITextField *nameFiled_UnnHeTooShiMingRenZhengView;
@property (nonatomic, strong) UITextField *numberFiled_UnnHeTooShiMingRenZhengView;

@property (nonatomic, strong) UnnHeTooShiMingRenZhengView *ShiMingRenZhengView;

@property(nonatomic, strong) UnnHeToo_COMMON_BLOCK callback;

@end

@implementation UnnHeTooShiMingRenZhengView

-(id)initUnnHeTooShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(UnnHeToo_COMMON_BLOCK)callback{
    self = [super initWithFrame:CGRectZero];
    self.landscape_UnnHeTooShiMingRenZhengView = landscape;
    self.accessToken_UnnHeTooShiMingRenZhengView = accessToken;
    self.callback = callback;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"ShiMingRenZhengView width:%d",width);
        NSLog(@"ShiMingRenZhengView height:%d",height);
        
        self.parentView_UnnHeTooShiMingRenZhengView = NULL;
        if(self.landscape_UnnHeTooShiMingRenZhengView){
            self.alterView_UnnHeTooShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, 450, 250)];
            self.alterView_UnnHeTooShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_background_landscape.png"]]];
            
            [self addSubview:self.alterView_UnnHeTooShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_UnnHeTooShiMingRenZhengView];
            
            [self showLandUnnHeTooShiMingRenZhengView];
        }else{
            self.alterView_UnnHeTooShiMingRenZhengView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, 260, 260)];
            self.alterView_UnnHeTooShiMingRenZhengView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_background_landscape.png"]]];
            [self addSubview:self.alterView_UnnHeTooShiMingRenZhengView];
            [self bringSubviewToFront:self.alterView_UnnHeTooShiMingRenZhengView];
            [self showPortraitUnnHeTooShiMingRenZhengView];
        }
        [self setupUnnHeTooShiMingRenZhengView];
        [self addNotificationUnnHeTooShiMingRenZhengView];
    }
    
    return self;
}

-(void)showLandUnnHeTooShiMingRenZhengView{
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame =  CGRectMake(170, 5, 128, 52);
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:logoView];
    
//    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 5, 128, 52)];
//    TitleLabel.contentMode = UIViewContentModeBottomRight;
//    TitleLabel.font = [UIFont systemFontOfSize:17];
//    [TitleLabel setText:@"实名认证"];
//    TitleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:TitleLabel];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_ym_back.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtUnnHeTooShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 80, 38)];
    nameLabel.contentMode = UIViewContentModeBottomRight;
    nameLabel.font = [UIFont systemFontOfSize:14];
    [nameLabel setText:@"姓名"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:nameLabel];
    
    self.nameFiled_UnnHeTooShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x + nameLabel.frame.size.width, nameLabel.frame.origin.y, 310, 38)];
    self.nameFiled_UnnHeTooShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_register_edit_background.png"]];
    self.nameFiled_UnnHeTooShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_UnnHeTooShiMingRenZhengView.placeholder = @"请输入真实姓名";
    [self.nameFiled_UnnHeTooShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_UnnHeTooShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_UnnHeTooShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_UnnHeTooShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_UnnHeTooShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_UnnHeTooShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_UnnHeTooShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_UnnHeTooShiMingRenZhengView.delegate=self;
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:self.nameFiled_UnnHeTooShiMingRenZhengView];
    
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 80, 38)];
    numberLabel.contentMode = UIViewContentModeBottomRight;
    numberLabel.font = [UIFont systemFontOfSize:14];
    [numberLabel setText:@"身份证号码"];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:numberLabel];
    
    self.numberFiled_UnnHeTooShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(numberLabel.frame.origin.x + numberLabel.frame.size.width, numberLabel.frame.origin.y, 310, 38)];
    self.numberFiled_UnnHeTooShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_register_edit_background.png"]];
    self.numberFiled_UnnHeTooShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_UnnHeTooShiMingRenZhengView.placeholder = @"请输入身份证号码";
    [self.numberFiled_UnnHeTooShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_UnnHeTooShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_UnnHeTooShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_UnnHeTooShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_UnnHeTooShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_UnnHeTooShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_UnnHeTooShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.numberFiled_UnnHeTooShiMingRenZhengView.delegate=self;
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:self.numberFiled_UnnHeTooShiMingRenZhengView];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(160, 180, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_login_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtUnnHeTooShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:sureButton];
}

-(void)showPortraitUnnHeTooShiMingRenZhengView{
    UIImage * logo = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_logo.png"]];
    UIImageView * logoView = [[UIImageView alloc] initWithImage:logo];
    logoView.frame =  CGRectMake(85, 15, 95 , 38);
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:logoView];
    
    //    UILabel *TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 15, 95 , 38)];
    //    TitleLabel.contentMode = UIViewContentModeBottomRight;
    //    TitleLabel.font = [UIFont systemFontOfSize:17];
    //    [TitleLabel setText:@"实名认证"];
    //    TitleLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:TitleLabel];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 20, 20)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_ym_back.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtUnnHeTooShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nameFiled_UnnHeTooShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 60, 200, 38)];
    self.nameFiled_UnnHeTooShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_register_edit_background.png"]];
    self.nameFiled_UnnHeTooShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.nameFiled_UnnHeTooShiMingRenZhengView.placeholder = @"请输入真实姓名";
    [self.nameFiled_UnnHeTooShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.nameFiled_UnnHeTooShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.nameFiled_UnnHeTooShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameFiled_UnnHeTooShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameFiled_UnnHeTooShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameFiled_UnnHeTooShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameFiled_UnnHeTooShiMingRenZhengView.returnKeyType = UIReturnKeyNext;
    self.nameFiled_UnnHeTooShiMingRenZhengView.delegate=self;
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:self.nameFiled_UnnHeTooShiMingRenZhengView];

    
    self.numberFiled_UnnHeTooShiMingRenZhengView = [[UITextField alloc]initWithFrame:CGRectMake(30, 115, 200, 38)];
    self.numberFiled_UnnHeTooShiMingRenZhengView.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_register_edit_background.png"]];
    self.numberFiled_UnnHeTooShiMingRenZhengView.borderStyle = UITextBorderStyleNone;
    self.numberFiled_UnnHeTooShiMingRenZhengView.placeholder = @"请输入身份证号码";
    [self.numberFiled_UnnHeTooShiMingRenZhengView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.numberFiled_UnnHeTooShiMingRenZhengView.font = [UIFont systemFontOfSize:15];
    self.numberFiled_UnnHeTooShiMingRenZhengView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.numberFiled_UnnHeTooShiMingRenZhengView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numberFiled_UnnHeTooShiMingRenZhengView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.numberFiled_UnnHeTooShiMingRenZhengView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numberFiled_UnnHeTooShiMingRenZhengView.returnKeyType = UIReturnKeyDone;
    self.numberFiled_UnnHeTooShiMingRenZhengView.delegate=self;
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:self.numberFiled_UnnHeTooShiMingRenZhengView];
    
    
    UIButton * sureButton=[[UIButton alloc]initWithFrame:CGRectMake(65, 180, 130, 38)];
    UIImage *sureButtonImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_login_button.png"]];
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
    [sureButton addTarget:self action:@selector(sureClickAtUnnHeTooShiMingRenZhengView) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView_UnnHeTooShiMingRenZhengView addSubview:sureButton];
}

-(void)setupUnnHeTooShiMingRenZhengView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.ShiMingRenZhengView addGestureRecognizer:tapGesture];
}

-(void)addNotificationUnnHeTooShiMingRenZhengView{
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
        self.alterView_UnnHeTooShiMingRenZhengView.transform = CGAffineTransformMakeTranslation(0, -65);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;
    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alterView_UnnHeTooShiMingRenZhengView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.nameFiled_UnnHeTooShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_UnnHeTooShiMingRenZhengView resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameFiled_UnnHeTooShiMingRenZhengView resignFirstResponder];
    [self.numberFiled_UnnHeTooShiMingRenZhengView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameFiled_UnnHeTooShiMingRenZhengView)
    {
        [self.numberFiled_UnnHeTooShiMingRenZhengView becomeFirstResponder];
    }
    else if(textField==self.numberFiled_UnnHeTooShiMingRenZhengView)
    {
        [textField resignFirstResponder];
        

        [self sureClickAtUnnHeTooShiMingRenZhengView];
    }
    return YES;
}

-(void)sureClickAtUnnHeTooShiMingRenZhengView{
    if(_nameFiled_UnnHeTooShiMingRenZhengView.text.length == 0){
        [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"请输入姓名"];
        return;
    }
    
    
    NSString* verify = _numberFiled_UnnHeTooShiMingRenZhengView.text;
    if (verify.length == 0)
    {
        
        [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"请输入身份证号码"];
        
        return;
    }
    
    if (verify.length != 18)
    {
        
        [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"身份证号码有误"];
        
        return;
    }
    
    UnnHeToo_VSD_BLOCK completionBlock = ^(NSDictionary *dictionary, NSDictionary *headers) {
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
                    
                    [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"认证成功，请返回"];
                    self.callback(@"success");
                    [self dismissUnnHeTooShiMingRenZhengView:YES];
                }
                
                else{
                    //self.callback(@"认证失败,检查输入信息是否有误");
                    [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"认证失败,检查输入信息是否有误"];
                    
                    
                }
                
            }else if([value isEqualToString:@"invalid_request"]){
                //self.callback(@"身份证信息有误");
                [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"身份证信息有误"];
                return;
            }
            else
            {
                //self.callback([dictionary valueForKey:@"error"]);
                [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:[[UnnHeTooSdkImp sharedInstance] translateUnnHeToo:[dictionary valueForKey:@"error"]]];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[UnnHeTooCommonApi sharedInstance] startUnnHeTooIdentify:self.accessToken_UnnHeTooShiMingRenZhengView name:_nameFiled_UnnHeTooShiMingRenZhengView.text identifyNumber:_numberFiled_UnnHeTooShiMingRenZhengView.text completionBlock:completionBlock failedBlock:^(NSError *error) {
        
        
        [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"请重新登录帐号"];
        
    }];
}

-(void)backClickAtUnnHeTooShiMingRenZhengView{
    [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"请尽快进行实名认证!"];
    self.callback(@"ShiMing cancel");
    [self dismissUnnHeTooShiMingRenZhengView:YES];
}

-(void)showUnnHeTooShiMingRenZhengView:(UIView *)view{
    NSLog(@"showUnnHeTooShiMingRenZhengView");
    self.parentView_UnnHeTooShiMingRenZhengView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissUnnHeTooShiMingRenZhengView:(BOOL)animated{
    NSLog(@"dismissUnnHeTooShiMingRenZhengView");
    [super removeFromSuperview];
}

@end
