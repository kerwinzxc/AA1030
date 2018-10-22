
 
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
 
 
typedef enum : NSInteger {
    ReleasbNotReachable = 0,
    ReleasbReachableViaWiFi,
    ReleasbReachableViaWWAN
} ReleasbNetworkStatus;
 
#pragma mark IPv6 Support

 
 
extern NSString *ReleasbkReachabilityChangedNotification;
 
 
@interface ReleasbReachability : NSObject
 

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
 

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

+ (instancetype)reachabilityForInternetConnection;
 
 
#pragma mark reachabilityForLocalWiFi

- (BOOL)startNotifier;
- (void)stopNotifier;
 
- (ReleasbNetworkStatus)currentReachabilityStatus;
 

- (BOOL)connectionRequired;
 
@end
