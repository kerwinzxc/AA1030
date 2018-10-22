

#import <UIKit/UIKit.h>
#import "SJIOSBaseView.h"
#import "SJ_ValidateIdentity.h"
#import "SJIOSQuickLogin.h"
#import "SJIOSDefaultLogin.h"

@interface SJIOSYMBindPhoneView : SJIOSBaseView <UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

@property (nonatomic, strong) NSString *accessToken;
- (id)initWithLandscape:(Boolean)landscape;


@end
