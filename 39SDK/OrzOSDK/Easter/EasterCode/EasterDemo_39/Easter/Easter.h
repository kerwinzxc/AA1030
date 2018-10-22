

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EasterUtils.h"



@protocol EasterDelegate <NSObject>

-(void)initEasterSuccess:(NSDictionary *)result;

-(void)initEasterFail:(NSDictionary *)result;

-(void)loginEasterSuccess:(NSDictionary *)result;

-(void)loginEasterFail:(NSDictionary *)result;

-(void)logoutEasterSuccess:(NSDictionary *)result;

-(void)logoutEasterFail:(NSDictionary *)result;

-(void)RegchargEasterSuccess:(NSDictionary *)result;

-(void)RegchargEasterFail:(NSDictionary *)result;

-(void)openEasterUserCenter;
-(void)closeEasterUserCenter;

@end


@interface Easter : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic) id<EasterDelegate> EasterDelegate;

@property (nonatomic) Boolean EasternetWorkIsOK;



+(Easter*)getSharedInstance;

-(void)initEaster;

-(void)startEasterLogin;

-(void)startEasterSwitchAccount;

-(void)startEasterLogout;

-(void)showEasterGameCenter;

-(void)showEasterFloatView;

-(void)hideEasterFloatView;

-(void)startEasterRegcharg:(NSDictionary *)params;

-(void)sendEasterData:(NSString *)dataPoint data:(NSDictionary *)data;

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



