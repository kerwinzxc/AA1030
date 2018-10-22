#import <UIKit/UIKit.h>
#import "SJIOSSdk_const_def.h"

@interface SJIOSShiMingRenZhengView : UIView

-(id)initSJIOSShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback;

-(void)showSJIOSShiMingRenZhengView:(UIView *)view;

-(void)dismissSJIOSShiMingRenZhengView:(BOOL)animated;

@end
