

#import <Foundation/Foundation.h>
#import "RersistenceSdkPy.h"
#import "RersistenceSdk.h"
#import "RersistenceWebApi.h"
#import "RersistenceSdkImp.h"
#import "RersistenceWebInterface.h"



@implementation RersistenceSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startRersistenceLoading
{
    if (self.myAlertRersistencePy==nil){
        self.myAlertRersistencePy = [[UIAlertView alloc] initWithTitle:nil
                                             message: @"正在连接..."
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 38.0f, 38.0f);
        [self.myAlertRersistencePy addSubview:activityView];
        [activityView startAnimating];
        [self.myAlertRersistencePy show];
    }
}

- (void)changeloadingRersistence:(NSString*)msg
{
    if (self.myAlertRersistencePy) {
        [self.myAlertRersistencePy setMessage:msg];
    }
}

- (void)finishRersistenceLoading
{
    [self.myAlertRersistencePy dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlertRersistencePy = nil;
}


-(void)createRersistenceOrderWithExtra:(NSString *)extra
                   callBack:(Rersistence_ODER_BLOCK)callback {
    NSString *clientId = [[RersistenceSdkImp sharedInstance]getRersistenceAppKey];
    NSString *privateKey = [[RersistenceSdkImp sharedInstance]getRersistenceAppPrivateKey];
    NSString *channel = [[RersistenceSdkImp sharedInstance] getRersistenceChannel];
    NSString *sign ;
    
    if ([self.extendRersistencePy isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenRersistencePy,(long)self.accountRersistencePy,self.appNameRersistencePy,self.appOrderIdRersistencePy,channel,clientId,extra,(long)self.gatewayRersistencePy,self.productIdRersistencePy,self.productNameRersistencePy,self.userIdRersistencePy];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenRersistencePy,(long)self.accountRersistencePy,self.appNameRersistencePy,self.appOrderIdRersistencePy,channel,clientId,self.extendRersistencePy,extra,(long)self.gatewayRersistencePy,self.productIdRersistencePy,self.productNameRersistencePy,self.userIdRersistencePy];
    }
    sign = [RersistenceSdkMd5 md5:sign];
    [[RersistenceWebInterface sharedInstance]createOrRersistenceder:self.accessTokenRersistencePy userIdRersistence:self.userIdRersistencePy productNameRersistence:self.productNameRersistencePy productIdRersistence:self.productIdRersistencePy accountRersistence:self.accountRersistencePy appOrderIdRersistence:self.appOrderIdRersistencePy appNameRersistence:self.appNameRersistencePy clientIdRersistence:clientId gatewayRersistence:self.gatewayRersistencePy channelRersistence:channel orderTypeRersistence:@"iap" extraRersistence:extra extendRersistence:self.extendRersistencePy signRersistence:sign successCallbackRersistence:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishRersistenceLoading];
                [self RersistenceMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failedRersistencePy(-1002);
            }
            else
                [self finishRersistenceLoading];
                [self RersistenceMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failedRersistencePy(-1002);
        }
        else {
            self.sjOrderIdRersistencePy = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderIdRersistencePy);
        }
        
    } failCallbackRersistence:^(NSError *error) {
        [self finishRersistenceLoading];
        [self RersistenceMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failedRersistencePy(-1002);
    }];
    

}

-(void)RersistenceMessageDespatch:(int)sign
               message:(NSString *)msg
{
    switch (sign) {
        case MSG_ERROR:
            [self showRersistenceMsg:msg];
        default:
            break;
    }
}

