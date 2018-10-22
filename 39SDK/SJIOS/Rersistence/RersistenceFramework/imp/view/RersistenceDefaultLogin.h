
#import "RersistenceBaseView.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "SJ_ValidateIdentity.h"
@interface RersistenceDefaultLogin : RersistenceBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
