

#import "PostinBaseView.h"
#import "PostinQuickLogin.h"
#import "PostinDefaultLogin.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "SJ_ValidateIdentity.h"

@interface PostinYMPhoneLogin : PostinBaseView<UITextFieldDelegate>

typedef void(^Postin_RV_Complete_Callback)(NSString *, NSString*);

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Postin_SUCCESS_Callback)success failed:(Postin_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(PostinQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
