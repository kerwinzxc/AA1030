


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OrzOSDKNoticeView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end


@interface OrzOSDKCheckUpdateView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
