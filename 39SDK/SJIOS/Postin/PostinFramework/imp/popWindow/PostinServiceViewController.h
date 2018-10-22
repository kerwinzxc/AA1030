

#import "PostinFloatViewController.h"

@interface PostinServiceViewController : PostinFloatViewController<UIAlertViewDelegate,UIAlertViewDelegate>

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
