
#import "SJIOSBaseView.h"
#import "SJIOSSdk_const_def.h"
#import "SJ_ValidateIdentity.h"
@interface SJIOSDefaultLogin : SJIOSBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
