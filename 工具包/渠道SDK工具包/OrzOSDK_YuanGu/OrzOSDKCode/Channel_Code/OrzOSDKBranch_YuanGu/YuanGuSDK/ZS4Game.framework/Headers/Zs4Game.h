//v2034
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    GAMEInterfaceOrientationPortrait         =     5,    //--支持竖版转向，通常使用
    GAMEInterfaceOrientationLandscape        =     6     //--支持横版转向，通常使用
}
GameInterfaceOrientation;


@interface Zs4Game : NSObject


#pragma mark - 设置基本信息
- (void)setAppID:(int)appid                                          //设置AppId，用来统计
         AppKey:(NSString *)appkey                                  //设置AppKey，用来统计
       UmengKey:(NSString *)umengkey                                //设置UmengKey，用来统计
TalkingDataAdTracking:(NSString *)adTracking                        //设置adTracking
     TrackingKey:(NSString *) trackingkey                           //热云key
TrackingChannelId:(NSString *) channelId                            //热云channel
 GameOrientation:(GameInterfaceOrientation)gameOrientation             //设置SDK的方向
  LaunchOptions:(NSDictionary *)launchOptions;                       //设置启动参数


#pragma mark - 设置SDK 后台启动
- (void)setSDKEnterForeground;



#pragma mark - 设置游戏基本信息
- (void)login;


- (void)setServId:(NSString *)servId                //区服id 必须调用
         ServName:(NSString *)ServName              //区服名称
           RoleId:(NSString*)roleId                //角色id
         RoleName:(NSString *)roleName              //角色名字
        RoleGrade:(int)roleGrade;                 //角色等级



- (void)setRoleId:(NSString*)roleId                 //角色id
        RoleGrade:(int)roleGrade;                 //角色等级

- (void) payforProduct:(NSString *) productId     // 配置在appstore的商品ID
           Expand_Data:(NSString *) Expand_Data;  // 扩展参数，可以为空
//
//-(void)requestTokenCheckWithUid:(NSString *)uid
//                          token:(NSString *)token;

#pragma mark - 登录状态

- (BOOL)isLogined;
-(void)showLogo;



#pragma mark - 获取广告标志IDFA
+ (NSString *)getAdvertisingIdentifier;




#pragma mark - 游戏中设置一个用户中心按钮显示用户中心
- (void)showAccountCenter;

#pragma mark - 游戏设置一个在线客服按钮显示在线客服功能
- (void)showServiceCenter;


- (BOOL)isShowLoginView;


#pragma mark - 其他

+ (Zs4Game *)sharedInstance;
+ (void)releaseInstance;
+ (NSString *)version;
+ (NSString *)getPayType;


#pragma mark - 角色被其他设备登录可调用
- (void)logout;


@end



typedef enum {
    GAME_ERROR_NETWORK,                                 // 客户端网络问题
    GAME_ERROR_SERVER,                                  // 服务器异常
    
}GAMEErrorCode;


