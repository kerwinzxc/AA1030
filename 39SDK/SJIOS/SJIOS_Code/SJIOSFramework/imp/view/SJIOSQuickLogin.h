

#import "SJIOSBaseView.h"
#import "SJIOSQuickLogin.h"
#import "SJIOSSdkCommonDefine.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"


#import "SJ_ValidateIdentity.h"

@interface SJIOSQuickLogin : SJIOSBaseView


- (id)initWithBlock:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed
          landScape:(Boolean)landcape;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

-(void) quickQuickClick;
-(void) loginQuickClicke;
//-(void) registerQuickClick;
//-(void) cellphoneRegister;
-(void) ym_phoneRegister;
@end
