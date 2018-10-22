//
//  Zs4CreateRoleViewCtr.m
//
//  Created by aXiBa on 16/5/13.
//  Copyright © 2016年 aXiBa. All rights reserved.
//
//  玩家进入游戏后，进行区服角色选择完以后设置区服角色报道：（角色等级升级的时候也要调用一下这个方法进行实时报道）
//  [[Zs4Game sharedInstance]setServId:@"区服id" ServName:@"区服名称" RoleId:@"角色id" RoleName:@"角色名称" RoleGrade:角色等级（int型）];
//
//
//

#import "Zs4CreateRoleViewCtr.h"
#import <ZS4Game/Zs4GameHeader.h>

@interface Zs4CreateRoleViewCtr ()

@end

@implementation Zs4CreateRoleViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选区服角色";
    
    self.view.backgroundColor = [UIColor redColor];
    
    [[Zs4Game sharedInstance]setServId:@"serverid_1234"  //区服ID
                               ServName:@"学校门口"        //区服名称
                                 RoleId:@"roleid_5678"    //角色ID
                               RoleName:@"沃德天"          //角色名称
                              RoleGrade:10];              //等级 int 型
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    btn.center = self.view.center;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"模仿等级升级" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetMinX(btn.frame)+CGRectGetMaxX(btn.frame))/2-100,
                                                               CGRectGetMaxY(btn.frame)+10,
                                                               200,
                                                               44)];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //退出区服重新再选区服什么的不用注销SDK  建议游戏断线也不需要注销，只需要处理游戏自己的事情就可以了
    [btn1 setTitle:@"退出区服不用注销SDK" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnExitAction) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetMinX(btn.frame)+CGRectGetMaxX(btn.frame))/2-120,
                                                               CGRectGetMaxY(btn.frame)+60,
                                                               240,
                                                               44)];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //如果玩家要切换账号或设备互踢的时候才需要去注销SDK
    [btn2 setTitle:@"另一台设备登陆了/切换账号" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(logoutByLoginInOtherDevice:) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn2];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnAction
{
    [[Zs4Game sharedInstance] setRoleId:@"roleid_5678"  //角色ID
                               RoleGrade:11];            //最新等级
}


-(void)btnExitAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - actions
-(void)logoutByLoginInOtherDevice:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"你的账号在另一个设备登陆了，请检查你的账号是否安全."
                                                       delegate:self
                                              cancelButtonTitle:@"是我登陆的"
                                              otherButtonTitles:@"重新进入",nil];
    alertView.tag =1;
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1)
        {
            //TODO 注销重新登陆
            [[Zs4Game sharedInstance] logout];
        }else{
            //TODO 退出游戏
            exit(0);
        }
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
