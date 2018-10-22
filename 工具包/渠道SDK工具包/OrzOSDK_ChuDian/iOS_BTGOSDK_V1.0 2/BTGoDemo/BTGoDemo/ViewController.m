//
//  ViewController.m
//  BTGoDemo
//
//  Created by BTGOFL on 2018/6/26.
//  Copyright © 2018年 BTGOFL. All rights reserved.
//

#import "ViewController.h"
#import <BTGOSDK/BTGOSDK.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@"登录",@"充值一元",@"提交角色"];
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(200, 88+ 70*i, 120, 60);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        [btn setBackgroundColor:[UIColor cyanColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10+i;
        [self.view addSubview:btn];
        
    }
    /******************调用SDK登录 ******/
    [BTGOSDK login];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)clickAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    if(button.tag == 10){
        /******************调用SDK登录 ******/
        [BTGOSDK login];
    }else if (button.tag == 11){
        /******************充值调用 ******/
        BTGOPayInfo *model = [[BTGOPayInfo alloc]init];
        // 订单号，必须保证唯一性
        model.orderId =  [[NSUUID UUID]UUIDString];
        // 充值金额，单位为分
        model.money =1*100;
        // 苹果IAP产品ID  注：如果需要上架AppStore 必须传对应的产品id，产品id命名规则建议 bundleID +游戏名称缩写+金额，
        model.productId = @"com.btgo.wzry.6";
        // 扩展字段，服务端会原样返回
        model.ext = @"ext";
        // 角色ID
        model.roleId = @"100";
        // 角色名
        model.roleName = @"btgoRole";
        // 角色等级
        model.roleLevel = @"1";
        // 区服ID
        model.serverId = @"111111111";
        // 区服名
        model.serverName = @"区服一";
        
        [BTGOSDK payWithPayInfo:model];
        
    }else{
        
        //上传角色信息，进入游戏时调一次
        BTGORole *role = [[BTGORole alloc] init];
        //角色的id
        role.roleId = @"100";
        // 角色名
        role.roleName = @"btgoRole";
        // 角色等级
        role.roleLevel = @"1";
        // 区服ID
        role.serverId = @"1";
        // 区服名
        role.serverName = @"区服1";
        
        [BTGOSDK sendBTGORole:role];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}
@end
