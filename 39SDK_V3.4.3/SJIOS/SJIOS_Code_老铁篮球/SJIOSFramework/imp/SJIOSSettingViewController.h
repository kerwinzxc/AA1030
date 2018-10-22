

#import <UIKit/UIKit.h>
#import "SJIOSSwitchDelegate.h"

@interface SJIOSSettingViewController : UIPageViewController<UIPageViewControllerDataSource,SJIOSSwitchDelegate>

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) id<SJIOSShowController> myDelegate;
@property (nonatomic, strong) NSString *accessToken;

@property (assign, nonatomic)Boolean landscape;

@end
