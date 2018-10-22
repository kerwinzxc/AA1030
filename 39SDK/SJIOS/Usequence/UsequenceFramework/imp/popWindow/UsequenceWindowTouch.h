

#import <UIKit/UIKit.h>
#import "UsequenceSwitchDelegate.h"
@protocol UsequenceWindowTouchDelegate;

@interface UsequenceWindowTouch : UIWindow

-(id)initWithFrame:(CGRect)frame ;

- (void)addSubview:(UIView *)view ;

-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<UsequenceShowController>) delegate;
@end

@protocol UsequenceWindowTouchDelegate <NSObject>
@optional
//悬浮窗点击事件
-(void)assistiveTocuhs;
@end
