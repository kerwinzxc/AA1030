//
//  SLERoleModelLEfile.h
//  SLEdemo
//
//  Created byshelen on 16/11/24.
//  Copyright © 2016年 gudo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLERoleModelLEfile : NSObject
/** 角色名字 */
@property (nonatomic,strong)NSString *SLERoleName;

/** 角色等级 */
@property (nonatomic,strong)NSString *SLERoleLevel;

/** 服务器id */
@property (nonatomic,strong)NSString *SLESerVerID;

/** 服务器名字, urlencode(转码) */
@property (nonatomic,strong)NSString *SLEServerName;

@end
