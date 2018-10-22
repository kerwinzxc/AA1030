
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSBase.h>
#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSContextRef.h>
#import <JavaScriptCore/JSValue.h>
#import <JavaScriptCore/WebKitAvailability.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
 
 
typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;
 
#pragma mark IPv6 Support
 
extern NSString *kSJIOSReachabilityChangedNotification;

@interface SJIOSReachability : NSObject
 

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
 

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;
 

+ (instancetype)reachabilityForInternetConnection;
 
 
#pragma mark reachabilityForLocalWiFi

- (BOOL)startNotifier;
- (void)stopNotifier;
 
- (NetworkStatus)currentReachabilityStatus;

- (BOOL)connectionRequired;
 
@end
