

#import <Foundation/Foundation.h>

@protocol UnnHeTooSwitchDelegate <NSObject>
-(void)showPage:(NSUInteger)pageIndex;
@end

@protocol UnnHeTooShowController <NSObject>
@optional
-(void)dismissController;
-(void)showController;
@end
