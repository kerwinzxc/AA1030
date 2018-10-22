

#import <UIKit/UIKit.h>
#import "QroughtSwitchDelegate.h"
@protocol QroughtWindowTouchDelegate;

@interface QroughtWindowTouch : UIWindow

-(id)initWithFrame:(CGRect)frame ;

- (void)addSubview:(UIView *)view ;

-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<QroughtShowController>) delegate;
@end

@protocol QroughtWindowTouchDelegate <NSObject>
@optional
//悬浮窗点击事件
-(void)assistiveTocuhs;
@end
