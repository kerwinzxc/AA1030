
#import <Foundation/Foundation.h>
#import "QroughtSwitchDelegate.h"
#import <UIKit/UIKit.h>

@interface QroughtFloatWindow : NSObject<QroughtShowController>
{
    NSString *_accessToken;
}

-(void)show:(UIViewController *)viewController landspace:(BOOL)isLandscape;
-(void)dismissPop ;

+(QroughtFloatWindow*)shareInstance;


-(void)setPosition:(CGPoint)startPoint;


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken;
@end


