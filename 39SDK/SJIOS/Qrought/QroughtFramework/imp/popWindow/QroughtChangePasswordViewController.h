

#import <UIKit/UIKit.h>
#import "QroughtUserInfo.h"
@interface QroughtChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    QroughtUserInfo *userinfo;
}


@property (nonatomic, strong) NSString *accessToken;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithLandscape:(Boolean)landscape;


@end
