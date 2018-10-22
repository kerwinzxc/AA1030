
#import "SJIOSBaseView.h"
#import "UIControl+ZHW.h"

typedef void(^SJIOS_RV_Complete_Callback)(NSString *, NSString*);

@interface SJIOSRegisterView : SJIOSBaseView<UITextFieldDelegate>

- (id)initWithBlock:(SJIOS_RV_Complete_Callback)complete
          landscape:(Boolean)landscape;

- (void)normalPressed;
-(void) ym_registerBack;
@end
