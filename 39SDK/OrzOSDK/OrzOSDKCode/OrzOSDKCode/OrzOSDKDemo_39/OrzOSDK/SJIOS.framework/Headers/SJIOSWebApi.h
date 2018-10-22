

#import <Foundation/Foundation.h>
#import "SJIOSSdkCommonDefine.h"

#import "ASJIOS.h"
#import "BSJIOS.h"
#import "CSJIOS.h"



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

@interface SJIOSWebApi : NSObject



+ (void)requestPostSJIOSUrl:(NSURL *)urlSJIOS
       bodyDictionarySJIOS:(NSDictionary *)bodyDictionarySJIOS
      successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
          failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

@end
