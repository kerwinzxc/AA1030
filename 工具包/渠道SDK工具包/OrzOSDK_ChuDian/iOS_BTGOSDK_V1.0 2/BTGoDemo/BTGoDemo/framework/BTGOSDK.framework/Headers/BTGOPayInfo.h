//
//  PayInfo.h
//  BTGOSDK
//
//  Created by River on 16/9/9.
//  Copyright © 2016年 River. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTGOPayInfo : NSObject<NSCopying>

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,assign) NSInteger money;
@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *ext;

@property (nonatomic,strong) NSString *roleId;
@property (nonatomic,strong) NSString *roleName;
@property (nonatomic,strong) NSString *roleLevel;
@property (nonatomic,strong) NSString *serverId;
@property (nonatomic,strong) NSString *serverName;
@property (nonatomic,strong) NSDictionary *extra;
@end



