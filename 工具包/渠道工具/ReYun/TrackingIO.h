
#define TRACK_VERSION @"1.1.1"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN
@interface TrackingIO : NSObject

+(void) setPrintLog :(BOOL)print;

+ (void)initWithappKey:(NSString *)appKey withChannelId:(NSString *)channelId;

+ (void)setRegisterWithAccountID:(NSString *)account;

+ (void)setLoginWithAccountID:(NSString *)account;

+(void)setryzfStart:(NSString *)transactionId ryzfType:(NSString*)ryzfType currentType:(NSString*)currencyType currencyAmount:(float)currencyAmount;

+(void)setryzf:(NSString *)transactionId ryzfType:(NSString*)ryzfType currentType:(NSString*)currencyType currencyAmount:(float)currencyAmount;

+(void)setEvent:(NSString *)eventName andExtra:(nullable NSDictionary *)extra;

+(void)setProfile:(nullable NSDictionary *)dataDic;

+(NSString*)getDeviceId;
@end
NS_ASSUME_NONNULL_END
