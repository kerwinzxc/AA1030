

#import "UnnHeTooBaseView.h"
typedef void(^UnnHeToo_RV_Complete_Callback)(NSString *, NSString*);
@interface UnnHeTooBind : UnnHeTooBaseView<UITextFieldDelegate>


- (id)initWithBlock:(UnnHeToo_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname;

- (void)bindPressed;

@end
