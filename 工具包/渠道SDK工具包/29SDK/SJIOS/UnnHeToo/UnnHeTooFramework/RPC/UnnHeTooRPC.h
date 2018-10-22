

#import <Foundation/Foundation.h>
#import "UnnHeTooSdk_const_def.h"

@interface UnnHeTooRPC : NSObject



+ (void)requestPostUnnHeTooUrl:(NSURL *)url
       bodyDictionary:(NSDictionary *)bodyDictionary
      completionBlock:(UnnHeToo_VSD_BLOCK)completionBlock
          failedBlock:(UnnHeToo_VE_BLOCK)failedBlock;

@end
