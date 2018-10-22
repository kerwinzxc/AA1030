//
//  BattleViewController.h
//  MiniGame
//
//  Created by xianpeng.liu on 2018/8/2.
//  Copyright © 2018 Little Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BattleView;
@class BattleShopView;
@class BattleBoxView;
@class CheckView;
@class BagView;

@interface BattleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSInteger curMissionId;
@property NSInteger curLayer;

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *diamondLabel;
@property IBOutlet UILabel *coinLabel;

@property IBOutlet BattleView *battleView;
@property IBOutlet BattleShopView *battleShopView;
@property IBOutlet BattleBoxView *battleBoxView;
@property IBOutlet UIView *shopView;
@property IBOutlet CheckView *checkView;
@property IBOutlet BagView *bagView;

@property IBOutlet UITableView *bagTableView;

-(void)gotoNextMission;

-(IBAction)onClickFuli:(id)sender;
-(IBAction)onClickBag:(id)sender;
-(IBAction)onClickCheck:(id)sender;
-(IBAction)onClickShop:(id)sender;

-(IBAction)onClickCloseBag:(id)sender;
-(IBAction)onClickCloseCheck:(id)sender;
-(IBAction)onClickCloseShop:(id)sender;

@end
