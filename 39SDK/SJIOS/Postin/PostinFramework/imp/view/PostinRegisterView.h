
#import "PostinBaseView.h"
#import "UIControl+ZHW.h"

typedef void(^Postin_RV_Complete_Callback)(NSString *, NSString*);

@interface PostinRegisterView : PostinBaseView<UITextFieldDelegate>

- (id)initWithBlock:(Postin_RV_Complete_Callback)complete
          landscape:(Boolean)landscape;

- (void)normalPressed;
-(void) ym_registerBack;
@end
