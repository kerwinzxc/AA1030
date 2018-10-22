#import <UIKit/UIKit.h>
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"



@interface QroughtUserCenterView : UIView

-(id)initQroughtUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken;

-(void)showQroughtUserCenterView:(UIView *)view;

-(void)dismissQroughtUserCenterView:(BOOL)animated;

@end
