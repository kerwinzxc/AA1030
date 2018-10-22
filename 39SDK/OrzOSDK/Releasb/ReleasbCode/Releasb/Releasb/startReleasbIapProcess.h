
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ReleasbUtils.h"

@interface startReleasbIapProcess : UIView<UIWebViewDelegate>

@property(nonatomic, strong) UIView *parent_RegchargReleasb;
@property(nonatomic, strong) UIView *alertView_RegchargReleasb;

@property(nonatomic, strong) ReleasbXXXCloseCallback cb_RegchargReleasb;
@property (strong, nonatomic)NSString *Regchargstr_RegchargReleasb;

- (id)initWithSize:(NSDictionary *)param
           iapInfo:(NSString *)iapInfo
                cb:(ReleasbXXXCloseCallback)cb;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;
@end
