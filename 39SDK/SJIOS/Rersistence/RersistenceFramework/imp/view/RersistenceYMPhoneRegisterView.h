

#import "RersistenceBaseView.h"
#import "RersistenceQuickLogin.h"
#import "RersistenceDefaultLogin.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "SJ_ValidateIdentity.h"

@interface RersistenceYMPhoneRegisterView : RersistenceBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *ymPhoneNum;
@property (nonatomic, strong) UITextField *ymPassword;

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

- (id)initWithBlock:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
          landScape:(Boolean)landcape  view:(RersistenceQuickLogin*) view ;


//-(id)initWithBlockDefault:(Rersistence_SUCCESS_Callback)success failed:(Rersistence_FAILED_Callback)failed
//                landScape:(Boolean)landcape  view:(RersistenceDefaultLogin*) view ;


-(void)login_backButton;

@end
