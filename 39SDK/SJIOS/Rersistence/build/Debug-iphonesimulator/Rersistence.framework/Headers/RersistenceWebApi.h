

#import <Foundation/Foundation.h>
#import "RersistenceSdkCommonDefine.h"

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

@interface RersistenceWebApi : NSObject



+ (void)requestPostRersistenceUrl:(NSURL *)urlRersistence
       bodyDictionaryRersistence:(NSDictionary *)bodyDictionaryRersistence
      successCallbackRersistence:(Rersistence_VSD_BLOCK)successCallbackRersistence
          failCallbackRersistence:(Rersistence_VE_BLOCK)failCallbackRersistence;

@end
