

#import <Foundation/Foundation.h>
#import "SJ_ValidateIdentity.h"



@implementation SJ_ValidateIdentity



- (id)initWithBlock:(NSString *)accesstoken complete:(Postin_RV_Complete_Callback)complete landscape:(Boolean)landscape{
    
    if(landscape){
        self = [super initWithSize:CGSizeMake(450, 250) landScape:landscape ];
    }else{
        self = [super initWithSize:CGSizeMake(260, 260) landScape:landscape ];
    }
    
    if (self) {
        self.SHOWPROCESS = false;
        self.complete = complete;
        self.accesstoken = [[NSString alloc] initWithFormat:@"%@", accesstoken];
        
        if(self.landscape){
            [self setLandScapeView];
            [self setupView];
            [self addNotification];
            
        }else{
//            [self setPortraitView];
        }

    }
    return self;
}

//横屏状态下的登录界面
-(void)setLandScapeView{
    
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(160, 20, 166, 68)];
    logoView.image=[UIImage imageNamed:@"Postin.bundle/Postin_logo.png"];
    [self.alertContainer addSubview:logoView];
    
    
    UIButton * close=[[UIButton alloc]initWithFrame:CGRectMake(410, 10, 30, 25)];
    [close setBackgroundImage:[UIImage imageNamed:@"Postin.bundle/Postin_ym_close.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closePostinPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:close];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(70, 60, 310, 38)];
    label.contentMode = UIViewContentModeBottomRight;
    label.font = [UIFont fontWithName:@"Arial" size:14];
    label.textColor = [UIColor redColor];
    label.text = @"您尚未进行实名认证，请填入以下信息进行认证！";
    [self.alertContainer addSubview:label];
    
    
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(70, 88, 310, 38)];
    self.name.borderStyle = UITextBorderStyleNone;
    self.name.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    self.name.placeholder = @"  请输入真实姓名";
    self.name.font = [UIFont systemFontOfSize:16];
    self.name.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.name.autocorrectionType = UITextAutocorrectionTypeNo;
    self.name.textAlignment = UITextAlignmentLeft;
    self.name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.name.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.name.returnKeyType = UIReturnKeyDone;
    
    UIImage * logo_r = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_r.png"]];
    UIImageView * logoRView = [[UIImageView alloc] initWithImage:logo_r];
    logoRView.frame = CGRectMake(8, 6, 25, 25);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [usernameLeftView addSubview:logoRView];
    self.name.leftView = usernameLeftView;
    self.name.leftViewMode = UITextFieldViewModeAlways;
    
    self.name.delegate = self;
    [self.alertContainer addSubview:self.name];
    [self.alertContainer bringSubviewToFront:self.name];
    
    
    
    self.identity = [[UITextField alloc] initWithFrame:CGRectMake(70, 138, 310, 38)];
    self.identity.borderStyle = UITextBorderStyleNone;
    self.identity.background = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_register_edit_background.png"]];
    self.identity.placeholder = @"  请输入真实的身份证号码";
    self.identity.font = [UIFont systemFontOfSize:16];
    self.identity.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.identity.autocorrectionType = UITextAutocorrectionTypeNo;
    self.identity.textAlignment = UITextAlignmentLeft;
    self.identity.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.identity.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.identity.returnKeyType = UIReturnKeyDone;
    self.identity.keyboardType = UIKeyboardTypeNumberPad;//输入数字键盘
    
    UIImage * logo_s = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_logo_s.png"]];
    UIImageView * logoSView = [[UIImageView alloc] initWithImage:logo_s];
    logoSView.frame = CGRectMake(8, 6, 25, 25);
    UIView * passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [passwordLeftView addSubview:logoSView];
    self.identity.leftView = passwordLeftView;
    self.identity.leftViewMode = UITextFieldViewModeAlways;
    
    self.identity.delegate = self;
    [self.alertContainer addSubview:self.identity];
    [self.alertContainer bringSubviewToFront:self.identity];
    
    
    UIButton * comfirm=[[UIButton alloc]initWithFrame:CGRectMake(160, 188, 130, 38)];
    
    UIImage *ymLoginBackImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_login_button.png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [imageView setImage:ymLoginBackImage];
    UILabel *button_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 38)];
    [button_label setText:@"进 行 验 证"];
    [button_label sizeToFit];
    button_label.center = CGPointMake(comfirm.bounds.size.width/2, comfirm.bounds.size.height/2);
    [comfirm addSubview:imageView];
    [comfirm addSubview:button_label];
    [comfirm addTarget:self action:@selector(comfirmPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:comfirm];
    
}




