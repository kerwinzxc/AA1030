

#import <Foundation/Foundation.h>
#import "UsequenceSdkPy.h"
#import "UsequenceSdk.h"
#import "UsequenceWebApi.h"
#import "UsequenceSdkImp.h"
#import "UsequenceWebInterface.h"



@implementation UsequenceSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startUsequenceLoading
{
    if (self.myAlertUsequencePy==nil){
        self.myAlertUsequencePy = [[UIAlertView alloc] initWithTitle:nil
                                             message: @"正在连接..."
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 38.0f, 38.0f);
        [self.myAlertUsequencePy addSubview:activityView];
        [activityView startAnimating];
        [self.myAlertUsequencePy show];
    }
}

- (void)changeloadingUsequence:(NSString*)msg
{
    if (self.myAlertUsequencePy) {
        [self.myAlertUsequencePy setMessage:msg];
    }
}

- (void)finishUsequenceLoading
{
    [self.myAlertUsequencePy dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlertUsequencePy = nil;
}


-(void)createUsequenceOrderWithExtra:(NSString *)extra
                   callBack:(Usequence_ODER_BLOCK)callback {
    NSString *clientId = [[UsequenceSdkImp sharedInstance]getUsequenceAppKey];
    NSString *privateKey = [[UsequenceSdkImp sharedInstance]getUsequenceAppPrivateKey];
    NSString *channel = [[UsequenceSdkImp sharedInstance] getUsequenceChannel];
    NSString *sign ;
    
    if ([self.extendUsequencePy isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenUsequencePy,(long)self.accountUsequencePy,self.appNameUsequencePy,self.appOrderIdUsequencePy,channel,clientId,extra,(long)self.gatewayUsequencePy,self.productIdUsequencePy,self.productNameUsequencePy,self.userIdUsequencePy];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenUsequencePy,(long)self.accountUsequencePy,self.appNameUsequencePy,self.appOrderIdUsequencePy,channel,clientId,self.extendUsequencePy,extra,(long)self.gatewayUsequencePy,self.productIdUsequencePy,self.productNameUsequencePy,self.userIdUsequencePy];
    }
    sign = [UsequenceSdkMd5 md5:sign];
    [[UsequenceWebInterface sharedInstance]createOrUsequenceder:self.accessTokenUsequencePy userIdUsequence:self.userIdUsequencePy productNameUsequence:self.productNameUsequencePy productIdUsequence:self.productIdUsequencePy accountUsequence:self.accountUsequencePy appOrderIdUsequence:self.appOrderIdUsequencePy appNameUsequence:self.appNameUsequencePy clientIdUsequence:clientId gatewayUsequence:self.gatewayUsequencePy channelUsequence:channel orderTypeUsequence:@"iap" extraUsequence:extra extendUsequence:self.extendUsequencePy signUsequence:sign successCallbackUsequence:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishUsequenceLoading];
                [self UsequenceMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failedUsequencePy(-1002);
            }
            else
                [self finishUsequenceLoading];
                [self UsequenceMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failedUsequencePy(-1002);
        }
        else {
            self.sjOrderIdUsequencePy = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderIdUsequencePy);
        }
        
    } failCallbackUsequence:^(NSError *error) {
        [self finishUsequenceLoading];
        [self UsequenceMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failedUsequencePy(-1002);
    }];
    

}

-(void)UsequenceMessageDespatch:(int)sign
               message:(NSString *)msg
{
    switch (sign) {
        case MSG_ERROR:
            [self showUsequenceMsg:msg];
        default:
            break;
    }
}

