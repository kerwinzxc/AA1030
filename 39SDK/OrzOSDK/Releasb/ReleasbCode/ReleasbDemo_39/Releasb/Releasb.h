

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReleasbUtils.h"



@protocol ReleasbDelegate <NSObject>

-(void)initReleasbSuccess:(NSDictionary *)result;

-(void)initReleasbFail:(NSDictionary *)result;

-(void)loginReleasbSuccess:(NSDictionary *)result;

-(void)loginReleasbFail:(NSDictionary *)result;

-(void)logoutReleasbSuccess:(NSDictionary *)result;

-(void)logoutReleasbFail:(NSDictionary *)result;

-(void)RegchargReleasbSuccess:(NSDictionary *)result;

-(void)RegchargReleasbFail:(NSDictionary *)result;

-(void)openReleasbUserCenter;
-(void)closeReleasbUserCenter;

@end


@interface Releasb : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic) id<ReleasbDelegate> ReleasbDelegate;

@property (nonatomic) Boolean ReleasbnetWorkIsOK;



+(Releasb*)getSharedInstance;

-(void)initReleasb;

-(void)startReleasbLogin;

-(void)startReleasbSwitchAccount;

-(void)startReleasbLogout;

-(void)showReleasbGameCenter;

-(void)showReleasbFloatView;

-(void)hideReleasbFloatView;

-(void)startReleasbRegcharg:(NSDictionary *)params;

-(void)sendReleasbData:(NSString *)dataPoint data:(NSDictionary *)data;

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

@end



