

#import "UsequenceBaseView.h"
#import "UsequenceQuickLogin.h"
#import "UsequenceDefaultLogin.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "SJ_ValidateIdentity.h"
#import "UIControl+ZHW.h"

@interface UsequenceYMLoginView : UsequenceBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UsequenceQuickLogin*) view;

- (id)initWithBlock:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UsequenceQuickLogin*) view username:(NSString *)username;




-(void)login_backButton;

@end
