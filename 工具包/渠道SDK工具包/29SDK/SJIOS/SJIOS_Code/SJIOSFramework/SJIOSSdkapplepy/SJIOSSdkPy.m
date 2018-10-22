

#import <Foundation/Foundation.h>
#import "SJIOSSdkPy.h"
#import "SJIOSSdk.h"
#import "SJIOSRPC.h"
#import "SJIOSSdkImp.h"
#import "SJIOSCommonApi.h"



@implementation SJIOSSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startSJIOSLoading
{
    if (self.myAlert==nil){
        self.myAlert = [[UIAlertView alloc] initWithTitle:nil
                                             message: @"正在连接..."
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 38.0f, 38.0f);
        [self.myAlert addSubview:activityView];
        [activityView startAnimating];
        [self.myAlert show];
    }
}

- (void)changeloadingSJIOS:(NSString*)msg
{
    if (self.myAlert) {
        [self.myAlert setMessage:msg];
    }
}

- (void)finishSJIOSLoading
{
    [self.myAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlert = nil;
}


-(void)createSJIOSOrderWithExtra:(NSString *)extra
                   callBack:(SJIOS_ORDER_BLOCK)callback {
    NSString *clientId = [[SJIOSSdkImp sharedInstance]appKey];
    NSString *privateKey = [[SJIOSSdkImp sharedInstance]appPrivateKey];
    NSString *channel = [[SJIOSSdkImp sharedInstance]channel];
    NSString *sign ;
    
    if ([self.extend isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessToken,(long)self.account,self.appName,self.appOrderId,channel,clientId,extra,(long)self.gateway,self.productId,self.productName,self.userId];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessToken,(long)self.account,self.appName,self.appOrderId,channel,clientId,self.extend,extra,(long)self.gateway,self.productId,self.productName,self.userId];
    }
    sign = [SJIOSSdkMd5 md5:sign];
    [[SJIOSCommonApi sharedInstance]createOrSJIOSder:self.accessToken userId:self.userId productName:self.productName productId:self.productId account:self.account appOrderId:self.appOrderId appName:self.appName clientId:clientId gateway:self.gateway channel:channel orderType:@"iap" extra:extra extend:self.extend sign:sign completionBlock:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failed(-1002);
            }
            else
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failed(-1002);
        }
        else {
            self.sjOrderId = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderId);
        }
        
    } failedBlock:^(NSError *error) {
        [self finishSJIOSLoading];
        [self SJIOSMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failed(-1002);
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
    SJIOSProgressHUD * process = [[SJIOSProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:process];
    [self.view bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = SJIOSProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } completionBlock:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pySJIOSForAppstroe:(UIView *)view
                 param:(NSDictionary *)param
               success:(SJIOS_SUCCESS_Callback)success
                failed:(SJIOS_FAILED_Callback)failed{
    
    self.py_success = success;
    self.py_failed = failed;
    self.pyParam = param;
    self.view = view;
    
    
    self.productName = [self.pyParam objectForKey:SJIOS_PROTOCOL_PRODUCT_NAME];
    self.productId = [[NSString alloc] initWithFormat:@"%@", [self.pyParam objectForKey:SJIOS_PROTOCOL_PRODUCT_ID]];
    self.account = [[self.pyParam objectForKey:SJIOS_PROTOCOL_ACCOUNT] integerValue];
    self.appName = [self.pyParam objectForKey:SJIOS_PROTOCOL_APP_NAME];
    self.userId = [self.pyParam objectForKey:SJIOS_PROTOCOL_USER_ID];
    self.accessToken = [self.pyParam objectForKey:SJIOS_PROTOCOL_ACCESSTOKEN];
    self.appOrderId = [self.pyParam objectForKey:SJIOS_PROTOCOL_APP_ORDER_ID];
    self.gateway = [[self.pyParam objectForKey:SJIOS_PROTOCOL_GATEWAY] integerValue];
    self.extend = [[NSString alloc] initWithFormat:@"%@", [self.pyParam objectForKey:SJIOS_PROTOCOL_EXTEND_INFO]];
    self.role_id = [self.pyParam objectForKey:SJIOS_PROTOCOL_ROLE_ID];
    self.role_level = [self.pyParam objectForKey:SJIOS_PROTOCOL_ROLE_LEVEL];

    
    [self startSJIOSLoading];
    
    
    
    
    [self createSJIOSOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.account] callBack:^(NSString *orderId) {
        
        
        [TrackingIO setryzfStart:self.sjOrderId ryzfType:@"iap" currentType:@"CNY" currencyAmount:self.account];
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"id = %@", self.productId);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productId]];
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
        self.py_failed(-1000);
        
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
        self.py_failed(-1001);
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
                self.py_failed(-1004);
                [[SJIOSSdkImp sharedInstance] showSJIOSToast:@"-1004"];
                [self finishSJIOSLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreSJIOSTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingSJIOS:@"正在请求..."];
                break;
            default:
                self.py_failed(-1005);
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
                self.py_failed(-1007);
                [self finishSJIOSLoading];
                [[SJIOSSdkImp sharedInstance]showSJIOSToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_success(@"success");
                [self finishSJIOSLoading];
                [self SJIOSMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failed(-1008);
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
    [[SJIOSCommonApi sharedInstance] SJIOSSdkPyCheck:self.sjOrderId description:[SJIOSSecurityUtil encodeBase64String:nsData] completionBlock:checkResult failedBlock:^(NSError *error) {
        [self finishSJIOSLoading];
        [self SJIOSMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failed(-1006);
    }];
}


@end
