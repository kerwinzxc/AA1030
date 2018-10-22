//
//  AppDelegate.h
//
//  Created by aXiBa on 15/2/4.
//  Copyright (c) 2015年 aXiBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZS4Game/Zs4GameHeader.h>
#import "Zs4GameInitViewCtr.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Zs4GameInitViewCtr *gameInitViewController;
}

@property (strong, nonatomic) UIWindow *window;


@end

