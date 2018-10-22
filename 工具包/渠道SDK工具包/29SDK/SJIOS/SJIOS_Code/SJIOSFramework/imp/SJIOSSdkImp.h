

#import <Foundation/Foundation.h>
#import "SJIOSSdk_const_def.h"
#import "SJIOSUserInfo.h"
#import "SJIOSKeyChainTool.h"
#import "SJIOSSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "SJIOSReachability.h"
#import "TrackingIO.h"

#define ios8 ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
@interface SJIOSSdkImp  : NSObject

@property (strong, nonatomic) NSDictionary * setting;

@property (strong, nonatomic) NSString* username;
@property (nonatomic ,strong)UIView *rootControllerView;
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *outIp;

@property (nonatomic,strong) SJIOSSdkPy* SJIOSSdkPy;


+(NSString*)getIdfa;
+(NSString*)getIdfv;
-(NSString*)imei;
-(NSString*)appId;
-(NSString*)appKey;
-(NSString*)appPrivateKey;
-(NSString*)appSecret;
-(NSString*)newAdGid;
-(NSString*)newAdid;
-(NSString*)channel;
-(NSString*)keychainIDFV;
-(NSString*)version;
-(Boolean)isLandscape;


-(void)initSJIOS:(Boolean)isLandscape
   SJIOS_Appid:(NSString *)SJIOS_Appid
  SJIOS_Appkey:(NSString *)SJIOS_Appkey
 SJIOS_Channel:(NSString *)SJIOS_Channel
SJIOS_Appsecret:(NSString *)SJIOS_Appsecret
     SJIOS_Gid:(NSString *)SJIOS_Gid
SJIOS_RYAppkey:(NSString *)SJIOS_RYAppkey
    success:(SJIOS_SUCCESS_Callback)success
     failed:(SJIOS_FAILED_Callback)failed;

-(void)initSJIOSPart:(SJIOS_SUCCESS_Callback)success
         failed:(SJIOS_FAILED_Callback)failed;

-(void)destroySJIOS;


-(void)loginSJIOS:(UIView*)view 
   landscape:(Boolean)isLandscape
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;

-(void)logoutSJIOS:(UIView*)view
      success:(SJIOS_SUCCESS_Callback)success
       failed:(SJIOS_FAILED_Callback)failed;



-(void)pSJIOSy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(SJIOS_SUCCESS_Callback)success
    failed:(SJIOS_FAILED_Callback)failed;

-(void)executeSJIOS:(UIViewController *)viewController
     landscape:(BOOL)isLandscape
   accessToken:(NSString*)accessToken;

-(void)hideFloatSJIOS;

-(void)checkSJIOSUpdate:(UIView*)context
           success:(SJIOS_SUCCESS_Callback)success
            failed:(SJIOS_FAILED_Callback)failed
        landscape:(Boolean)landscape;


-(void)addSJIOSUser:(NSString*)username
      password:(NSString*)password
          bind:(NSString*) bind
       tourist:(NSString*) tourist
   phoneNumber:(NSString*) phoneNumber;

-(void)removeSJIOSUser:(NSString*)username;



- (void)showSJIOSWelcome: (NSString*)username;

-(void) showSJIOSToast:(NSString *)text;

-(NSString*)translateSJIOS:(NSString*) error;

+(SJIOSSdkImp*)sharedInstance;

-(void)loadingSJIOS:(SJIOS_SUCCESS_Callback)success
        failed:(SJIOS_FAILED_Callback)failed;

-(void)active;

-(long)getSJIOSTimeNow;

-(void)createRoleSJIOS:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed;

-(void)loginRoleSJIOS:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed;


-(void)showSJIOSShiMingRenZhengView:(NSString *)accessToken callback:(SJIOS_COMMON_BLOCK)callback;



-(void)logout:(NSString *)serverid user_id:(NSString*)user_id success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed;

-(void) sjRegister:(NSString *)userid;

-(void)level:(NSString *)level  serverid:(NSString*)serverid user_id:(NSString*)user_id  role_id:(NSString*)roleid success:(SJIOS_SUCCESS_Callback)success failed:(SJIOS_FAILED_Callback)failed;

-(void)error:(NSString *)log
     success:(SJIOS_SUCCESS_Callback)success
      failed:(SJIOS_FAILED_Callback)failed;



-(NSString*)getSJIOSTimeUserNow;

@end

