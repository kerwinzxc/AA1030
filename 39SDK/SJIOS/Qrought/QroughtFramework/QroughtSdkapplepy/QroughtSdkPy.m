

#import <Foundation/Foundation.h>
#import "QroughtSdkPy.h"
#import "QroughtSdk.h"
#import "QroughtWebApi.h"
#import "QroughtSdkImp.h"
#import "QroughtWebInterface.h"



@implementation QroughtSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startQroughtLoading
{
    if (self.myAlertQroughtPy==nil){
        self.myAlertQroughtPy = [[UIAlertView alloc] initWithTitle:nil
                                             message: @"正在连接..."
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 38.0f, 38.0f);
        [self.myAlertQroughtPy addSubview:activityView];
        [activityView startAnimating];
        [self.myAlertQroughtPy show];
    }
}

- (void)changeloadingQrought:(NSString*)msg
{
    if (self.myAlertQroughtPy) {
        [self.myAlertQroughtPy setMessage:msg];
    }
}

- (void)finishQroughtLoading
{
    [self.myAlertQroughtPy dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlertQroughtPy = nil;
}


-(void)createQroughtOrderWithExtra:(NSString *)extra
                   callBack:(Qrought_ODER_BLOCK)callback {
    NSString *clientId = [[QroughtSdkImp sharedInstance]getQroughtAppKey];
    NSString *privateKey = [[QroughtSdkImp sharedInstance]getQroughtAppPrivateKey];
    NSString *channel = [[QroughtSdkImp sharedInstance] getQroughtChannel];
    NSString *sign ;
    
    if ([self.extendQroughtPy isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenQroughtPy,(long)self.accountQroughtPy,self.appNameQroughtPy,self.appOrderIdQroughtPy,channel,clientId,extra,(long)self.gatewayQroughtPy,self.productIdQroughtPy,self.productNameQroughtPy,self.userIdQroughtPy];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenQroughtPy,(long)self.accountQroughtPy,self.appNameQroughtPy,self.appOrderIdQroughtPy,channel,clientId,self.extendQroughtPy,extra,(long)self.gatewayQroughtPy,self.productIdQroughtPy,self.productNameQroughtPy,self.userIdQroughtPy];
    }
    sign = [QroughtSdkMd5 md5:sign];
    [[QroughtWebInterface sharedInstance]createOrQroughtder:self.accessTokenQroughtPy userIdQrought:self.userIdQroughtPy productNameQrought:self.productNameQroughtPy productIdQrought:self.productIdQroughtPy accountQrought:self.accountQroughtPy appOrderIdQrought:self.appOrderIdQroughtPy appNameQrought:self.appNameQroughtPy clientIdQrought:clientId gatewayQrought:self.gatewayQroughtPy channelQrought:channel orderTypeQrought:@"iap" extraQrought:extra extendQrought:self.extendQroughtPy signQrought:sign successCallbackQrought:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishQroughtLoading];
                [self QroughtMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failedQroughtPy(-1002);
            }
            else
                [self finishQroughtLoading];
                [self QroughtMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failedQroughtPy(-1002);
        }
        else {
            self.sjOrderIdQroughtPy = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderIdQroughtPy);
        }
        
    } failCallbackQrought:^(NSError *error) {
        [self finishQroughtLoading];
        [self QroughtMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failedQroughtPy(-1002);
    }];
    

}

-(void)QroughtMessageDespatch:(int)sign
               message:(NSString *)msg
{
    switch (sign) {
        case MSG_ERROR:
            [self showQroughtMsg:msg];
        default:
            break;
    }
}

