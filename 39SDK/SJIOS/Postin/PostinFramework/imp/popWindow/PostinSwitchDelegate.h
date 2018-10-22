

#import <Foundation/Foundation.h>

@protocol PostinSwitchDelegate <NSObject>
-(void)showPage:(NSUInteger)pageIndex;
@end

@protocol PostinShowController <NSObject>
@optional
-(void)dismissController;
-(void)showController;
@end
