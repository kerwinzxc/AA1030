

#import <UIKit/UIKit.h>

@interface PostinBindPhoneViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSString *accessToken;
-(id)initWithLandscape:(Boolean)landscape;
@property (assign, nonatomic)Boolean landscape;
@end
