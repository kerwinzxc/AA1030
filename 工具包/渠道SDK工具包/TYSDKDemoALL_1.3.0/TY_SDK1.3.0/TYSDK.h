//
//  TYSDK.h
//  TYSDK
//
//  Created by three on 2018/5/11.
//  Copyright © 2018年 three. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TYReceiveDataModel.h"



/** 登陆通知
 *  登陆成功返回用户数据，失败data返回为空
 *
 *  notification.userinfo = @{ }
 */
extern NSString * const TYAppDidloginNotification;
/** 支付结果通知
 *  notification.userinfo = {   @"TYResult" : @(1) || @(-1) || @(0)    }
 
 *  Succeed = 1,  -->   购买成功
 
 *  Failed = -1,  -->   购买失败
 
 *  Cancel = 0,   -->   用户中途取消
 
 */
extern NSString * const TYAppDidPaymentNotification;

@interface TYSDK : NSObject


//appkey
@property (nonatomic,strong)NSString *appkey;
//Cid
@property (nonatomic,strong)NSString *Cid;

//单例方法
+(instancetype)sharedSDK;

//初始化并传入AppKey
-(void)TYSDKinitAndAppKey:(NSString*)appkey;

//传入有效界面 拉起登陆界面
-(void)TYaddController:(UIViewController*)VC;
//传入Model拉起内购支付
- (void)TYJoinUpIapPassModel:(TYReceiveDataModel*)mode addController:(UIViewController*)VC;

//传入Model拉起统计
- (void)TYJoinUpStatisticsModel:(TYReceiveStatisticsDataModel*)mode;




// i 这个属性是 SDK内用到的属性 接入时请无视  
@property (nonatomic,assign)int i;




@end

