

#import <UIKit/UIKit.h>
#import "RersistenceSwitchDelegate.h"

@interface RersistenceFloatViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, assign) id<RersistenceSwitchDelegate> delegate;

@end
