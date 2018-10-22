

#import <UIKit/UIKit.h>
#import "QroughtSwitchDelegate.h"

@interface QroughtFloatViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, assign) id<QroughtSwitchDelegate> delegate;

@end
