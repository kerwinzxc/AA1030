//
//  TXYloginView.h
//  GameSDK
//
//  Created by Tommy on 2018/7/10.
//  Copyright © 2018年 p0sixB1ackcat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loginBlock)(NSString *uid ,NSString *token);
@interface BBBloginViewTwo : UIView


@property(nonatomic,strong)UIButton *freeUserBtn;
@property(nonatomic,strong)UIButton *userLoginBtn;
@property(nonatomic,strong)loginBlock  Block;

+(BBBloginViewTwo *)shareLoginView;
-(void)hengpingFrame;
-(void)shupingFrame;

@end
