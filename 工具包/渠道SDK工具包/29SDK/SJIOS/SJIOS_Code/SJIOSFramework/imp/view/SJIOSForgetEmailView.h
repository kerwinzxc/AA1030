
#import <UIKit/UIKit.h>
#import "SJIOSBaseView.h"

@interface SJIOSForgetEmailView : SJIOSBaseView <UITextFieldDelegate>

- (id)initWithLandscape:(Boolean)landscape
                  phone:(NSString*)phone
                     qq:(NSString*)qq;

@end
