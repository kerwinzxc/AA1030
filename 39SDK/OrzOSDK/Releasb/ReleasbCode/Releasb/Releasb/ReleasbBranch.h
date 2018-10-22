#import "ReleasbUtils.h"
#import "ReleasbBranchDelegate.h"
#import <UIKit/UIKit.h>

@interface ReleasbBranch : NSObject

@property (strong, nonatomic) id<ReleasbBranchDelegate> delegate;

+(ReleasbBranch*)getSharedInstance;

-(NSString *)getReleasbChannelSdkVersion;

-(void)doReleasbChannelInit;

-(void)doReleasbChannelLogin;

-(void)doReleasbChannelSwitchAccount;

-(void)doReleasbChannelLogout;

-(void)doChannelshowReleasbGameCenter;

-(void)doChannelshowReleasbFloatView;

-(void)doChannelhideReleasbFloatView;

-(void)doReleasbChannelRegcharg:(NSDictionary *)params;

-(void)doReleasbChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(void)doReleasbChannelRealNameRegister:(int)flag callback:(ReleasbShiMimgRenZhengCallback)callback;

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



-(UIView *)getReleasbCurrentView;
-(UIViewController *)getReleasbCurrentViewController;

@end
