

#import <Foundation/Foundation.h>

@protocol UsequenceSwitchDelegate <NSObject>
-(void)showPage:(NSUInteger)pageIndex;
@end

@protocol UsequenceShowController <NSObject>
@optional
-(void)dismissController;
-(void)showController;
@end