-(void)showQroughtMsg:(NSString *)msg {
    QroughtProgressHUD * process = [[QroughtProgressHUD alloc] initWithView:self.viewQroughtPy];
    [self.viewQroughtPy addSubview:process];
    [self.viewQroughtPy bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = QroughtProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pyQroughtForAppstroe:(UIView *)viewQrought
                 paramQrought:(NSDictionary *)paramQrought
               successQrought:(Qrought_SUCCESS_Callback)successQrought
                failedQrought:(Qrought_FAILED_Callback)failedQrought{
    
    self.py_successQroughtPy = successQrought;
    self.py_failedQroughtPy = failedQrought;
    self.pyParamQroughtPy = paramQrought;
    self.viewQroughtPy = viewQrought;
    
    
    self.productNameQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_PRODUCT_NAME];
    self.productIdQroughtPy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_PRODUCT_ID]];
    self.accountQroughtPy = [[self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_ACCOUNT] integerValue];
    self.appNameQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_APP_NAME];
    self.userIdQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_USER_ID];
    self.accessTokenQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_ACCESSTOKEN];
    self.appOrderIdQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_APP_ORDER_ID];
    self.gatewayQroughtPy = [[self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_GATEWAY] integerValue];
    self.extendQroughtPy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_EXTEND_INFO]];
    self.role_idQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_ROLE_ID];
    self.role_levelQroughtPy = [self.pyParamQroughtPy objectForKey:Qrought_PROTOCOL_ROLE_LEVEL];

    
    [self startQroughtLoading];
    
    
    
    
    [self createQroughtOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.accountQroughtPy] callBack:^(NSString *orderId) {

        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"id = %@", self.productIdQroughtPy);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productIdQroughtPy]];
        productRequest.delegate = self;
        [productRequest start];
    }];
    

    
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *skProduct = response.products;
    NSLog(@"skProduct.count = %d", (int)skProduct.count);
    if((int)skProduct.count == 0){
        
        [self finishQroughtLoading];
        [self QroughtMessageDespatch:MSG_ERROR message:@"商品内购id有误"];
        self.py_failedQroughtPy(-1000);
        
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
        [self finishQroughtLoading];
        [self QroughtMessageDespatch:MSG_ERROR message:@"失败,用户禁止计费购买"];
        self.py_failedQroughtPy(-1001);
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
                
                [self completeQroughtTransaction: transaction];
                
                break;
            case SKPaymentTransactionStateFailed:
                [self failedQroughtTransaction: transaction];
                NSLog(@"self.py_failedQroughtPy(-1004);");
                [[QroughtSdkImp sharedInstance] showQroughtToast:@"已取消"];
                [self finishQroughtLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreQroughtTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingQrought:@"正在请求..."];
                break;
            default:
                self.py_failedQroughtPy(-1005);
                [[QroughtSdkImp sharedInstance] showQroughtToast:@"-1005"];
                break;
        }
    }
}


//成功
- (void) completeQroughtTransaction: (SKPaymentTransaction *)transaction
{
    
    [self sendPQroughtyInfoToServer:transaction];    //将完成后的信息移出队列
    [[SKPaymentQueue defaultQueue]finishTransaction: transaction];
}

//恢复完成
- (void) restoreQroughtTransaction: (SKPaymentTransaction *)transaction
{
    //NSString* str = [[transaction transactionReceipt] base64EncodedStringWithOptions:0];
    [self sendPQroughtyInfoToServer:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//失败
- (void)failedQroughtTransaction: (SKPaymentTransaction *)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

- (void) sendPQroughtyInfoToServer :(SKPaymentTransaction *)transaction
{
    NSData *receipt = transaction.transactionReceipt;
    
    
    //苹果返回的结果无法直接转化成合作方需求的数据格式，只能自己拼装，以下是拼装过程
    NSString * nsData = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    Qrought_VSD_BLOCK checkResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.py_failedQroughtPy(-1007);
                [self finishQroughtLoading];
                [[QroughtSdkImp sharedInstance]showQroughtToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_successQroughtPy(@"success");
                [self finishQroughtLoading];
                [self QroughtMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failedQroughtPy(-1008);
                [self finishQroughtLoading];
                [self QroughtMessageDespatch:MSG_ERROR message:@"失败"];
            }
            
        }@catch(NSException * e)
        {
            [self finishQroughtLoading];
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    
    [self changeloadingQrought:@"正在验证..."];
    [[QroughtWebInterface sharedInstance] QroughtSdkQroughtCheck:self.sjOrderIdQroughtPy descriptionQrought:[QroughtSecurityUtil encodeBase64String:nsData] successCallbackQrought:checkResult failCallbackQrought:^(NSError *error) {
        [self finishQroughtLoading];
        [self QroughtMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failedQroughtPy(-1006);
    }];
}


@end
