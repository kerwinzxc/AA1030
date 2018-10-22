//
//  BBBGameManager.h
//  GameSDK
//
//  Created by Tommy on 2018/6/7.
//  Copyright © 2018年 p0sixB1ackcat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBBloginViewTwo.h"

typedef void(^QuitBlock)(NSString *message);

typedef void(^quitBlock)(NSString *msg);

typedef void(^payResult)(NSInteger code , NSString *msg);

@interface BBBGameManager : NSObject


+(instancetype)shareManager;

//初始化
-(void)txy_initGameKey:(NSString *)key;

//支付
/**
 *  0 支付失败
 *  1 支付成功
 *  2 用户取消
 *  3 结果不明
 */
-(void)txy_payWithGoodsName:(NSString *)name Price:(NSString *)price game_trade_no:(NSString *)num producetID:(NSString *)ID  payresult:(payResult)result;

//登录
-(void)txy_loginViewShowAndBlock:(loginBlock)Block;

-(void)txy_sideBarShow;

////退出账号
-(void)txy_quitUserAccount:(QuitBlock)block;

@end
