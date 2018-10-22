

#import <Foundation/Foundation.h>
#import "SJIOSSdkCommonDefine.h"

@interface SJIOSWebApi : NSObject



+ (void)requestPostSJIOSUrl:(NSURL *)urlSJIOS
       bodyDictionarySJIOS:(NSDictionary *)bodyDictionarySJIOS
      successCallbackSJIOS:(SJIOS_VSD_BLOCK)successCallbackSJIOS
          failCallbackSJIOS:(SJIOS_VE_BLOCK)failCallbackSJIOS;

@end
