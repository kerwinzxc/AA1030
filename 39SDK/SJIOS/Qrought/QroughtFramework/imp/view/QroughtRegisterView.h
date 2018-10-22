
#import "QroughtBaseView.h"
#import "UIControl+ZHW.h"

typedef void(^Qrought_RV_Complete_Callback)(NSString *, NSString*);

@interface QroughtRegisterView : QroughtBaseView<UITextFieldDelegate>

- (id)initWithBlock:(Qrought_RV_Complete_Callback)complete
          landscape:(Boolean)landscape;

- (void)normalPressed;
-(void) ym_registerBack;
@end
