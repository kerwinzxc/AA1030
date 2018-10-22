


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface EasterNoticeView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end


@interface EasterCheckUpdateView : UIView

- (id)initWithSize:(NSDictionary *)param;

- (void)show:(UIView *)view;

- (void)dismissWithAnimation:(BOOL)animated;

@end
