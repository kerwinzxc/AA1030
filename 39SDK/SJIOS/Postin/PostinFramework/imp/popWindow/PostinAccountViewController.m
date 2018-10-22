
#import "PostinAccountViewController.h"
#import "PostinBindIdentifyViewController.h"
#import "PostinBindPhoneViewController.h"
#import "PostinChangePasswordViewController.h"
#import "PostinProgressHUD.h"
#import "PostinNavViewController.h"
#import "PostinDataBase.h"
#import "PostinSdkImp.h"
#import "PostinWebInterface.h"
#import "PostinSdkImp.h"
#import "PostinBindEmailViewController.h"
@interface PostinAccountViewController ()

@property (strong, nonatomic) PostinBindEmailViewController * PostinBindEmailViewController;
@property (strong, nonatomic) PostinBindPhoneViewController * PostinBindPhoneViewController;
@property (strong, nonatomic) PostinBindIdentifyViewController * PostinBindIdentifyViewController;
@property (strong, nonatomic) PostinNavViewController *bindPhoneNavViewController;
@property (strong, nonatomic) PostinNavViewController *bindIdentifyNavViewController;
@property (strong, nonatomic) PostinChangePasswordViewController *changePasswordController;
@property (strong, nonatomic) PostinNavViewController *changePasswordNavController;
@property (strong, nonatomic) PostinNavViewController  *bindEmailNavController;
@property (strong, nonatomic) PostinProgressHUD *process;

@property (nonatomic, strong) UILabel *bangding_lable;
@property (nonatomic, strong) UILabel *email_lable;
@property (nonatomic, strong) UILabel *identity_lable;

@end

@implementation PostinAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

            }
    return self;
}

