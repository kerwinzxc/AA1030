#import "EasterUtils.h"
#import "EasterBranchDelegate.h"
#import <UIKit/UIKit.h>

@interface EasterBranch : NSObject

@property (strong, nonatomic) id<EasterBranchDelegate> delegate;

+(EasterBranch*)getSharedInstance;

-(NSString *)getEasterChannelSdkVersion;

-(void)doEasterChannelInit;

-(void)doEasterChannelLogin;

-(void)doEasterChannelSwitchAccount;

-(void)doEasterChannelLogout;

-(void)doChannelshowEasterGameCenter;

-(void)doChannelshowEasterFloatView;

-(void)doChannelhideEasterFloatView;

-(void)doEasterChannelRegcharg:(NSDictionary *)params;

-(void)doEasterChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(void)doEasterChannelRealNameRegister:(int)flag callback:(EasterShiMimgRenZhengCallback)callback;

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



-(UIView *)getEasterCurrentView;
-(UIViewController *)getEasterCurrentViewController;

@end
