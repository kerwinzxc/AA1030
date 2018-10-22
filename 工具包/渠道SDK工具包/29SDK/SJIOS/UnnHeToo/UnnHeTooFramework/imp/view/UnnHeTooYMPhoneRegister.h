

#import "UnnHeTooBaseView.h"
#import "UnnHeTooQuickLogin.h"
#import "UnnHeTooDefaultLogin.h"
#import "UnnHeTooSdk_const_def.h"
#import "UIControl+ZHW.h"

@interface UnnHeTooYMPhoneRegister : UnnHeTooBaseView<UITextFieldDelegate>

typedef void(^UnnHeToo_RV_Complete_Callback)(NSString *, NSString*);


- (id)initWithBlock:(UnnHeToo_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
