

#import <Foundation/Foundation.h>
#import "EasterBranch.h"
#import "EasterUtils.h"

@interface EasterBranch_39 : EasterBranch

@property (nonatomic) Boolean IsClickedLogin;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *accesstoken;
@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleId;
@property (strong, nonatomic) NSString *roleLevel;

@property(nonatomic, strong) UIAlertView* myAlert;
@property (strong, nonatomic)NSString *productId;
@property (strong, nonatomic)NSString *apple_oderid;

-(NSString *)getEasterChannelSdkVersion;

-(void)doEasterChannelInit;

-(void)doEasterChannelLogin;

-(void)doEasterChannelSwitchAccount;

-(void)doEasterChannelLogout;

-(void)doChannelshowEasterGameCenter;

-(void)doChannelshowEasterFloatView;

-(void)doChannelhideEasterFloatView;

-(void)doEasterChannelRegcharg:(NSDictionary *)params;

-(void)doEasterChannelRealNameRegister:(int)flag callback:(EasterShiMimgRenZhengCallback)callback;

-(void)doEasterChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;


@end
