

#import "SJIOSBaseView.h"
#import "SJIOSQuickLogin.h"
#import "SJIOSDefaultLogin.h"
#import "SJIOSSdkCommonDefine.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"


#import "SJ_ValidateIdentity.h"
#import "UIControl+ZHW.h"

@interface SJIOSYMLoginView : SJIOSBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(SJIOSQuickLogin*) view;

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(SJIOSQuickLogin*) view username:(NSString *)username;




-(void)login_backButton;

@end
