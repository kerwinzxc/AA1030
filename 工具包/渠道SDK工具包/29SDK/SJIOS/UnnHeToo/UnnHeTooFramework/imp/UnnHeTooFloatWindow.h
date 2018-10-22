
#import <Foundation/Foundation.h>
#import "UnnHeTooSwitchDelegate.h"
#import <UIKit/UIKit.h>

@interface UnnHeTooFloatWindow : NSObject<UnnHeTooShowController>
{
    NSString *_accessToken;
}

-(void)show:(UIViewController *)viewController landspace:(BOOL)isLandscape;
-(void)dismissPop ;

+(UnnHeTooFloatWindow*)shareInstance;


-(void)setPosition:(CGPoint)startPoint;


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken;
@end


