

#import "RersistenceBaseView.h"
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "RersistenceProgressHUD.h"
#import "RersistenceSdkImp.h"
#import "RersistenceWebInterface.h"

@interface SJ_ValidateIdentity : RersistenceBaseView<UITextFieldDelegate>

@property(nonatomic,strong) RersistenceProgressHUD *process;
@property(nonatomic) Boolean SHOWPROCESS;
@property(nonatomic,strong) Rersistence_RV_Complete_Callback complete;
@property(nonatomic,strong) UITextField *name;
@property(nonatomic,strong) UITextField *identity;
@property(nonatomic,strong) NSString *accesstoken;
@property(nonatomic,strong) SJ_ValidateIdentity *sj_ValidateIdentity;//登录界面

- (id)initWithBlock:(NSString *)accesstoken complete:(Rersistence_RV_Complete_Callback)complete landscape:(Boolean)landscape;

@end
