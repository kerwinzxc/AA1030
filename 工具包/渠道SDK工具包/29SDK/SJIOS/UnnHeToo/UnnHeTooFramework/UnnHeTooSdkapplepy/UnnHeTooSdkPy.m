

#import <Foundation/Foundation.h>
#import "UnnHeTooSdkPy.h"
#import "UnnHeTooSdk.h"
#import "UnnHeTooRPC.h"
#import "UnnHeTooSdkImp.h"
#import "UnnHeTooCommonApi.h"



@implementation UnnHeTooSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startUnnHeTooLoading
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

- (void)changeloadingUnnHeToo:(NSString*)msg
{
    if (self.myAlert) {
        [self.myAlert setMessage:msg];
    }
}

- (void)finishUnnHeTooLoading
{
    [self.myAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlert = nil;
}


-(void)createUnnHeTooOrderWithExtra:(NSString *)extra
                   callBack:(UnnHeToo_ORDER_BLOCK)callback {
    NSString *clientId = [[UnnHeTooSdkImp sharedInstance]appKey];
    NSString *privateKey = [[UnnHeTooSdkImp sharedInstance]appPrivateKey];
    NSString *channel = [[UnnHeTooSdkImp sharedInstance]channel];
    NSString *sign ;
    
    if ([self.extend isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessToken,(long)self.account,self.appName,self.appOrderId,channel,clientId,extra,(long)self.gateway,self.productId,self.productName,self.userId];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessToken,(long)self.account,self.appName,self.appOrderId,channel,clientId,self.extend,extra,(long)self.gateway,self.productId,self.productName,self.userId];
    }
    sign = [UnnHeTooSdkMd5 md5:sign];
    [[UnnHeTooCommonApi sharedInstance]createOrUnnHeTooder:self.accessToken userId:self.userId productName:self.productName productId:self.productId account:self.account appOrderId:self.appOrderId appName:self.appName clientId:clientId gateway:self.gateway channel:channel orderType:@"iap" extra:extra extend:self.extend sign:sign completionBlock:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishUnnHeTooLoading];
                [self UnnHeTooMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failed(-1002);
            }
            else
                [self finishUnnHeTooLoading];
                [self UnnHeTooMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failed(-1002);
        }
        else {
            self.sjOrderId = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderId);
        }
        
    } failedBlock:^(NSError *error) {
        [self finishUnnHeTooLoading];
        [self UnnHeTooMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failed(-1002);
    }];
    

}

-(void)UnnHeTooMessageDespatch:(int)sign
               message:(NSString *)msg
{
    switch (sign) {
        case MSG_ERROR:
            [self showUnnHeTooMsg:msg];
        default:
            break;
    }
}

-(void)showUnnHeTooMsg:(NSString *)msg {
    UnnHeTooProgressHUD * process = [[UnnHeTooProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:process];
    [self.view bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = UnnHeTooProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } completionBlock:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pyUnnHeTooForAppstroe:(UIView *)view
                 param:(NSDictionary *)param
               success:(UnnHeToo_SUCCESS_Callback)success
                failed:(UnnHeToo_FAILED_Callback)failed{
    
    self.py_success = success;
    self.py_failed = failed;
    self.pyParam = param;
    self.view = view;
    
    
    self.productName = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_PRODUCT_NAME];
    self.productId = [[NSString alloc] initWithFormat:@"%@", [self.pyParam objectForKey:UnnHeToo_PROTOCOL_PRODUCT_ID]];
    self.account = [[self.pyParam objectForKey:UnnHeToo_PROTOCOL_ACCOUNT] integerValue];
    self.appName = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_APP_NAME];
    self.userId = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_USER_ID];
    self.accessToken = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_ACCESSTOKEN];
    self.appOrderId = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_APP_ORDER_ID];
    self.gateway = [[self.pyParam objectForKey:UnnHeToo_PROTOCOL_GATEWAY] integerValue];
    self.extend = [[NSString alloc] initWithFormat:@"%@", [self.pyParam objectForKey:UnnHeToo_PROTOCOL_EXTEND_INFO]];
    self.role_id = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_ROLE_ID];
    self.role_level = [self.pyParam objectForKey:UnnHeToo_PROTOCOL_ROLE_LEVEL];

    
    [self startUnnHeTooLoading];
    
    
    
    
    [self createUnnHeTooOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.account] callBack:^(NSString *orderId) {
        
    
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
        
        [self finishUnnHeTooLoading];
        [self UnnHeTooMessageDespatch:MSG_ERROR message:@"商品内购id有误"];
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
        [self finishUnnHeTooLoading];
        [self UnnHeTooMessageDespatch:MSG_ERROR message:@"失败,用户禁止计费购买"];
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
                
                [self completeUnnHeTooTransaction: transaction];
                
                break;
            case SKPaymentTransactionStateFailed:
                [self failedUnnHeTooTransaction: transaction];
                self.py_failed(-1004);
                [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"-1004"];
                [self finishUnnHeTooLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreUnnHeTooTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingUnnHeToo:@"正在请求..."];
                break;
            default:
                self.py_failed(-1005);
                [[UnnHeTooSdkImp sharedInstance] showUnnHeTooToast:@"-1005"];
                break;
        }
    }
}


//成功
- (void) completeUnnHeTooTransaction: (SKPaymentTransaction *)transaction
{
    
    [self sendPUnnHeTooyInfoToServer:transaction];    //将完成后的信息移出队列
    [[SKPaymentQueue defaultQueue]finishTransaction: transaction];
}

//恢复完成
- (void) restoreUnnHeTooTransaction: (SKPaymentTransaction *)transaction
{
    //NSString* str = [[transaction transactionReceipt] base64EncodedStringWithOptions:0];
    [self sendPUnnHeTooyInfoToServer:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//失败
- (void)failedUnnHeTooTransaction: (SKPaymentTransaction *)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

- (void) sendPUnnHeTooyInfoToServer :(SKPaymentTransaction *)transaction
{
    NSData *receipt = transaction.transactionReceipt;
    
    
    //苹果返回的结果无法直接转化成合作方需求的数据格式，只能自己拼装，以下是拼装过程
    NSString * nsData = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];


    
    UnnHeToo_VSD_BLOCK checkResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.py_failed(-1007);
                [self finishUnnHeTooLoading];
                [[UnnHeTooSdkImp sharedInstance]showUnnHeTooToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_success(@"success");
                [self finishUnnHeTooLoading];
                [self UnnHeTooMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failed(-1008);
                [self finishUnnHeTooLoading];
                [self UnnHeTooMessageDespatch:MSG_ERROR message:@"失败"];
            }
            
        }@catch(NSException * e)
        {
            [self finishUnnHeTooLoading];
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    
    [self changeloadingUnnHeToo:@"正在验证..."];
    [[UnnHeTooCommonApi sharedInstance] UnnHeTooSdkPyCheck:self.sjOrderId description:[UnnHeTooSecurityUtil encodeBase64String:nsData] completionBlock:checkResult failedBlock:^(NSError *error) {
        [self finishUnnHeTooLoading];
        [self UnnHeTooMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failed(-1006);
    }];
}


@end