-(id)initWithLandscape:(Boolean)landscape
{
    self = [super init];
    if (self) {
        self.landscape = landscape;
        
        CGRect mainRect = [[UIScreen mainScreen]bounds];
        if (ios8) {
            
        }else{
             if (self.landscape == true) {
            mainRect = CGRectMake(mainRect.origin.x, mainRect.origin.y, mainRect.size.height, mainRect.size.width);
        }
        }
       
        UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(20, 85, mainRect.size.width - 40, mainRect.size.height-95)];
        
       
        subView.backgroundColor = [UIColor whiteColor];
        
        NSArray *data=[[[[PostinDataBase alloc]init] getTestList] sortedArrayUsingComparator:^NSComparisonResult(PostinUserInfo *obj1, PostinUserInfo  *obj2) {
            return [obj2.loginTime compare:obj1.loginTime];
        }];
        PostinUserInfo *userinfo=[data objectAtIndex:0];
        
       
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height)];
        
        [subView addSubview:self.scrollView];
        
        
         //修改密码
        UIView *changePasswordContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, subView.frame.size.width, 40)];
        changePasswordContainer.layer.cornerRadius = 4;
        changePasswordContainer.backgroundColor = [UIColor colorWithRed:0.1294 green:0.5294 blue:0.8588 alpha:1.0];
        changePasswordContainer.userInteractionEnabled = YES;
        UITapGestureRecognizer *changePasswordGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToChangePassword)];
        [changePasswordContainer addGestureRecognizer:changePasswordGesture];
        
        UIImageView *changePasswordImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 82, 22)];
        [changePasswordImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_menu_change.png"]]];
        [changePasswordContainer addSubview:changePasswordImage];
   
        
        
       
       UIImageView *navImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(changePasswordContainer.frame.size.width - 30, 10, 20, 20)];
        navImageView1.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_down.png"]];
        [changePasswordContainer addSubview:navImageView1];
        UIView *bindContainer;
        if([userinfo.tourist isEqualToString:@"1"]&&[userinfo.bind isEqualToString:@"0"]){
             bindContainer = [[UIView alloc]initWithFrame:CGRectMake(0,0, subView.frame.size.width, 40)];
        }else{
            [self.scrollView addSubview:changePasswordContainer];
            bindContainer = [[UIView alloc]initWithFrame:CGRectMake(0,changePasswordContainer.frame.size.height+30, subView.frame.size.width, 40)];
        }
       
	//绑定手机
        bindContainer.backgroundColor = [UIColor colorWithRed:0.1294 green:0.5294 blue:0.8588 alpha:1.0];
        bindContainer.layer.cornerRadius = 4;
        bindContainer.userInteractionEnabled = YES;
        [self.scrollView addSubview:bindContainer];
        UITapGestureRecognizer *bindGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToBind)];
        [bindContainer addGestureRecognizer:bindGesture];
        
        UIImageView *bindImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 82, 22)];
        [bindImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_menu_bang.png"]]];
        [bindContainer addSubview:bindImage];
        
        self.bangding_lable = [[UILabel alloc]initWithFrame:CGRectMake(120, 9, 68, 22)];
        self.bangding_lable.contentMode = UIViewContentModeBottomRight;
        self.bangding_lable.font = [UIFont systemFontOfSize:12];
        self.bangding_lable.textColor = [UIColor redColor];
        [self.bangding_lable setText:@"未绑定"];
        self.bangding_lable.textAlignment = NSTextAlignmentCenter;
        [bindContainer addSubview:self.bangding_lable];
        
        
        UIImageView *navImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(bindContainer.frame.size.width - 30, 10, 20, 20)];
        navImageView2.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_down.png"]];
        [bindContainer addSubview:navImageView2];
        [self.view addSubview:subView];
        
        //绑定邮箱
        UIView *emailContainer = [[UIView alloc]initWithFrame:CGRectMake(0,bindContainer.frame.origin.y+ bindContainer.frame.size.height+30, subView.frame.size.width, 40)];
        emailContainer.layer.cornerRadius = 4;
        emailContainer.backgroundColor = [UIColor colorWithRed:0.1294 green:0.5294 blue:0.8588 alpha:1.0];
        emailContainer.userInteractionEnabled = YES;
        [self.scrollView addSubview:emailContainer];
        
        UITapGestureRecognizer *emailGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToEmail)];
        [emailContainer addGestureRecognizer:emailGesture];
        
        UIImageView *emailImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9,82, 22)];
        [emailImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_menu_email.png"]]];
        [emailContainer addSubview:emailImage];
        
        self.email_lable = [[UILabel alloc]initWithFrame:CGRectMake(120, 9, 68, 22)];
        self.email_lable.contentMode = UIViewContentModeBottomRight;
        self.email_lable.font = [UIFont systemFontOfSize:12];
        self.email_lable.textColor = [UIColor redColor];
        [self.email_lable setText:@"未绑定"];
        self.email_lable.textAlignment = NSTextAlignmentCenter;
        [emailContainer addSubview:self.email_lable];
        
        UIImageView *nav1ImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(bindContainer.frame.size.width - 30, 10, 20, 20)];
        nav1ImageView2.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_down.png"]];
        [emailContainer addSubview:nav1ImageView2];
        


        //实名认证
        UIView *identifyContainer = [[UIView alloc]initWithFrame:CGRectMake(0,emailContainer.frame.origin.y+ emailContainer.frame.size.height+30, subView.frame.size.width, 40)];
        identifyContainer.layer.cornerRadius = 4;
        identifyContainer.backgroundColor = [UIColor colorWithRed:0.1294 green:0.5294 blue:0.8588 alpha:1.0];
        identifyContainer.userInteractionEnabled = YES;
        [self.scrollView addSubview:identifyContainer];
        
        UITapGestureRecognizer *identifyGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToIdentify)];
        [identifyContainer addGestureRecognizer:identifyGesture];
        
        UIImageView *identifyImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9,82, 22)];
        [identifyImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_menu_shiming.png"]]];
        [identifyContainer addSubview:identifyImage];
        
        self.identity_lable = [[UILabel alloc]initWithFrame:CGRectMake(120, 9, 68, 22)];
        self.identity_lable.contentMode = UIViewContentModeBottomRight;
        self.identity_lable.font = [UIFont systemFontOfSize:12];
        self.identity_lable.textColor = [UIColor redColor];
        [self.identity_lable setText:@"未认证"];
        self.identity_lable.textAlignment = NSTextAlignmentCenter;
        [identifyContainer addSubview:self.identity_lable];
        
        
        UIImageView *nav2ImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(emailContainer.frame.size.width - 30, 10, 20, 20)];
        nav2ImageView2.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_ac_down.png"]];
        [identifyContainer addSubview:nav2ImageView2];
        
        self.scrollView.contentSize = CGSizeMake(subView.frame.size.width, identifyContainer.frame.origin.y+ identifyContainer.frame.size.height);
        
        [self loadingData];
    }
    return self;
}

