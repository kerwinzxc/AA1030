
 
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
 
 
typedef enum : NSInteger {
    OrzOSDKNotReachable = 0,
    OrzOSDKReachableViaWiFi,
    OrzOSDKReachableViaWWAN
} OrzOSDKNetworkStatus;
 
#pragma mark IPv6 Support

 
 
extern NSString *OrzOSDKkReachabilityChangedNotification;
 
 
@interface OrzOSDKReachability : NSObject
 

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
 

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

+ (instancetype)reachabilityForInternetConnection;
 
 
#pragma mark reachabilityForLocalWiFi

- (BOOL)startNotifier;
- (void)stopNotifier;
 
- (OrzOSDKNetworkStatus)currentReachabilityStatus;
 

- (BOOL)connectionRequired;
 
@end
