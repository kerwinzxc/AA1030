
#import <UIKit/UIKit.h>
#import "SJIOSBaseView.h"

@interface SJIOSForgetEmailView : SJIOSBaseView <UITextFieldDelegate>

- (id)initWithLandscape:(Boolean)landscape
                  phone:(UIButton*)phone
                     qq:(UIButton*)qq;

@end
