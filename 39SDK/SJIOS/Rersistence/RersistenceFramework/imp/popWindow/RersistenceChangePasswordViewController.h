

#import <UIKit/UIKit.h>
#import "RersistenceUserInfo.h"
@interface RersistenceChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    RersistenceUserInfo *userinfo;
}


@property (nonatomic, strong) NSString *accessToken;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithLandscape:(Boolean)landscape;


@end
