

#import <UIKit/UIKit.h>
#import "UnnHeTooFloatViewController.h"

@interface UnnHeTooAccountViewController : UnnHeTooFloatViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
