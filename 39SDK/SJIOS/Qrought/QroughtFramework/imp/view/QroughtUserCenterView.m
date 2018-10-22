#import <Foundation/Foundation.h>
#import "QroughtUserCenterView.h"
#import "QroughtSdkImp.h"
#import <WebKit/WebKit.h>



@interface QroughtUserCenterView()<UITextFieldDelegate, WKScriptMessageHandler>

@property (nonatomic, assign) Boolean landscape_QroughtUserCenterView;
@property (nonatomic, strong) NSString *accessToken_QroughtUserCenterView;

@property (nonatomic, strong) UIView *parentView_QroughtUserCenterView;
@property (nonatomic, strong) UIView *alterView_QroughtUserCenterView;
@property (nonatomic, strong) WKWebView *asfeve;
@property (nonatomic, strong) UILabel *titleQroughtLabel;

@end

@implementation QroughtUserCenterView
-(id)initQroughtUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken {
    self = [super initWithFrame:CGRectZero];
    self.landscape_QroughtUserCenterView = landscape;
    self.accessToken_QroughtUserCenterView = accessToken;
    
    if(self){
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"QroughtUserCenterView width:%d",width);
        NSLog(@"QroughtUserCenterView height:%d",height);
        
        self.parentView_QroughtUserCenterView = NULL;
        if(self.landscape_QroughtUserCenterView){
            self.alterView_QroughtUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_QroughtUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_bg_landscape.png"]]];
            
            [self addSubview:self.alterView_QroughtUserCenterView];
            [self bringSubviewToFront:self.alterView_QroughtUserCenterView];
            
            [self showQroughtUserCenterView];
        }else{
            self.alterView_QroughtUserCenterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
            self.alterView_QroughtUserCenterView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_shiming_bg_landscape.png"]]];
            [self addSubview:self.alterView_QroughtUserCenterView];
            [self bringSubviewToFront:self.alterView_QroughtUserCenterView];
            [self showQroughtUserCenterView];
        }
    }
    
    return self;
}
//- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
//          landScape:(Boolean)landscape  view:(QroughtUserCenterView*) view ymPhoneNumber:(NSString *)ymPhoneNum
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

    

-(void)showQroughtUserCenterView{
    //back按钮
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 35, 35)];
    UIImage *backImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_back_1.png"]];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [self.alterView_QroughtUserCenterView addSubview:backButton];
    [backButton addTarget:self action:@selector(backClickAtQroughtUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleQroughtLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.alterView_QroughtUserCenterView.frame.size.width-100, 50)];
    self.titleQroughtLabel.contentMode = UIViewContentModeTopLeft;
    self.titleQroughtLabel.numberOfLines = 0;
    self.titleQroughtLabel.font = [UIFont systemFontOfSize:24];
    self.titleQroughtLabel.textColor = [UIColor blackColor];
    [self.titleQroughtLabel setText:@"帐号服务"];
    self.titleQroughtLabel.textAlignment = NSTextAlignmentCenter;
    [self.alterView_QroughtUserCenterView addSubview:self.titleQroughtLabel];
    
    //close按钮
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.alterView_QroughtUserCenterView.frame.size.width-43, 7, 35, 35)];
    UIImage *closeImage = [[UIImage alloc]initWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Qrought.bundle/Qrought_close_1.png"]];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [self.alterView_QroughtUserCenterView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeClickAtQroughtUserCenterView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    [userContentController addScriptMessageHandler:self name:@"startTitle"];
    config.userContentController = userContentController;
    self.asfeve = [[WKWebView alloc] initWithFrame:CGRectMake(0, 50, self.alterView_QroughtUserCenterView.frame.size.width, self.alterView_QroughtUserCenterView.frame.size.height-50) configuration:config];
    [self.asfeve setUserInteractionEnabled:YES];
    self.asfeve.scrollView.bounces = NO;
    self.asfeve.scrollView.backgroundColor=[UIColor grayColor];
    self.asfeve.opaque = NO;

    [self.alterView_QroughtUserCenterView addSubview:self.asfeve];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *usercenter = [NSString stringWithFormat:@"%@?access_token=%@", Qrought_USERCENTER_URL, self.accessToken_QroughtUserCenterView];
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
        [self.titleQroughtLabel setText:dictionary[@"title"]];
        
    }
}

-(void)backClickAtQroughtUserCenterView{
    //[self dismissQroughtUserCenterView:YES];
    [self.asfeve goBack];
}

-(void)closeClickAtQroughtUserCenterView{
    [self dismissQroughtUserCenterView:YES];
}

-(void)showQroughtUserCenterView:(UIView *)view{
    NSLog(@"showQroughtUserCenterView");
    self.parentView_QroughtUserCenterView = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

-(void)dismissQroughtUserCenterView:(BOOL)animated{
    NSLog(@"dismissQroughtUserCenterView");
    [super removeFromSuperview];
}

@end
