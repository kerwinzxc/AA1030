

#import <UIKit/UIKit.h>
#import "RersistenceSwitchDelegate.h"
@protocol RersistenceWindowTouchDelegate;

@interface RersistenceWindowTouch : UIWindow

-(id)initWithFrame:(CGRect)frame ;

- (void)addSubview:(UIView *)view ;

-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken delegate:(id<RersistenceShowController>) delegate;
@end

@protocol RersistenceWindowTouchDelegate <NSObject>
@optional
//悬浮窗点击事件
-(void)assistiveTocuhs;
@end
