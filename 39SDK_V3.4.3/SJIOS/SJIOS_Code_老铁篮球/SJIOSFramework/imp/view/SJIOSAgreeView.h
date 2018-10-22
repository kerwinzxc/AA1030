

#import <UIKit/UIKit.h>

@interface SJIOSAgreeView : UIView

@property(nonatomic, strong) UIAlertView *parent;
@property(nonatomic, strong) UIAlertView *alertContainer;
@property(nonatomic, assign) Boolean landscape;

- (id)init;

- (id)initWithSize:(CGSize)size
         landScape:(Boolean)landScape;


- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
