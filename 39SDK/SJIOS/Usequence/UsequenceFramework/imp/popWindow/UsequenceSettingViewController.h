

#import <UIKit/UIKit.h>
#import "UsequenceSwitchDelegate.h"

@interface UsequenceSettingViewController : UIPageViewController<UIPageViewControllerDataSource,UsequenceSwitchDelegate>

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) id<UsequenceShowController> myDelegate;
@property (nonatomic, strong) NSString *accessToken;

@property (assign, nonatomic)Boolean landscape;

@end
