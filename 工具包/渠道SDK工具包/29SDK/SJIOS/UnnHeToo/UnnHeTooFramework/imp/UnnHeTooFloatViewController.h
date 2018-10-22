

#import <UIKit/UIKit.h>
#import "UnnHeTooSwitchDelegate.h"

@interface UnnHeTooFloatViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, assign) id<UnnHeTooSwitchDelegate> delegate;

@end
