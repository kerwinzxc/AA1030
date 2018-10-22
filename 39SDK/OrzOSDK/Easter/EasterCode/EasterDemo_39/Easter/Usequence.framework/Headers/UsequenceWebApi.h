

#import <Foundation/Foundation.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"



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

@interface UsequenceWebApi : NSObject



+ (void)requestPostUsequenceUrl:(NSURL *)urlUsequence
       bodyDictionaryUsequence:(NSDictionary *)bodyDictionaryUsequence
      successCallbackUsequence:(Usequence_VSD_BLOCK)successCallbackUsequence
          failCallbackUsequence:(Usequence_VE_BLOCK)failCallbackUsequence;

@end
