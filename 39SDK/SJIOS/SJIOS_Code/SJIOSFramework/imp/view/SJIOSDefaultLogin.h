
#import "SJIOSBaseView.h"
#import "SJIOSSdkCommonDefine.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"


#import "SJ_ValidateIdentity.h"
@interface SJIOSDefaultLogin : SJIOSBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
