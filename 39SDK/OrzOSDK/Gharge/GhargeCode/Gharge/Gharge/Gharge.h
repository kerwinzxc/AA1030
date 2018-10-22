

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GhargeUtils.h"



@protocol GhargeDelegate <NSObject>

-(void)initGhargeSuccess:(NSDictionary *)result;

-(void)initGhargeFail:(NSDictionary *)result;

-(void)loginGhargeSuccess:(NSDictionary *)result;

-(void)loginGhargeFail:(NSDictionary *)result;

-(void)logoutGhargeSuccess:(NSDictionary *)result;

-(void)logoutGhargeFail:(NSDictionary *)result;

-(void)RegchargGhargeSuccess:(NSDictionary *)result;

-(void)RegchargGhargeFail:(NSDictionary *)result;

-(void)openGhargeUserCenter;
-(void)closeGhargeUserCenter;

@end


@interface Gharge : NSObject

@property (strong, nonatomic) id<GhargeDelegate> GhargeDelegate;

@property (nonatomic) Boolean GhargenetWorkIsOK;



+(Gharge*)getSharedInstance;

-(void)initGharge;

-(void)startGhargeLogin;

-(void)startGhargeSwitchAccount;

-(void)startGhargeLogout;

-(void)showGhargeGameCenter;

-(void)showGhargeFloatView;

-(void)hideGhargeFloatView;

-(void)startGhargeRegcharg:(NSDictionary *)params;

-(void)sendGhargeData:(NSString *)dataPoint data:(NSDictionary *)data;

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



