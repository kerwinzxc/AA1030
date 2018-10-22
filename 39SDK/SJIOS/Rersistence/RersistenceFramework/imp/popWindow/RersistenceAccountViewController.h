

#import <UIKit/UIKit.h>
#import "RersistenceFloatViewController.h"

@interface RersistenceAccountViewController : RersistenceFloatViewController

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (assign, nonatomic)Boolean landscape;
-(id)initWithLandscape:(Boolean)landscape;

@end
