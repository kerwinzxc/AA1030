
#import <Foundation/Foundation.h>
#import "SJIOSSwitchDelegate.h"
#import <UIKit/UIKit.h>

@interface SJIOSFloatWindow : NSObject<SJIOSShowController>
{
    NSString *_accessToken;
}

-(void)show:(UIViewController *)viewController landspace:(BOOL)isLandscape;
-(void)dismissPop ;

+(SJIOSFloatWindow*)shareInstance;


-(void)setPosition:(CGPoint)startPoint;


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken;
@end


