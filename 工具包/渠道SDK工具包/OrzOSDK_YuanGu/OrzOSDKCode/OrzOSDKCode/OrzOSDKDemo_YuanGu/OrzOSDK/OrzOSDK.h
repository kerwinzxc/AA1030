

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrzOSDKUtils.h"



@protocol OrzOSDKDelegate <NSObject>

-(void)initOrzOSDKSuccess:(NSDictionary *)result;

-(void)initOrzOSDKFail:(NSDictionary *)result;

-(void)loginOrzOSDKSuccess:(NSDictionary *)result;

-(void)loginOrzOSDKFail:(NSDictionary *)result;

-(void)logoutOrzOSDKSuccess:(NSDictionary *)result;

-(void)logoutOrzOSDKFail:(NSDictionary *)result;

-(void)RegchargOrzOSDKSuccess:(NSDictionary *)result;

-(void)RegchargOrzOSDKFail:(NSDictionary *)result;

-(void)openOrzOSDKUserCenter;
-(void)closeOrzOSDKUserCenter;

@end


@interface OrzOSDK : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic) id<OrzOSDKDelegate> OrzOSDKDelegate;

@property (nonatomic) Boolean OrzOSDKnetWorkIsOK;



+(OrzOSDK*)getSharedInstance;

-(void)initOrzOSDK;

-(void)startOrzOSDKLogin;

-(void)startOrzOSDKSwitchAccount;

-(void)startOrzOSDKLogout;

-(void)showOrzOSDKGameCenter;

-(void)showOrzOSDKFloatView;

-(void)hideOrzOSDKFloatView;

-(void)startOrzOSDKRegcharg:(NSDictionary *)params;

-(void)sendOrzOSDKData:(NSString *)dataPoint data:(NSDictionary *)data;

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



