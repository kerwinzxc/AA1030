//
//  UConfig
//  XWUSDK
//
//  Created by River on 2017/4/5.
//  Copyright © 2017年 cgamex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTGOConfig : NSObject<NSCopying>
    
@property (nonatomic,strong) NSString *appId;
@property (nonatomic,strong) NSString *appKey;
@property (nonatomic,strong) NSDictionary *extra;

-(NSString*)toString;
    
@end
