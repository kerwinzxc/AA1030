

#import <Foundation/Foundation.h>

@protocol RersistenceSwitchDelegate <NSObject>
-(void)showPage:(NSUInteger)pageIndex;
@end

@protocol RersistenceShowController <NSObject>
@optional
-(void)dismissController;
-(void)showController;
@end
