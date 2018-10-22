

#import <Foundation/Foundation.h>
#import "OrzOSDKBranch.h"
#import "OrzOSDKUtils.h"

#import <SJIOS/GPSDK.h>

@interface OrzOSDKBranch_SanJHY : OrzOSDKBranch

@property (strong, nonatomic) NSString *Appid_29;
@property (strong, nonatomic) NSString *GameKey_29;
@property (strong, nonatomic) NSString *igvaAPP;
@property (strong, nonatomic) NSString *channelId_29;


@property (strong, nonatomic) NSString *serverid;
@property (strong, nonatomic) NSString *roleid;

-(NSString *)getOrzOSDKChannelSdkVersion;

-(void)doOrzOSDKChannelInit;

-(void)doOrzOSDKChannelLogin;

-(void)doOrzOSDKChannelSwitchAccount;

-(void)doOrzOSDKChannelLogout;

-(void)doChannelshowOrzOSDKGameCenter;

-(void)doChannelshowOrzOSDKFloatView;

-(void)doChannelhideOrzOSDKFloatView;

-(void)doOrzOSDKChannelRegcharg:(NSDictionary *)params;

-(void)doOrzOSDKChannelRealNameRegister:(int)flag;

-(void)doOrzOSDKChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;



@end
