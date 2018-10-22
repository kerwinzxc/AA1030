

#import <Foundation/Foundation.h>
#import "SJIOSSdkPy.h"
#import "SJIOSSdk.h"
#import "SJIOSWebApi.h"
#import "SJIOSSdkImp.h"
#import "SJIOSWebInterface.h"



@implementation SJIOSSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startSJIOSLoading
{
    if (self.myAlertSJIOSPy==nil){
        self.myAlertSJIOSPy = [[UIAlertView alloc] initWithTitle:nil
                                             message: @"正在连接..."
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 38.0f, 38.0f);
        [self.myAlertSJIOSPy addSubview:activityView];
        [activityView startAnimating];
        [self.myAlertSJIOSPy show];
    }
}

- (void)changeloadingSJIOS:(NSString*)msg
{
    if (self.myAlertSJIOSPy) {
        [self.myAlertSJIOSPy setMessage:msg];
    }
}

- (void)finishSJIOSLoading
{
    [self.myAlertSJIOSPy dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlertSJIOSPy = nil;
}


-(void)createSJIOSOrderWithExtra:(NSString *)extra
                   callBack:(SJIOS_ODER_BLOCK)callback {
    NSString *clientId = [[SJIOSSdkImp sharedInstance]getSJIOSAppKey];
    NSString *privateKey = [[SJIOSSdkImp sharedInstance]getSJIOSAppPrivateKey];
    NSString *channel = [[SJIOSSdkImp sharedInstance] getSJIOSChannel];
    NSString *sign ;
    
    if ([self.extendSJIOSPy isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenSJIOSPy,(long)self.accountSJIOSPy,self.appNameSJIOSPy,self.appOrderIdSJIOSPy,channel,clientId,extra,(long)self.gatewaySJIOSPy,self.productIdSJIOSPy,self.productNameSJIOSPy,self.userIdSJIOSPy];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenSJIOSPy,(long)self.accountSJIOSPy,self.appNameSJIOSPy,self.appOrderIdSJIOSPy,channel,clientId,self.extendSJIOSPy,extra,(long)self.gatewaySJIOSPy,self.productIdSJIOSPy,self.productNameSJIOSPy,self.userIdSJIOSPy];
    }
    sign = [SJIOSSdkMd5 md5:sign];
    [[SJIOSWebInterface sharedInstance]createOrSJIOSder:self.accessTokenSJIOSPy userIdSJIOS:self.userIdSJIOSPy productNameSJIOS:self.productNameSJIOSPy productIdSJIOS:self.productIdSJIOSPy accountSJIOS:self.accountSJIOSPy appOrderIdSJIOS:self.appOrderIdSJIOSPy appNameSJIOS:self.appNameSJIOSPy clientIdSJIOS:clientId gatewaySJIOS:self.gatewaySJIOSPy channelSJIOS:channel orderTypeSJIOS:@"iap" extraSJIOS:extra extendSJIOS:self.extendSJIOSPy signSJIOS:sign successCallbackSJIOS:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failedSJIOSPy(-1002);
            }
            else
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failedSJIOSPy(-1002);
        }
        else {
            self.sjOrderIdSJIOSPy = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderIdSJIOSPy);
        }
        
    } failCallbackSJIOS:^(NSError *error) {
        [self finishSJIOSLoading];
        [self SJIOSMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failedSJIOSPy(-1002);
    }];
    

}

-(void)SJIOSMessageDespatch:(int)sign
               message:(NSString *)msg
{
    switch (sign) {
        case MSG_ERROR:
            [self showSJIOSMsg:msg];
        default:
            break;
    }
}

