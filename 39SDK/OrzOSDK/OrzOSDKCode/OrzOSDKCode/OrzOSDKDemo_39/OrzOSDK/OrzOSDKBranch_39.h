

#import <Foundation/Foundation.h>
#import "OrzOSDKBranch.h"
#import "OrzOSDKUtils.h"

@interface OrzOSDKBranch_39 : OrzOSDKBranch

@property (nonatomic) Boolean IsClickedLogin;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *accesstoken;
@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleId;
@property (strong, nonatomic) NSString *roleLevel;

@property(nonatomic, strong) UIAlertView* myAlert;
@property (strong, nonatomic)NSString *productId;
@property (strong, nonatomic)NSString *apple_oderid;

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
