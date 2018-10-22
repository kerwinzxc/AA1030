

#import "UsequenceBaseView.h"
#import "UsequenceQuickLogin.h"
#import "UsequenceDefaultLogin.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "SJ_ValidateIdentity.h"

@interface UsequenceYMPhoneLogin : UsequenceBaseView<UITextFieldDelegate>

typedef void(^Usequence_RV_Complete_Callback)(NSString *, NSString*);

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(UsequenceQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