-(void)loadingData{
    
    

    NSString *tokenDicPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *token = [tokenDicPath stringByAppendingPathComponent:@"token.plist"];
    NSDictionary *tokenDic = [NSDictionary dictionaryWithContentsOfFile:token];
    if(tokenDic == nil){
        [[PostinSdkImp sharedInstance]showPostinToast:@"Token错误" ];
        
    }else{
        self.accessToken = [[NSString alloc] initWithFormat:@"%@", [tokenDic valueForKey:@"ACCESS_TOKEN"]];
        
    }
    
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([ok isEqualToString:@"1"])
                {
                    self.bangding_lable.textColor = [UIColor whiteColor];
                    [self.bangding_lable setText:@"已绑定"];
                }
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    [[PostinWebInterface sharedInstance] checkPostinPhone:self.accessToken successCallbackPostin:successCallback failCallbackPostin:^(NSError *code) {
        [self showPostinToast:@"请重新登录帐号"];
    }];
    
    
    
    
    Postin_VSD_BLOCK successCallback1 = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([ok isEqualToString:@"1"])
                {
                    self.email_lable.textColor = [UIColor whiteColor];
                    [self.email_lable setText:@"已绑定"];
                    
                }
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    
    [[PostinWebInterface sharedInstance] checkPostinMail:self.accessToken successCallbackPostin:successCallback1 failCallbackPostin:^(NSError *code) {
        [self showPostinToast:@"请重新登录帐号"];
        
    }];
    
    
    Postin_VSD_BLOCK successCallback2 = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {

            if (dictionary == nil)
            {
                return;
            }
            
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([ok isEqualToString:@"1"])
                {
                    self.identity_lable.textColor = [UIColor whiteColor];
                    [self.identity_lable setText:@"已认证"];
                }
            }
        }
        @catch(NSException * e)
        {
            
        }
        @finally
        {
            
        }
    };
    [[PostinWebInterface sharedInstance] checkPostinIdentify:self.accessToken successCallbackPostin:successCallback2 failCallbackPostin:^(NSError *code) {
        
        
        [self showPostinToast:@"请重新登录帐号"];
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageIndex = 1;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.delegate showPage:self.pageIndex];
}

