

#import <UIKit/UIKit.h>
#import "PostinUserInfo.h"
@interface PostinChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    PostinUserInfo *userinfo;
}


@property (nonatomic, strong) NSString *accessToken;
@property (assign, nonatomic)Boolean landscape;

-(id)initWithLandscape:(Boolean)landscape;


@end
