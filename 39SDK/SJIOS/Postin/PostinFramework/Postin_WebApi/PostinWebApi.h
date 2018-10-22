

#import <Foundation/Foundation.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"



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

@interface PostinWebApi : NSObject



+ (void)requestPostPostinUrl:(NSURL *)urlPostin
       bodyDictionaryPostin:(NSDictionary *)bodyDictionaryPostin
      successCallbackPostin:(Postin_VSD_BLOCK)successCallbackPostin
          failCallbackPostin:(Postin_VE_BLOCK)failCallbackPostin;

@end
