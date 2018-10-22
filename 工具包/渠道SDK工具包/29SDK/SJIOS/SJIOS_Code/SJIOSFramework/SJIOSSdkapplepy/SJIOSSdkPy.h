

#ifndef SJIOSSdkPy_h
#define SJIOSSdkPy_h

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "SJIOSSdk_const_def.h"
#import "SJIOSSdkMd5.h"
#import "SJIOSProgressHUD.h"
#import "SJIOSSecurityUtil.h"

@interface SJIOSSdkPy : NSObject <UIAlertViewDelegate , SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property(nonatomic, strong) UIView* view;

@property(nonatomic, strong) UIAlertView* myAlert;
@property(nonatomic, strong) SJIOS_SUCCESS_Callback py_success;
@property(nonatomic, strong) SJIOS_FAILED_Callback py_failed;
@property(nonatomic, strong) NSDictionary *pyParam;


@property (strong, nonatomic)NSString *productName;
@property (strong, nonatomic)NSString *productId;
@property (assign, nonatomic)NSInteger account;
@property (strong, nonatomic)NSString *appName;
@property (strong, nonatomic)NSString *userId;
@property (strong, nonatomic)NSString *accessToken;
@property (strong, nonatomic)NSString *appOrderId;
@property (assign, nonatomic)NSInteger gateway;
@property (strong, nonatomic)NSString *extend;
@property (strong, nonatomic)NSString *role_id;
@property (strong, nonatomic)NSString *role_level;

@property (strong, nonatomic)NSString *sjOrderId;


- (void)pySJIOSForAppstroe:(UIView *)view
                 param:(NSDictionary *)param
               success:(SJIOS_SUCCESS_Callback)success
                failed:(SJIOS_FAILED_Callback)failed;


@end

#endif
