

#import "UnnHeTooBaseView.h"
#import "UnnHeTooQuickLogin.h"
#import "UnnHeTooDefaultLogin.h"
#import "UnnHeTooSdk_const_def.h"
#import "SJ_ValidateIdentity.h"
#import "UIControl+ZHW.h"

@interface UnnHeTooYMLoginView : UnnHeTooBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UnnHeTooQuickLogin*) view;

- (id)initWithBlock:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UnnHeTooQuickLogin*) view username:(NSString *)username;




-(void)login_backButton;

@end
