
#import "UnnHeTooBaseView.h"
#import "UIControl+ZHW.h"

typedef void(^UnnHeToo_RV_Complete_Callback)(NSString *, NSString*);

@interface UnnHeTooRegisterView : UnnHeTooBaseView<UITextFieldDelegate>

- (id)initWithBlock:(UnnHeToo_RV_Complete_Callback)complete
          landscape:(Boolean)landscape;

- (void)normalPressed;
-(void) ym_registerBack;
@end
