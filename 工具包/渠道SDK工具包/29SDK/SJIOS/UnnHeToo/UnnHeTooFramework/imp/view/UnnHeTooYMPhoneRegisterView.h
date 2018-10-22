

#import "UnnHeTooBaseView.h"
#import "UnnHeTooQuickLogin.h"
#import "UnnHeTooDefaultLogin.h"
#import "UnnHeTooSdk_const_def.h"
#import "SJ_ValidateIdentity.h"

@interface UnnHeTooYMPhoneRegisterView : UnnHeTooBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ymPhoneNum;
@property (nonatomic, strong) UITextField *ymPassword;

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UnnHeTooQuickLogin*) view ;


//-(id)initWithBlockDefault:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
//                landScape:(Boolean)landcape  view:(UnnHeTooDefaultLogin*) view ;


-(void)login_backButton;

@end
