
#import "QroughtFloatWindow.h"
#import "QroughtWindowTouch.h"
#import "QroughtPopWindow.h"
#define degreesTo(x) (M_PI * (x) / 180.0)


@interface QroughtFloatWindow()

@property (nonatomic, strong) QroughtWindowTouch *popOverWindow;
@property (nonatomic,strong) QroughtPopWindow* QroughtPopWindow;


@end

static QroughtFloatWindow *floatWindow;

@implementation QroughtFloatWindow



+(QroughtFloatWindow*)shareInstance {
    if (floatWindow == nil) {
        floatWindow  = [[QroughtFloatWindow alloc]init];

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
//设置QroughtPopWindow positon
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
