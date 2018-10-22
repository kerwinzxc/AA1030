

#import <UIKit/UIKit.h>

@interface SJIOSBindIdentifyViewController : UIViewController<UITextFieldDelegate>{
    
    UITextField *identifyNumberField;
    UITextField *identifyNameField;
}

@property (nonatomic, strong) NSString *accessToken;
-(id)initWithLandscape:(Boolean)landscape;
@property (assign, nonatomic)Boolean landscape;
@end
