


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ReleasbNoticeView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end


@interface ReleasbCheckUpdateView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
