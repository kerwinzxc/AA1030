

#import <Foundation/Foundation.h>
#import "UnnHeTooSdk_const_def.h"
#import "UnnHeTooUserInfo.h"
#import "UnnHeTooKeyChainTool.h"
#import "UnnHeTooSdkPy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>
#import "UnnHeTooReachability.h"

#define ios8 ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
@interface UnnHeTooSdkImp  : NSObject

@property (strong, nonatomic) NSDictionary * setting;

@property (strong, nonatomic) NSString* username;
@property (nonatomic ,strong)UIView *rootControllerView;
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *outIp;

@property (nonatomic,strong) UnnHeTooSdkPy* UnnHeTooSdkPy;


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


-(void)initUnnHeToo:(Boolean)isLandscape
   UnnHeToo_Appid:(NSString *)UnnHeToo_Appid
  UnnHeToo_Appkey:(NSString *)UnnHeToo_Appkey
 UnnHeToo_Channel:(NSString *)UnnHeToo_Channel
UnnHeToo_Appsecret:(NSString *)UnnHeToo_Appsecret
     UnnHeToo_Gid:(NSString *)UnnHeToo_Gid
UnnHeToo_RYAppkey:(NSString *)UnnHeToo_RYAppkey
    success:(UnnHeToo_SUCCESS_Callback)success
     failed:(UnnHeToo_FAILED_Callback)failed;

-(void)initUnnHeTooPart:(UnnHeToo_SUCCESS_Callback)success
         failed:(UnnHeToo_FAILED_Callback)failed;

-(void)destroyUnnHeToo;


-(void)loginUnnHeToo:(UIView*)view 
   landscape:(Boolean)isLandscape
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed;

-(void)logoutUnnHeToo:(UIView*)view
      success:(UnnHeToo_SUCCESS_Callback)success
       failed:(UnnHeToo_FAILED_Callback)failed;



-(void)pUnnHeTooy:(UIViewController*)context
 landscape:(Boolean)isLandscape
    params:(NSDictionary*)params
   success:(UnnHeToo_SUCCESS_Callback)success
    failed:(UnnHeToo_FAILED_Callback)failed;

-(void)executeUnnHeToo:(UIViewController *)viewController
     landscape:(BOOL)isLandscape
   accessToken:(NSString*)accessToken;

-(void)hideFloatUnnHeToo;

-(void)checkUnnHeTooUpdate:(UIView*)context
           success:(UnnHeToo_SUCCESS_Callback)success
            failed:(UnnHeToo_FAILED_Callback)failed
        landscape:(Boolean)landscape;


-(void)addUnnHeTooUser:(NSString*)username
      password:(NSString*)password
          bind:(NSString*) bind
       tourist:(NSString*) tourist
   phoneNumber:(NSString*) phoneNumber;

-(void)removeUnnHeTooUser:(NSString*)username;



- (void)showUnnHeTooWelcome: (NSString*)username;

-(void) showUnnHeTooToast:(NSString *)text;

-(NSString*)translateUnnHeToo:(NSString*) error;

+(UnnHeTooSdkImp*)sharedInstance;

-(void)loadingUnnHeToo:(UnnHeToo_SUCCESS_Callback)success
        failed:(UnnHeToo_FAILED_Callback)failed;

-(void)active;

-(long)getUnnHeTooTimeNow;

-(void)createRoleUnnHeToo:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
        roleLevel:(NSString *)roleLevel success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed;

-(void)loginRoleUnnHeToo:(NSString *)serverid user_id:(NSString*)user_id roleId:(NSString *)roleId
       roleLevel:(NSString *)roleLevel success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed;


-(void)showUnnHeTooShiMingRenZhengView:(NSString *)accessToken callback:(UnnHeToo_COMMON_BLOCK)callback;



-(void)logout:(NSString *)serverid user_id:(NSString*)user_id success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed;

-(void) sjRegister:(NSString *)userid;

-(void)level:(NSString *)level  serverid:(NSString*)serverid user_id:(NSString*)user_id  role_id:(NSString*)roleid success:(UnnHeToo_SUCCESS_Callback)success failed:(UnnHeToo_FAILED_Callback)failed;

-(void)error:(NSString *)log
     success:(UnnHeToo_SUCCESS_Callback)success
      failed:(UnnHeToo_FAILED_Callback)failed;



-(NSString*)getUnnHeTooTimeUserNow;

@end

