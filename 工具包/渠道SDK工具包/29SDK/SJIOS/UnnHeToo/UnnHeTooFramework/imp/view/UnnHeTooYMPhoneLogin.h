

#import "UnnHeTooBaseView.h"
#import "UnnHeTooQuickLogin.h"
#import "UnnHeTooDefaultLogin.h"
#import "UnnHeTooSdk_const_def.h"
#import "SJ_ValidateIdentity.h"

@interface UnnHeTooYMPhoneLogin : UnnHeTooBaseView<UITextFieldDelegate>

typedef void(^UnnHeToo_RV_Complete_Callback)(NSString *, NSString*);

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UnnHeTooQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
