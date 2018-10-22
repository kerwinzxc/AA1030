
#import <UIKit/UIKit.h>
#import "RersistenceBaseView.h"

@interface RersistenceForgetEmailView : RersistenceBaseView <UITextFieldDelegate>

- (id)initWithLandscape:(Boolean)landscape
                  phone:(UIButton*)phone
                     qq:(UIButton*)qq;

@end
