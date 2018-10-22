
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EasterUtils.h"

@interface startEasterIapProcess : UIView<UIWebViewDelegate>

@property(nonatomic, strong) UIView *parent_RegchargEaster;
@property(nonatomic, strong) UIView *alertView_RegchargEaster;

@property(nonatomic, strong) EasterXXXCloseCallback cb_RegchargEaster;
@property (strong, nonatomic)NSString *Regchargstr_RegchargEaster;

- (id)initWithSize:(NSDictionary *)param
           iapInfo:(NSString *)iapInfo
                cb:(EasterXXXCloseCallback)cb;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;
@end
