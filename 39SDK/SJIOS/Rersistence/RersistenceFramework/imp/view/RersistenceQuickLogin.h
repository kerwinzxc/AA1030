

#import "RersistenceBaseView.h"
#import "RersistenceQuickLogin.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "SJ_ValidateIdentity.h"

@interface RersistenceQuickLogin : RersistenceBaseView


- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

-(void) quickQuickClick;
-(void) loginQuickClicke;
//-(void) registerQuickClick;
//-(void) cellphoneRegister;
-(void) ym_phoneRegister;
@end
