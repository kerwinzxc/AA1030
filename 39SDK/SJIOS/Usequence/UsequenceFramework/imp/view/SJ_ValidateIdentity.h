

#import "UsequenceBaseView.h"
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "UsequenceProgressHUD.h"
#import "UsequenceSdkImp.h"
#import "UsequenceWebInterface.h"

@interface SJ_ValidateIdentity : UsequenceBaseView<UITextFieldDelegate>

@property(nonatomic,strong) UsequenceProgressHUD *process;
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) Usequence_RV_Complete_Callback complete;
@property(nonatomic,strong) UITextField *name;
@property(nonatomic,strong) UITextField *identity;
@property(nonatomic,strong) NSString *accesstoken;
@property(nonatomic,strong) SJ_ValidateIdentity *sj_ValidateIdentity;//登录界面

- (id)initWithBlock:(NSString *)accesstoken complete:(Usequence_RV_Complete_Callback)complete landscape:(Boolean)landscape;

@end
