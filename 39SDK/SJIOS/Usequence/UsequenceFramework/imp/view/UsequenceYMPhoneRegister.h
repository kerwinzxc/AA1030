

#import "UsequenceBaseView.h"
#import "UsequenceQuickLogin.h"
#import "UsequenceDefaultLogin.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "UIControl+ZHW.h"

@interface UsequenceYMPhoneRegister : UsequenceBaseView<UITextFieldDelegate>

typedef void(^Usequence_RV_Complete_Callback)(NSString *, NSString*);


- (id)initWithBlock:(Usequence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
