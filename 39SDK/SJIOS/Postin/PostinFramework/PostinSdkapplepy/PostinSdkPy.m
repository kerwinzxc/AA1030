

#import <Foundation/Foundation.h>
#import "PostinSdkPy.h"
#import "PostinSdk.h"
#import "PostinWebApi.h"
#import "PostinSdkImp.h"
#import "PostinWebInterface.h"



@implementation PostinSdkPy

static int const MSG_ERROR = 1;

//加载网页动画
- (void)startPostinLoading
{
    if (self.myAlertPostinPy==nil){
        self.myAlertPostinPy = [[UIAlertView alloc] initWithTitle:nil
                                             message: @"正在连接..."
                                            delegate: self
                                   cancelButtonTitle: nil
                                   otherButtonTitles: nil];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(120.f, 48.0f, 38.0f, 38.0f);
        [self.myAlertPostinPy addSubview:activityView];
        [activityView startAnimating];
        [self.myAlertPostinPy show];
    }
}

- (void)changeloadingPostin:(NSString*)msg
{
    if (self.myAlertPostinPy) {
        [self.myAlertPostinPy setMessage:msg];
    }
}

- (void)finishPostinLoading
{
    [self.myAlertPostinPy dismissWithClickedButtonIndex:0 animated:YES];
    self.myAlertPostinPy = nil;
}


-(void)createPostinOrderWithExtra:(NSString *)extra
                   callBack:(Postin_ODER_BLOCK)callback {
    NSString *clientId = [[PostinSdkImp sharedInstance]getPostinAppKey];
    NSString *privateKey = [[PostinSdkImp sharedInstance]getPostinAppPrivateKey];
    NSString *channel = [[PostinSdkImp sharedInstance] getPostinChannel];
    NSString *sign ;
    
    if ([self.extendPostinPy isEqualToString:@""]) {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenPostinPy,(long)self.accountPostinPy,self.appNamePostinPy,self.appOrderIdPostinPy,channel,clientId,extra,(long)self.gatewayPostinPy,self.productIdPostinPy,self.productNamePostinPy,self.userIdPostinPy];
    }
    else {
        sign = [NSString stringWithFormat:@"%@access_token%@account%ldapp_name%@app_order_id%@channel%@client_id%@extend%@extra%@gateway%ldorder_typeiapproduct_id%@product_name%@user_id%@",privateKey,self.accessTokenPostinPy,(long)self.accountPostinPy,self.appNamePostinPy,self.appOrderIdPostinPy,channel,clientId,self.extendPostinPy,extra,(long)self.gatewayPostinPy,self.productIdPostinPy,self.productNamePostinPy,self.userIdPostinPy];
    }
    sign = [PostinSdkMd5 md5:sign];
    [[PostinWebInterface sharedInstance]createOrPostinder:self.accessTokenPostinPy userIdPostin:self.userIdPostinPy productNamePostin:self.productNamePostinPy productIdPostin:self.productIdPostinPy accountPostin:self.accountPostinPy appOrderIdPostin:self.appOrderIdPostinPy appNamePostin:self.appNamePostinPy clientIdPostin:clientId gatewayPostin:self.gatewayPostinPy channelPostin:channel orderTypePostin:@"iap" extraPostin:extra extendPostin:self.extendPostinPy signPostin:sign successCallbackPostin:^(NSDictionary *dictionary, NSDictionary *header) {

        
        
        if ([dictionary objectForKey:@"error"]!=nil) {
            if ([[dictionary objectForKey:@"error"] isEqualToString:@"duplicate_order"]) {
                [self finishPostinLoading];
                [self PostinMessageDespatch:MSG_ERROR message:@"订单重复，请重新下单"];
                self.py_failedPostinPy(-1002);
            }
            else
                [self finishPostinLoading];
                [self PostinMessageDespatch:MSG_ERROR message:@"网络不稳定，下单失败，请稍后重试"];
                self.py_failedPostinPy(-1002);
        }
        else {
            self.sjOrderIdPostinPy = [[NSString alloc] initWithString:[dictionary objectForKey:@"order_id"]];
            callback(self.sjOrderIdPostinPy);
        }
        
    } failCallbackPostin:^(NSError *error) {
        [self finishPostinLoading];
        [self PostinMessageDespatch:MSG_ERROR message:@"网络不稳定，请稍后重试"];
        self.py_failedPostinPy(-1002);
    }];
    

}

-(void)PostinMessageDespatch:(int)sign
               message:(NSString *)msg
{
    switch (sign) {
        case MSG_ERROR:
            [self showPostinMsg:msg];
        default:
            break;
    }
}

-(void)showPostinMsg:(NSString *)msg {
    PostinProgressHUD * process = [[PostinProgressHUD alloc] initWithView:self.viewPostinPy];
    [self.viewPostinPy addSubview:process];
    [self.viewPostinPy bringSubviewToFront:process];
    process.labelText = msg;
    process.mode = PostinProgressHUDModeCustomView;
    process.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
    [process showAnimated:YES whileExecutingBlock:^{
        [NSThread sleepForTimeInterval:1];
    } successCallback:^{
        [process removeFromSuperview];
    }];
    
}

