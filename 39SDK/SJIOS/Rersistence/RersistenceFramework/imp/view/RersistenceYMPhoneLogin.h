

#import "RersistenceBaseView.h"
#import "RersistenceQuickLogin.h"
#import "RersistenceDefaultLogin.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "SJ_ValidateIdentity.h"

@interface RersistenceYMPhoneLogin : RersistenceBaseView<UITextFieldDelegate>

typedef void(^Rersistence_RV_Complete_Callback)(NSString *, NSString*);

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(RersistenceQuickLogin*) view ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
