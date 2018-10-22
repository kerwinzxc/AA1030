

#import "UsequenceBaseView.h"
#import "UsequenceQuickLogin.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "SJ_ValidateIdentity.h"

@interface UsequenceQuickLogin : UsequenceBaseView


- (id)initWithBlock:(Usequence_SUCCESS_Callback)success failed:(Usequence_FAILED_Callback)failed
          landScape:(Boolean)landcape;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

-(void) quickQuickClick;
-(void) loginQuickClicke;
//-(void) registerQuickClick;
//-(void) cellphoneRegister;
-(void) ym_phoneRegister;
@end
