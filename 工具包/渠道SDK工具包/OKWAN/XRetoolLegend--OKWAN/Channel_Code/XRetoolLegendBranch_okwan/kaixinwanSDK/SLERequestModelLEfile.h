//
//  SLERequestModelLEfile.h
//  SLEdemo
//
//  Created byshelen on 16/11/23.
//  Copyright © 2016年 gudo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLERequestModelLEfile : NSObject
/** 游戏名 */
@property (nonatomic,strong)NSString *SLEgameName;
/** 游戏方如有需要传入的参数请传入这个 */
@property (nonatomic,strong)NSString *SLEattach;
/** 角色名 */
@property (nonatomic,strong)NSString *SLEroleName;

/** 订单号 */
@property (nonatomic,strong)NSString *SLEorderOn;

/** 商品描述 */
@property (nonatomic,strong)NSString *SLEbody;

/** 等级 */
@property(nonatomic, strong)NSString *SLERoleLevel;

/** 价格 */
@property (nonatomic,strong)NSString *SLEamount;

/** 商品数量 */
@property (nonatomic,strong)NSString *SLEgoodsNum;

/** 服务器id */
@property (nonatomic,strong)NSString *SLEserverID;

/** 苹果内购的商品id */
@property (nonatomic,strong)NSString *SLEproductID;

/** 详情见文档 */
@property(nonatomic, strong)NSString *SLEUrl;
@end
