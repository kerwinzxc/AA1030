

#import <Foundation/Foundation.h>
#import "OrzOSDKBranch.h"

@implementation OrzOSDKBranch

+(OrzOSDKBranch*)getSharedInstance
{
    static __strong OrzOSDKBranch * targetBranch = nil;
    if (targetBranch == nil)
    {
        NSDictionary *ChannelParams = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"OrzOSDKParams"];
        
        NSString *channelClassName = [[NSString alloc] initWithFormat:@"OrzOSDKBranch_%@", [ChannelParams objectForKey:@"Channel_Name"]];
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

-(NSString *)getOrzOSDKChannelSdkVersion{
    return @"1";
}

-(void)doOrzOSDKChannelInit{
    
    
}

-(void)doOrzOSDKChannelLogin{
}

-(void)doOrzOSDKChannelSwitchAccount{
    
}


-(void)doOrzOSDKChannelLogout{
    
}

-(void)doChannelshowOrzOSDKGameCenter{
    
}

-(void)doChannelshowOrzOSDKFloatView{
    
}

-(void)doChannelhideOrzOSDKFloatView{
    
}

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params{
    
}

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    
}

-(void)doOrzOSDKChannelRealNameRegister:(int)flag callback:(OrzOSDKShiMimgRenZhengCallback)callback{
    
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


-(UIView *)getOrzOSDKCurrentView{
    

    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}

-(UIViewController *)getOrzOSDKCurrentViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
