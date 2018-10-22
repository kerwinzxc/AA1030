
#import "RersistenceFloatWindow.h"
#import "RersistenceWindowTouch.h"
#import "RersistencePopWindow.h"
#define degreesTo(x) (M_PI * (x) / 180.0)


@interface RersistenceFloatWindow()

@property (nonatomic, strong) RersistenceWindowTouch *popOverWindow;
@property (nonatomic,strong) RersistencePopWindow* RersistencePopWindow;


@end

static RersistenceFloatWindow *floatWindow;

@implementation RersistenceFloatWindow



+(RersistenceFloatWindow*)shareInstance {
    if (floatWindow == nil) {
        floatWindow  = [[RersistenceFloatWindow alloc]init];

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
//设置RersistencePopWindow positon
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
