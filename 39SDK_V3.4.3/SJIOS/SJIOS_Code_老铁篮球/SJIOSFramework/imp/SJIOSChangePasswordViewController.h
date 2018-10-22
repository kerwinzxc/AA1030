

#import <UIKit/UIKit.h>
#import "SJIOSUserInfo.h"
@interface SJIOSChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    SJIOSUserInfo *userinfo;
}


@property (nonatomic, strong) NSString *accessToken;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithLandscape:(Boolean)landscape;


@end
