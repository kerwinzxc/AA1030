

#import <Foundation/Foundation.h>

@protocol SJIOSSwitchDelegate <NSObject>
-(void)showPage:(NSUInteger)pageIndex;
@end

@protocol SJIOSShowController <NSObject>
@optional
-(void)dismissController;
-(void)showController;
@end
