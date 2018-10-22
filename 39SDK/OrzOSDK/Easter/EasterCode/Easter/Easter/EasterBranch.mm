

#import <Foundation/Foundation.h>
#import "EasterBranch.h"

@implementation EasterBranch

+(EasterBranch*)getSharedInstance
{
    static __strong EasterBranch * targetBranch = nil;
    if (targetBranch == nil)
    {
        NSDictionary *ChannelParams = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"EasterParams"];
        
        NSString *channelClassName = [[NSString alloc] initWithFormat:@"EasterBranch_%@", [ChannelParams objectForKey:@"Channel_Name"]];
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

-(NSString *)getEasterChannelSdkVersion{
    return @"1";
}

-(void)doEasterChannelInit{
    
    
}

-(void)doEasterChannelLogin{
}

-(void)doEasterChannelSwitchAccount{
    
}


-(void)doEasterChannelLogout{
    
}

-(void)doChannelshowEasterGameCenter{
    
}

-(void)doChannelshowEasterFloatView{
    
}

-(void)doChannelhideEasterFloatView{
    
}

-(void)doEasterChannelRegcharg:(NSDictionary *)params{
    
}

-(void)doEasterChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    
}

-(void)doEasterChannelRealNameRegister:(int)flag callback:(EasterShiMimgRenZhengCallback)callback{
    
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


-(UIView *)getEasterCurrentView{
    

    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(UIViewController *)getEasterCurrentViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
