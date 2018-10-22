

#ifndef RersistenceSdkPy_h
#define RersistenceSdkPy_h

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "RersistenceSdkCommonDefine.h"

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"


#import "RersistenceSdkMd5.h"
#import "RersistenceProgressHUD.h"
#import "RersistenceSecurityUtil.h"

@interface RersistenceSdkPy : NSObject <UIAlertViewDelegate , SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property(nonatomic, strong) UIView* viewRersistencePy;

@property(nonatomic, strong) UIAlertView* myAlertRersistencePy;
@property(nonatomic, strong) Rersistence_SUCCESS_Callback py_successRersistencePy;
@property(nonatomic, strong) Rersistence_FAILED_Callback py_failedRersistencePy;
@property(nonatomic, strong) NSDictionary *pyParamRersistencePy;


@property (strong, nonatomic)NSString *productNameRersistencePy;
@property (strong, nonatomic)NSString *productIdRersistencePy;
@property (assign, nonatomic)NSInteger accountRersistencePy;
@property (strong, nonatomic)NSString *appNameRersistencePy;
@property (strong, nonatomic)NSString *userIdRersistencePy;
@property (strong, nonatomic)NSString *accessTokenRersistencePy;
@property (strong, nonatomic)NSString *appOrderIdRersistencePy;
@property (assign, nonatomic)NSInteger gatewayRersistencePy;
@property (strong, nonatomic)NSString *extendRersistencePy;
@property (strong, nonatomic)NSString *role_idRersistencePy;
@property (strong, nonatomic)NSString *role_levelRersistencePy;

@property (strong, nonatomic)NSString *sjOrderIdRersistencePy;


- (void)pyRersistenceForAppstroe:(UIView *)viewRersistence
                 paramRersistence:(NSDictionary *)paramRersistence
               successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
                failedRersistence:(Rersistence_FAILED_Callback)failedRersistence;


@end

#endif
