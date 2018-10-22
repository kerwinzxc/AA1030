

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XRetoolLegendUtils.h"



@protocol XRetoolLegendDelegate <NSObject>

-(void)initXRetoolLegendSuccess:(NSDictionary *)result;

-(void)initXRetoolLegendFail:(NSDictionary *)result;

-(void)loginXRetoolLegendSuccess:(NSDictionary *)result;

-(void)loginXRetoolLegendFail:(NSDictionary *)result;

-(void)logoutXRetoolLegendSuccess:(NSDictionary *)result;

-(void)logoutXRetoolLegendFail:(NSDictionary *)result;

-(void)RegchargXRetoolLegendSuccess:(NSDictionary *)result;

-(void)RegchargXRetoolLegendFail:(NSDictionary *)result;

-(void)openXRetoolLegendUserCenter;
-(void)closeXRetoolLegendUserCenter;

@end


@interface XRetoolLegend : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic) id<XRetoolLegendDelegate> XRetoolLegendDelegate;

@property (nonatomic) Boolean XRetoolLegendnetWorkIsOK;



+(XRetoolLegend*)getSharedInstance;

-(void)initXRetoolLegend;

-(void)startXRetoolLegendLogin;

-(void)startXRetoolLegendSwitchAccount;

-(void)startXRetoolLegendLogout;

-(void)showXRetoolLegendGameCenter;

-(void)showXRetoolLegendFloatView;

-(void)hideXRetoolLegendFloatView;

-(void)startXRetoolLegendRegcharg:(NSDictionary *)params;

-(void)sendXRetoolLegendData:(NSString *)dataPoint data:(NSDictionary *)data;

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



