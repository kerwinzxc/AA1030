

#import "SJIOSBaseView.h"
typedef void(^SJIOS_RV_Complete_Callback)(NSString *, NSString*);
@interface SJIOSBind : SJIOSBaseView<UITextFieldDelegate>


- (id)initWithBlock:(SJIOS_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname;

- (void)bindPressed;

@end
