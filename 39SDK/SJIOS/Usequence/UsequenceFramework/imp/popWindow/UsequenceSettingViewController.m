

#import "UsequenceSettingViewController.h"
#import "UIImage+UsequenceSdk.h"
#import "UsequenceAccountViewController.h"
#import "UsequenceServiceViewController.h"
#import "UsequenceFloatViewController.h"
#import "UsequenceSdkImp.h"
@interface UsequenceSettingViewController ()

@property (strong, nonatomic) UsequenceServiceViewController *UsequenceServiceViewController;
@property (strong, nonatomic) UsequenceAccountViewController *accountController;
@property (strong, nonatomic) UsequenceAccountViewController *accountController2;

@property (strong, nonatomic) UIView *container;
@property (strong, nonatomic) UIView *serviceContainer;
@property (strong, nonatomic) UIView *accountContainer;
@property (strong, nonatomic) UIView *hideFloatUsequenceContainer;
@property (strong, nonatomic) UIImageView *blueBar;
@property (nonatomic) int isFirstTime;

@end


@implementation UsequenceSettingViewController


-(id)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options {
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        

    }
    return self;
}

-(void)back {
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"closeSJUserCenter" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    [self.myDelegate dismissController];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   
    
    if (self.isFirstTime == 0) {
        [self initNavigation];
        self.isFirstTime = 1;
    }
    
    self.UsequenceServiceViewController = [[UsequenceServiceViewController alloc]initWithLandscape:self.landscape];
    self.UsequenceServiceViewController.pageIndex = 0;
    self.UsequenceServiceViewController.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    self.accountController = [[UsequenceAccountViewController alloc]initWithLandscape:self.landscape];
    self.accountController.accessToken = self.accessToken;
    self.accountController.pageIndex = 1;
    self.accountController.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

    
    UsequenceFloatViewController *targetController;
    if (self.pageIndex == 0) {
        targetController = self.UsequenceServiceViewController;
        [self.serviceContainer addSubview:self.blueBar];
    }
    else if (self.pageIndex == 1) {
        targetController = self.accountController;
        [self.accountContainer addSubview:self.blueBar];
    }

    
    targetController.delegate = self;
    // Do any additional setup after loading the view.
    self.dataSource = self;
    
    [self setViewControllers:@[targetController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:NULL];
    
    self.view.backgroundColor = [UIColor whiteColor];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
}





-(void)initNavigation {
    UIImage *backNormalImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_back.png"]] ;
    UIImage *backHighImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_back_cl.png"]] ;
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:backNormalImage forState:UIControlStateNormal];
    [backButton setImage:backHighImage forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    CGSize screenSize = [[UIScreen mainScreen]bounds].size;
    if (ios8) {
        
    }else{
        if (self.landscape == true) {
            screenSize = CGSizeMake(screenSize.height, screenSize.width);
        }
    }
   
    
//    UIImage *backgroundImage = [UIImage imageWithColor:[UIColor colorWithRed:0.1176 green:0.5255 blue:0.855 alpha:1.0] cornerRadius:3.0f sizeOfdialog:CGSizeMake(screenSize.width, 44)];
    
 //   [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
   // self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:0.1176 green:0.5255 blue:0.855 alpha:1.0];
     [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:130.0/255.0 blue:180.0/255.0 alpha:1.0] ];
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y, screenSize.width, 30)];
    containerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *grayImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, screenSize.width / 2, 2)];
    grayImageView.backgroundColor = [UIColor lightGrayColor];
    
    UIView *serviceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width/2, containerView.frame.size.height)];
    
    [serviceView addSubview:grayImageView];
    
    serviceView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *serviceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenSize.width / 4 - 25, 6, 49, 17)];
    serviceImageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_icon_meun_ser.png"]] ;
    
    [serviceView addSubview:serviceImageView];
    
    
    [containerView addSubview:serviceView];
    self.serviceContainer = serviceView;
    
    UIImageView *speratorImage = [[UIImageView alloc]initWithFrame:CGRectMake(screenSize.width / 2 - 1, 0, 3, containerView.frame.size.height )];
    speratorImage.backgroundColor = [UIColor lightGrayColor];
    [containerView addSubview:speratorImage];
    
    UIView *accountView = [[UIView alloc]initWithFrame:CGRectMake(screenSize.width / 2, 0, screenSize.width / 2, containerView.frame.size.height )];
    accountView.backgroundColor = [UIColor whiteColor];
    UIImageView *grayImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, screenSize.width / 2, 2)];
    grayImageView1.backgroundColor = [UIColor lightGrayColor];
    [accountView addSubview:grayImageView1];
    UIImageView *accountImageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenSize.width / 4 - 25, 6, 49, 17)];
    accountImageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Usequence.bundle/Usequence_icon_meun_ac.png"]] ;
    [accountView addSubview:accountImageView];
    
    [containerView addSubview:accountView];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    self.accountContainer = accountView;
    
    self.container = containerView;
    
    self.blueBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, containerView.frame.size.height - 2, screenSize.width / 2, 2)];
    self.blueBar.backgroundColor = [UIColor colorWithRed:0.0 green:0.576 blue:1.0 alpha:1];
    
    [self.view addSubview:containerView];
    
    [self addAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addAction {
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    self.container.userInteractionEnabled = YES;
    self.serviceContainer.userInteractionEnabled = YES;
    self.accountContainer.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *serviceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(serviceTap)];
    [self.serviceContainer addGestureRecognizer:serviceTap];
    
    UITapGestureRecognizer *accountTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accountTap)];
    [self.accountContainer addGestureRecognizer:accountTap];
}

-(void)serviceTap {
    [self.blueBar removeFromSuperview];
    [self.serviceContainer addSubview:self.blueBar];
    self.pageIndex = 0;
    [self setViewControllers:@[self.UsequenceServiceViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:NULL];
}


-(void)accountTap {
    [self.blueBar removeFromSuperview];
    [self.accountContainer addSubview:self.blueBar];
    self.pageIndex = 1;
    [self setViewControllers:@[self.accountController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:NULL];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UsequenceFloatViewController *)vc
{
    if (vc.pageIndex == 1) {
        self.UsequenceServiceViewController.delegate = self;
        self.pageIndex = 0;
        return self.UsequenceServiceViewController;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UsequenceFloatViewController *)vc
{
    if (vc.pageIndex == 0) {
        self.accountController.delegate = self;
        self.pageIndex = 1;
        return self.accountController;
    }
    
    return nil;
}


-(void)showPage:(NSUInteger)pageIndex {
    if (pageIndex == 0) {
        [self.blueBar removeFromSuperview];
        [self.serviceContainer addSubview:self.blueBar];
    }
    else if(pageIndex == 1) {
        [self.blueBar removeFromSuperview];
        [self.accountContainer addSubview:self.blueBar];
    }
}



-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (self.landscape == true) {
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            return YES;
        }
    }
    else if(self.landscape == false) {
        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
            return YES;
        }
    }
    return NO;
}


-(NSUInteger)supportedInterfaceOrientations {
    if (self.landscape == true) {
        return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
    }
    else
        return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate{
    return NO;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
