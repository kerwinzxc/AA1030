

#import <UIKit/UIKit.h>
#import "QroughtFloatViewController.h"

@interface QroughtAccountViewController : QroughtFloatViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
