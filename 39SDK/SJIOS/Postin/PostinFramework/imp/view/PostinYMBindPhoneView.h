

#import <UIKit/UIKit.h>
#import "PostinBaseView.h"
#import "SJ_ValidateIdentity.h"
#import "PostinQuickLogin.h"
#import "PostinDefaultLogin.h"

@interface PostinYMBindPhoneView : PostinBaseView <UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

@property (nonatomic, strong) NSString *accessToken;
- (id)initWithLandscape:(Boolean)landscape;


@end
