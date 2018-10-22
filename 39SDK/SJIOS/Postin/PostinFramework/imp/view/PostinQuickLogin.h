

#import "PostinBaseView.h"
#import "PostinQuickLogin.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "SJ_ValidateIdentity.h"

@interface PostinQuickLogin : PostinBaseView


- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
          landScape:(Boolean)landcape;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

-(void) quickQuickClick;
-(void) loginQuickClicke;
//-(void) registerQuickClick;
//-(void) cellphoneRegister;
-(void) ym_phoneRegister;
@end
