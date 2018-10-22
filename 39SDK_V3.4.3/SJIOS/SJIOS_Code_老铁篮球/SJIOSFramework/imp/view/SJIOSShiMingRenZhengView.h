#import <UIKit/UIKit.h>
#import "SJIOSSdkCommonDefine.h"

@interface SJIOSShiMingRenZhengView : UIView

-(id)initSJIOSShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback;

-(void)showSJIOSShiMingRenZhengView:(UIView *)view;

-(void)dismissSJIOSShiMingRenZhengView:(BOOL)animated;

@end