- (void)pyPostinForAppstroe:(UIView *)viewPostin
                 paramPostin:(NSDictionary *)paramPostin
               successPostin:(Postin_SUCCESS_Callback)successPostin
                failedPostin:(Postin_FAILED_Callback)failedPostin{
    
    self.py_successPostinPy = successPostin;
    self.py_failedPostinPy = failedPostin;
    self.pyParamPostinPy = paramPostin;
    self.viewPostinPy = viewPostin;
    
    
    self.productNamePostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_PRODUCT_NAME];
    self.productIdPostinPy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_PRODUCT_ID]];
    self.accountPostinPy = [[self.pyParamPostinPy objectForKey:Postin_PROTOCOL_ACCOUNT] integerValue];
    self.appNamePostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_APP_NAME];
    self.userIdPostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_USER_ID];
    self.accessTokenPostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_ACCESSTOKEN];
    self.appOrderIdPostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_APP_ORDER_ID];
    self.gatewayPostinPy = [[self.pyParamPostinPy objectForKey:Postin_PROTOCOL_GATEWAY] integerValue];
    self.extendPostinPy = [[NSString alloc] initWithFormat:@"%@", [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_EXTEND_INFO]];
    self.role_idPostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_ROLE_ID];
    self.role_levelPostinPy = [self.pyParamPostinPy objectForKey:Postin_PROTOCOL_ROLE_LEVEL];

    
    [self startPostinLoading];
    
    
    
    
    [self createPostinOrderWithExtra:[NSString stringWithFormat:@"iap:%ld",(long)self.accountPostinPy] callBack:^(NSString *orderId) {

        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        NSLog(@"id = %@", self.productIdPostinPy);
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productIdPostinPy]];
        productRequest.delegate = self;
        [productRequest start];
    }];
    

    
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *skProduct = response.products;
    NSLog(@"skProduct.count = %d", (int)skProduct.count);
    if((int)skProduct.count == 0){
        
        [self finishPostinLoading];
        [self PostinMessageDespatch:MSG_ERROR message:@"商品内购id有误"];
        self.py_failedPostinPy(-1000);
        
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
        [self finishPostinLoading];
        [self PostinMessageDespatch:MSG_ERROR message:@"失败,用户禁止计费购买"];
        self.py_failedPostinPy(-1001);
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
                
                [self completePostinTransaction: transaction];
                
                break;
            case SKPaymentTransactionStateFailed:
                [self failedPostinTransaction: transaction];
                NSLog(@"self.py_failedPostinPy(-1004);");
                [[PostinSdkImp sharedInstance] showPostinToast:@"已取消"];
                [self finishPostinLoading];
                break;
            case SKPaymentTransactionStateRestored:
                [self restorePostinTransaction: transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                [self changeloadingPostin:@"正在请求..."];
                break;
            default:
                self.py_failedPostinPy(-1005);
                [[PostinSdkImp sharedInstance] showPostinToast:@"-1005"];
                break;
        }
    }
}


//成功
- (void) completePostinTransaction: (SKPaymentTransaction *)transaction
{
    
    [self sendPPostinyInfoToServer:transaction];    //将完成后的信息移出队列
    [[SKPaymentQueue defaultQueue]finishTransaction: transaction];
}

//恢复完成
- (void) restorePostinTransaction: (SKPaymentTransaction *)transaction
{
    //NSString* str = [[transaction transactionReceipt] base64EncodedStringWithOptions:0];
    [self sendPPostinyInfoToServer:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//失败
- (void)failedPostinTransaction: (SKPaymentTransaction *)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
}

- (void) sendPPostinyInfoToServer :(SKPaymentTransaction *)transaction
{
    NSData *receipt = transaction.transactionReceipt;
    
    
    //苹果返回的结果无法直接转化成合作方需求的数据格式，只能自己拼装，以下是拼装过程
    NSString * nsData = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    Postin_VSD_BLOCK checkResult = ^(NSDictionary *dictionary, NSDictionary *headers){
        @try{

            if (dictionary == nil)
            {
                self.py_failedPostinPy(-1007);
                [self finishPostinLoading];
                [[PostinSdkImp sharedInstance]showPostinToast:@"验证有误"];
                return;
            }
            NSLog(@"checkResult = %@", dictionary);
            if([[dictionary objectForKey:@"result"] isEqualToString:@"success"]){
                
                
                self.py_successPostinPy(@"success");
                [self finishPostinLoading];
                [self PostinMessageDespatch:MSG_ERROR message:@"成功"];
                
            }else{
                
                self.py_failedPostinPy(-1008);
                [self finishPostinLoading];
                [self PostinMessageDespatch:MSG_ERROR message:@"失败"];
            }
            
        }@catch(NSException * e)
        {
            [self finishPostinLoading];
        }
        @finally
        {
            //  self.logining = false;
        }
    };
    
    [self changeloadingPostin:@"正在验证..."];
    [[PostinWebInterface sharedInstance] PostinSdkPostinCheck:self.sjOrderIdPostinPy descriptionPostin:[PostinSecurityUtil encodeBase64String:nsData] successCallbackPostin:checkResult failCallbackPostin:^(NSError *error) {
        [self finishPostinLoading];
        [self PostinMessageDespatch:MSG_ERROR message:@"验证失败"];
        self.py_failedPostinPy(-1006);
    }];
}


@end
