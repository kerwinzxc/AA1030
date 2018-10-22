#import <UIKit/UIKit.h>
#import "UnnHeTooSdk_const_def.h"

@interface UnnHeTooShiMingRenZhengView : UIView

-(id)initUnnHeTooShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(UnnHeToo_COMMON_BLOCK)callback;

-(void)showUnnHeTooShiMingRenZhengView:(UIView *)view;

-(void)dismissUnnHeTooShiMingRenZhengView:(BOOL)animated;

@end
