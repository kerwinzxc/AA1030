

#import "SJIOSBaseView.h"
#import "SJIOSQuickLogin.h"
#import "SJIOSDefaultLogin.h"
#import "SJIOSSdkCommonDefine.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"


#import "SJ_ValidateIdentity.h"

@interface SJIOSYMPhoneRegisterView : SJIOSBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ymPhoneNum;
@property (nonatomic, strong) UITextField *ymPassword;

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(SJIOSQuickLogin*) view ;


//-(id)initWithBlockDefault:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
//                landScape:(Boolean)landcape  view:(SJIOSDefaultLogin*) view ;


-(void)login_backButton;

@end