//键盘自动上移====start
-(void)setupView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBackClicked:)];
    [self.sj_ValidateIdentity addGestureRecognizer:tapGesture];
}

-(void)addNotification{
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
        self.alertContainer.transform = CGAffineTransformMakeTranslation(0, -120);
    } completion:nil];
    
}

- (void)onKeyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfoDic = notification.userInfo;

    
    NSTimeInterval duration = [userInfoDic[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //这里是将时间曲线信息(一个64为的无符号整形)转换为UIViewAnimationOptions，要通过左移动16来完成类型转换。
    UIViewAnimationOptions options = [userInfoDic[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue] << 16;
    
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.alertContainer.transform = CGAffineTransformIdentity;
    } completion:nil];
    
}

- (void)onBackClicked:(id)sender {
    [self.name resignFirstResponder];
    [self.identity resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
//键盘自动上移====end

-(void) closePostinPressed{
    self.complete(@"close", @"-1");
    [self dismissWithAnimation:YES];
}

-(void) comfirmPressed{
    
    [self.name resignFirstResponder];//键盘隐藏
    [self.identity resignFirstResponder];//键盘隐藏
    
    if([self.name.text length] == 0){
        [[PostinSdkImp sharedInstance]showPostinToast:@"请输入姓名"];
        return;
    }
    
    if([self.identity.text length] == 0){
        [[PostinSdkImp sharedInstance]showPostinToast:@"请输入身份证号码"];
        return;
    }
    
    if([self.identity.text length] != 18){
        [[PostinSdkImp sharedInstance]showPostinToast:@"身份证号码输入有误"];
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
                    
                    [[PostinSdkImp sharedInstance] showPostinToast:@"认证成功"];
                    self.complete(@"ok", @"1");
                    [self dismissWithAnimation:YES];
                    
                }
                else
                {
                    [[PostinSdkImp sharedInstance] showPostinToast:@"信息有误，认证失败"];

                }
            }
            else
            {
                [[PostinSdkImp sharedInstance] showPostinToast:@"信息有误，认证失败"];
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[PostinWebInterface sharedInstance] startPostinIdentify:self.accesstoken namePostin:[self.name.text stringByReplacingOccurrencesOfString:@" " withString:@""] identifyNumberPostin:[self.identity.text stringByReplacingOccurrencesOfString:@" " withString:@""] successCallbackPostin:successCallback failCallbackPostin:^(NSError *error) {
        
        [self showPostinToast:@"请重新登录帐号"];
        
    }];
    
    
}

-(void)showPostinToast:(NSString *)msg{
    if (self.process == nil) {
        self.process = [[PostinProgressHUD alloc] initWithView:self.alertContainer];
    }
    
    [self.alertContainer addSubview:self.process];
    [self.alertContainer bringSubviewToFront:self.process];
    self.process.labelText = msg;
    [self.process showAnimated:YES whileExecutingBlock:^{
        
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [self.process removeFromSuperview];
    }];
}

-(void)processPostinShow {
    if (self.process == nil) {
        self.process = [[PostinProgressHUD alloc] initWithView:self.alertContainer];
        
    }
    [self.alertContainer addSubview:_process];
    _process.labelText = @"正在验证";
    
    [_process showAnimated:YES whileExecutingBlock:^{
        int count = 0;
        while (self.SHOWPROCESS)
        {
            count ++;
            [NSThread sleepForTimeInterval:1];
            if (count > 60) {
                [[PostinSdkImp sharedInstance] showPostinToast:@"网络不太好，请重试！！！"];
                break;
            }
        }
    } successCallback:^{
        [_process removeFromSuperview];
    }];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.name resignFirstResponder];
    [self.identity resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.name)
    {
        [self.identity becomeFirstResponder];
    }
    else if(textField==self.identity)
    {
        [textField resignFirstResponder];
        
        NSString * name = self.name.text;
        if ([name length] == 0)
        {
            
            [[PostinSdkImp sharedInstance]showPostinToast:@"用户名为空"];
            
            return YES;
        }
        
        NSString * identity = self.identity.text;
        if ([identity length] == 0)
        {
            [[PostinSdkImp sharedInstance]showPostinToast:@"密码为空"];
            
            return YES;
        }
        
        [self comfirmPressed];
    }
    return YES;

}
@end
