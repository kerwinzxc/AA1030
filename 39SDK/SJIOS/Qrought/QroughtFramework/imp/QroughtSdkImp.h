

#import <Foundation/Foundation.h>
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "QroughtUserInfo.h"
#import "QroughtKeyChainTool.h"
#import "QroughtSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "QroughtReachability.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSBase.h>
#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSContextRef.h>
#import <JavaScriptCore/JSValue.h>
#import <JavaScriptCore/WebKitAvailability.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#define ios8 ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
@interface QroughtSdkImp  : NSObject


@property (strong, nonatomic) NSString* usernameQrought;
@property (nonatomic ,strong)UIView *rootViewQrought;

@property (nonatomic,strong) QroughtSdkPy* QroughtSdkPy;


+(NSString*)getQroughtIdfa;
+(NSString*)getQroughtIdfv;
-(NSString*)getQroughtImei;
-(NSString*)getQroughtAppId;
-(NSString*)getQroughtAppKey;
-(NSString*)getQroughtAppPrivateKey;
-(NSString*)getQroughtAppSecret;
-(NSString*)getQroughtNewAdGid;
-(NSString*)getQroughtNewAdid;
-(NSString*)getQroughtChannel;
-(NSString*)getQroughtKeychainIDFV;
-(NSString*)getQroughtVersion;
-(Boolean)getQroughtIsLandscape;

+(NSString*)getQroughtCurrentTimestamp;

-(BOOL)getQroughtShiMingRenZhengFlag;
-(NSString*)getQroughtShiMingRenZhengMsg;
-(NSString*)getQroughtPackageId;


-(void)initQrought:(Boolean)isLandscape
   Qrought_Appid:(NSString *)Qrought_Appid
  Qrought_Appkey:(NSString *)Qrought_Appkey
 Qrought_Channel:(NSString *)Qrought_Channel
Qrought_Appsecret:(NSString *)Qrought_Appsecret
     Qrought_Gid:(NSString *)Qrought_Gid
Qrought_RYAppkey:(NSString *)Qrought_RYAppkey
Qrought_PackageId:(NSString *)Qrought_PackageId
    success:(Qrought_SUCCESS_Callback)success
     failed:(Qrought_FAILED_Callback)failed;

-(void)initQroughtPart:(Qrought_SUCCESS_Callback)successQrought
         failedQrought:(Qrought_FAILED_Callback)failedQrought;

-(void)destroyQrought;


-(void)loginQrought:(UIView*)viewQrought
   landscapeQrought:(Boolean)isLandscapeQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought;

-(void)loginQrought:(UIView*)viewQrought
        landscapeQrought:(Boolean)isLandscapeQrought
          successQrought:(Qrought_SUCCESS_Callback)successQrought
           failedQrought:(Qrought_FAILED_Callback)failedQrought
             flagQrought:(int *)flagQrought;

-(void)logoutQrought:(UIView*)viewQrought
      successQrought:(Qrought_SUCCESS_Callback)successQrought
       failedQrought:(Qrought_FAILED_Callback)failedQrought;



-(void)pQroughty:(UIViewController*)contextpQroughty
 landscapepQroughty:(Boolean)isLandscapepQroughty
    paramspQroughty:(NSDictionary*)paramspQroughty
   successpQroughty:(Qrought_SUCCESS_Callback)successpQroughty
    failedpQroughty:(Qrought_FAILED_Callback)failedpQroughty;

-(void)executeQrought:(UIViewController *)viewControllerQrought
     landscapeQrought:(BOOL)isLandscapeQrought
   accessTokenQrought:(NSString*)accessTokenQrought;

-(void)hideFloatQrought;

-(void)checkQroughtUpdate:(UIView*)contextQrought
           successQrought:(Qrought_SUCCESS_Callback)successQrought
            failedQrought:(Qrought_FAILED_Callback)failedQrought
        landscapeQrought:(Boolean)landscapeQrought;


-(void)addQroughtUser:(NSString*)usernameQrought
      passwordQrought:(NSString*)passwordQrought
          bindQrought:(NSString*) bindQrought
       touristQrought:(NSString*) touristQrought
   phoneNumberQrought:(NSString*) phoneNumberQrought;

-(void)removeQroughtUser:(NSString*)username;



- (void)showQroughtWelcome: (NSString*)username;

-(void) showQroughtToast:(NSString *)text;

-(NSString*)translateQrought:(NSString*) error;

+(QroughtSdkImp*)sharedInstance;

-(void)loadingQrought:(Qrought_SUCCESS_Callback)successQrought
        failedQrought:(Qrought_FAILED_Callback)failedQrought;



-(long)getQroughtTimeNow;

-(void)createRoleQrought:(NSString *)serveridQrought user_idQrought:(NSString*)user_idQrought roleIdQrought:(NSString *)roleIdQrought
        roleLevelQrought:(NSString *)roleLevelQrought successQrought:(Qrought_SUCCESS_Callback)successQrought failedQrought:(Qrought_FAILED_Callback)failedQrought;

-(void)loginRoleQrought:(NSString *)serveridQrought user_idQrought:(NSString*)user_idQrought roleIdQrought:(NSString *)roleIdQrought
       roleLevelQrought:(NSString *)roleLevelQrought successQrought:(Qrought_SUCCESS_Callback)successQrought failedQrought:(Qrought_FAILED_Callback)failedQrought;


-(void)showQroughtShiMingRenZhengView:(NSString *)accessTokenQrought callbackQrought:(Qrought_COMMON_BLOCK)callbackQrought;


-(void) sjQroughtRegister:(NSString *)userid;

-(void)levelupQrought:(NSString*) levelQrought
  serverNameQrought:(NSString *)serverNameQrought
    serveridQrought:(NSString *) serveridQrought
      userIdQrought:(NSString*) userIdQrought
     role_idQrought:(NSString*)roleidQrought
    roleNameQrought:(NSString*)roleNameQrought
     successQrought:(Qrought_SUCCESS_Callback)successQrought
      failedQrought:(Qrought_FAILED_Callback)failedQrought;

-(void)error:(NSString *)log
     success:(Qrought_SUCCESS_Callback)success
      failed:(Qrought_FAILED_Callback)failed;



-(NSString*)getQroughtTimeUserNow;

@end

