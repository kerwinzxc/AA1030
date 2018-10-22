
#import "SJIOSFloatWindow.h"
#import "SJIOSWindowTouch.h"
#import "SJIOSPopWindow.h"
#define degreesTo(x) (M_PI * (x) / 180.0)


@interface SJIOSFloatWindow()

@property (nonatomic, strong) SJIOSWindowTouch *popOverWindow;
@property (nonatomic,strong) SJIOSPopWindow* SJIOSPopWindow;


@end

static SJIOSFloatWindow *floatWindow;

@implementation SJIOSFloatWindow



+(SJIOSFloatWindow*)shareInstance {
    if (floatWindow == nil) {
        floatWindow  = [[SJIOSFloatWindow alloc]init];

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
//设置SJIOSPopWindow positon
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
