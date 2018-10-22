

#import "UsequenceBaseView.h"
#import "UsequenceQuickLogin.h"
#import "UsequenceDefaultLogin.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "SJ_ValidateIdentity.h"

@interface UsequenceYMPhoneRegisterView : UsequenceBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ymPhoneNum;
@property (nonatomic, strong) UITextField *ymPassword;

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UsequenceQuickLogin*) view ;


//-(id)initWithBlockDefault:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
//                landScape:(Boolean)landcape  view:(UsequenceDefaultLogin*) view ;


-(void)login_backButton;

@end
