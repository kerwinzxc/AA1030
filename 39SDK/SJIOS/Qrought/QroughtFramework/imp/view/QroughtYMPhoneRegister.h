

#import "QroughtBaseView.h"
#import "QroughtQuickLogin.h"
#import "QroughtDefaultLogin.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "UIControl+ZHW.h"

@interface QroughtYMPhoneRegister : QroughtBaseView<UITextFieldDelegate>

typedef void(^Qrought_RV_Complete_Callback)(NSString *, NSString*);


- (id)initWithBlock:(Qrought_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
