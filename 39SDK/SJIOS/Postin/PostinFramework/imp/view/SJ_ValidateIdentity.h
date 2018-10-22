

#import "PostinBaseView.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "PostinProgressHUD.h"
#import "PostinSdkImp.h"
#import "PostinWebInterface.h"

@interface SJ_ValidateIdentity : PostinBaseView<UITextFieldDelegate>

@property(nonatomic,strong) PostinProgressHUD *process;
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) Postin_RV_Complete_Callback complete;
@property(nonatomic,strong) UITextField *name;
@property(nonatomic,strong) UITextField *identity;
@property(nonatomic,strong) NSString *accesstoken;
@property(nonatomic,strong) SJ_ValidateIdentity *sj_ValidateIdentity;//登录界面

- (id)initWithBlock:(NSString *)accesstoken complete:(Postin_RV_Complete_Callback)complete landscape:(Boolean)landscape;

@end
