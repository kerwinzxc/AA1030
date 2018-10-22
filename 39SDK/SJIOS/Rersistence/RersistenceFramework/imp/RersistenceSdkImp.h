

#import <Foundation/Foundation.h>
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "RersistenceUserInfo.h"
#import "RersistenceKeyChainTool.h"
#import "RersistenceSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "RersistenceReachability.h"

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
@interface RersistenceSdkImp  : NSObject


@property (strong, nonatomic) NSString* usernameRersistence;
@property (nonatomic ,strong)UIView *rootViewRersistence;

@property (nonatomic,strong) RersistenceSdkPy* RersistenceSdkPy;


+(NSString*)getRersistenceIdfa;
+(NSString*)getRersistenceIdfv;
-(NSString*)getRersistenceImei;
-(NSString*)getRersistenceAppId;
-(NSString*)getRersistenceAppKey;
-(NSString*)getRersistenceAppPrivateKey;
-(NSString*)getRersistenceAppSecret;
-(NSString*)getRersistenceNewAdGid;
-(NSString*)getRersistenceNewAdid;
-(NSString*)getRersistenceChannel;
-(NSString*)getRersistenceKeychainIDFV;
-(NSString*)getRersistenceVersion;
-(Boolean)getRersistenceIsLandscape;

+(NSString*)getRersistenceCurrentTimestamp;

-(BOOL)getRersistenceShiMingRenZhengFlag;
-(NSString*)getRersistenceShiMingRenZhengMsg;
-(NSString*)getRersistencePackageId;


-(void)initRersistence:(Boolean)isLandscape
   Rersistence_Appid:(NSString *)Rersistence_Appid
  Rersistence_Appkey:(NSString *)Rersistence_Appkey
 Rersistence_Channel:(NSString *)Rersistence_Channel
Rersistence_Appsecret:(NSString *)Rersistence_Appsecret
     Rersistence_Gid:(NSString *)Rersistence_Gid
Rersistence_RYAppkey:(NSString *)Rersistence_RYAppkey
Rersistence_PackageId:(NSString *)Rersistence_PackageId
    success:(Rersistence_SUCCESS_Callback)success
     failed:(Rersistence_FAILED_Callback)failed;

-(void)initRersistencePart:(Rersistence_SUCCESS_Callback)successRersistence
         failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

-(void)destroyRersistence;


-(void)loginRersistence:(UIView*)viewRersistence
   landscapeRersistence:(Boolean)isLandscapeRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

-(void)loginRersistence:(UIView*)viewRersistence
        landscapeRersistence:(Boolean)isLandscapeRersistence
          successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
           failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
             flagRersistence:(int *)flagRersistence;

-(void)logoutRersistence:(UIView*)viewRersistence
      successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
       failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;



-(void)pRersistencey:(UIViewController*)contextpRersistencey
 landscapepRersistencey:(Boolean)isLandscapepRersistencey
    paramspRersistencey:(NSDictionary*)paramspRersistencey
   successpRersistencey:(Rersistence_SUCCESS_Callback)successpRersistencey
    failedpRersistencey:(Rersistence_FAILED_Callback)failedpRersistencey;

-(void)executeRersistence:(UIViewController *)viewControllerRersistence
     landscapeRersistence:(BOOL)isLandscapeRersistence
   accessTokenRersistence:(NSString*)accessTokenRersistence;

-(void)hideFloatRersistence;

-(void)checkRersistenceUpdate:(UIView*)contextRersistence
           successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
            failedRersistence:(Rersistence_FAILED_Callback)failedRersistence
        landscapeRersistence:(Boolean)landscapeRersistence;


-(void)addRersistenceUser:(NSString*)usernameRersistence
      passwordRersistence:(NSString*)passwordRersistence
          bindRersistence:(NSString*) bindRersistence
       touristRersistence:(NSString*) touristRersistence
   phoneNumberRersistence:(NSString*) phoneNumberRersistence;

-(void)removeRersistenceUser:(NSString*)username;



- (void)showRersistenceWelcome: (NSString*)username;

-(void) showRersistenceToast:(NSString *)text;

-(NSString*)translateRersistence:(NSString*) error;

+(RersistenceSdkImp*)sharedInstance;

-(void)loadingRersistence:(Rersistence_SUCCESS_Callback)successRersistence
        failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;



-(long)getRersistenceTimeNow;

-(void)createRoleRersistence:(NSString *)serveridRersistence user_idRersistence:(NSString*)user_idRersistence roleIdRersistence:(NSString *)roleIdRersistence
        roleLevelRersistence:(NSString *)roleLevelRersistence successRersistence:(Rersistence_SUCCESS_Callback)successRersistence failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

-(void)loginRoleRersistence:(NSString *)serveridRersistence user_idRersistence:(NSString*)user_idRersistence roleIdRersistence:(NSString *)roleIdRersistence
       roleLevelRersistence:(NSString *)roleLevelRersistence successRersistence:(Rersistence_SUCCESS_Callback)successRersistence failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;


-(void)showRersistenceShiMingRenZhengView:(NSString *)accessTokenRersistence callbackRersistence:(Rersistence_COMMON_BLOCK)callbackRersistence;


-(void) sjRersistenceRegister:(NSString *)userid;

-(void)levelupRersistence:(NSString*) levelRersistence
  serverNameRersistence:(NSString *)serverNameRersistence
    serveridRersistence:(NSString *) serveridRersistence
      userIdRersistence:(NSString*) userIdRersistence
     role_idRersistence:(NSString*)roleidRersistence
    roleNameRersistence:(NSString*)roleNameRersistence
     successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
      failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;

-(void)error:(NSString *)log
     success:(Rersistence_SUCCESS_Callback)success
      failed:(Rersistence_FAILED_Callback)failed;



-(NSString*)getRersistenceTimeUserNow;

@end

