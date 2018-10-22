
#import <UIKit/UIKit.h>

@interface RersistencePopWindow : UIView
@property (nonatomic, strong) NSString *accessToken;
@property (strong, nonatomic)UIButton *floatButton;
@property (strong, nonatomic)UIImage *floatImage;
@property (strong, nonatomic)UIView *ButtonBackground;
@property (strong, nonatomic)UIButton *serviceButton;
@property (strong, nonatomic)UIButton *accountButton;
@property (strong, nonatomic)UIButton *ymFloatHideButton;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithFrameRersistencePopWindow:(CGRect)frame  controller:(UIViewController*) controller landspace:(BOOL) landspace accessToken:(NSString*) accessToken;
@end
