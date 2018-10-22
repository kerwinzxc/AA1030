

#import "RersistenceBaseView.h"
#import "RersistenceQuickLogin.h"
#import "RersistenceDefaultLogin.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "SJ_ValidateIdentity.h"
#import "UIControl+ZHW.h"

@interface RersistenceYMLoginView : RersistenceBaseView<UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(RersistenceQuickLogin*) view;

- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(RersistenceQuickLogin*) view username:(NSString *)username;




-(void)login_backButton;

@end
