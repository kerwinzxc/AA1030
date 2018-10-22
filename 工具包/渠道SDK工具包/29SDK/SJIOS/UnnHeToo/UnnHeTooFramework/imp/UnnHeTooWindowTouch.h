

#import <UIKit/UIKit.h>
#import "UnnHeTooSwitchDelegate.h"
@protocol UnnHeTooWindowTouchDelegate;

@interface UnnHeTooWindowTouch : UIWindow

-(id)initWithFrame:(CGRect)frame ;

- (void)addSubview:(UIView *)view ;

-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<UnnHeTooShowController>) delegate;
@end

@protocol UnnHeTooWindowTouchDelegate <NSObject>
@optional
//悬浮窗点击事件
-(void)assistiveTocuhs;
@end
