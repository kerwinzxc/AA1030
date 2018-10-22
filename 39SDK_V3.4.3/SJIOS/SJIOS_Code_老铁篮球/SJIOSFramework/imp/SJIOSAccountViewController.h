

#import <UIKit/UIKit.h>
#import "SJIOSFloatViewController.h"

@interface SJIOSAccountViewController : SJIOSFloatViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