-(void)goToBind {
    
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([ok isEqualToString:@"1"])
                {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
                    
                    self.process.labelText = @"已经绑定过手机";
                    self.process.mode = PostinProgressHUDModeCustomView;
                    self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                    [self.process showAnimated:YES whileExecutingBlock:^{
                        sleep(2);
                    } successCallback:^{
                        [self.process removeFromSuperview];
                    }];
                }
                else
                {
                    if (self.PostinBindPhoneViewController == nil) {
                        self.PostinBindPhoneViewController = [[PostinBindPhoneViewController alloc]initWithLandscape:self.landscape];
                        self.bindPhoneNavViewController = [[PostinNavViewController alloc]initWithRootViewController:self.PostinBindPhoneViewController];
                        
                    }
                    self.PostinBindPhoneViewController.accessToken = self.accessToken;
                    [self presentViewController:self.bindPhoneNavViewController animated:YES completion:^{
                        
                    }];
                    
                }
            }
            else
            {
                if (self.process == nil) {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
                }
                
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                self.process.labelText = [[PostinSdkImp sharedInstance] translatePostin:[dictionary valueForKey:@"error"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    
                    [NSThread sleepForTimeInterval:1];
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
    
    
    
    
    [[PostinWebInterface sharedInstance] checkPostinPhone:self.accessToken successCallbackPostin:successCallback failCallbackPostin:^(NSError *code) {
        
        
                if (self.process == nil) {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
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
-(void)goToEmail
{
    
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([ok isEqualToString:@"1"])
                {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
                    
                    self.process.labelText = @"已经绑定过邮箱";
                    self.process.mode = PostinProgressHUDModeCustomView;
                    self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                    [self.process showAnimated:YES whileExecutingBlock:^{
                        sleep(2);
                    } successCallback:^{
                        [self.process removeFromSuperview];
                    }];
                }
                else
                {
                    if (self.PostinBindEmailViewController == nil) {
                        self.PostinBindEmailViewController = [[PostinBindEmailViewController alloc]initWithLandscape:self.landscape];
                        self.bindEmailNavController = [[PostinNavViewController alloc]initWithRootViewController:self.PostinBindEmailViewController];
                        
                    }
                    self.PostinBindEmailViewController.accessToken = self.accessToken;
                    [self presentViewController:self.bindEmailNavController animated:YES completion:^{
                        
                    }];
                }
            }
            else
            {
                if (self.process == nil) {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
                }
                
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                self.process.labelText = [[PostinSdkImp sharedInstance] translatePostin:[dictionary valueForKey:@"error"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    
                    [NSThread sleepForTimeInterval:1];
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
    
    
    
    
    [[PostinWebInterface sharedInstance] checkPostinMail:self.accessToken successCallbackPostin:successCallback failCallbackPostin:^(NSError *code) {
        

                if (self.process == nil) {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
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

-(void)goToIdentify{
    Postin_VSD_BLOCK successCallback = ^(NSDictionary *dictionary, NSDictionary *headers) {
        @try
        {
            if (dictionary == nil)
            {
                return;
            }
            
            
            NSString *value = [dictionary objectForKey:@"error"];
            if ((NSNull *)value == nil)
            {
                NSString *ok = [[NSString alloc]initWithFormat:@"%@",[dictionary objectForKey:@"ok"]];
                if ([ok isEqualToString:@"1"])
                {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.process];
                    [self.view bringSubviewToFront:self.process];
                    
                    self.process.labelText = @"已认证";
                    self.process.mode = PostinProgressHUDModeCustomView;
                    self.process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
                    [self.process showAnimated:YES whileExecutingBlock:^{
                        sleep(2);
                    } successCallback:^{
                        [self.process removeFromSuperview];
                    }];
                }
                else
                {
                    if (self.PostinBindIdentifyViewController == nil) {
                        self.PostinBindIdentifyViewController = [[PostinBindIdentifyViewController alloc]initWithLandscape:self.landscape];
                        self.bindIdentifyNavViewController = [[PostinNavViewController alloc]initWithRootViewController:self.PostinBindIdentifyViewController];
                        
                    }
                    self.PostinBindIdentifyViewController.accessToken = self.accessToken;
                    [self presentViewController:self.bindIdentifyNavViewController animated:YES completion:^{
                        
                    }];
                }
            }
            else
            {
                if (self.process == nil) {
                    self.process = [[PostinProgressHUD alloc] initWithView:self.view];
                }
                
                [self.view addSubview:self.process];
                [self.view bringSubviewToFront:self.process];
                self.process.labelText = [[PostinSdkImp sharedInstance] translatePostin:[dictionary valueForKey:@"error"]];
                [self.process showAnimated:YES whileExecutingBlock:^{
                    
                    [NSThread sleepForTimeInterval:1];
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
    [[PostinWebInterface sharedInstance] checkPostinIdentify:self.accessToken successCallbackPostin:successCallback failCallbackPostin:^(NSError *code) {
        
        
        [self showPostinToast:@"请重新登录帐号"];
    }];
}


-(void)showPostinToast:(NSString *)msg{
    if (self.process == nil) {
        self.process = [[PostinProgressHUD alloc] initWithView:self.view];
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


-(void)goToChangePassword {
    if (self.changePasswordController == nil) {
        self.changePasswordController = [[PostinChangePasswordViewController alloc]initWithLandscape:self.landscape];
        self.changePasswordNavController = [[PostinNavViewController alloc]initWithRootViewController:self.changePasswordController];
    }
    self.changePasswordController.accessToken = self.accessToken;
    [self presentViewController:self.changePasswordNavController animated:YES completion:^{
        
    }];
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
    
}

@end
