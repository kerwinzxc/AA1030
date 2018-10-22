
#import <Foundation/Foundation.h>
#import "UsequenceSwitchDelegate.h"
#import <UIKit/UIKit.h>

@interface UsequenceFloatWindow : NSObject<UsequenceShowController>
{
    NSString *_accessToken;
}

-(void)show:(UIViewController *)viewController landspace:(BOOL)isLandscape;
-(void)dismissPop ;

+(UsequenceFloatWindow*)shareInstance;


-(void)setPosition:(CGPoint)startPoint;


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken;
@end


