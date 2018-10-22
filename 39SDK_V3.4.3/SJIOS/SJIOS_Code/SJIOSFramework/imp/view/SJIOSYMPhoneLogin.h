

#import "SJIOSBaseView.h"
#import "SJIOSQuickLogin.h"
#import "SJIOSDefaultLogin.h"
#import "SJIOSSdkCommonDefine.h"
#import "SJ_ValidateIdentity.h"

@interface SJIOSYMPhoneLogin : SJIOSBaseView<UITextFieldDelegate>

typedef void(^SJIOS_RV_Complete_Callback)(NSString *, NSString*);

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(SJIOSQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
