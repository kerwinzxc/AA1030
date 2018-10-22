
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PunctuationUtils.h"

@interface startPunctuationIapProcess : UIView<UIWebViewDelegate>

@property(nonatomic, strong) UIView *parent_RegchargPunctuation;
@property(nonatomic, strong) UIView *alertView_RegchargPunctuation;

@property(nonatomic, strong) PunctuationXXXCloseCallback cb_RegchargPunctuation;
@property (strong, nonatomic)NSString *Regchargstr_RegchargPunctuation;

- (id)initWithSize:(NSDictionary *)param
           iapInfo:(NSString *)iapInfo
                cb:(PunctuationXXXCloseCallback)cb;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;
@end
