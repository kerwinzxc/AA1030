#import <UIKit/UIKit.h>
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"



@interface QroughtShiMingRenZhengView : UIView

-(id)initQroughtShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Qrought_COMMON_BLOCK)callback;

-(void)showQroughtShiMingRenZhengView:(UIView *)view;

-(void)dismissQroughtShiMingRenZhengView:(BOOL)animated;

@end