-(void)showSJIOSMsg:(NSString *)msg {
    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.viewSJIOSPy];
    [self.viewSJIOSPy addSubview:process];
    [self.viewSJIOSPy bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = SJIOSProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pySJIOSForAppstroe:(UIView *)viewSJIOS
                 paramSJIOS:(NSDictionary *)paramSJIOS
               successSJIOS:(SJIOS_SUCCESS_Callback)successSJIOS
                failedSJIOS:(SJIOS_FAILED_Callback)failedSJIOS{
    
    self.py_successSJIOSPy = successSJIOS;
    self.py_failedSJIOSPy = failedSJIOS;
    self.pyParamSJIOSPy = paramSJIOS;
    self.viewSJIOSPy = viewSJIOS;
    
    
    self.productNameSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_PRODUCT_NAME];
    self.productIdSJIOSPy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_PRODUCT_ID]];
    self.accountSJIOSPy = [[self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_ACCOUNT] integerValue];
    self.appNameSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_APP_NAME];
    self.userIdSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_USER_ID];
    self.accessTokenSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_ACCESSTOKEN];
    self.appOrderIdSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_APP_ORDER_ID];
    self.gatewaySJIOSPy = [[self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_GATEWAY] integerValue];
    self.extendSJIOSPy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_EXTEND_INFO]];
    self.role_idSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_ROLE_ID];
    self.role_levelSJIOSPy = [self.pyParamSJIOSPy objectForKey:SJIOS_PROTOCOL_ROLE_LEVEL];

    
    [self startSJIOSLoading];
    
    
    
    
    [self createSJIOSOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.accountSJIOSPy] callBack:^(NSString *orderId) {

        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"id = %@", self.productIdSJIOSPy);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productIdSJIOSPy]];
        productRequest.delegate = self;
        [productRequest start];
    }];
    

    
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *skProduct = response.products;
    NSLog(@"skProduct.count = %d", (int)skProduct.count);
    if((int)skProduct.count == 0){
        
        [self finishSJIOSLoading];
        [self SJIOSMessageDespatch:MSG_ERROR message:@"商品内购id有误"];
        self.py_failedSJIOSPy(-1000);
        
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
        [self finishSJIOSLoading];
        [self SJIOSMessageDespatch:MSG_ERROR message:@"失败,用户禁止计费购买"];
        self.py_failedSJIOSPy(-1001);
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
                
                [self completeSJIOSTransaction: transaction];
                
                break;
            case SKPaymentTransactionStateFailed:
                [self failedSJIOSTransaction: transaction];
                NSLog(@"self.py_failedSJIOSPy(-1004);");
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"已取消"];
                [self finishSJIOSLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreSJIOSTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingSJIOS:@"正在请求..."];
                break;
            default:
                self.py_failedSJIOSPy(-1005);
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"-1005"];
                break;
        }
    }
}


//成功
- (void) completeSJIOSTransaction: (SKPaymentTransaction *)transaction
{
    
    [self sendPSJIOSyInfoToServer:transaction];    //将完成后的信息移出队列
    [[SKPaymentQueue defaultQueue]finishTransaction: transaction];
}

//恢复完成
- (void) restoreSJIOSTransaction: (SKPaymentTransaction *)transaction
{
    //NSString* str = [[transaction transactionReceipt] base64EncodedStringWithOptions:0];
    [self sendPSJIOSyInfoToServer:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//失败
- (void)failedSJIOSTransaction: (SKPaymentTransaction *)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

- (void) sendPSJIOSyInfoToServer :(SKPaymentTransaction *)transaction
{
    NSData *receipt = transaction.transactionReceipt;
    
    
    //苹果返回的结果无法直接转化成合作方需求的数据格式，只能自己拼装，以下是拼装过程
    NSString * nsData = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    SJIOS_VSD_BLOCK checkResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.py_failedSJIOSPy(-1007);
                [self finishSJIOSLoading];
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_successSJIOSPy(@"success");
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failedSJIOSPy(-1008);
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"失败"];
            }
            
        }@catch(NSException * e)
        {
            [self finishSJIOSLoading];
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    
    [self changeloadingSJIOS:@"正在验证..."];
    [[SJIOSWebInterface sharedInstance] SJIOSSdkSJIOSCheck:self.sjOrderIdSJIOSPy descriptionSJIOS:[SJIOSSecurityUtil encodeBase64String:nsData] successCallbackSJIOS:checkResult failCallbackSJIOS:^(NSError *error) {
        [self finishSJIOSLoading];
        [self SJIOSMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failedSJIOSPy(-1006);
    }];
}


@end
