

#import <Foundation/Foundation.h>
#import "ReleasbBranch.h"
#import "ReleasbUtils.h"

@interface ReleasbBranch_39 : ReleasbBranch

@property (nonatomic) Boolean IsClickedLogin;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *accesstoken;
@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleId;
@property (strong, nonatomic) NSString *roleLevel;

@property(nonatomic, strong) UIAlertView* myAlert;
@property (strong, nonatomic)NSString *productId;
@property (strong, nonatomic)NSString *apple_oderid;

-(NSString *)getReleasbChannelSdkVersion;

-(void)doReleasbChannelInit;

-(void)doReleasbChannelLogin;

-(void)doReleasbChannelSwitchAccount;

-(void)doReleasbChannelLogout;

-(void)doChannelshowReleasbGameCenter;

-(void)doChannelshowReleasbFloatView;

-(void)doChannelhideReleasbFloatView;

-(void)doReleasbChannelRegcharg:(NSDictionary *)params;

-(void)doReleasbChannelRealNameRegister:(int)flag callback:(ReleasbShiMimgRenZhengCallback)callback;

-(void)doReleasbChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;


@end
