
#import "PostinFloatWindow.h"
#import "PostinWindowTouch.h"
#import "PostinPopWindow.h"
#define degreesTo(x) (M_PI * (x) / 180.0)


@interface PostinFloatWindow()

@property (nonatomic, strong) PostinWindowTouch *popOverWindow;
@property (nonatomic,strong) PostinPopWindow* PostinPopWindow;


@end

static PostinFloatWindow *floatWindow;

@implementation PostinFloatWindow



+(PostinFloatWindow*)shareInstance {
    if (floatWindow == nil) {
        floatWindow  = [[PostinFloatWindow alloc]init];

    }

    return floatWindow;
}


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken{
    [floatWindow.popOverWindow setViewController:viewController isLandspace:isLandspace accessToken:accessToken delegate:self];
}

-(void)show:(UIViewController *)viewController landspace:isLandscape{

}


-(void)dismissPop {
    [self.popOverWindow resignKeyWindow];
    self.popOverWindow.hidden = YES;
    
}
//设置PostinPopWindow positon
-(void)setPosition:(CGPoint)startPoint {
    CGRect rect=floatWindow.popOverWindow.frame;
    rect.origin.x = startPoint.x;
    rect.origin.y = startPoint.y;
    floatWindow.popOverWindow.frame = rect;
}


-(void)showController{
    [self dismissPop];
}

@end
