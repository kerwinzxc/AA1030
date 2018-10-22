

#import "QroughtFloatViewController.h"

@interface QroughtServiceViewController : QroughtFloatViewController<UIAlertViewDelegate,UIAlertViewDelegate>

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
