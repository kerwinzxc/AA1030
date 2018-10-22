

#import <UIKit/UIKit.h>
#import "UsequenceSwitchDelegate.h"

@interface UsequenceFloatViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, assign) id<UsequenceSwitchDelegate> delegate;

@end
