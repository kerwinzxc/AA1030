

#import <UIKit/UIKit.h>
#import "RersistenceSwitchDelegate.h"

@interface RersistenceSettingViewController : UIPageViewController<UIPageViewControllerDataSource,RersistenceSwitchDelegate>

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) id<RersistenceShowController> myDelegate;
@property (nonatomic, strong) NSString *accessToken;

@property (assign, nonatomic)Boolean landscape;

@end
