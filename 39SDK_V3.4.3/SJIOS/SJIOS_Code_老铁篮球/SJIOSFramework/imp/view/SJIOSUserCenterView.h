#import <UIKit/UIKit.h>
#import "SJIOSSdkCommonDefine.h"

@interface SJIOSUserCenterView : UIView

-(id)initSJIOSUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken;

-(void)showSJIOSUserCenterView:(UIView *)view;

-(void)dismissSJIOSUserCenterView:(BOOL)animated;

@end
