
#import "UnnHeTooFloatWindow.h"
#import "UnnHeTooWindowTouch.h"
#import "UnnHeTooPopWindow.h"
#define degreesTo(x) (M_PI * (x) / 180.0)


@interface UnnHeTooFloatWindow()

@property (nonatomic, strong) UnnHeTooWindowTouch *popOverWindow;
@property (nonatomic,strong) UnnHeTooPopWindow* UnnHeTooPopWindow;


@end

static UnnHeTooFloatWindow *floatWindow;

@implementation UnnHeTooFloatWindow



+(UnnHeTooFloatWindow*)shareInstance {
    if (floatWindow == nil) {
        floatWindow  = [[UnnHeTooFloatWindow alloc]init];

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
//设置UnnHeTooPopWindow positon
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
