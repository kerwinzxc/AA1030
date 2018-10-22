

#import <UIKit/UIKit.h>
#import "UnnHeTooSwitchDelegate.h"

@interface UnnHeTooSettingViewController : UIPageViewController<UIPageViewControllerDataSource,UnnHeTooSwitchDelegate>

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) id<UnnHeTooShowController> myDelegate;
@property (nonatomic, strong) NSString *accessToken;

@property (assign, nonatomic)Boolean landscape;

@end
