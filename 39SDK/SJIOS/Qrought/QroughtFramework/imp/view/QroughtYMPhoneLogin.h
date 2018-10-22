

#import "QroughtBaseView.h"
#import "QroughtQuickLogin.h"
#import "QroughtDefaultLogin.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "SJ_ValidateIdentity.h"

@interface QroughtYMPhoneLogin : QroughtBaseView<UITextFieldDelegate>

typedef void(^Qrought_RV_Complete_Callback)(NSString *, NSString*);

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(QroughtQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
