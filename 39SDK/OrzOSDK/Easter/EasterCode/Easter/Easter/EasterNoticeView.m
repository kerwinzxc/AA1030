
#import "EasterNoticeView.h"

@interface EasterNoticeView()

@property(nonatomic, strong) UIView *Easter_notice_parent;
@property(nonatomic, strong) UIView *Easter_notice_alertView;

@end

@implementation EasterNoticeView

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
        self.Easter_notice_parent = NULL;

        self.Easter_notice_alertView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, width-40, height-40)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.Easter_notice_alertView.frame.size.width , self.Easter_notice_alertView.frame.size.height)];
        imageview.image = [UIImage imageNamed:@"Easter.bundle/Easter_notice_bg.png"];
        [self.Easter_notice_alertView addSubview:imageview];
        self.Easter_notice_alertView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.Easter_notice_alertView];
        [self bringSubviewToFront:self.Easter_notice_alertView];
        
        UIButton *Easter_notice_close = [[UIButton alloc]initWithFrame:CGRectMake(self.Easter_notice_alertView.frame.size.width-32, 7, 25, 25)];
        [Easter_notice_close setBackgroundImage:[UIImage imageNamed:@"Easter.bundle/Easter_notice_close.png"] forState:UIControlStateNormal];
        [Easter_notice_close addTarget:self action:@selector(Easter_notice_closePressed) forControlEvents:UIControlEventTouchUpInside];
        [self.Easter_notice_alertView addSubview:Easter_notice_close];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10 , width-80, 35)];
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setText:[param objectForKey:@"notice_title"]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:22.0];
        [self.Easter_notice_alertView addSubview:titleLabel];
        
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 55 , width-80, self.Easter_notice_alertView.frame.size.height-70)];
        [self.Easter_notice_alertView addSubview:scroll];
        

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

-(void)Easter_notice_closePressed{
    [self dismissWithAnimation:YES];
}

-(void)show:(UIView *)view
{
    self.Easter_notice_parent = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)dismissWithAnimation:(BOOL)animated
{
    
    [self removeFromSuperview];
    
    
    
}

@end





@interface EasterCheckUpdateView()

@property(nonatomic, strong) UIView *Easter_update_parent;
@property(nonatomic, strong) UIView *Easter_update_alertView;

@property(nonatomic, strong) NSString *Easter_update_url;

@end

@implementation EasterCheckUpdateView


- (id)initWithSize:(NSDictionary *)param{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        CGRect rect=[[UIScreen mainScreen] bounds];
        int width = rect.size.width;
        int height = rect.size.height;
        NSLog(@"with:%d",width);
        NSLog(@"height:%d",height);
        self.Easter_update_url = [[NSString alloc] initWithFormat:@"%@", [param objectForKey:@"url"]];
       
        self.Easter_update_parent = NULL;
        
        self.Easter_update_alertView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, width-40, height-40)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.Easter_update_alertView.frame.size.width , self.Easter_update_alertView.frame.size.height)];
        imageview.image = [UIImage imageNamed:@"Easter.bundle/Easter_notice_bg.png"];
        [self.Easter_update_alertView addSubview:imageview];
        self.Easter_update_alertView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.Easter_update_alertView];
        [self bringSubviewToFront:self.Easter_update_alertView];
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10 , width-80, 35)];
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setText:[param objectForKey:@"title"]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:22.0];
        [self.Easter_update_alertView addSubview:titleLabel];
        

        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 55 , width-80, self.Easter_update_alertView.frame.size.height-110)];
        [self.Easter_update_alertView addSubview:scroll];
        
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
        
        
        
        UIButton *Easter_update = [[UIButton alloc]initWithFrame:CGRectMake((self.Easter_update_alertView.frame.size.width-60)/2, self.Easter_update_alertView.frame.size.height-40, 80, 30)];
        [Easter_update setTitle:@"立即更新" forState:UIControlStateNormal];
        [Easter_update setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [Easter_update addTarget:self action:@selector(Easter_updatePressed) forControlEvents:UIControlEventTouchUpInside];
        [self.Easter_update_alertView addSubview:Easter_update];
    }
    
    return self;
}

-(void)Easter_update_closePressed{
    [self dismissWithAnimation:YES];
}

-(void)Easter_updatePressed{
    NSLog(@"self.update_url = %@", self.Easter_update_url);
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.Easter_update_url]] == true){
        NSLog(@"canopen");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.Easter_update_url]];
    }else{
        NSLog(@"can not open");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.Easter_update_url]];
    }
    
    [self dismissWithAnimation:YES];
}

-(void)show:(UIView *)view
{
    self.Easter_update_parent = view;
    self.frame = view.bounds;
    [view addSubview:self];
    [view bringSubviewToFront:self];
}

- (void)dismissWithAnimation:(BOOL)animated
{
    
    [self removeFromSuperview];
    
    
    
}

@end


