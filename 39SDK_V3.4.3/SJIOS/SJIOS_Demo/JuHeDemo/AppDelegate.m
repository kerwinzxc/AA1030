

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    //此处填入原来游戏的viercontroller
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *controller = [[ViewController alloc] init];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];

    
    
    //    [[OrzOSDK getSharedInstance] getOrzOSDKHKeJiFlag:^(BOOL flag){
    //        self.nowStatus = flag;
    //        if(flag == NO){
    //            //此处填入原来游戏的viercontroller
    //            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //            self.window.backgroundColor = [UIColor whiteColor];
    //            ViewController *controller = [[ViewController alloc] init];
    //            self.window.rootViewController = controller;
    //            [self.window makeKeyAndVisible];
    //        }else{
    //            //此处可直接复制
    //            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //            self.window.backgroundColor = [UIColor whiteColor];
    //            self.window.rootViewController = [[OrzOSDK getSharedInstance] showOrzOSDKHKeJiVC];
    //            [self.window makeKeyAndVisible];
    //
    //        }
    //
    //    }];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end

