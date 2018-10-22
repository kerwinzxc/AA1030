

#import "QroughtBaseView.h"
#import "QroughtQuickLogin.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "SJ_ValidateIdentity.h"

@interface QroughtQuickLogin : QroughtBaseView


- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
          landScape:(Boolean)landcape;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

-(void) quickQuickClick;
-(void) loginQuickClicke;
//-(void) registerQuickClick;
//-(void) cellphoneRegister;
-(void) ym_phoneRegister;
@end
