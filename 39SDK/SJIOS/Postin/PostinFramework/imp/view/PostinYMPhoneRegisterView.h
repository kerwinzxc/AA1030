

#import "PostinBaseView.h"
#import "PostinQuickLogin.h"
#import "PostinDefaultLogin.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "SJ_ValidateIdentity.h"

@interface PostinYMPhoneRegisterView : PostinBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ymPhoneNum;
@property (nonatomic, strong) UITextField *ymPassword;

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(PostinQuickLogin*) view ;


//-(id)initWithBlockDefault:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
//                landScape:(Boolean)landcape  view:(PostinDefaultLogin*) view ;


-(void)login_backButton;

@end
