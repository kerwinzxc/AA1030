

#import <Foundation/Foundation.h>
#import "ReleasbBranch.h"

@implementation ReleasbBranch

+(ReleasbBranch*)getSharedInstance
{
    static __strong ReleasbBranch * targetBranch = nil;
    if (targetBranch == nil)
    {
        NSDictionary *ChannelParams = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ReleasbParams"];
        
        NSString *channelClassName = [[NSString alloc] initWithFormat:@"ReleasbBranch_%@", [ChannelParams objectForKey:@"Channel_Name"]];
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

-(NSString *)getReleasbChannelSdkVersion{
    return @"1";
}

-(void)doReleasbChannelInit{
    
    
}

-(void)doReleasbChannelLogin{
}

-(void)doReleasbChannelSwitchAccount{
    
}


-(void)doReleasbChannelLogout{
    
}

-(void)doChannelshowReleasbGameCenter{
    
}

-(void)doChannelshowReleasbFloatView{
    
}

-(void)doChannelhideReleasbFloatView{
    
}

-(void)doReleasbChannelRegcharg:(NSDictionary *)params{
    
}

-(void)doReleasbChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    
}

-(void)doReleasbChannelRealNameRegister:(int)flag callback:(ReleasbShiMimgRenZhengCallback)callback{
    
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


-(UIView *)getReleasbCurrentView{
    

    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(UIViewController *)getReleasbCurrentViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
