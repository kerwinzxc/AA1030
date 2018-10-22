

#import "SJIOSFloatViewController.h"

@interface SJIOSServiceViewController : SJIOSFloatViewController<UIAlertViewDelegate,UIAlertViewDelegate>

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
