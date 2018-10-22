
#import <Foundation/Foundation.h>
#import "RersistenceSwitchDelegate.h"
#import <UIKit/UIKit.h>

@interface RersistenceFloatWindow : NSObject<RersistenceShowController>
{
    NSString *_accessToken;
}

-(void)show:(UIViewController *)viewController landspace:(BOOL)isLandscape;
-(void)dismissPop ;

+(RersistenceFloatWindow*)shareInstance;


-(void)setPosition:(CGPoint)startPoint;


-(void)setViewController:(UIViewController *)viewController isLandspace:(Boolean)isLandspace accessToken:(NSString*) accessToken;
@end


