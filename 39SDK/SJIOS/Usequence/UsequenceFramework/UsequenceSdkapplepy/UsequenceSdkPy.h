

#ifndef UsequenceSdkPy_h
#define UsequenceSdkPy_h

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "UsequenceSdkCommonDefine.h"

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"


#import "UsequenceSdkMd5.h"
#import "UsequenceProgressHUD.h"
#import "UsequenceSecurityUtil.h"

@interface UsequenceSdkPy : NSObject <UIAlertViewDelegate , SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property(nonatomic, strong) UIView* viewUsequencePy;

@property(nonatomic, strong) UIAlertView* myAlertUsequencePy;
@property(nonatomic, strong) Usequence_SUCCESS_Callback py_successUsequencePy;
@property(nonatomic, strong) Usequence_FAILED_Callback py_failedUsequencePy;
@property(nonatomic, strong) NSDictionary *pyParamUsequencePy;


@property (strong, nonatomic)NSString *productNameUsequencePy;
@property (strong, nonatomic)NSString *productIdUsequencePy;
@property (assign, nonatomic)NSInteger accountUsequencePy;
@property (strong, nonatomic)NSString *appNameUsequencePy;
@property (strong, nonatomic)NSString *userIdUsequencePy;
@property (strong, nonatomic)NSString *accessTokenUsequencePy;
@property (strong, nonatomic)NSString *appOrderIdUsequencePy;
@property (assign, nonatomic)NSInteger gatewayUsequencePy;
@property (strong, nonatomic)NSString *extendUsequencePy;
@property (strong, nonatomic)NSString *role_idUsequencePy;
@property (strong, nonatomic)NSString *role_levelUsequencePy;

@property (strong, nonatomic)NSString *sjOrderIdUsequencePy;


- (void)pyUsequenceForAppstroe:(UIView *)viewUsequence
                 paramUsequence:(NSDictionary *)paramUsequence
               successUsequence:(Usequence_SUCCESS_Callback)successUsequence
                failedUsequence:(Usequence_FAILED_Callback)failedUsequence;


@end

#endif
