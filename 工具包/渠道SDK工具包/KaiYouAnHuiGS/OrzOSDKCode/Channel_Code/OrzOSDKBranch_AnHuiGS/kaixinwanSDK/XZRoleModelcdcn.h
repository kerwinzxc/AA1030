//
//  XZRoleModelcdcn.h
//  XZLoginDemo
//
//  Created by科么 on 16/11/24.
//  Copyright © 2016年 Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZRoleModelcdcn : NSObject
/** 角色名字 */
@property (nonatomic,strong)NSString *XZRoleName;

/** 角色等级 */
@property (nonatomic,strong)NSString *XZRoleLevel;

/** 服务器id */
@property (nonatomic,strong)NSString *XZSerVerID;

/** 服务器名字, urlencode(转码) */
@property (nonatomic,strong)NSString *XZServerName;

@end
