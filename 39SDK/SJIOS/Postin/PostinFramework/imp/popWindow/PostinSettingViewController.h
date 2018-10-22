

#import <UIKit/UIKit.h>
#import "PostinSwitchDelegate.h"

@interface PostinSettingViewController : UIPageViewController<UIPageViewControllerDataSource,PostinSwitchDelegate>

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) id<PostinShowController> myDelegate;
@property (nonatomic, strong) NSString *accessToken;

@property (assign, nonatomic)Boolean landscape;

@end
