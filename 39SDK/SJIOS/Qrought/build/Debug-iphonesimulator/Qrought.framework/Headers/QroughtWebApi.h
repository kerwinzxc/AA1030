

#import <Foundation/Foundation.h>
#import "QroughtSdkCommonDefine.h"

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

@interface QroughtWebApi : NSObject



+ (void)requestPostQroughtUrl:(NSURL *)urlQrought
       bodyDictionaryQrought:(NSDictionary *)bodyDictionaryQrought
      successCallbackQrought:(Qrought_VSD_BLOCK)successCallbackQrought
          failCallbackQrought:(Qrought_VE_BLOCK)failCallbackQrought;

@end
