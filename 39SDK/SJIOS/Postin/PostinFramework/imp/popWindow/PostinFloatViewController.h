

#import <UIKit/UIKit.h>
#import "PostinSwitchDelegate.h"

@interface PostinFloatViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, assign) id<PostinSwitchDelegate> delegate;

@end
