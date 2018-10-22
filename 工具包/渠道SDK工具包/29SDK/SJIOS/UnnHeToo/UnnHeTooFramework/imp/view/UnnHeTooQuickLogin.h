

#import "UnnHeTooBaseView.h"
#import "UnnHeTooQuickLogin.h"
#import "UnnHeTooSdk_const_def.h"
#import "SJ_ValidateIdentity.h"

@interface UnnHeTooQuickLogin : UnnHeTooBaseView


- (id)initWithBlock:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed
          landScape:(Boolean)landcape;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

-(void) quickQuickClick;
-(void) loginQuickClicke;
//-(void) registerQuickClick;
//-(void) cellphoneRegister;
-(void) ym_phoneRegister;
@end
