//
//  ViewController.m
//  YYJH-TYSDKDemo
//
//  Created by liangzhuang on 2018/5/18.
//  Copyright © 2018年 yyjh. All rights reserved.
//

#import "ViewController.h"
#import "TYSDK.h"
#import "TYReceiveDataModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //6337a4a4caf1b6651859288ef4e212bd //三方支付
    //y679f34259d6706a9afb0cad30f161a92 //内购
    
    [[TYSDK sharedSDK] TYSDKinitAndAppKey:@"6337a4a4caf1b6651859288ef4e212bd"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidloggoNotifcation:) name:TYAppDidloginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppDidPaymentNotification:) name:TYAppDidPaymentNotification object:nil];
}

//登录 登出都可以用此方法
- (IBAction)loginAction:(id)sender {
    [[TYSDK sharedSDK] TYaddController:self];
}

//支付
- (IBAction)payAction:(id)sender {
    
    int32_t arc = arc4random()%10000+10000;
    NSString *cporder = [NSString stringWithFormat:@"2017052817365947536314906%d",arc];
    
    NSDictionary *customParamer_dict = @{@"aKey":@"aValue",
                                         @"bKey":@"bValue"};
    NSData *customParamer_data = [NSJSONSerialization dataWithJSONObject:customParamer_dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *customParamer_str = [[NSString alloc] initWithData:customParamer_data encoding:NSUTF8StringEncoding];
    
    
    TYReceiveDataModel *model = [[TYReceiveDataModel alloc] init];
    model.TYServerid = @"9999";
    model.TYRoleid = @"10050184";
    model.TYAmt = @"6";
    model.TYGoodsid = @"com.87eytu.bchd.t1g60";// 这里填内购id
    model.TYPaygold = @"180元宝";
    model.TYCporder = cporder;// cp方订单id
    model.TYCustomParameter = customParamer_str; // 自定义透传参数
    
    [[TYSDK sharedSDK] TYJoinUpIapPassModel:model addController:self];
}

//统计
- (IBAction)tongjiAction:(id)sender {
    
    TYReceiveStatisticsDataModel *mode = [[TYReceiveStatisticsDataModel alloc]init];
    mode.TYMark = @"统计备注";
    mode.TYRoleid = @"123";
    mode.TYZoneid = @"2222";
    mode.TYRolename = @"角色昵称";
    mode.TYZonename = @"服务器名称";
    mode.TYRolelevel = @"2222";
    [[TYSDK sharedSDK]TYJoinUpStatisticsModel:mode];
}

//登录回调消息
- (void)DidloggoNotifcation:(NSNotification*)notification{
    NSLog(@">>>>>>>>>>%@",notification.userInfo);

}


//客户端支付回调消息
- (void)AppDidPaymentNotification:(NSNotification*)notification{
    NSString *resultStr = nil;
    if ([[notification.userInfo valueForKey:@"TYResult"] integerValue] == 0) {
        resultStr = @"支付取消";
    }
    if ([[notification.userInfo valueForKey:@"TYResult"] integerValue] == 1) {
        resultStr = @"支付成功";
    }
    if ([[notification.userInfo valueForKey:@"TYResult"] integerValue] == -1) {
        resultStr = @"支付失败";
    }
    NSLog(@"resultStr = %@",resultStr);
}


@end
