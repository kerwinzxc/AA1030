

#import <UIKit/UIKit.h>
#import "UnnHeTooBaseView.h"
#import "SJ_ValidateIdentity.h"
#import "UnnHeTooQuickLogin.h"
#import "UnnHeTooDefaultLogin.h"

@interface UnnHeTooYMBindPhoneView : UnnHeTooBaseView <UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

@property (nonatomic, strong) NSString *accessToken;
- (id)initWithLandscape:(Boolean)landscape;


@end
