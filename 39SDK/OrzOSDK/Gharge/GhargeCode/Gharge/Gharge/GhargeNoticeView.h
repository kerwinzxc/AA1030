


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GhargeNoticeView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end


@interface GhargeCheckUpdateView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
