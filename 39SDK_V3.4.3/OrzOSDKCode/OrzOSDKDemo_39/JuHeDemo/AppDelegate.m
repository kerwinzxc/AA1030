

#import "AppDelegate.h"
#import "OrzOSDK.h"
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
    
    [[OrzOSDK getSharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[OrzOSDK getSharedInstance] applicationWillResignActive:application];
    if(self.nowStatus == NO){
        //游戏逻辑
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[OrzOSDK getSharedInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[OrzOSDK getSharedInstance] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[OrzOSDK getSharedInstance] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[OrzOSDK getSharedInstance] applicationWillTerminate:application];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [[OrzOSDK getSharedInstance] application:application handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[OrzOSDK getSharedInstance] application:application openURL:url options:options];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[OrzOSDK getSharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return [[OrzOSDK getSharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

@end

