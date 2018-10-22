

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PunctuationUtils.h"



@protocol PunctuationDelegate <NSObject>

-(void)initPunctuationSuccess:(NSDictionary *)result;

-(void)initPunctuationFail:(NSDictionary *)result;

-(void)loginPunctuationSuccess:(NSDictionary *)result;

-(void)loginPunctuationFail:(NSDictionary *)result;

-(void)logoutPunctuationSuccess:(NSDictionary *)result;

-(void)logoutPunctuationFail:(NSDictionary *)result;

-(void)RegchargPunctuationSuccess:(NSDictionary *)result;

-(void)RegchargPunctuationFail:(NSDictionary *)result;

-(void)openPunctuationUserCenter;
-(void)closePunctuationUserCenter;

@end


@interface Punctuation : NSObject

@property (strong, nonatomic) id<PunctuationDelegate> PunctuationDelegate;

@property (nonatomic) Boolean PunctuationnetWorkIsOK;



+(Punctuation*)getSharedInstance;

-(void)initPunctuation;

-(void)startPunctuationLogin;

-(void)startPunctuationSwitchAccount;

-(void)startPunctuationLogout;

-(void)showPunctuationGameCenter;

-(void)showPunctuationFloatView;

-(void)hidePunctuationFloatView;

-(void)startPunctuationRegcharg:(NSDictionary *)params;

-(void)sendPunctuationData:(NSString *)dataPoint data:(NSDictionary *)data;

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



