
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GhargeUtils.h"

@interface startGhargeIapProcess : UIView<UIWebViewDelegate>

@property(nonatomic, strong) UIView *parent_RegchargGharge;
@property(nonatomic, strong) UIView *alertView_RegchargGharge;

@property(nonatomic, strong) GhargeXXXCloseCallback cb_RegchargGharge;
@property (strong, nonatomic)NSString *Regchargstr_RegchargGharge;

- (id)initWithSize:(NSDictionary *)param
           iapInfo:(NSString *)iapInfo
                cb:(GhargeXXXCloseCallback)cb;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;
@end
