
#import <UIKit/UIKit.h>
#import "UnnHeTooBaseView.h"

@interface UnnHeTooForgetEmailView : UnnHeTooBaseView <UITextFieldDelegate>

- (id)initWithLandscape:(Boolean)landscape
                  phone:(NSString*)phone
                     qq:(NSString*)qq;

@end
