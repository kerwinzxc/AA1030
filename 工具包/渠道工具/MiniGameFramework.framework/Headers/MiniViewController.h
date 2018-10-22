//
//  ViewController.h
//  MiniGame
//
//  Created by xianpeng.liu on 2018/8/1.
//  Copyright © 2018 Little Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MissionView;

@interface MiniViewController : UIViewController

@property IBOutlet MissionView *missionView1;
@property IBOutlet MissionView *missionView2;
@property IBOutlet MissionView *missionView3;
@property IBOutlet MissionView *missionView4;
@property IBOutlet MissionView *missionView5;
@property IBOutlet MissionView *missionView6;

-(IBAction)onClickMission1:(id)sender;
-(IBAction)onClickMission2:(id)sender;
-(IBAction)onClickMission3:(id)sender;
-(IBAction)onClickMission4:(id)sender;
-(IBAction)onClickMission5:(id)sender;
-(IBAction)onClickMission6:(id)sender;

@property IBOutlet UIImageView *bgImageView;

@end
