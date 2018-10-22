

#import <Foundation/Foundation.h>

@protocol QroughtSwitchDelegate <NSObject>
-(void)showPage:(NSUInteger)pageIndex;
@end

@protocol QroughtShowController <NSObject>
@optional
-(void)dismissController;
-(void)showController;
@end
