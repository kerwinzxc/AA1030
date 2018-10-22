
#import <UIKit/UIKit.h>
#import "QroughtBaseView.h"

@interface QroughtForgetEmailView : QroughtBaseView <UITextFieldDelegate>

- (id)initWithLandscape:(Boolean)landscape
                  phone:(UIButton*)phone
                     qq:(UIButton*)qq;

@end
