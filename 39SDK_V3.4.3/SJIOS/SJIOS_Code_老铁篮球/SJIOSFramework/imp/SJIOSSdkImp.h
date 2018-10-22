

#import <Foundation/Foundation.h>
#import "SJIOSSdkCommonDefine.h"
#import "SJIOSUserInfo.h"
#import "SJIOSKeyChainTool.h"
#import "SJIOSSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "SJIOSReachability.h"

#define ios8 ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
@interface SJIOSSdkImp  : NSObject


@property (strong, nonatomic) NSString* usernameSJIOS;
@property (nonatomic ,strong)UIView *rootViewSJIOS;

@property (nonatomic,strong) SJIOSSdkPy* SJIOSSdkPy;


+(NSString*)getSJIOSIdfa;
+(NSString*)getSJIOSIdfv;
-(NSString*)getSJIOSImei;
-(NSString*)getSJIOSAppId;
-(NSString*)getSJIOSAppKey;
-(NSString*)getSJIOSAppPrivateKey;
-(NSString*)getSJIOSAppSecret;
-(NSString*)getSJIOSNewAdGid;
-(NSString*)getSJIOSNewAdid;
-(NSString*)getSJIOSChannel;
-(NSString*)getSJIOSKeychainIDFV;
-(NSString*)getSJIOSVersion;
-(Boolean)getSJIOSIsLandscape;

+(NSString*)getSJIOSCurrentTimestamp;

-(BOOL)getSJIOSShiMingRenZhengFlag;
-(NSString*)getSJIOSShiMingRenZhengMsg;
-(NSString*)getSJIOSPackageId;


-(void)initSJIOS:(Boolean)isLandscape
   SJIOS_Appid:(NSString *)SJIOS_Appid
  SJIOS_Appkey:(NSString *)SJIOS_Appkey
 SJIOS_Channel:(NSString *)SJIOS_Channel
SJIOS_Appsecret:(NSString *)SJIOS_Appsecret
     SJIOS_Gid:(NSString *)SJIOS_Gid
SJIOS_RYAppkey:(NSString *)SJIOS_RYAppkey
SJIOS_PackageId:(NSString *)SJIOS_PackageId
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed;

-(void)initSJIOSPart:(SJIOS_SUCCESS_Callback)successSJIOS
         failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

-(void)destroySJIOS;


-(void)loginSJIOS:(UIView*)viewSJIOS
   landscapeSJIOS:(Boolean)isLandscapeSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

-(void)loginSJIOS:(UIView*)viewSJIOS
        landscapeSJIOS:(Boolean)isLandscapeSJIOS
          successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
           failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
             flagSJIOS:(int *)flagSJIOS;

-(void)logoutSJIOS:(UIView*)viewSJIOS
      successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
       failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;



-(void)pSJIOSy:(UIViewController*)contextpSJIOSy
 landscapepSJIOSy:(Boolean)isLandscapepSJIOSy
    paramspSJIOSy:(NSDictionary*)paramspSJIOSy
   successpSJIOSy:(SJIOS_SUCCESS_Callback)successpSJIOSy
    failedpSJIOSy:(SJIOS_FAILED_Callback)failedpSJIOSy;

-(void)executeSJIOS:(UIViewController *)viewControllerSJIOS
     landscapeSJIOS:(BOOL)isLandscapeSJIOS
   accessTokenSJIOS:(NSString*)accessTokenSJIOS;

-(void)hideFloatSJIOS;

-(void)checkSJIOSUpdate:(UIView*)contextSJIOS
           successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
            failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS
        landscapeSJIOS:(Boolean)landscapeSJIOS;


-(void)addSJIOSUser:(NSString*)usernameSJIOS
      passwordSJIOS:(NSString*)passwordSJIOS
          bindSJIOS:(NSString*) bindSJIOS
       touristSJIOS:(NSString*) touristSJIOS
   phoneNumberSJIOS:(NSString*) phoneNumberSJIOS;

-(void)removeSJIOSUser:(NSString*)username;



- (void)showSJIOSWelcome: (NSString*)username;

-(void) showSJIOSToast:(NSString *)text;

-(NSString*)translateSJIOS:(NSString*) error;

+(SJIOSSdkImp*)sharedInstance;

-(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
        failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;



-(long)getSJIOSTimeNow;

-(void)createRoleSJIOS:(NSString *)serveridSJIOS user_idSJIOS:(NSString*)user_idSJIOS roleIdSJIOS:(NSString *)roleIdSJIOS
        roleLevelSJIOS:(NSString *)roleLevelSJIOS successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

-(void)loginRoleSJIOS:(NSString *)serveridSJIOS user_idSJIOS:(NSString*)user_idSJIOS roleIdSJIOS:(NSString *)roleIdSJIOS
       roleLevelSJIOS:(NSString *)roleLevelSJIOS successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;


-(void)showSJIOSShiMingRenZhengView:(NSString *)accessTokenSJIOS callbackSJIOS:(SJIOS_COMMON_BLOCK)callbackSJIOS;


-(void) sjSJIOSRegister:(NSString *)userid;

-(void)levelupSJIOS:(NSString*) levelSJIOS
  serverNameSJIOS:(NSString *)serverNameSJIOS
    serveridSJIOS:(NSString *) serveridSJIOS
      userIdSJIOS:(NSString*) userIdSJIOS
     role_idSJIOS:(NSString*)roleidSJIOS
    roleNameSJIOS:(NSString*)roleNameSJIOS
     successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
      failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;

-(void)error:(NSString *)log
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;



-(NSString*)getSJIOSTimeUserNow;

@end

