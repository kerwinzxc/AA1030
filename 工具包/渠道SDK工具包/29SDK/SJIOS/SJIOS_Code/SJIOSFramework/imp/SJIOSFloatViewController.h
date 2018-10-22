

#import <UIKit/UIKit.h>
#import "SJIOSSwitchDelegate.h"

@interface SJIOSFloatViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, assign) id<SJIOSSwitchDelegate> delegate;

@end
