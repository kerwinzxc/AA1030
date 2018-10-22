

#import <UIKit/UIKit.h>
#import "UsequenceUserInfo.h"
@interface UsequenceChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    UsequenceUserInfo *userinfo;
}


@property (nonatomic, strong) NSString *accessToken;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithLandscape:(Boolean)landscape;


@end
