

#import <UIKit/UIKit.h>
#import "RersistenceBaseView.h"
#import "SJ_ValidateIdentity.h"
#import "RersistenceQuickLogin.h"
#import "RersistenceDefaultLogin.h"

@interface RersistenceYMBindPhoneView : RersistenceBaseView <UITextFieldDelegate>

@property(nonatomic,strong) SJ_ValidateIdentity *sjValidateIdentity;

@property (nonatomic, strong) NSString *accessToken;
- (id)initWithLandscape:(Boolean)landscape;


@end
