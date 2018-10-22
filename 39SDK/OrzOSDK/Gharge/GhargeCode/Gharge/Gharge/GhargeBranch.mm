

#import <Foundation/Foundation.h>
#import "GhargeBranch.h"

@implementation GhargeBranch

+(GhargeBranch*)getSharedInstance
{
    static __strong GhargeBranch * targetBranch = nil;
    if (targetBranch == nil)
    {
        NSDictionary *ChannelParams = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"GhargeParams"];
        
        NSString *channelClassName = [[NSString alloc] initWithFormat:@"GhargeBranch_%@", [ChannelParams objectForKey:@"Channel_Name"]];
        NSLog(@"channelClassName  %@", channelClassName);
        Class BranchClass = NSClassFromString(channelClassName);
        if (BranchClass != nil)
        {
            NSLog(@"1");
            targetBranch = [BranchClass alloc];
        }else{
            NSLog(@"2");
        }
    }
    
    return targetBranch;
}

-(NSString *)getGhargeChannelSdkVersion{
    return @"1";
}

-(void)doGhargeChannelInit{
    
    
}

-(void)doGhargeChannelLogin{
}

-(void)doGhargeChannelSwitchAccount{
    
}


-(void)doGhargeChannelLogout{
    
}

-(void)doChannelshowGhargeGameCenter{
    
}

-(void)doChannelshowGhargeFloatView{
    
}

-(void)doChannelhideGhargeFloatView{
    
}

-(void)doGhargeChannelRegcharg:(NSDictionary *)params{
    
}

-(void)doGhargeChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    
}

-(void)doGhargeChannelRealNameRegister:(int)flag callback:(GhargeShiMimgRenZhengCallback)callback{
    
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}
- (void)applicationWillTerminate:(UIApplication *)application{
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return TRUE;
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler{
    return TRUE;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
}


-(UIView *)getGhargeCurrentView{
    

    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(UIViewController *)getGhargeCurrentViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
