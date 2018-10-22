

#import <Foundation/Foundation.h>
#import "OrzOSDKBranch.h"
#import "OrzOSDKUtils.h"

@interface OrzOSDKBranch_AnHuiGS : OrzOSDKBranch
@property (strong, nonatomic) NSString *gid;
@property (strong, nonatomic) NSString *apikey;
@property (strong, nonatomic) NSString *secretkey;
@property (strong, nonatomic) NSString *gamename;

@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleName;
@property (strong, nonatomic) NSString *roleLevel;

-(NSString *)getOrzOSDKChannelSdkVersion;

-(void)doOrzOSDKChannelInit;

-(void)doOrzOSDKChannelLogin;

-(void)doOrzOSDKChannelSwitchAccount;

-(void)doOrzOSDKChannelLogout;

-(void)doChannelshowOrzOSDKGameCenter;

-(void)doChannelshowOrzOSDKFloatView;

-(void)doChannelhideOrzOSDKFloatView;

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params;

-(void)doOrzOSDKChannelRealNameRegister:(int)flag callback:(OrzOSDKShiMimgRenZhengCallback)callback;

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;


@end
