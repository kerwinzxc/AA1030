
#import <Foundation/Foundation.h>
#import "PostinSwitchDelegate.h"
#import <UIKit/UIKit.h>

@interface PostinFloatWindow : NSObject<PostinShowController>
{
    NSString *_accessToken;
}

-(void)show:(UIViewController *)viewController landspace:(BOOL)isLandscape;
-(void)dismissPop ;

+(PostinFloatWindow*)shareInstance;


-(void)setPosition:(CGPoint)startPoint;


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken;
@end


