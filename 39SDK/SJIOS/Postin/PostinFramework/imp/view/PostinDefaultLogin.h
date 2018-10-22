
#import "PostinBaseView.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "SJ_ValidateIdentity.h"
@interface PostinDefaultLogin : PostinBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
