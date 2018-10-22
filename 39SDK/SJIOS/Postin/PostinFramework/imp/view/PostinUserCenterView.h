#import <UIKit/UIKit.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"



@interface PostinUserCenterView : UIView

-(id)initPostinUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken;

-(void)showPostinUserCenterView:(UIView *)view;

-(void)dismissPostinUserCenterView:(BOOL)animated;

@end
