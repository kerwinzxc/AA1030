
#import "RersistenceBaseView.h"
#import "UIControl+ZHW.h"

typedef void(^Rersistence_RV_Complete_Callback)(NSString *, NSString*);

@interface RersistenceRegisterView : RersistenceBaseView<UITextFieldDelegate>

- (id)initWithBlock:(Rersistence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape;

- (void)normalPressed;
-(void) ym_registerBack;
@end
