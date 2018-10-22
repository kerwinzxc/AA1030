//
//  ReceiveDataModel.h
//  TYSDK
//
//  Created by three on 2018/5/17.
//  Copyright © 2018年 three. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYReceiveDataModel : NSObject
/*
 @param serverid 游戏区服
 @param roleid 游戏角色id
 @param amt 充值实收金额
 @param goodsid 商品id
 @param paygold 游戏币
 @param cporder cp方订单号  长度64位以内
 @param customParameter 自定义参数(可透传，默认@"") 不建议使用特殊字符
 */
@property (nonatomic, copy) NSString *TYServerid;            
@property (nonatomic, copy) NSString *TYRoleid;
@property (nonatomic, copy) NSString *TYAmt;
@property (nonatomic, copy) NSString *TYGoodsid;
@property (nonatomic, assign) NSInteger TYPaygold;
@property (nonatomic, copy) NSString *TYCporder;
@property (nonatomic, copy) NSString *TYCustomParameter;

@end
@interface TYReceiveStatisticsDataModel : NSObject
/*
 mark 统计备注
 @param roleid 角色id
 @param rolename 角色昵称
 @param rolelevel 角色等级
 @param zoneid 区服id
 @param zonename 区服名称
 */
@property (nonatomic, copy) NSString *TYMark;
@property (nonatomic, copy) NSString *TYRoleid;
@property (nonatomic, copy) NSString *TYRolename;
@property (nonatomic, copy) NSString *TYRolelevel;
@property (nonatomic, copy) NSString *TYZoneid;
@property (nonatomic, copy) NSString *TYZonename;
@end
