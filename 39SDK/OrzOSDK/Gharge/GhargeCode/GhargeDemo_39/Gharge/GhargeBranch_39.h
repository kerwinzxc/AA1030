

#import <Foundation/Foundation.h>
#import "GhargeBranch.h"
#import "GhargeUtils.h"

@interface GhargeBranch_39 : GhargeBranch

@property (nonatomic) Boolean IsClickedLogin;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *accesstoken;
@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleId;
@property (strong, nonatomic) NSString *roleLevel;

@property(nonatomic, strong) UIAlertView* myAlert;
@property (strong, nonatomic)NSString *productId;
@property (strong, nonatomic)NSString *apple_oderid;

-(NSString *)getGhargeChannelSdkVersion;

-(void)doGhargeChannelInit;

-(void)doGhargeChannelLogin;

-(void)doGhargeChannelSwitchAccount;

-(void)doGhargeChannelLogout;

-(void)doChannelshowGhargeGameCenter;

-(void)doChannelshowGhargeFloatView;

-(void)doChannelhideGhargeFloatView;

-(void)doGhargeChannelRegcharg:(NSDictionary *)params;

-(void)doGhargeChannelRealNameRegister:(int)flag callback:(GhargeShiMimgRenZhengCallback)callback;

-(void)doGhargeChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;


@end
