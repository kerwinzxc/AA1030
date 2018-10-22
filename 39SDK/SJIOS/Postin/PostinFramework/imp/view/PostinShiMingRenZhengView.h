#import <UIKit/UIKit.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"



@interface PostinShiMingRenZhengView : UIView

-(id)initPostinShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Postin_COMMON_BLOCK)callback;

-(void)showPostinShiMingRenZhengView:(UIView *)view;

-(void)dismissPostinShiMingRenZhengView:(BOOL)animated;

@end
