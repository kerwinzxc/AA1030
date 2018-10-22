#import "PunctuationUtils.h"
#import "PunctuationBranchDelegate.h"
#import <UIKit/UIKit.h>

@interface PunctuationBranch : NSObject

@property (strong, nonatomic) id<PunctuationBranchDelegate> delegate;

+(PunctuationBranch*)getSharedInstance;

-(NSString *)getPunctuationChannelSdkVersion;

-(void)doPunctuationChannelInit;

-(void)doPunctuationChannelLogin;

-(void)doPunctuationChannelSwitchAccount;

-(void)doPunctuationChannelLogout;

-(void)doChannelshowPunctuationGameCenter;

-(void)doChannelshowPunctuationFloatView;

-(void)doChannelhidePunctuationFloatView;

-(void)doPunctuationChannelRegcharg:(NSDictionary *)params;

-(void)doPunctuationChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(void)doPunctuationChannelRealNameRegister:(int)flag callback:(PunctuationShiMimgRenZhengCallback)callback;

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



-(UIView *)getPunctuationCurrentView;
-(UIViewController *)getPunctuationCurrentViewController;

@end
