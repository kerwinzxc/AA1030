
#import "QroughtBaseView.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "SJ_ValidateIdentity.h"
@interface QroughtDefaultLogin : QroughtBaseView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithBlock:(Qrought_SUCCESS_Callback)success failed:(Qrought_FAILED_Callback)failed
          landScape:(Boolean)landcape ;


@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;
- (void) registerPressed;
-(void) footClick;
@end
