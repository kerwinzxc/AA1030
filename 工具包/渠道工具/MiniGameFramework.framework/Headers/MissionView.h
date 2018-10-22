//
//  MissionView.h
//  MiniGame
//
//  Created by xianpeng.liu on 2018/8/2.
//  Copyright © 2018 Little Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissionView : UIView

@property IBOutlet UIImageView *lockView;
@property IBOutlet UILabel *missionLabel;
@property IBOutlet UIImageView *progressView;
@property IBOutlet UIImageView *progressBgView;
@property IBOutlet NSLayoutConstraint *progressConstraint;
@property IBOutlet UILabel *progressLabel;

-(void)updateUIWithMissionId:(NSInteger)curMissionId andLayer:(NSUInteger)curLayer;

@end
