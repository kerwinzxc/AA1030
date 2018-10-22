

#import <UIKit/UIKit.h>
#import "QroughtBaseView.h"
#import "SJ_ValidateIdentity.h"
#import "QroughtQuickLogin.h"
#import "QroughtDefaultLogin.h"

@interface QroughtYMBindPhoneView : QroughtBaseView <UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

@property (nonatomic, strong) NSString *accessToken;
- (id)initWithLandscape:(Boolean)landscape;


@end
