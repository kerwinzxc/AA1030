#import <UIKit/UIKit.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"



@interface UsequenceUserCenterView : UIView

-(id)initUsequenceUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken;

-(void)showUsequenceUserCenterView:(UIView *)view;

-(void)dismissUsequenceUserCenterView:(BOOL)animated;

@end
