

#import "UnnHeTooPopwidowViewController.h"
#import "UnnHeTooSettingViewController.h"
#import "UnnHeTooNavViewController.h"

#define WIDTH self.popOverWindow.frame.size.width
#define HEIGHT self.popOverWindow.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define degreesTo(x) (M_PI * (x) / 180.0)
@interface UnnHeTooPopwidowViewController ()
@property (nonatomic) int show;
@property (nonatomic, strong)UIWindow *popOverWindow;
@property (nonatomic, strong)UIViewController *fromViewController;
@property (nonatomic, strong)UnnHeTooSettingViewController *destionController;
@property (nonatomic, strong)UnnHeTooNavViewController *destionNavController;
@property (assign,nonatomic)id<UnnHeTooShowController> delegate;
@end

@implementation UnnHeTooPopwidowViewController
-(id)initWithUnnHeTooPopWindow:(UIWindow *) window{
    self=[super init];
    if (self) {
        self.popOverWindow=window;
        CGRect frame = self.view.frame;
        if ( [[UIDevice currentDevice].systemVersion floatValue] >6.0){
            frame.origin.y = 20;
            frame.size.height = self.view.frame.size.height - 20;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        } else {
            frame.origin.x = 0;
        }
        self.view.frame = frame;
    }
    return self;
}
-(void)setPopView{
    self.floatButton = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIImage *floatImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_company_logo.png"]];
    self.floatButton.image = floatImage;
    self.floatButton.userInteractionEnabled = YES;
    [self.view addSubview:self.floatButton];
    self.ButtonBackground = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 95, 50)];
    UIImage *backImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_float_background.png"]] ;
    UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 50)];
    backgroundImage.image = backImage;
    backgroundImage.backgroundColor = [UIColor clearColor];
    [self.ButtonBackground addSubview:backgroundImage];
    self.ButtonBackground.userInteractionEnabled = YES;
    [self.view addSubview:self.ButtonBackground];
    
    self.serviceButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 47, 47)];
    
    UIImage *normalServiceImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_icon_ser.png"]] ;
    UIImage *pressedServiceImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_icon_ser_cl.png"]] ;
    [self.serviceButton setImage:normalServiceImage forState:UIControlStateNormal];
    [self.serviceButton setImage:pressedServiceImage forState:UIControlStateHighlighted];
    [self.ButtonBackground addSubview:self.serviceButton];
    
    [self.serviceButton addTarget:self action:@selector(serviceClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.accountButton = [[UIButton alloc]initWithFrame:CGRectMake(57, 0, 47, 47)];
    UIImage *normalAccountImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_icon_ac.png"]] ;
    UIImage *pressedAccountImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_icon_ac_cl.png"]] ;
    [self.accountButton setImage:normalAccountImage forState:UIControlStateNormal];
    [self.accountButton setImage:pressedAccountImage forState:UIControlStateHighlighted];
    [self.accountButton addTarget:self action:@selector(accountClick) forControlEvents:UIControlEventTouchUpInside];
    self.show = 0;
    self.ButtonBackground.hidden = YES;
    [self.ButtonBackground addSubview:self.accountButton];

}


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<UnnHeTooShowController>)delegate
{
    self.fromViewController=viewController;
    self.landscape=isLandspace;
    self.delegate=delegate;
    self.accessToken=accessToken;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (BOOL)prefersStatusBarHidden
{
    return YES;

}


-(void)serviceClick {
    if (self.fromViewController == nil) {
        NSLog(@"请初始化ViewController信息");
    }
    else {
        if (self.destionController == nil) {
            self.destionController = [[UnnHeTooSettingViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:NULL];
            self.destionNavController = [[UnnHeTooNavViewController alloc]initWithRootViewController:self.destionController];
            self.destionController.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            self.destionController.myDelegate = self.delegate;
            
            
        }
        
        self.destionController.landscape = self.landscape;
        self.destionController.accessToken = self.accessToken;
        self.destionController.pageIndex = 0;
        [self.delegate showController];
        [self.fromViewController presentViewController:self.destionNavController animated:YES completion:^{
        }];
    }
}

-(void)accountClick {
    if (self.fromViewController == nil) {
        NSLog(@"请初始化ViewController信息");
    }
    else {
        if (self.destionController == nil) {
            self.destionController = [[UnnHeTooSettingViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:NULL];
            self.destionNavController = [[UnnHeTooNavViewController alloc]initWithRootViewController:self.destionController];
            self.destionController.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            self.destionController.myDelegate = self.delegate;
            
        }
        
        self.destionController.landscape = self.landscape;
        self.destionController.accessToken = self.accessToken;
        self.destionController.pageIndex = 1;
        [self.delegate showController];
        [self.fromViewController presentViewController:self.destionNavController animated:YES completion:^{
        }];
    }
}



//float 子布局显示和隐藏
-(void)showTap {
    if (self.landscape) {
        if (self.show == 0) {
            CGSize mainSize = [[UIScreen mainScreen]bounds].size;
            CGRect mainRect = CGRectMake(self.popOverWindow.frame.origin.x , self.popOverWindow.frame.origin.y, 50, 145);
            self.popOverWindow.frame = mainRect;
            if (self.popOverWindow.frame.origin.y + self.popOverWindow.frame.size.height > mainSize.height) {
                mainRect = CGRectMake(mainRect.origin.x, mainSize.height-145, mainRect.size.width, mainRect.size.height);
                [UIView animateWithDuration:0.2 animations:^{
                    self.popOverWindow.frame = mainRect;
                } completion:^(BOOL finished) {
                }];
            }
            self.ButtonBackground.hidden = NO;
            self.show = 1;
        }
        else {
            CGRect mainRect = CGRectMake(self.popOverWindow.frame.origin.x , self.popOverWindow.frame.origin.y,50,50);
            self.popOverWindow.frame = mainRect;
            self.ButtonBackground.hidden = YES;
            self.show = 0;
        }
    }else{
        if (self.show == 0) {
            CGSize mainSize = [[UIScreen mainScreen]bounds].size;
            CGRect mainRect = CGRectMake(self.popOverWindow.frame.origin.x , self.popOverWindow.frame.origin.y, 145, 50);
            self.popOverWindow.frame = mainRect;
            
            if (self.popOverWindow.frame.origin.x + self.popOverWindow.frame.size.width > mainSize.width) {
                mainRect = CGRectMake(mainSize.width - self.popOverWindow.frame.size.width, mainRect.origin.y, mainRect.size.width, mainRect.size.height);
                [UIView animateWithDuration:0.2 animations:^{
                    self.popOverWindow.frame = mainRect;
                } completion:^(BOOL finished) {
                }];
            }
            self.ButtonBackground.hidden = NO;
            self.show = 1;
        }
        else {
            CGRect mainRect = CGRectMake(self.popOverWindow.frame.origin.x , self.popOverWindow.frame.origin.y, 50, 50);
            self.popOverWindow.frame = mainRect;
            self.ButtonBackground.hidden = YES;
            self.show = 0;
        }
        
    }
    
}
-(void)removeView{
    [self.ButtonBackground removeFromSuperview];
    [self.floatButton removeFromSuperview];
}

-(void)addView:(float)roate{
    self.view.backgroundColor=[UIColor clearColor];
    [self setPopView];
    CGAffineTransform transform =self.floatButton.transform;
    transform = CGAffineTransformRotate(transform,  degreesTo(roate));
    self.floatButton.transform = transform;
    
    CGAffineTransform transform1 =self.ButtonBackground.transform;
    transform1 = CGAffineTransformRotate(transform1,  degreesTo(roate));
    self.ButtonBackground.transform = transform1;
    
}
@end
