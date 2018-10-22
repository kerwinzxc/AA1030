#import <UIKit/UIKit.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"



@interface UsequenceShiMingRenZhengView : UIView

-(id)initUsequenceShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Usequence_COMMON_BLOCK)callback;

-(void)showUsequenceShiMingRenZhengView:(UIView *)view;

-(void)dismissUsequenceShiMingRenZhengView:(BOOL)animated;

@end
