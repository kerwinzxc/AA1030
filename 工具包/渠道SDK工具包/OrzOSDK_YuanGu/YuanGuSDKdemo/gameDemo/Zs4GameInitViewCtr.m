//
//  Zs4GameInitViewCtr.m
//
//  Created by aXiBa on 16/5/13.
//  Copyright © 2016年 aXiBa. All rights reserved.
//
//

#import "Zs4GameInitViewCtr.h"
#import "Zs4LoginViewCtr.h"
#import <ZS4Game/Zs4GameHeader.h>

@interface Zs4GameInitViewCtr ()

@end

@implementation Zs4GameInitViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"初始化--SDK版本%@",[Zs4Game version]];//SDK版本号
    self.view.backgroundColor = [UIColor redColor];
    
    UILabel *b = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 320, 10)];
    b.center = self.view.center;
    b.numberOfLines = 2;
    [self.view addSubview:b];
    
    UILabel *lbInitGame = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetMinX(b.frame)+CGRectGetMaxX(b.frame))/2-160,
                                                                   CGRectGetMinY(b.frame)-60, 320, 60)];
    lbInitGame.center = self.view.center;
    lbInitGame.numberOfLines = 3;
    //模拟游戏加载资源
    lbInitGame.text = @"请稍等，游戏正在加载资源中(98%)......\n[这句话是假的啦，你可以直接开始游戏哦]";
    [self.view addSubview:lbInitGame];
    
    
    UIButton *btnStartGame = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetMinX(lbInitGame.frame)+CGRectGetMaxX(lbInitGame.frame))/2-40, CGRectGetMaxY(b.frame)+20, 78, 44)];
    [btnStartGame setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnStartGame.titleLabel.lineBreakMode = 0;
    btnStartGame.backgroundColor = [UIColor whiteColor];
    
    //模拟游戏开始按钮
    [btnStartGame setTitle:@"开始游戏" forState:UIControlStateNormal];
    [btnStartGame addTarget:self action:@selector(btnInitGameAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStartGame];
    
}

-(void)btnInitGameAction
{
    
    if ([[Zs4Game sharedInstance] isLogined]) {
        
        Zs4LoginViewCtr *loginView = [[Zs4LoginViewCtr alloc]init];
        [self.navigationController pushViewController:loginView animated:YES];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(initGameAction) object:self];//
    }else{
        if([[Zs4Game sharedInstance] isShowLoginView]){
        }else{
            [[Zs4Game sharedInstance] login];
        }
    }
}


-(void)initGameAction
{
    Zs4LoginViewCtr *loginView = [[Zs4LoginViewCtr alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
