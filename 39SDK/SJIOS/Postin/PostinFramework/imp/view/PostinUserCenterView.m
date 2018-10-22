#import <Foundation/Foundation.h>
#import "PostinUserCenterView.h"
#import "PostinSdkImp.h"
#import <WebKit/WebKit.h>



@interface PostinUserCenterView()<UITextFieldDelegate, WKScriptMessageHandler>

@property (nonatomic, assign) Boolean landscape_PostinUserCenterView;
@property (nonatomic, strong) NSString *accessToken_PostinUserCenterView;

@property (nonatomic, strong) UIView *parentView_PostinUserCenterView;
@property (nonatomic, strong) UIView *alterView_PostinUserCenterView;
@property (nonatomic, strong) WKWebView *asfeve;
@property (nonatomic, strong) UILabel *titlePostinLabel;

@end

@implementation PostinUserCenterView
-(id)initPostinUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken {
    self = [super initWithFrame:CGRectZero];
    self.landscape_PostinUserCenterView = landscape;
    self.accessToken_PostinUserCenterView = accessToken;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"PostinUserCenterView width:%d",width);
        NSLog(@"PostinUserCenterView height:%d",height);
        
        self.parentView_PostinUserCenterView = NULL;
        if(self.landscape_PostinUserCenterView){
            self.alterView_PostinUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_PostinUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_PostinUserCenterView];
            [self bringSubviewToFront:self.alterView_PostinUserCenterView];
            
            [self showPostinUserCenterView];
        }else{
            self.alterView_PostinUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_PostinUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_PostinUserCenterView];
            [self bringSubviewToFront:self.alterView_PostinUserCenterView];
            [self showPostinUserCenterView];
        }
    }
    
    return self;
}
//- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
//          landScape:(Boolean)landscape  view:(PostinUserCenterView*) view ymPhoneNumber:(NSString *)ymPhoneNum
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

    

-(void)showPostinUserCenterView{
    //back按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_back_1.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_PostinUserCenterView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtPostinUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    self.titlePostinLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.alterView_PostinUserCenterView.frame.size.width-100, 50)];
    self.titlePostinLabel.contentMode = UIViewContentModeTopLeft;
    self.titlePostinLabel.numberOfLines = 0;
    self.titlePostinLabel.font = [UIFont systemFontOfSize:24];
    self.titlePostinLabel.textColor = [UIColor blackColor];
    [self.titlePostinLabel setText:@"帐号服务"];
    self.titlePostinLabel.textAlignment = NSTextAlignmentCenter;
    [self.alterView_PostinUserCenterView addSubview:self.titlePostinLabel];
    
    //close按钮
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.alterView_PostinUserCenterView.frame.size.width-43, 7, 35, 35)];
    UIImage *closeImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_close_1.png"]];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [self.alterView_PostinUserCenterView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeClickAtPostinUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    [userContentController addScriptMessageHandler:self name:@"startTitle"];
    config.userContentController = userContentController;
    self.asfeve = [[WKWebView alloc] initWithFrame:CGRectMake(0, 50, self.alterView_PostinUserCenterView.frame.size.width, self.alterView_PostinUserCenterView.frame.size.height-50) configuration:config];
    [self.asfeve setUserInteractionEnabled:YES];
    self.asfeve.scrollView.bounces = NO;
    self.asfeve.scrollView.backgroundColor=[UIColor grayColor];
    self.asfeve.opaque = NO;

    [self.alterView_PostinUserCenterView addSubview:self.asfeve];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *usercenter = [NSString stringWithFormat:@"%@?access_token=%@", Postin_USERCENTER_URL, self.accessToken_PostinUserCenterView];
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
        [self.titlePostinLabel setText:dictionary[@"title"]];
        
    }
}

-(void)backClickAtPostinUserCenterView{
    //[self dismissPostinUserCenterView:YES];
    [self.asfeve goBack];
}

-(void)closeClickAtPostinUserCenterView{
    [self dismissPostinUserCenterView:YES];
}

-(void)showPostinUserCenterView:(UIView *)view{
    NSLog(@"showPostinUserCenterView");
    self.parentView_PostinUserCenterView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissPostinUserCenterView:(BOOL)animated{
    NSLog(@"dismissPostinUserCenterView");
    [super removeFromSuperview];
}

@end
