//
//  XZRequestModelcdcn.h
//  XZLoginDemo
//
//  Created by科么 on 16/11/23.
//  Copyright © 2016年 Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZRequestModelcdcn : NSObject
/** 游戏名 */
@property (nonatomic,strong)NSString *XZgameName;
/** 游戏方如有需要传入的参数请传入这个 */
@property (nonatomic,strong)NSString *XZattach;
/** 角色名 */
@property (nonatomic,strong)NSString *XZroleName;

/** 订单号 */
@property (nonatomic,strong)NSString *XZorderOn;

/** 商品描述 */
@property (nonatomic,strong)NSString *XZbody;

/** 等级 */
@property(nonatomic, strong)NSString *XZRoleLevel;

/** 价格 */
@property (nonatomic,strong)NSString *XZamount;

/** 商品数量 */
@property (nonatomic,strong)NSString *XZgoodsNum;

/** 服务器id */
@property (nonatomic,strong)NSString *XZserverID;

/** 苹果内购的商品id */
@property (nonatomic,strong)NSString *XZproductID;

/** 详情见文档 */
@property(nonatomic, strong)NSString *XZUrl;
@end
