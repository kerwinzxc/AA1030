
 
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
 
 
typedef enum : NSInteger {
    EasterNotReachable = 0,
    EasterReachableViaWiFi,
    EasterReachableViaWWAN
} EasterNetworkStatus;
 
#pragma mark IPv6 Support

 
 
extern NSString *EasterkReachabilityChangedNotification;
 
 
@interface EasterReachability : NSObject
 

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
 

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

+ (instancetype)reachabilityForInternetConnection;
 
 
#pragma mark reachabilityForLocalWiFi

- (BOOL)startNotifier;
- (void)stopNotifier;
 
- (EasterNetworkStatus)currentReachabilityStatus;
 

- (BOOL)connectionRequired;
 
@end
