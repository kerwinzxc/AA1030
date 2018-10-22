#import <UIKit/UIKit.h>
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"



@interface RersistenceUserCenterView : UIView

-(id)initRersistenceUserCenterView:(Boolean)landscape accessToken:(NSString *)accessToken;

-(void)showRersistenceUserCenterView:(UIView *)view;

-(void)dismissRersistenceUserCenterView:(BOOL)animated;

@end
