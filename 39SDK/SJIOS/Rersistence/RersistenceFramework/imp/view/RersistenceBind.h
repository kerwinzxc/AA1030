

#import "RersistenceBaseView.h"
typedef void(^Rersistence_RV_Complete_Callback)(NSString *, NSString*);
@interface RersistenceBind : RersistenceBaseView<UITextFieldDelegate>


- (id)initWithBlock:(Rersistence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname;

- (void)bindPressed;

@end
