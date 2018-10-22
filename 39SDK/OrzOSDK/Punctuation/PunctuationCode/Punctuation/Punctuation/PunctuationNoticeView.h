


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PunctuationNoticeView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end


@interface PunctuationCheckUpdateView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
