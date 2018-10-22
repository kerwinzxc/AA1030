

#import <Foundation/Foundation.h>
#import "SJIOSSdk_const_def.h"

@interface SJIOSRPC : NSObject



+ (void)requestPostSJIOSUrl:(NSURL *)url
       bodyDictionary:(NSDictionary *)bodyDictionary
      completionBlock:(SJIOS_VSD_BLOCK)completionBlock
          failedBlock:(SJIOS_VE_BLOCK)failedBlock;

@end
