

#ifndef SJIOSSdkPy_h
#define SJIOSSdkPy_h

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "SJIOSSdkCommonDefine.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSSecurityUtil.h"

@interface SJIOSSdkPy : NSObject <UIAlertViewDelegate , SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property(nonatomic, strong) UIView* viewSJIOSPy;

@property(nonatomic, strong) UIAlertView* myAlertSJIOSPy;
@property(nonatomic, strong) SJIOS_SUCCESS_Callback py_successSJIOSPy;
@property(nonatomic, strong) SJIOS_FAILED_Callback py_failedSJIOSPy;
@property(nonatomic, strong) NSDictionary *pyParamSJIOSPy;


@property (strong, nonatomic)NSString *productNameSJIOSPy;
@property (strong, nonatomic)NSString *productIdSJIOSPy;
@property (assign, nonatomic)NSInteger accountSJIOSPy;
@property (strong, nonatomic)NSString *appNameSJIOSPy;
@property (strong, nonatomic)NSString *userIdSJIOSPy;
@property (strong, nonatomic)NSString *accessTokenSJIOSPy;
@property (strong, nonatomic)NSString *appOrderIdSJIOSPy;
@property (assign, nonatomic)NSInteger gatewaySJIOSPy;
@property (strong, nonatomic)NSString *extendSJIOSPy;
@property (strong, nonatomic)NSString *role_idSJIOSPy;
@property (strong, nonatomic)NSString *role_levelSJIOSPy;

@property (strong, nonatomic)NSString *sjOrderIdSJIOSPy;


- (void)pySJIOSForAppstroe:(UIView *)viewSJIOS
                 paramSJIOS:(NSDictionary *)paramSJIOS
               successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
                failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS;


@end

#endif
