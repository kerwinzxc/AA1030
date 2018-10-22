
#import "UsequenceBaseView.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "SJ_ValidateIdentity.h"
@interface UsequenceDefaultLogin : UsequenceBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
