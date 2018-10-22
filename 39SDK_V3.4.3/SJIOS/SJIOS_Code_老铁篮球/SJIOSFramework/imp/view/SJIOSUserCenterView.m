#import <Foundation/Foundation.h>
#import "SJIOSUserCenterView.h"
#import "SJIOSSdkImp.h"
#import <WebKit/WebKit.h>



@interface SJIOSUserCenterView()<UITextFieldDelegate, WKScriptMessageHandler>

@property (nonatomic, assign) Boolean landscape_SJIOSUserCenterView;
@property (nonatomic, strong) NSString *accessToken_SJIOSUserCenterView;

@property (nonatomic, strong) UIView *parentView_SJIOSUserCenterView;
@property (nonatomic, strong) UIView *alterView_SJIOSUserCenterView;
@property (nonatomic, strong) WKWebView *asfeve;
@property (nonatomic, strong) UILabel *titleSJIOSLabel;

@end

@implementation SJIOSUserCenterView
-(id)initSJIOSUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken {
    self = [super initWithFrame:CGRectZero];
    self.landscape_SJIOSUserCenterView = landscape;
    self.accessToken_SJIOSUserCenterView = accessToken;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"SJIOSUserCenterView width:%d",width);
        NSLog(@"SJIOSUserCenterView height:%d",height);
        
        self.parentView_SJIOSUserCenterView = NULL;
        if(self.landscape_SJIOSUserCenterView){
            self.alterView_SJIOSUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_SJIOSUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_SJIOSUserCenterView];
            [self bringSubviewToFront:self.alterView_SJIOSUserCenterView];
            
            [self showSJIOSUserCenterView];
        }else{
            self.alterView_SJIOSUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_SJIOSUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_SJIOSUserCenterView];
            [self bringSubviewToFront:self.alterView_SJIOSUserCenterView];
            [self showSJIOSUserCenterView];
        }
    }
    
    return self;
}
//- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
//          landScape:(Boolean)landscape  view:(SJIOSUserCenterView*) view ymPhoneNumber:(NSString *)ymPhoneNum
//
//{
//    if(landscape){
//        //横屏
//        [self landscapeback];
//
//    }else{
//        //竖屏
//
//}

    

-(void)showSJIOSUserCenterView{
    //back按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_back_1.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_SJIOSUserCenterView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtSJIOSUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleSJIOSLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.alterView_SJIOSUserCenterView.frame.size.width-100, 50)];
    self.titleSJIOSLabel.contentMode = UIViewContentModeTopLeft;
    self.titleSJIOSLabel.numberOfLines = 0;
    self.titleSJIOSLabel.font = [UIFont systemFontOfSize:24];
    self.titleSJIOSLabel.textColor = [UIColor blackColor];
    [self.titleSJIOSLabel setText:@"帐号服务"];
    self.titleSJIOSLabel.textAlignment = NSTextAlignmentCenter;
    [self.alterView_SJIOSUserCenterView addSubview:self.titleSJIOSLabel];
    
    //close按钮
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.alterView_SJIOSUserCenterView.frame.size.width-43, 7, 35, 35)];
    UIImage *closeImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"SJIOS.bundle/SJIOS_close_1.png"]];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [self.alterView_SJIOSUserCenterView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeClickAtSJIOSUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    [userContentController addScriptMessageHandler:self name:@"startTitle"];
    config.userContentController = userContentController;
    self.asfeve = [[WKWebView alloc] initWithFrame:CGRectMake(0, 50, self.alterView_SJIOSUserCenterView.frame.size.width, self.alterView_SJIOSUserCenterView.frame.size.height-50) configuration:config];
    [self.asfeve setUserInteractionEnabled:YES];
    self.asfeve.scrollView.bounces = NO;
    self.asfeve.scrollView.backgroundColor=[UIColor grayColor];
    self.asfeve.opaque = NO;

    [self.alterView_SJIOSUserCenterView addSubview:self.asfeve];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *usercenter = [NSString stringWithFormat:@"%@?access_token=%@", SJIOS_USERCENTER_URL, self.accessToken_SJIOSUserCenterView];
    NSString *encodedString = [usercenter stringByAddingPercentEncodingWithAllowedCharacters:set];
    [self.asfeve loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
    
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"startTitle"]) {//截屏保存账号信息
        NSLog(@"WKScriptMessageHandler    startTitle ______________%@", message.body);
        NSError *error = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[message.body dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (dictionary == nil)
        {
            NSLog(@"333");
            return;
        }
        [self.titleSJIOSLabel setText:dictionary[@"title"]];
        
    }
}

-(void)backClickAtSJIOSUserCenterView{
    //[self dismissSJIOSUserCenterView:YES];
    [self.asfeve goBack];
}

-(void)closeClickAtSJIOSUserCenterView{
    [self dismissSJIOSUserCenterView:YES];
}

-(void)showSJIOSUserCenterView:(UIView *)view{
    NSLog(@"showSJIOSUserCenterView");
    self.parentView_SJIOSUserCenterView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissSJIOSUserCenterView:(BOOL)animated{
    NSLog(@"dismissSJIOSUserCenterView");
    [super removeFromSuperview];
}

@end
