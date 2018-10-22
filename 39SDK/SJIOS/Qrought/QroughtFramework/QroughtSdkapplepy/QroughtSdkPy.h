

#ifndef QroughtSdkPy_h
#define QroughtSdkPy_h

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "QroughtSdkCommonDefine.h"

#import "AQrought.h"
#import "BQrought.h"
#import "CQrought.h"


#import "QroughtSdkMd5.h"
#import "QroughtProgressHUD.h"
#import "QroughtSecurityUtil.h"

@interface QroughtSdkPy : NSObject <UIAlertViewDelegate , SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property(nonatomic, strong) UIView* viewQroughtPy;

@property(nonatomic, strong) UIAlertView* myAlertQroughtPy;
@property(nonatomic, strong) Qrought_SUCCESS_Callback py_successQroughtPy;
@property(nonatomic, strong) Qrought_FAILED_Callback py_failedQroughtPy;
@property(nonatomic, strong) NSDictionary *pyParamQroughtPy;


@property (strong, nonatomic)NSString *productNameQroughtPy;
@property (strong, nonatomic)NSString *productIdQroughtPy;
@property (assign, nonatomic)NSInteger accountQroughtPy;
@property (strong, nonatomic)NSString *appNameQroughtPy;
@property (strong, nonatomic)NSString *userIdQroughtPy;
@property (strong, nonatomic)NSString *accessTokenQroughtPy;
@property (strong, nonatomic)NSString *appOrderIdQroughtPy;
@property (assign, nonatomic)NSInteger gatewayQroughtPy;
@property (strong, nonatomic)NSString *extendQroughtPy;
@property (strong, nonatomic)NSString *role_idQroughtPy;
@property (strong, nonatomic)NSString *role_levelQroughtPy;

@property (strong, nonatomic)NSString *sjOrderIdQroughtPy;


- (void)pyQroughtForAppstroe:(UIView *)viewQrought
                 paramQrought:(NSDictionary *)paramQrought
               successQrought:(Qrought_SUCCESS_Callback)successQrought
                failedQrought:(Qrought_FAILED_Callback)failedQrought;


@end

#endif
