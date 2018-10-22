//
//  GPSDK.h
//  GPSDKDemo
//
//  Created by 29 on 2018/5/22.
//  Copyright © 2018年 29Game. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GPResultInfo)(NSDictionary* data);
typedef void(^GPCompleteBlock)(BOOL success, NSString *info);

NS_ASSUME_NONNULL_BEGIN
@interface GPSDK : NSObject

/**
 调用登录,获取uid
 
 @param finishedBlock 登录回调
 */
+ (void)loginFinished:(nullable GPResultInfo)finishedBlock;

/**
 初始化sdk
 
 @param playId          gameId (29游参数表中gameId)
 @param secret          appkey (29游参数表中秘钥key)
 @param canal           channel渠道号 (29游参数表中渠道ID)
 @param completeBlock   处理回调
 */
+ (void)configWithPlayId:(NSString *)playId
                  secret:(NSString *)secret
                   canal:(NSString *)canal
           completeBlock:(nullable GPCompleteBlock)completeBlock;

/**
 上传玩家信息（必须先初始化完成调用）
 
 @param roleId        角色id
 @param roleName      角色名称
 @param roleLv        角色等级
 @param serverId      区服id
 @param serverName    区服名字
 */
+ (void)uploadRoleInfoWithRoleId:(NSString *)roleId
                        roleName:(NSString *)roleName
                          roleLv:(NSString *)roleLv
                        serverId:(NSString *)serverId
                      serverName:(NSString *)serverName;

/**
 购买商品
 
 @param productId     商品id
 @param roleId        角色id (要与信息上传接口roleId一致)
 @param serverId      服务器id (要与信息上传接口serverId一致)
 @param cpInfo        透传参数，自定义字段，服务器回调时会原样返回，可为空
 @param finishedBlock 结果block，orderId:订单号，productId:产品id，payState:1成功/0失败
 */
+ (void)iapWithProductId:(NSString *)productId
                  roleId:(NSString *)roleId
                serverId:(NSString *)serverId
                  cpInfo:(nullable NSString *)cpInfo
                finished:(nullable GPResultInfo)finishedBlock;

//获取uid,需要先登录
+ (NSString *)uid;

//获取渠道ID
+ (NSString *)canal;

//获取gameKEY
+ (NSString *)playKey;

//获取appId
+ (NSString *)playId;

//获取SDK版本号
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
