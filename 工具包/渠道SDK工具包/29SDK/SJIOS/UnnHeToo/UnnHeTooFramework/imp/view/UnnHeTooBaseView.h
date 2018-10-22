
#import <UIKit/UIKit.h>

@interface UnnHeTooBaseView : UIView

@property(nonatomic, strong) UIView *parent;
@property(nonatomic, strong) UIView *alertContainer;
@property(nonatomic, assign) Boolean landscape;

- (id)init;

- (id)initWithSize:(CGSize)size
         landScape:(Boolean)landScape;


- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
