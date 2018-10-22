

#import "QroughtBaseView.h"
typedef void(^Qrought_RV_Complete_Callback)(NSString *, NSString*);
@interface QroughtBind : QroughtBaseView<UITextFieldDelegate>


- (id)initWithBlock:(Qrought_RV_Complete_Callback)complete
          landscape:(Boolean)landscape bindname:(NSString *) bindname;

- (void)bindPressed;

@end
