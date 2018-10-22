

#import <Foundation/Foundation.h>
#import "GhargeBranch.h"
#import "GhargeUtils.h"

@interface GhargeBranch_39 : GhargeBranch

@property(nonatomic, strong) UIAlertView* myAlert;
@property (strong, nonatomic)NSString *productId;
@property (strong, nonatomic)NSString *apple_oderid;

@property (strong, nonatomic) NSString *serverId;
@property (strong, nonatomic) NSString *roleId;
@property (strong, nonatomic) NSString *roleLevel;

@property (nonatomic) Boolean isLogined;
@property (nonatomic) Boolean loginViewIsShowing;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *accesstoken;

-(void)doChannelshowGhargeGameCenter;
-(void)doChannelshowGhargeFloatView;
-(void)doChannelhideGhargeFloatView;

-(void)doGhargeChannelInit;
-(void)doGhargeChannelLogin;
-(void)doGhargeChannelSwitchAccount;
-(void)doGhargeChannelLogout;

-(void)doGhargeChannelRegcharg:(NSDictionary *)params;
-(void)doGhargeChannelRealNameRegister:(int)flag callback:(GhargeShiMimgRenZhengCallback)callback;
-(void)doGhargeChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data;

- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(NSString *)getGhargeChannelSdkVersion;

- (instancetype)initWithKeyframe:(NSDictionary *)keyframe;
- (instancetype)initWithValue:(id)value;
- (void)remapValueWithBlock:(CGFloat (^)(CGFloat inValue))remapBlock;
- (GhargeBranch_39 *)copyWithData:(id)data;

@property (nonatomic, readonly) NSNumber *keyframeTime;
@property (nonatomic, readonly) BOOL isHold;
@property (nonatomic, readonly) CGPoint inTangent;
@property (nonatomic, readonly) CGPoint outTangent;
@property (nonatomic, readonly) CGPoint spatialInTangent;
@property (nonatomic, readonly) CGPoint spatialOutTangent;

@property (nonatomic, readonly) CGFloat floatValue;
@property (nonatomic, readonly) CGPoint pointValue;
@property (nonatomic, readonly) CGSize sizeValue;
@property (nonatomic, readonly) UIColor *colorValue;
@property (nonatomic, readonly, nullable) GhargeBranch_39 *pathData;
@property (nonatomic, readonly) NSArray *arrayValue;
@property (nonatomic, readonly) NSArray<GhargeBranch_39 *> *keyframes;

/*  2 */ @property(nonatomic, strong, readonly) NSString *nationalNumberPattern;
/*  3 */ @property(nonatomic, strong, readonly) NSString *possibleNumberPattern;
/*  9 */ @property(nonatomic, strong, readonly) NSArray<NSNumber *> *possibleLength;
/* 10 */ @property(nonatomic, strong, readonly) NSArray<NSNumber *> *possibleLengthLocalOnly;
/*  6 */ @property(nonatomic, strong, readonly) NSString *exampleNumber;
/*  7 */ @property(nonatomic, strong, readonly) NSData *nationalNumberMatcherData;
/*  8 */ @property(nonatomic, strong, readonly) NSData *possibleNumberMatcherData;

- (instancetype)initWithEntry:(NSArray *)entry;

@end
