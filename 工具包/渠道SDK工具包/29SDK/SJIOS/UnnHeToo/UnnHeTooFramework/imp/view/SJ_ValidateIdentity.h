

#import "UnnHeTooBaseView.h"
#import "UnnHeTooSdk_const_def.h"
#import "UnnHeTooProgressHUD.h"
#import "UnnHeTooSdkImp.h"
#import "UnnHeTooCommonApi.h"

@interface SJ_ValidateIdentity : UnnHeTooBaseView<UITextFieldDelegate>

@property(nonatomic,strong) UnnHeTooProgressHUD *process;
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) UnnHeToo_RV_Complete_Callback complete;
@property(nonatomic,strong) UITextField *name;
@property(nonatomic,strong) UITextField *identity;
@property(nonatomic,strong) NSString *accesstoken;
@property(nonatomic,strong) SJ_ValidateIdentity *sj_ValidateIdentity;//登录界面

- (id)initWithBlock:(NSString *)accesstoken complete:(UnnHeToo_RV_Complete_Callback)complete landscape:(Boolean)landscape;

@end
