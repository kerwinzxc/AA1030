#import "GhargeUtils.h"
#import "GhargeBranchDelegate.h"
#import <UIKit/UIKit.h>

@interface GhargeBranch : NSObject

@property (strong, nonatomic) id<GhargeBranchDelegate> delegate;

+(GhargeBranch*)getSharedInstance;

-(NSString *)getGhargeChannelSdkVersion;

-(void)doGhargeChannelInit;

-(void)doGhargeChannelLogin;

-(void)doGhargeChannelSwitchAccount;

-(void)doGhargeChannelLogout;

-(void)doChannelshowGhargeGameCenter;

-(void)doChannelshowGhargeFloatView;

-(void)doChannelhideGhargeFloatView;

-(void)doGhargeChannelRegcharg:(NSDictionary *)params;

-(void)doGhargeChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(void)doGhargeChannelRealNameRegister:(int)flag callback:(GhargeShiMimgRenZhengCallback)callback;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;



-(UIView *)getGhargeCurrentView;
-(UIViewController *)getGhargeCurrentViewController;

@end
