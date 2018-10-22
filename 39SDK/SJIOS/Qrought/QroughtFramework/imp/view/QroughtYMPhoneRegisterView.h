

#import "QroughtBaseView.h"
#import "QroughtQuickLogin.h"
#import "QroughtDefaultLogin.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "SJ_ValidateIdentity.h"

@interface QroughtYMPhoneRegisterView : QroughtBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ymPhoneNum;
@property (nonatomic, strong) UITextField *ymPassword;

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(QroughtQuickLogin*) view ;


//-(id)initWithBlockDefault:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
//                landScape:(Boolean)landcape  view:(QroughtDefaultLogin*) view ;


-(void)login_backButton;

@end
