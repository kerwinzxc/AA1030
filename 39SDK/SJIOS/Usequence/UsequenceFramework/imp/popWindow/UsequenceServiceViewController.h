

#import "UsequenceFloatViewController.h"

@interface UsequenceServiceViewController : UsequenceFloatViewController<UIAlertViewDelegate,UIAlertViewDelegate>

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
