

#import "QroughtBaseView.h"
#import "QroughtQuickLogin.h"
#import "QroughtDefaultLogin.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "SJ_ValidateIdentity.h"
#import "UIControl+ZHW.h"

@interface QroughtYMLoginView : QroughtBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(QroughtQuickLogin*) view;

- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(QroughtQuickLogin*) view username:(NSString *)username;




-(void)login_backButton;

@end
