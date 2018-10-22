

#import "PostinBaseView.h"
#import "PostinQuickLogin.h"
#import "PostinDefaultLogin.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "SJ_ValidateIdentity.h"
#import "UIControl+ZHW.h"

@interface PostinYMLoginView : PostinBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(PostinQuickLogin*) view;

- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(PostinQuickLogin*) view username:(NSString *)username;




-(void)login_backButton;

@end
