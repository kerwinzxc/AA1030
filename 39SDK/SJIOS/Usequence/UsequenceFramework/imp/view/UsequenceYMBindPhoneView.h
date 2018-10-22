

#import <UIKit/UIKit.h>
#import "UsequenceBaseView.h"
#import "SJ_ValidateIdentity.h"
#import "UsequenceQuickLogin.h"
#import "UsequenceDefaultLogin.h"

@interface UsequenceYMBindPhoneView : UsequenceBaseView <UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

@property (nonatomic, strong) NSString *accessToken;
- (id)initWithLandscape:(Boolean)landscape;


@end
