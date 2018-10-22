

#import <UIKit/UIKit.h>

@interface QroughtBindPhoneViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSString *accessToken;
-(id)initWithLandscape:(Boolean)landscape;
@property (assign, nonatomic)Boolean landscape;
@end
