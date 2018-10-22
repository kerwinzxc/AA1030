

#import "SJIOSBaseView.h"
#import "SJIOSSdkCommonDefine.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"


#import "SJIOSProgressHUD.h"
#import "SJIOSSdkImp.h"
#import "SJIOSWebInterface.h"

@interface SJ_ValidateIdentity : SJIOSBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJIOSProgressHUD *process;
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) SJIOS_RV_Complete_Callback complete;
@property(nonatomic,strong) UITextField *name;
@property(nonatomic,strong) UITextField *identity;
@property(nonatomic,strong) NSString *accesstoken;
@property(nonatomic,strong) SJ_ValidateIdentity *sj_ValidateIdentity;//登录界面

- (id)initWithBlock:(NSString *)accesstoken complete:(SJIOS_RV_Complete_Callback)complete landscape:(Boolean)landscape;

@end
