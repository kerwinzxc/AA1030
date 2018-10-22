

#import <Foundation/Foundation.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "PostinUserInfo.h"
#import "PostinKeyChainTool.h"
#import "PostinSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "PostinReachability.h"

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
@interface PostinSdkImp  : NSObject


@property (strong, nonatomic) NSString* usernamePostin;
@property (nonatomic ,strong)UIView *rootViewPostin;

@property (nonatomic,strong) PostinSdkPy* PostinSdkPy;


+(NSString*)getPostinIdfa;
+(NSString*)getPostinIdfv;
-(NSString*)getPostinImei;
-(NSString*)getPostinAppId;
-(NSString*)getPostinAppKey;
-(NSString*)getPostinAppPrivateKey;
-(NSString*)getPostinAppSecret;
-(NSString*)getPostinNewAdGid;
-(NSString*)getPostinNewAdid;
-(NSString*)getPostinChannel;
-(NSString*)getPostinKeychainIDFV;
-(NSString*)getPostinVersion;
-(Boolean)getPostinIsLandscape;

+(NSString*)getPostinCurrentTimestamp;

-(BOOL)getPostinShiMingRenZhengFlag;
-(NSString*)getPostinShiMingRenZhengMsg;
-(NSString*)getPostinPackageId;


-(void)initPostin:(Boolean)isLandscape
   Postin_Appid:(NSString *)Postin_Appid
  Postin_Appkey:(NSString *)Postin_Appkey
 Postin_Channel:(NSString *)Postin_Channel
Postin_Appsecret:(NSString *)Postin_Appsecret
     Postin_Gid:(NSString *)Postin_Gid
Postin_RYAppkey:(NSString *)Postin_RYAppkey
Postin_PackageId:(NSString *)Postin_PackageId
    success:(Postin_SUCCESS_Callback)success
     failed:(Postin_FAILED_Callback)failed;

-(void)initPostinPart:(Postin_SUCCESS_Callback)successPostin
         failedPostin:(Postin_FAILED_Callback)failedPostin;

-(void)destroyPostin;


-(void)loginPostin:(UIView*)viewPostin
   landscapePostin:(Boolean)isLandscapePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin;

-(void)loginPostin:(UIView*)viewPostin
        landscapePostin:(Boolean)isLandscapePostin
          successPostin:(Postin_SUCCESS_Callback)successPostin
           failedPostin:(Postin_FAILED_Callback)failedPostin
             flagPostin:(int *)flagPostin;

-(void)logoutPostin:(UIView*)viewPostin
      successPostin:(Postin_SUCCESS_Callback)successPostin
       failedPostin:(Postin_FAILED_Callback)failedPostin;



-(void)pPostiny:(UIViewController*)contextpPostiny
 landscapepPostiny:(Boolean)isLandscapepPostiny
    paramspPostiny:(NSDictionary*)paramspPostiny
   successpPostiny:(Postin_SUCCESS_Callback)successpPostiny
    failedpPostiny:(Postin_FAILED_Callback)failedpPostiny;

-(void)executePostin:(UIViewController *)viewControllerPostin
     landscapePostin:(BOOL)isLandscapePostin
   accessTokenPostin:(NSString*)accessTokenPostin;

-(void)hideFloatPostin;

-(void)checkPostinUpdate:(UIView*)contextPostin
           successPostin:(Postin_SUCCESS_Callback)successPostin
            failedPostin:(Postin_FAILED_Callback)failedPostin
        landscapePostin:(Boolean)landscapePostin;


-(void)addPostinUser:(NSString*)usernamePostin
      passwordPostin:(NSString*)passwordPostin
          bindPostin:(NSString*) bindPostin
       touristPostin:(NSString*) touristPostin
   phoneNumberPostin:(NSString*) phoneNumberPostin;

-(void)removePostinUser:(NSString*)username;



- (void)showPostinWelcome: (NSString*)username;

-(void) showPostinToast:(NSString *)text;

-(NSString*)translatePostin:(NSString*) error;

+(PostinSdkImp*)sharedInstance;

-(void)loadingPostin:(Postin_SUCCESS_Callback)successPostin
        failedPostin:(Postin_FAILED_Callback)failedPostin;



-(long)getPostinTimeNow;

-(void)createRolePostin:(NSString *)serveridPostin user_idPostin:(NSString*)user_idPostin roleIdPostin:(NSString *)roleIdPostin
        roleLevelPostin:(NSString *)roleLevelPostin successPostin:(Postin_SUCCESS_Callback)successPostin failedPostin:(Postin_FAILED_Callback)failedPostin;

-(void)loginRolePostin:(NSString *)serveridPostin user_idPostin:(NSString*)user_idPostin roleIdPostin:(NSString *)roleIdPostin
       roleLevelPostin:(NSString *)roleLevelPostin successPostin:(Postin_SUCCESS_Callback)successPostin failedPostin:(Postin_FAILED_Callback)failedPostin;


-(void)showPostinShiMingRenZhengView:(NSString *)accessTokenPostin callbackPostin:(Postin_COMMON_BLOCK)callbackPostin;


-(void) sjPostinRegister:(NSString *)userid;

-(void)levelupPostin:(NSString*) levelPostin
  serverNamePostin:(NSString *)serverNamePostin
    serveridPostin:(NSString *) serveridPostin
      userIdPostin:(NSString*) userIdPostin
     role_idPostin:(NSString*)roleidPostin
    roleNamePostin:(NSString*)roleNamePostin
     successPostin:(Postin_SUCCESS_Callback)successPostin
      failedPostin:(Postin_FAILED_Callback)failedPostin;

-(void)error:(NSString *)log
     success:(Postin_SUCCESS_Callback)success
      failed:(Postin_FAILED_Callback)failed;



-(NSString*)getPostinTimeUserNow;

@end

