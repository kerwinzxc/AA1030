

#import <Foundation/Foundation.h>
#import "PunctuationBranch.h"

@implementation PunctuationBranch

+(PunctuationBranch*)getSharedInstance
{
    static __strong PunctuationBranch * targetBranch = nil;
    if (targetBranch == nil)
    {
        NSDictionary *ChannelParams = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"PunctuationParams"];
        
        NSString *channelClassName = [[NSString alloc] initWithFormat:@"PunctuationBranch_%@", [ChannelParams objectForKey:@"Channel_Name"]];
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

-(NSString *)getPunctuationChannelSdkVersion{
    return @"1";
}

-(void)doPunctuationChannelInit{
    
    
}

-(void)doPunctuationChannelLogin{
}

-(void)doPunctuationChannelSwitchAccount{
    
}


-(void)doPunctuationChannelLogout{
    
}

-(void)doChannelshowPunctuationGameCenter{
    
}

-(void)doChannelshowPunctuationFloatView{
    
}

-(void)doChannelhidePunctuationFloatView{
    
}

-(void)doPunctuationChannelRegcharg:(NSDictionary *)params{
    
}

-(void)doPunctuationChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    
}

-(void)doPunctuationChannelRealNameRegister:(int)flag callback:(PunctuationShiMimgRenZhengCallback)callback{
    
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


-(UIView *)getPunctuationCurrentView{
    

    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(UIViewController *)getPunctuationCurrentViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
