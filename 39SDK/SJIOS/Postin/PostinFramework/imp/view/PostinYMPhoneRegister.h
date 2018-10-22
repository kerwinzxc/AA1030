

#import "PostinBaseView.h"
#import "PostinQuickLogin.h"
#import "PostinDefaultLogin.h"
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "UIControl+ZHW.h"

@interface PostinYMPhoneRegister : PostinBaseView<UITextFieldDelegate>

typedef void(^Postin_RV_Complete_Callback)(NSString *, NSString*);


- (id)initWithBlock:(Postin_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
