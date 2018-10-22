

#ifndef PostinSdkPy_h
#define PostinSdkPy_h

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "PostinSdkCommonDefine.h"

#import "APostin.h"
#import "BPostin.h"
#import "CPostin.h"


#import "PostinSdkMd5.h"
#import "PostinProgressHUD.h"
#import "PostinSecurityUtil.h"

@interface PostinSdkPy : NSObject <UIAlertViewDelegate , SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property(nonatomic, strong) UIView* viewPostinPy;

@property(nonatomic, strong) UIAlertView* myAlertPostinPy;
@property(nonatomic, strong) Postin_SUCCESS_Callback py_successPostinPy;
@property(nonatomic, strong) Postin_FAILED_Callback py_failedPostinPy;
@property(nonatomic, strong) NSDictionary *pyParamPostinPy;


@property (strong, nonatomic)NSString *productNamePostinPy;
@property (strong, nonatomic)NSString *productIdPostinPy;
@property (assign, nonatomic)NSInteger accountPostinPy;
@property (strong, nonatomic)NSString *appNamePostinPy;
@property (strong, nonatomic)NSString *userIdPostinPy;
@property (strong, nonatomic)NSString *accessTokenPostinPy;
@property (strong, nonatomic)NSString *appOrderIdPostinPy;
@property (assign, nonatomic)NSInteger gatewayPostinPy;
@property (strong, nonatomic)NSString *extendPostinPy;
@property (strong, nonatomic)NSString *role_idPostinPy;
@property (strong, nonatomic)NSString *role_levelPostinPy;

@property (strong, nonatomic)NSString *sjOrderIdPostinPy;


- (void)pyPostinForAppstroe:(UIView *)viewPostin
                 paramPostin:(NSDictionary *)paramPostin
               successPostin:(Postin_SUCCESS_Callback)successPostin
                failedPostin:(Postin_FAILED_Callback)failedPostin;


@end

#endif
