

#import "PostinBaseView.h"
typedef void(^Postin_RV_Complete_Callback)(NSString *, NSString*);
@interface PostinBind : PostinBaseView<UITextFieldDelegate>


- (id)initWithBlock:(Postin_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname;

- (void)bindPressed;

@end
