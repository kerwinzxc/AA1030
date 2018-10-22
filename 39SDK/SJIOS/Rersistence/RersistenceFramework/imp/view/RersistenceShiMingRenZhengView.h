#import <UIKit/UIKit.h>
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"



@interface RersistenceShiMingRenZhengView : UIView

-(id)initRersistenceShiMingRenZhengView:(Boolean)landscape accessToken:(NSString *)accessToken callback:(Rersistence_COMMON_BLOCK)callback;

-(void)showRersistenceShiMingRenZhengView:(UIView *)view;

-(void)dismissRersistenceShiMingRenZhengView:(BOOL)animated;

@end
