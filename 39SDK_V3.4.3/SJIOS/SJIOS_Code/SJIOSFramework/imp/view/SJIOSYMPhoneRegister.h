

#import "SJIOSBaseView.h"
#import "SJIOSQuickLogin.h"
#import "SJIOSDefaultLogin.h"
#import "SJIOSSdkCommonDefine.h"
#import "UIControl+ZHW.h"

@interface SJIOSYMPhoneRegister : SJIOSBaseView<UITextFieldDelegate>

typedef void(^SJIOS_RV_Complete_Callback)(NSString *, NSString*);


- (id)initWithBlock:(SJIOS_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
