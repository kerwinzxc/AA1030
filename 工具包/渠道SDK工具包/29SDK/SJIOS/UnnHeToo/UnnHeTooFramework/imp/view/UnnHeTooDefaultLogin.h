
#import "UnnHeTooBaseView.h"
#import "UnnHeTooSdk_const_def.h"
#import "SJ_ValidateIdentity.h"
@interface UnnHeTooDefaultLogin : UnnHeTooBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
