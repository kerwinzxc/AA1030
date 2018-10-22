

#import "QroughtBaseView.h"
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "QroughtProgressHUD.h"
#import "QroughtSdkImp.h"
#import "QroughtWebInterface.h"

@interface SJ_ValidateIdentity : QroughtBaseView<UITextFieldDelegate>

@property(nonatomic,strong) QroughtProgressHUD *process;
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) Qrought_RV_Complete_Callback complete;
@property(nonatomic,strong) UITextField *name;
@property(nonatomic,strong) UITextField *identity;
@property(nonatomic,strong) NSString *accesstoken;
@property(nonatomic,strong) SJ_ValidateIdentity *sj_ValidateIdentity;//登录界面

- (id)initWithBlock:(NSString *)accesstoken complete:(Qrought_RV_Complete_Callback)complete landscape:(Boolean)landscape;

@end
