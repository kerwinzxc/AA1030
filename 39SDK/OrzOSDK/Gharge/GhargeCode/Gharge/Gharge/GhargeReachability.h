
 
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
 
 
typedef enum : NSInteger {
    GhargeNotReachable = 0,
    GhargeReachableViaWiFi,
    GhargeReachableViaWWAN
} GhargeNetworkStatus;
 
#pragma mark IPv6 Support

 
 
extern NSString *GhargekReachabilityChangedNotification;
 
 
@interface GhargeReachability : NSObject
 

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
 

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

+ (instancetype)reachabilityForInternetConnection;
 
 
#pragma mark reachabilityForLocalWiFi

- (BOOL)startNotifier;
- (void)stopNotifier;
 
- (GhargeNetworkStatus)currentReachabilityStatus;
 

- (BOOL)connectionRequired;
 
@end
