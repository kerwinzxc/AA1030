
#import "startOrzOSDKIapProcess.h"

#import <Foundation/Foundation.h>



@implementation startOrzOSDKIapProcess


- (id)initWithSize:(NSDictionary *)param
           iapInfo:(NSString *)iapInfo
                cb:(OrzOSDKXXXCloseCallback)cb
{
    
    self = [super initWithFrame:CGRectZero];

    CGRect rect=[[UIScreen mainScreen] bounds];
    int width = rect.size.width;
    int height = rect.size.height;

    self.parent_RegchargOrzOSDK = NULL;
    self.cb_RegchargOrzOSDK = cb;
    
    
    self.alertView_RegchargOrzOSDK = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    
    [self addSubview:self.alertView_RegchargOrzOSDK];
    [self bringSubviewToFront:self.alertView_RegchargOrzOSDK];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.alertView_RegchargOrzOSDK.frame.size.width , self.alertView_RegchargOrzOSDK.frame.size.height)];
    imageview.image = [UIImage imageNamed:@"OrzOSDK.bundle/OrzOSDK_notice_bg.png"];
    [self.alertView_RegchargOrzOSDK addSubview:imageview];
    
    
    UIImageView *title = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.alertView_RegchargOrzOSDK.frame.size.width , 40)];
    title.image = [UIImage imageNamed:@"OrzOSDK.bundle/OrzOSDK_title.png"];
    [self.alertView_RegchargOrzOSDK addSubview:title];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.alertView_RegchargOrzOSDK.frame.size.width -200)/2, 0 , 200, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel setText:@"游戏中心"];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24.0];
    [self.alertView_RegchargOrzOSDK addSubview:titleLabel];
    
    
    UIButton * close=[[UIButton alloc]initWithFrame:CGRectMake(self.alertView_RegchargOrzOSDK.frame.size.width-32, 7, 25, 25)];
    [close setBackgroundImage:[UIImage imageNamed:@"OrzOSDK.bundle/OrzOSDK_notice_close.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView_RegchargOrzOSDK addSubview:close];
    
    
    
    UIWebView *asfeve = [[UIWebView alloc] initWithFrame:CGRectMake(0, title.frame.size.height, self.alertView_RegchargOrzOSDK.frame.size.width, self.alertView_RegchargOrzOSDK.frame.size.height-title.frame.size.height)];
    [asfeve setUserInteractionEnabled:YES];
    [asfeve setScalesPageToFit:YES];
    [self.alertView_RegchargOrzOSDK addSubview:asfeve];
    asfeve.delegate = self;
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *iapiapiap = [NSString stringWithFormat:@"https://juh%@%@%@%@%@%@%@%@", @"esdk.3", @"975ad.com/W", @"ap/P", @"ay/index/package_id/", [[OrzOSDKUtils getSharedInstance] getOrzOSDKInfoPlist_PackageId], @"/or", @"der/", iapInfo];
    NSString *encodedString = [iapiapiap stringByAddingPercentEncodingWithAllowedCharacters:set];
    [asfeve loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    return self;
}


-(void)closePressed
{
    NSLog(@"closePressed");
    self.cb_RegchargOrzOSDK(@{@"code":@"1",@"msg":@"Regcharg closed"});
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self removeFromSuperview];
}

-(void)show:(UIView *)view
{
    self.parent_RegchargOrzOSDK = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)dismissWithAnimation:(BOOL)animated
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    NSString *className=[[NSString alloc]initWithFormat:@"%s",object_getClassName(self)];
    NSLog(@"className == %@",className);
    [self removeFromSuperview];
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if([[UIApplication sharedApplication] canOpenURL:request.URL.absoluteURL] == true){
        NSLog(@"canopen");
        
    }else{
        NSLog(@"can not open");
        [[UIApplication sharedApplication] openURL:request.URL.absoluteURL];
    }
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}



@end
