//
//  BTGORole.h
//  CYouUSDK
//
//  Created by River on 2017/4/5.
//  Copyright © 2017年 River All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTGORole : NSObject<NSCopying>
    
@property (nonatomic,strong) NSString *roleId;
@property (nonatomic,strong) NSString *roleName;
@property (nonatomic,strong) NSString *roleLevel;
@property (nonatomic,strong) NSString *serverId;
@property (nonatomic,strong) NSString *serverName;
@property (nonatomic,strong) NSDictionary *extra;
@property (nonatomic,strong) NSString *rolelevelext;

-(NSString*)toString;

@end
