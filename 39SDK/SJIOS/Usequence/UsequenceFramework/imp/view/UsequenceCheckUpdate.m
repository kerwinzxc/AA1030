

#import "UsequenceCheckUpdate.h"
@interface UsequenceCheckUpdate()
@property (nonatomic) Boolean landScape;
@property(nonatomic,strong)NSString *url;
@end
@implementation UsequenceCheckUpdate


- (id)initWithBlock:(Boolean)landcape url:(NSString *)url{
    self = [super initWithSize:CGSizeMake(260, 200) landScape:landcape ];
    if (self) {
        self.landScape=landcape;
        self.url=url;
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 260, 38)];
        title.text=@"版本提示";
        title.textAlignment=NSTextAlignmentCenter;
        [self.alertContainer addSubview:title];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, title.frame.origin.y+48, 260, 38)];
        lable.text=@"有新版本啦,更新后才能继续体验哦!";
        lable.font=[UIFont systemFontOfSize:14];
        lable.textAlignment=NSTextAlignmentCenter;
        [self.alertContainer addSubview:lable];
        UIButton *confirm=[[UIButton alloc]initWithFrame:CGRectMake(15, lable.frame.origin.y+48, 230, 38)];
        [confirm setTitle:@"确认更新" forState:UIControlStateNormal];
        confirm.backgroundColor=[UIColor lightGrayColor];
        confirm.titleLabel.textColor=[UIColor whiteColor];
        confirm.titleLabel.font=[UIFont systemFontOfSize:18];
        [confirm addTarget:self action:@selector(checkUpdate) forControlEvents:UIControlEventTouchUpInside];
        [self.alertContainer addSubview:confirm];
     
    }
    return self;
}

-(void)checkUpdate
{
    NSString *installUrl = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",self.url];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:installUrl]];
}
@end
