

#import "PostinWindowTouch.h"
#import "PostinPopwidowViewController.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define degreesTo(x) (M_PI * (x) / 180.0)
@interface PostinWindowTouch()
@property(nonatomic,strong)PostinPopwidowViewController *popcontroller;
@property(nonatomic,unsafe_unretained)id<PostinWindowTouchDelegate> assistiveDelegate;
@property (nonatomic) float lastX;
@property (nonatomic) float lastY;
@end
@implementation PostinWindowTouch

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert;
        self.popcontroller=[[PostinPopwidowViewController alloc]initWithPostinPopWindow:self];
        //self.popcontroller.view.alpha=0.3;
        [self addSubview:self.popcontroller.view];
        self.userInteractionEnabled=YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<PostinShowController>) delegate;{
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:device];
    [self.popcontroller setViewController:viewController isLandspace:isLandspace accessToken:accessToken delegate:delegate];
}
//改变位置
-(void)locationChange:(UIPanGestureRecognizer*)p
{
   // [self pauseLayer:self.popcontroller.view.layer];
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication] keyWindow]];
    if(p.state == UIGestureRecognizerStateBegan)
    {

         //self.popcontroller.view.alpha = 0.8;
    }
    if(p.state == UIGestureRecognizerStateChanged)
    {
       self.center = CGPointMake(panPoint.x, panPoint.y);

    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
      
        if(panPoint.x <= kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeight-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > kScreenHeight-HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, kScreenHeight-HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, pointy);
                }];
            }
        }
        else if(panPoint.x > kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeight-40-HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, 480-HEIGHT/2);
                }];
            }
            else if (panPoint.x > kScreenWidth-WIDTH/2-15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidth-WIDTH/2, HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > kScreenHeight-HEIGHT/2 ? kScreenHeight-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(320-WIDTH/2, pointy);
                }];
            }
        }
        //[self changeColor];
    }
}
//点击事件
-(void)click:(UITapGestureRecognizer*)t
{
   // [self pauseLayer:self.popcontroller.view.layer];
    self.popcontroller.view.alpha = 0.8;
    [self.popcontroller showTap];
    //[self performSelector:@selector(changeColor) withObject:nil afterDelay:4.0];
  //  [self changeColor];
    if(_assistiveDelegate && [_assistiveDelegate respondsToSelector:@selector(assistiveTocuhs)])
    {
        [_assistiveDelegate assistiveTocuhs];
    }
}
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)rotation_icon:(CGRect) rect roate:(float)roate{
    self.frame=rect;
    [self.popcontroller removeView];
    [self.popcontroller addView:roate];
}


- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    CGRect  screen=[[UIScreen mainScreen]bounds];
    switch (o) {
        case UIDeviceOrientationPortrait:
            [self  rotation_icon:CGRectMake(0, 0,50, 50) roate:0.0] ;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [self rotation_icon:CGRectMake(screen.size.width-50, screen.size.height-50, 50, 50) roate: 180.0];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self rotation_icon:CGRectMake(screen.size.width-50, 0, 50, 50) roate:90.0];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self rotation_icon:CGRectMake(0, screen.size.height-50, 50, 50) roate:270.0];
            break;
        default:
            break;
    }
}


@end
