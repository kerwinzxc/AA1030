
 
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
 
 
typedef enum : NSInteger {
    PunctuationNotReachable = 0,
    PunctuationReachableViaWiFi,
    PunctuationReachableViaWWAN
} PunctuationNetworkStatus;
 
#pragma mark IPv6 Support

 
 
extern NSString *PunctuationkReachabilityChangedNotification;
 
 
@interface PunctuationReachability : NSObject
 

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
 

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

+ (instancetype)reachabilityForInternetConnection;
 
 
#pragma mark reachabilityForLocalWiFi

- (BOOL)startNotifier;
- (void)stopNotifier;
 
- (PunctuationNetworkStatus)currentReachabilityStatus;
 

- (BOOL)connectionRequired;
 
@end
