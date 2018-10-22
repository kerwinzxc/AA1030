

#import "RersistenceFloatViewController.h"

@interface RersistenceServiceViewController : RersistenceFloatViewController<UIAlertViewDelegate,UIAlertViewDelegate>

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
