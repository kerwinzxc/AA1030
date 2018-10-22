#import <Foundation/Foundation.h>
#import "RersistenceUserCenterView.h"
#import "RersistenceSdkImp.h"
#import <WebKit/WebKit.h>



@interface RersistenceUserCenterView()<UITextFieldDelegate, WKScriptMessageHandler>

@property (nonatomic, assign) Boolean landscape_RersistenceUserCenterView;
@property (nonatomic, strong) NSString *accessToken_RersistenceUserCenterView;

@property (nonatomic, strong) UIView *parentView_RersistenceUserCenterView;
@property (nonatomic, strong) UIView *alterView_RersistenceUserCenterView;
@property (nonatomic, strong) WKWebView *asfeve;
@property (nonatomic, strong) UILabel *titleRersistenceLabel;

@end

@implementation RersistenceUserCenterView
-(id)initRersistenceUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken {
    self = [super initWithFrame:CGRectZero];
    self.landscape_RersistenceUserCenterView = landscape;
    self.accessToken_RersistenceUserCenterView = accessToken;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"RersistenceUserCenterView width:%d",width);
        NSLog(@"RersistenceUserCenterView height:%d",height);
        
        self.parentView_RersistenceUserCenterView = NULL;
        if(self.landscape_RersistenceUserCenterView){
            self.alterView_RersistenceUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_RersistenceUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_RersistenceUserCenterView];
            [self bringSubviewToFront:self.alterView_RersistenceUserCenterView];
            
            [self showRersistenceUserCenterView];
        }else{
            self.alterView_RersistenceUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_RersistenceUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_RersistenceUserCenterView];
            [self bringSubviewToFront:self.alterView_RersistenceUserCenterView];
            [self showRersistenceUserCenterView];
        }
    }
    
    return self;
}
//- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
//          landScape:(Boolean)landscape  view:(RersistenceUserCenterView*) view ymPhoneNumber:(NSString *)ymPhoneNum
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

    

-(void)showRersistenceUserCenterView{
    //back按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_back_1.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_RersistenceUserCenterView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtRersistenceUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleRersistenceLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.alterView_RersistenceUserCenterView.frame.size.width-100, 50)];
    self.titleRersistenceLabel.contentMode = UIViewContentModeTopLeft;
    self.titleRersistenceLabel.numberOfLines = 0;
    self.titleRersistenceLabel.font = [UIFont systemFontOfSize:24];
    self.titleRersistenceLabel.textColor = [UIColor blackColor];
    [self.titleRersistenceLabel setText:@"帐号服务"];
    self.titleRersistenceLabel.textAlignment = NSTextAlignmentCenter;
    [self.alterView_RersistenceUserCenterView addSubview:self.titleRersistenceLabel];
    
    //close按钮
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.alterView_RersistenceUserCenterView.frame.size.width-43, 7, 35, 35)];
    UIImage *closeImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Rersistence.bundle/Rersistence_close_1.png"]];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [self.alterView_RersistenceUserCenterView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeClickAtRersistenceUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    [userContentController addScriptMessageHandler:self name:@"startTitle"];
    config.userContentController = userContentController;
    self.asfeve = [[WKWebView alloc] initWithFrame:CGRectMake(0, 50, self.alterView_RersistenceUserCenterView.frame.size.width, self.alterView_RersistenceUserCenterView.frame.size.height-50) configuration:config];
    [self.asfeve setUserInteractionEnabled:YES];
    self.asfeve.scrollView.bounces = NO;
    self.asfeve.scrollView.backgroundColor=[UIColor grayColor];
    self.asfeve.opaque = NO;

    [self.alterView_RersistenceUserCenterView addSubview:self.asfeve];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *usercenter = [NSString stringWithFormat:@"%@?access_token=%@", Rersistence_USERCENTER_URL, self.accessToken_RersistenceUserCenterView];
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
        [self.titleRersistenceLabel setText:dictionary[@"title"]];
        
    }
}

-(void)backClickAtRersistenceUserCenterView{
    //[self dismissRersistenceUserCenterView:YES];
    [self.asfeve goBack];
}

-(void)closeClickAtRersistenceUserCenterView{
    [self dismissRersistenceUserCenterView:YES];
}

-(void)showRersistenceUserCenterView:(UIView *)view{
    NSLog(@"showRersistenceUserCenterView");
    self.parentView_RersistenceUserCenterView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissRersistenceUserCenterView:(BOOL)animated{
    NSLog(@"dismissRersistenceUserCenterView");
    [super removeFromSuperview];
}

@end
