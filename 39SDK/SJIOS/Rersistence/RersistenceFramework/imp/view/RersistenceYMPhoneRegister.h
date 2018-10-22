

#import "RersistenceBaseView.h"
#import "RersistenceQuickLogin.h"
#import "RersistenceDefaultLogin.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "UIControl+ZHW.h"

@interface RersistenceYMPhoneRegister : RersistenceBaseView<UITextFieldDelegate>

typedef void(^Rersistence_RV_Complete_Callback)(NSString *, NSString*);


- (id)initWithBlock:(Rersistence_RV_Complete_Callback)complete
          landscape:(Boolean)landscape ymPhoneNumber:(NSString *)ymPhoneNum;



-(void)login_backButton;

@end
