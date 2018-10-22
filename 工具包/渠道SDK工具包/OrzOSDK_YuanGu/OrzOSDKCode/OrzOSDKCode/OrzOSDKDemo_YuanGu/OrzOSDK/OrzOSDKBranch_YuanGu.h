

#import <Foundation/Foundation.h>
#import "OrzOSDKBranch.h"
#import "OrzOSDKUtils.h"

#import <ZS4Game/Zs4GameHeader.h>
#import <ZS4Game/Zs4Game.h>
#import <ZS4Game/Zs4GameNotifications.h>
#import <ZS4Game/Zs4GameUser.h>

@interface OrzOSDKBranch_YuanGu : OrzOSDKBranch

@property (strong, nonatomic) NSString *AppID_YuanGu;
@property (strong, nonatomic) NSString *AppKey_YuanGu;
@property (strong, nonatomic) NSString *UmengKey_YuanGu;

@property (strong, nonatomic) NSString *TalkingDataAdTracking_YuanGu;
@property (strong, nonatomic) NSString *TrackingKey_YuanGu;
@property (strong, nonatomic) NSString *TrackingChannelId_YuanGu;


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
