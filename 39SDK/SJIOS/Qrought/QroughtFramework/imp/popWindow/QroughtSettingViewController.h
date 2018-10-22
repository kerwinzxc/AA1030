

#import <UIKit/UIKit.h>
#import "QroughtSwitchDelegate.h"

@interface QroughtSettingViewController : UIPageViewController<UIPageViewControllerDataSource,QroughtSwitchDelegate>

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) id<QroughtShowController> myDelegate;
@property (nonatomic, strong) NSString *accessToken;

@property (assign, nonatomic)Boolean landscape;

@end
