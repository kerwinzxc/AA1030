
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OrzOSDKUtils.h"

@interface startOrzOSDKIapProcess : UIView<UIWebViewDelegate>

@property(nonatomic, strong) UIView *parent_RegchargOrzOSDK;
@property(nonatomic, strong) UIView *alertView_RegchargOrzOSDK;

@property(nonatomic, strong) OrzOSDKXXXCloseCallback cb_RegchargOrzOSDK;
@property (strong, nonatomic)NSString *Regchargstr_RegchargOrzOSDK;

- (id)initWithSize:(NSDictionary *)param
           iapInfo:(NSString *)iapInfo
                cb:(OrzOSDKXXXCloseCallback)cb;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;
@end
