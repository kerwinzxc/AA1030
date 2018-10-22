
#import <UIKit/UIKit.h>
#import "PostinBaseView.h"

@interface PostinForgetEmailView : PostinBaseView <UITextFieldDelegate>

- (id)initWithLandscape:(Boolean)landscape
                  phone:(UIButton*)phone
                     qq:(UIButton*)qq;

@end