-(void)showRersistenceMsg:(NSString *)msg {
    RersistenceProgressHUD * process = [[RersistenceProgressHUD alloc] initWithView:self.viewRersistencePy];
    [self.viewRersistencePy addSubview:process];
    [self.viewRersistencePy bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = RersistenceProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pyRersistenceForAppstroe:(UIView *)viewRersistence
                 paramRersistence:(NSDictionary *)paramRersistence
               successRersistence:(Rersistence_SUCCESS_Callback)successRersistence
                failedRersistence:(Rersistence_FAILED_Callback)failedRersistence{
    
    self.py_successRersistencePy = successRersistence;
    self.py_failedRersistencePy = failedRersistence;
    self.pyParamRersistencePy = paramRersistence;
    self.viewRersistencePy = viewRersistence;
    
    
    self.productNameRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_PRODUCT_NAME];
    self.productIdRersistencePy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_PRODUCT_ID]];
    self.accountRersistencePy = [[self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_ACCOUNT] integerValue];
    self.appNameRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_APP_NAME];
    self.userIdRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_USER_ID];
    self.accessTokenRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_ACCESSTOKEN];
    self.appOrderIdRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_APP_ORDER_ID];
    self.gatewayRersistencePy = [[self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_GATEWAY] integerValue];
    self.extendRersistencePy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_EXTEND_INFO]];
    self.role_idRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_ROLE_ID];
    self.role_levelRersistencePy = [self.pyParamRersistencePy objectForKey:Rersistence_PROTOCOL_ROLE_LEVEL];

    
    [self startRersistenceLoading];
    
    
    
    
    [self createRersistenceOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.accountRersistencePy] callBack:^(NSString *orderId) {

        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"id = %@", self.productIdRersistencePy);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productIdRersistencePy]];
        productRequest.delegate = self;
        [productRequest start];
    }];
    

    
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *skProduct = response.products;
    NSLog(@"skProduct.count = %d", (int)skProduct.count);
    if((int)skProduct.count == 0){
        
        [self finishRersistenceLoading];
        [self RersistenceMessageDespatch:MSG_ERROR message:@"商品内购id有误"];
        self.py_failedRersistencePy(-1000);
        
        return;
    }
    SKProduct *p = [skProduct objectAtIndex:0];
    
    NSLocale *locale = p.priceLocale;
    NSLog(@"p.price = %@", p.price);
    NSLog(@"p.priceLocale = %@", p.priceLocale);
    NSLog(@"p.productIdentifier = %@", p.productIdentifier);
    
    NSNumberFormatter *num = [[NSNumberFormatter alloc] init];
    [num setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [num setNumberStyle:NSNumberFormatterCurrencyStyle];
    [num setLocale:p.priceLocale];
    
    NSString *country = (NSString *)CFLocaleGetValue((CFLocaleRef)locale, kCFLocaleCountryCode);
    NSLog(@"country = %@", country);
    
    
    if ([SKPaymentQueue canMakePayments])
    {
        
        SKPayment *pyment = [SKPayment paymentWithProductIdentifier:p.productIdentifier];
        [[SKPaymentQueue defaultQueue] addPayment: pyment];
        
    }
    else
    {
        [self finishRersistenceLoading];
        [self RersistenceMessageDespatch:MSG_ERROR message:@"失败,用户禁止计费购买"];
        self.py_failedRersistencePy(-1001);
    }
}

//Appstore 监听回调
- (void)paymentQueue: (SKPaymentQueue *)queue updatedTransactions: (NSArray *)transactions
{
    

    for(SKPaymentTransaction * transaction in transactions)
    {
        
        switch(transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                
                [self completeRersistenceTransaction: transaction];
                
                break;
            case SKPaymentTransactionStateFailed:
                [self failedRersistenceTransaction: transaction];
                NSLog(@"self.py_failedRersistencePy(-1004);");
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"已取消"];
                [self finishRersistenceLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreRersistenceTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingRersistence:@"正在请求..."];
                break;
            default:
                self.py_failedRersistencePy(-1005);
                [[RersistenceSdkImp sharedInstance] showRersistenceToast:@"-1005"];
                break;
        }
    }
}


//成功
- (void) completeRersistenceTransaction: (SKPaymentTransaction *)transaction
{
    
    [self sendPRersistenceyInfoToServer:transaction];    //将完成后的信息移出队列
    [[SKPaymentQueue defaultQueue]finishTransaction: transaction];
}

//恢复完成
- (void) restoreRersistenceTransaction: (SKPaymentTransaction *)transaction
{
    //NSString* str = [[transaction transactionReceipt] base64EncodedStringWithOptions:0];
    [self sendPRersistenceyInfoToServer:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//失败
- (void)failedRersistenceTransaction: (SKPaymentTransaction *)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

- (void) sendPRersistenceyInfoToServer :(SKPaymentTransaction *)transaction
{
    NSData *receipt = transaction.transactionReceipt;
    
    
    //苹果返回的结果无法直接转化成合作方需求的数据格式，只能自己拼装，以下是拼装过程
    NSString * nsData = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    Rersistence_VSD_BLOCK checkResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.py_failedRersistencePy(-1007);
                [self finishRersistenceLoading];
                [[RersistenceSdkImp sharedInstance]showRersistenceToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_successRersistencePy(@"success");
                [self finishRersistenceLoading];
                [self RersistenceMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failedRersistencePy(-1008);
                [self finishRersistenceLoading];
                [self RersistenceMessageDespatch:MSG_ERROR message:@"失败"];
            }
            
        }@catch(NSException * e)
        {
            [self finishRersistenceLoading];
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    
    [self changeloadingRersistence:@"正在验证..."];
    [[RersistenceWebInterface sharedInstance] RersistenceSdkRersistenceCheck:self.sjOrderIdRersistencePy descriptionRersistence:[RersistenceSecurityUtil encodeBase64String:nsData] successCallbackRersistence:checkResult failCallbackRersistence:^(NSError *error) {
        [self finishRersistenceLoading];
        [self RersistenceMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failedRersistencePy(-1006);
    }];
}


@end
