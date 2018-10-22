

#import "PostinServiceViewController.h"
#import "PostinSdkImp.h"
#import "PostinWebInterface.h"
@interface PostinServiceViewController ()
- (IBAction)buttonClick:(id)sender;
@property(nonatomic,strong) NSString *homePage;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *qq;
@property(nonatomic,strong) NSString *qqgroup;
@property(nonatomic,strong) NSString *message;
@property (nonatomic) CGFloat kScreenWidth;
@property (nonatomic) CGFloat kScreenHeight;

@end

@implementation PostinServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithLandscape:(Boolean)landscape
{
    self = [super init];
    if (self) {
        self.landscape = landscape;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pageIndex = 0;
}

-(void)loadView {
    [super loadView];
    
    UIView *subView ;
    
    CGRect rect=[[UIScreen mainScreen]bounds];
    
    if (ios8) {
        self.kScreenWidth=rect.size.width;
        self.kScreenHeight=rect.size.height;
        
        NSLog(@"ios8  self.kScreenWidth==%f::self.kScreenHeight==%f",rect.size.width,rect.size.height);
    }else{
        if (self.landscape) {
            self.kScreenWidth=rect.size.height;
            self.kScreenHeight=rect.size.width;
            NSLog(@"ios8  1 self.kScreenWidth==%f::self.kScreenHeight==%f",rect.size.width,rect.size.height);
        }else{
            self.kScreenWidth=rect.size.width;
            self.kScreenHeight=rect.size.height;
            NSLog(@"ios8  2 self.kScreenWidth==%f::self.kScreenHeight==%f",rect.size.width,rect.size.height);
        }
    }
    

        if (self.landscape == true) {
            subView = [[UIView alloc]initWithFrame:CGRectMake((self.kScreenWidth-200)/2, (self.kScreenHeight-160)/2, 200, 200)];
            
        }
        else
        {
            subView = [[UIView alloc]initWithFrame:CGRectMake((self.kScreenWidth-160)/2, (self.kScreenHeight-200)/2, 200, 200)];//60, 200
            
        }
    Postin_VSD_BLOCK successBlock= ^(NSDictionary *dictionary, NSDictionary *header) {
        
        if ([dictionary objectForKey:@"error"] == nil) {
            NSDictionary *obj = [dictionary objectForKey:@"support"];
            NSLog(@"obj %@", obj);
            self.homePage = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"home"]];
            self.phone = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"phone"]];
            self.message = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"message"]];
            self.qq = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"qq"]];
            self.qqgroup = [[NSString alloc] initWithFormat:@"%@", [obj objectForKey:@"qq_group"]];
            

  
    
    UILabel *qqLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 20, 30)];
    [qqLabel1 setText:@"客服QQ:"];
    [qqLabel1 setFont:[UIFont systemFontOfSize:13]];
    [qqLabel1 sizeToFit];
    [subView addSubview:qqLabel1];
            
    UILabel *qqContentLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(qqLabel1.frame.size.width + qqLabel1.frame.origin.x + 10, qqLabel1.frame.origin.y, 50, 50)];
    [qqContentLabel1 setText:self.qq];
    [qqContentLabel1 setFont:[UIFont systemFontOfSize:13]];
    [qqContentLabel1 sizeToFit];
    [subView addSubview:qqContentLabel1];
    
    
    UILabel *qqLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, qqLabel1.frame.origin.y + qqLabel1.frame.size.height + 10, 20, 30)];
    [qqLabel2 setFont:[UIFont systemFontOfSize:13]];
    [qqLabel2 setText:@"QQ群:"];
    [qqLabel2 sizeToFit];
    [subView addSubview:qqLabel2];
    
    UILabel *qqContentLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(qqLabel2.frame.size.width + qqLabel2.frame.origin.x + 10, qqLabel2.frame.origin.y, 50, 50)];
    [qqContentLabel2 setText:self.qqgroup];
    [qqContentLabel2 sizeToFit];
    [qqContentLabel2 setFont:[UIFont systemFontOfSize:13]];
    [subView addSubview:qqContentLabel2];
 
    UILabel *servicePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, qqLabel2.frame.origin.y + qqLabel2.frame.size.height + 10, 50, 50)];
    [servicePhoneLabel setText:@"客服热线:"];
    [servicePhoneLabel setFont:[UIFont systemFontOfSize:13]];
    [servicePhoneLabel sizeToFit];
    [subView addSubview:servicePhoneLabel];

    UILabel *servicePhoneValue = [[UILabel alloc]initWithFrame:CGRectMake(servicePhoneLabel.frame.origin.x + servicePhoneLabel.frame.size.width + 10, servicePhoneLabel.frame.origin.y, 50, 50)];
    [servicePhoneValue setFont:[UIFont systemFontOfSize:13]];
    [servicePhoneValue setText:self.phone];
    [servicePhoneValue sizeToFit];
    [subView addSubview:servicePhoneValue];
    
    UILabel *xxxLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, servicePhoneLabel.frame.origin.y + servicePhoneLabel.frame.size.height + 10, 50, 50)];
    [xxxLabel setFont:[UIFont systemFontOfSize:13]];
    [xxxLabel setText:@"官网:"];
    [xxxLabel sizeToFit];
    [subView addSubview:xxxLabel];
    
    UILabel *xxxValue = [[UILabel alloc]initWithFrame:CGRectMake(xxxLabel.frame.origin.x + xxxLabel.frame.size.width + 10, xxxLabel.frame.origin.y, 50, 50)];
    [xxxValue setFont:[UIFont systemFontOfSize:13]];
    [xxxValue setText:self.homePage];
    [xxxValue sizeToFit];
    [subView addSubview:xxxValue];
  
    
    UIButton *callButton = [[UIButton alloc]initWithFrame:CGRectMake(0, xxxLabel.frame.origin.y +xxxLabel.frame.size.height + 10, 175, 36)];
    
    UIImage *callDefaultImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_icon_call_phone_default.png"]];
    UIImage *callDownImage = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_icon_call_phone_cl.png"]];
    [callButton setImage:callDefaultImage forState:UIControlStateNormal];
    [callButton setImage:callDownImage forState:UIControlStateHighlighted];
    [callButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
            
            if([self.phone isEqualToString:@"暂无"]){
                callButton.hidden = YES;
            }else{
                callButton.hidden = NO;
            }
            
    [subView addSubview:callButton];
    
    
    [self.view addSubview:subView];
    }
    };
    
    [[PostinWebInterface sharedInstance]getPostinSupport:[[PostinSdkImp sharedInstance]getPostinAppId] onSuccessPostin:successBlock onFailedPostin:^(NSError *error) {

    }];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.delegate showPage:self.pageIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您确定要拨打电话？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *tel = [NSString stringWithFormat:@"tel://4000003%@", @"975"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    }
}

//fix not hide status on ios7
- (BOOL)prefersStatusBarHidden
{
    return YES;
    
}

@end
