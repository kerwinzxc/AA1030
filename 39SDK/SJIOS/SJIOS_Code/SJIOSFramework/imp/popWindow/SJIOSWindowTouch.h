

#import <UIKit/UIKit.h>
#import "SJIOSSwitchDelegate.h"
@protocol SJIOSWindowTouchDelegate;

@interface SJIOSWindowTouch : UIWindow

-(id)initWithFrame:(CGRect)frame ;

- (void)addSubview:(UIView *)view ;

-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<SJIOSShowController>) delegate;
@end

@protocol SJIOSWindowTouchDelegate <NSObject>
@optional
//悬浮窗点击事件
-(void)assistiveTocuhs;
@end
