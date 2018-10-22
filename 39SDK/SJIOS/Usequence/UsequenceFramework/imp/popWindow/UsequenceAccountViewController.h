

#import <UIKit/UIKit.h>
#import "UsequenceFloatViewController.h"

@interface UsequenceAccountViewController : UsequenceFloatViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
