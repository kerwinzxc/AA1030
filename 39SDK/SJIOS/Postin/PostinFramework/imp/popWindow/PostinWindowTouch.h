

#import <UIKit/UIKit.h>
#import "PostinSwitchDelegate.h"
@protocol PostinWindowTouchDelegate;

@interface PostinWindowTouch : UIWindow

-(id)initWithFrame:(CGRect)frame ;

- (void)addSubview:(UIView *)view ;

-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<PostinShowController>) delegate;
@end

@protocol PostinWindowTouchDelegate <NSObject>
@optional
//悬浮窗点击事件
-(void)assistiveTocuhs;
@end
