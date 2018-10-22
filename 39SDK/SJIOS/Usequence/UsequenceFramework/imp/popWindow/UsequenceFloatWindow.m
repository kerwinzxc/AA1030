
#import "UsequenceFloatWindow.h"
#import "UsequenceWindowTouch.h"
#import "UsequencePopWindow.h"
#define degreesTo(x) (M_PI * (x) / 180.0)


@interface UsequenceFloatWindow()

@property (nonatomic, strong) UsequenceWindowTouch *popOverWindow;
@property (nonatomic,strong) UsequencePopWindow* UsequencePopWindow;


@end

static UsequenceFloatWindow *floatWindow;

@implementation UsequenceFloatWindow



+(UsequenceFloatWindow*)shareInstance {
    if (floatWindow == nil) {
        floatWindow  = [[UsequenceFloatWindow alloc]init];

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
//设置UsequencePopWindow positon
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