-(void)showUsequenceMsg:(NSString *)msg {
    UsequenceProgressHUD * process = [[UsequenceProgressHUD alloc] initWithView:self.viewUsequencePy];
    [self.viewUsequencePy addSubview:process];
    [self.viewUsequencePy bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = UsequenceProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pyUsequenceForAppstroe:(UIView *)viewUsequence
                 paramUsequence:(NSDictionary *)paramUsequence
               successUsequence:(Usequence_SUCCESS_Callback)successUsequence
                failedUsequence:(Usequence_FAILED_Callback)failedUsequence{
    
    self.py_successUsequencePy = successUsequence;
    self.py_failedUsequencePy = failedUsequence;
    self.pyParamUsequencePy = paramUsequence;
    self.viewUsequencePy = viewUsequence;
    
    
    self.productNameUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_PRODUCT_NAME];
    self.productIdUsequencePy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_PRODUCT_ID]];
    self.accountUsequencePy = [[self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_ACCOUNT] integerValue];
    self.appNameUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_APP_NAME];
    self.userIdUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_USER_ID];
    self.accessTokenUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_ACCESSTOKEN];
    self.appOrderIdUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_APP_ORDER_ID];
    self.gatewayUsequencePy = [[self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_GATEWAY] integerValue];
    self.extendUsequencePy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_EXTEND_INFO]];
    self.role_idUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_ROLE_ID];
    self.role_levelUsequencePy = [self.pyParamUsequencePy objectForKey:Usequence_PROTOCOL_ROLE_LEVEL];

    
    [self startUsequenceLoading];
    
    
    
    
    [self createUsequenceOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.accountUsequencePy] callBack:^(NSString *orderId) {

        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"id = %@", self.productIdUsequencePy);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productIdUsequencePy]];
        productRequest.delegate = self;
        [productRequest start];
    }];
    

    
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *skProduct = response.products;
    NSLog(@"skProduct.count = %d", (int)skProduct.count);
    if((int)skProduct.count == 0){
        
        [self finishUsequenceLoading];
        [self UsequenceMessageDespatch:MSG_ERROR message:@"商品内购id有误"];
        self.py_failedUsequencePy(-1000);
        
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
        [self finishUsequenceLoading];
        [self UsequenceMessageDespatch:MSG_ERROR message:@"失败,用户禁止计费购买"];
        self.py_failedUsequencePy(-1001);
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
                
                [self completeUsequenceTransaction: transaction];
                
                break;
            case SKPaymentTransactionStateFailed:
                [self failedUsequenceTransaction: transaction];
                NSLog(@"self.py_failedUsequencePy(-1004);");
                [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"已取消"];
                [self finishUsequenceLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreUsequenceTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingUsequence:@"正在请求..."];
                break;
            default:
                self.py_failedUsequencePy(-1005);
                [[UsequenceSdkImp sharedInstance] showUsequenceToast:@"-1005"];
                break;
        }
    }
}


//成功
- (void) completeUsequenceTransaction: (SKPaymentTransaction *)transaction
{
    
    [self sendPUsequenceyInfoToServer:transaction];    //将完成后的信息移出队列
    [[SKPaymentQueue defaultQueue]finishTransaction: transaction];
}

//恢复完成
- (void) restoreUsequenceTransaction: (SKPaymentTransaction *)transaction
{
    //NSString* str = [[transaction transactionReceipt] base64EncodedStringWithOptions:0];
    [self sendPUsequenceyInfoToServer:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//失败
- (void)failedUsequenceTransaction: (SKPaymentTransaction *)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

- (void) sendPUsequenceyInfoToServer :(SKPaymentTransaction *)transaction
{
    NSData *receipt = transaction.transactionReceipt;
    
    
    //苹果返回的结果无法直接转化成合作方需求的数据格式，只能自己拼装，以下是拼装过程
    NSString * nsData = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    Usequence_VSD_BLOCK checkResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.py_failedUsequencePy(-1007);
                [self finishUsequenceLoading];
                [[UsequenceSdkImp sharedInstance]showUsequenceToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_successUsequencePy(@"success");
                [self finishUsequenceLoading];
                [self UsequenceMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failedUsequencePy(-1008);
                [self finishUsequenceLoading];
                [self UsequenceMessageDespatch:MSG_ERROR message:@"失败"];
            }
            
        }@catch(NSException * e)
        {
            [self finishUsequenceLoading];
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    
    [self changeloadingUsequence:@"正在验证..."];
    [[UsequenceWebInterface sharedInstance] UsequenceSdkUsequenceCheck:self.sjOrderIdUsequencePy descriptionUsequence:[UsequenceSecurityUtil encodeBase64String:nsData] successCallbackUsequence:checkResult failCallbackUsequence:^(NSError *error) {
        [self finishUsequenceLoading];
        [self UsequenceMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failedUsequencePy(-1006);
    }];
}


@end
