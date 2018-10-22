

#import "UsequenceBaseView.h"
typedef void(^Usequence_RV_Complete_Callback)(NSString *, NSString*);
@interface UsequenceBind : UsequenceBaseView<UITextFieldDelegate>


- (id)initWithBlock:(Usequence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname;

- (void)bindPressed;

@end
