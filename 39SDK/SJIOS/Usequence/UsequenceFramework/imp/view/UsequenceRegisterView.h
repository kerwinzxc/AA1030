
#import "UsequenceBaseView.h"
#import "UIControl+ZHW.h"

typedef void(^Usequence_RV_Complete_Callback)(NSString *, NSString*);

@interface UsequenceRegisterView : UsequenceBaseView<UITextFieldDelegate>

- (id)initWithBlock:(Usequence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape;

- (void)normalPressed;
-(void) ym_registerBack;
@end
