
#import "GhargeNoticeView.h"

@interface GhargeNoticeView()

@property(nonatomic, strong) UIView *Gharge_notice_parent;
@property(nonatomic, strong) UIView *Gharge_notice_alertView;

@end

@implementation GhargeNoticeView

- (id)initWithSize:(NSDictionary *)param{

    self = [super initWithFrame:CGRectZero];
    if (self) {
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"with:%d",width);
        NSLog(@"height:%d",height);
        NSLog(@"notice_title = %@", [param objectForKey:@"notice_title"]);
        NSLog(@"notice_content = %@", [param objectForKey:@"notice_content"]);
        self.Gharge_notice_parent = NULL;

        self.Gharge_notice_alertView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, width-40, height-40)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.Gharge_notice_alertView.frame.size.width , self.Gharge_notice_alertView.frame.size.height)];
        imageview.image = [UIImage imageNamed:@"Gharge.bundle/Gharge_notice_bg.png"];
        [self.Gharge_notice_alertView addSubview:imageview];
        self.Gharge_notice_alertView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.Gharge_notice_alertView];
        [self bringSubviewToFront:self.Gharge_notice_alertView];
        
        UIButton *Gharge_notice_close = [[UIButton alloc]initWithFrame:CGRectMake(self.Gharge_notice_alertView.frame.size.width-32, 7, 25, 25)];
        [Gharge_notice_close setBackgroundImage:[UIImage imageNamed:@"Gharge.bundle/Gharge_notice_close.png"] forState:UIControlStateNormal];
        [Gharge_notice_close addTarget:self action:@selector(Gharge_notice_closePressed) forControlEvents:UIControlEventTouchUpInside];
        [self.Gharge_notice_alertView addSubview:Gharge_notice_close];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10 , width-80, 35)];
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setText:[param objectForKey:@"notice_title"]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:22.0];
        [self.Gharge_notice_alertView addSubview:titleLabel];
        
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 55 , width-80, self.Gharge_notice_alertView.frame.size.height-70)];
        [self.Gharge_notice_alertView addSubview:scroll];
        

        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , width-80, height-70)];
        contentLabel.textColor = [UIColor blackColor];
        [contentLabel setText:[param objectForKey:@"notice_content"]];
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGSize labelSize = [contentLabel.text boundingRectWithSize:CGSizeMake(width-80, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:17.0];
        [contentLabel sizeToFit];
        [scroll addSubview:contentLabel];
        
        scroll.contentSize = CGSizeMake(width-80, contentLabel.frame.size.height);
        
        
        
    }
    
    return self;
}

-(void)Gharge_notice_closePressed{
    [self dismissWithAnimation:YES];
}

-(void)show:(UIView *)view
{
    self.Gharge_notice_parent = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)dismissWithAnimation:(BOOL)animated
{
    
    [self removeFromSuperview];
    
    
    
}

@end





@interface GhargeCheckUpdateView()

@property(nonatomic, strong) UIView *Gharge_update_parent;
@property(nonatomic, strong) UIView *Gharge_update_alertView;

@property(nonatomic, strong) NSString *Gharge_update_url;

@end

@implementation GhargeCheckUpdateView


- (id)initWithSize:(NSDictionary *)param{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"with:%d",width);
        NSLog(@"height:%d",height);
        self.Gharge_update_url = [[NSString alloc] initWithFormat:@"%@", [param objectForKey:@"url"]];
       
        self.Gharge_update_parent = NULL;
        
        self.Gharge_update_alertView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, width-40, height-40)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.Gharge_update_alertView.frame.size.width , self.Gharge_update_alertView.frame.size.height)];
        imageview.image = [UIImage imageNamed:@"Gharge.bundle/Gharge_notice_bg.png"];
        [self.Gharge_update_alertView addSubview:imageview];
        self.Gharge_update_alertView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.Gharge_update_alertView];
        [self bringSubviewToFront:self.Gharge_update_alertView];
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10 , width-80, 35)];
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setText:[param objectForKey:@"title"]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:22.0];
        [self.Gharge_update_alertView addSubview:titleLabel];
        

        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 55 , width-80, self.Gharge_update_alertView.frame.size.height-110)];
        [self.Gharge_update_alertView addSubview:scroll];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , width-80, height-110)];
        contentLabel.textColor = [UIColor blackColor];
        [contentLabel setText:[param objectForKey:@"content"]];
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        CGSize labelSize = [contentLabel.text boundingRectWithSize:CGSizeMake(width-80, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:17.0];
        [contentLabel sizeToFit];
        [scroll addSubview:contentLabel];
        
        scroll.contentSize = CGSizeMake(width-80, contentLabel.frame.size.height);
        
        
        
        UIButton *Gharge_update = [[UIButton alloc]initWithFrame:CGRectMake((self.Gharge_update_alertView.frame.size.width-60)/2, self.Gharge_update_alertView.frame.size.height-40, 80, 30)];
        [Gharge_update setTitle:@"立即更新" forState:UIControlStateNormal];
        [Gharge_update setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [Gharge_update addTarget:self action:@selector(Gharge_updatePressed) forControlEvents:UIControlEventTouchUpInside];
        [self.Gharge_update_alertView addSubview:Gharge_update];
    }
    
    return self;
}

-(void)Gharge_update_closePressed{
    [self dismissWithAnimation:YES];
}

-(void)Gharge_updatePressed{
    NSLog(@"self.update_url = %@", self.Gharge_update_url);
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.Gharge_update_url]] == true){
        NSLog(@"canopen");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.Gharge_update_url]];
    }else{
        NSLog(@"can not open");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.Gharge_update_url]];
    }
    
    [self dismissWithAnimation:YES];
}

-(void)show:(UIView *)view
{
    self.Gharge_update_parent = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)dismissWithAnimation:(BOOL)animated
{
    
    [self removeFromSuperview];
    
    
    
}

@end


