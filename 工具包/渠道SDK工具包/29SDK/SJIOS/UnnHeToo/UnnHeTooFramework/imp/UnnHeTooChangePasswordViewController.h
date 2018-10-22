

#import <UIKit/UIKit.h>
#import "UnnHeTooUserInfo.h"
@interface UnnHeTooChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    UnnHeTooUserInfo *userinfo;
}


@property (nonatomic, strong) NSString *accessToken;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithLandscape:(Boolean)landscape;


@end
