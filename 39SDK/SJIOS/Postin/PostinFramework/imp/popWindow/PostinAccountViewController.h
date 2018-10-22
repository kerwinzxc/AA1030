

#import <UIKit/UIKit.h>
#import "PostinFloatViewController.h"

@interface PostinAccountViewController : PostinFloatViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
