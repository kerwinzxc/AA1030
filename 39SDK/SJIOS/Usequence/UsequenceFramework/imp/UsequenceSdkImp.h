

#import <Foundation/Foundation.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "UsequenceUserInfo.h"
#import "UsequenceKeyChainTool.h"
#import "UsequenceSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "UsequenceReachability.h"

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
@interface UsequenceSdkImp  : NSObject


@property (strong, nonatomic) NSString* usernameUsequence;
@property (nonatomic ,strong)UIView *rootViewUsequence;

@property (nonatomic,strong) UsequenceSdkPy* UsequenceSdkPy;


+(NSString*)getUsequenceIdfa;
+(NSString*)getUsequenceIdfv;
-(NSString*)getUsequenceImei;
-(NSString*)getUsequenceAppId;
-(NSString*)getUsequenceAppKey;
-(NSString*)getUsequenceAppPrivateKey;
-(NSString*)getUsequenceAppSecret;
-(NSString*)getUsequenceNewAdGid;
-(NSString*)getUsequenceNewAdid;
-(NSString*)getUsequenceChannel;
-(NSString*)getUsequenceKeychainIDFV;
-(NSString*)getUsequenceVersion;
-(Boolean)getUsequenceIsLandscape;

+(NSString*)getUsequenceCurrentTimestamp;

-(BOOL)getUsequenceShiMingRenZhengFlag;
-(NSString*)getUsequenceShiMingRenZhengMsg;
-(NSString*)getUsequencePackageId;


-(void)initUsequence:(Boolean)isLandscape
   Usequence_Appid:(NSString *)Usequence_Appid
  Usequence_Appkey:(NSString *)Usequence_Appkey
 Usequence_Channel:(NSString *)Usequence_Channel
Usequence_Appsecret:(NSString *)Usequence_Appsecret
     Usequence_Gid:(NSString *)Usequence_Gid
Usequence_RYAppkey:(NSString *)Usequence_RYAppkey
Usequence_PackageId:(NSString *)Usequence_PackageId
    success:(Usequence_SUCCESS_Callback)success
     failed:(Usequence_FAILED_Callback)failed;

-(void)initUsequencePart:(Usequence_SUCCESS_Callback)successUsequence
         failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

-(void)destroyUsequence;


-(void)loginUsequence:(UIView*)viewUsequence
   landscapeUsequence:(Boolean)isLandscapeUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

-(void)loginUsequence:(UIView*)viewUsequence
        landscapeUsequence:(Boolean)isLandscapeUsequence
          successUsequence:(Usequence_SUCCESS_Callback)successUsequence
           failedUsequence:(Usequence_FAILED_Callback)failedUsequence
             flagUsequence:(int *)flagUsequence;

-(void)logoutUsequence:(UIView*)viewUsequence
      successUsequence:(Usequence_SUCCESS_Callback)successUsequence
       failedUsequence:(Usequence_FAILED_Callback)failedUsequence;



-(void)pUsequencey:(UIViewController*)contextpUsequencey
 landscapepUsequencey:(Boolean)isLandscapepUsequencey
    paramspUsequencey:(NSDictionary*)paramspUsequencey
   successpUsequencey:(Usequence_SUCCESS_Callback)successpUsequencey
    failedpUsequencey:(Usequence_FAILED_Callback)failedpUsequencey;

-(void)executeUsequence:(UIViewController *)viewControllerUsequence
     landscapeUsequence:(BOOL)isLandscapeUsequence
   accessTokenUsequence:(NSString*)accessTokenUsequence;

-(void)hideFloatUsequence;

-(void)checkUsequenceUpdate:(UIView*)contextUsequence
           successUsequence:(Usequence_SUCCESS_Callback)successUsequence
            failedUsequence:(Usequence_FAILED_Callback)failedUsequence
        landscapeUsequence:(Boolean)landscapeUsequence;


-(void)addUsequenceUser:(NSString*)usernameUsequence
      passwordUsequence:(NSString*)passwordUsequence
          bindUsequence:(NSString*) bindUsequence
       touristUsequence:(NSString*) touristUsequence
   phoneNumberUsequence:(NSString*) phoneNumberUsequence;

-(void)removeUsequenceUser:(NSString*)username;



- (void)showUsequenceWelcome: (NSString*)username;

-(void) showUsequenceToast:(NSString *)text;

-(NSString*)translateUsequence:(NSString*) error;

+(UsequenceSdkImp*)sharedInstance;

-(void)loadingUsequence:(Usequence_SUCCESS_Callback)successUsequence
        failedUsequence:(Usequence_FAILED_Callback)failedUsequence;



-(long)getUsequenceTimeNow;

-(void)createRoleUsequence:(NSString *)serveridUsequence user_idUsequence:(NSString*)user_idUsequence roleIdUsequence:(NSString *)roleIdUsequence
        roleLevelUsequence:(NSString *)roleLevelUsequence successUsequence:(Usequence_SUCCESS_Callback)successUsequence failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

-(void)loginRoleUsequence:(NSString *)serveridUsequence user_idUsequence:(NSString*)user_idUsequence roleIdUsequence:(NSString *)roleIdUsequence
       roleLevelUsequence:(NSString *)roleLevelUsequence successUsequence:(Usequence_SUCCESS_Callback)successUsequence failedUsequence:(Usequence_FAILED_Callback)failedUsequence;


-(void)showUsequenceShiMingRenZhengView:(NSString *)accessTokenUsequence callbackUsequence:(Usequence_COMMON_BLOCK)callbackUsequence;


-(void) sjUsequenceRegister:(NSString *)userid;

-(void)levelupUsequence:(NSString*) levelUsequence
  serverNameUsequence:(NSString *)serverNameUsequence
    serveridUsequence:(NSString *) serveridUsequence
      userIdUsequence:(NSString*) userIdUsequence
     role_idUsequence:(NSString*)roleidUsequence
    roleNameUsequence:(NSString*)roleNameUsequence
     successUsequence:(Usequence_SUCCESS_Callback)successUsequence
      failedUsequence:(Usequence_FAILED_Callback)failedUsequence;

-(void)error:(NSString *)log
     success:(Usequence_SUCCESS_Callback)success
      failed:(Usequence_FAILED_Callback)failed;



-(NSString*)getUsequenceTimeUserNow;

@end

