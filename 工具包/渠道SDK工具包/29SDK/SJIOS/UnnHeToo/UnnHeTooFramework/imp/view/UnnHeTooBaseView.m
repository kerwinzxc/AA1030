

#import "UnnHeTooBaseView.h"
#import "UnnHeTooSdkImp.h"

@interface UnnHeTooBaseView()

@property(nonatomic) CGSize size;
@property(nonatomic,strong) NSMutableArray *viewList;
@property(nonatomic) Boolean landcape;
@end

const CGFloat default_witdh = 280.0f;
//const CGFloat default_height = 240.0f;
const CGFloat default_height = 307.2f;

static NSString * LOG_TAG = @"UnnHeTooBaseView";



@implementation UnnHeTooBaseView


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView* result = [super hitTest:point withEvent:event];
    
    CGRect cusomPicker = [self convertRect:self.frame fromView:self];
    
    if (CGRectContainsPoint(cusomPicker,point))
    {
        
        return result;
    }
    else
    {

        return self.alertContainer;
        
    }
    
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    // UIView* result = [super hitTest:point withEvent:event];
    CGRect cusomPicker = [self convertRect:self.frame fromView:self];
    if (CGRectContainsPoint(cusomPicker,point))
    {
        return YES;
    }
    else
    {

        return NO;
        
    }
}



- (id)initWithSize:(CGSize)size
         landScape:(Boolean)landScape
{
    self.landcape = landScape;
    NSLog(@"landcape:%@",landScape?@"YES":@"NO");
    self = [super initWithFrame:CGRectZero];
    
    //self.userInteractionEnabled = false;
    
    if (self) {
        CGRect rect=[[UIScreen mainScreen] bounds];
        NSLog(@"with:%f",rect.size.width);
        NSLog(@"height:%f",rect.size.height);
        self.parent = NULL;
        
            //横屏
            if (landScape) {
        
                 self.alertContainer = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-450)/2, (rect.size.height-250)/2, size.width, size.height)];

                self.alertContainer.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_background_landscape.png"]]];
            }else{//竖屏

                 self.alertContainer = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-260)/2, (rect.size.height-260)/2, size.width, size.height)];
                self.alertContainer.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"UnnHeToo.bundle/UnnHeToo_background_portrait.png"]]];
            }

        
        [self addSubview:self.alertContainer];
        [self bringSubviewToFront:self.alertContainer];
      
        self.size = size;
        self.landscape = landScape;
    }
    return self;
}


-(void)show:(UIView *)view
{
        self.parent = view;
        self.frame = view.bounds;
        [view addSubview:self];
        [view bringSubviewToFront:self];
}

- (void)dismissWithAnimation:(BOOL)animated
{
    

       [self removeFromSuperview];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(self.landcape == false){
        return (UIInterfaceOrientationLandscapeLeft == interfaceOrientation)||(UIInterfaceOrientationLandscapeRight == interfaceOrientation);
    }else{
        return UIInterfaceOrientationPortrait == interfaceOrientation;
    }
    
}

- (NSUInteger) supportedInterfaceOrientations{
    
    if(self.landcape == false){
        return UIInterfaceOrientationMaskLandscape;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
    
}

- (BOOL) shouldAutorotate {
    return YES;
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
