

#import <Foundation/Foundation.h>

#import "PostinAgreeView.h"
#import "PostinSdkImp.h"

@interface PostinAgreeView()

@property(nonatomic) CGSize size;
@property(nonatomic,strong) NSMutableArray *viewList;
@property(nonatomic) Boolean landcape;
@end


static NSString * LOG_TAG = @"PostinAgreeView";



@implementation PostinAgreeView


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView* result = [super hitTest:point withEvent:event];
    
    CGRect cusomPicker = [self convertRect:self.alertContainer.frame fromView:self];
    
    if (CGRectContainsPoint(cusomPicker,point))
    {
        //self.scrollEnabled = NO;
        
        return result;
    }
    else
    {

        return self.alertContainer;
        
    }
    
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    // UIView* result = [super hitTest:point withEvent:event];
    CGRect cusomPicker = [self convertRect:self.alertContainer.frame fromView:self];
    if (CGRectContainsPoint(cusomPicker,point))
    {
        //self.scrollEnabled = NO;
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
    self = [super initWithFrame:CGRectZero];
    if (self) {
        CGRect rect=[[UIScreen mainScreen] bounds];
        self.parent = NULL;
        
        if (ios8) {
            self.alertContainer = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-300)/2, (rect.size.height-300)/2, size.width, size.height)];
        }else{
            if (landScape) {
                self.alertContainer = [[UIView alloc] initWithFrame:CGRectMake((rect.size.height-300)/2, (rect.size.width-300)/2, size.width, size.height)];
            }else{
                self.alertContainer = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-300)/2, (rect.size.height-300)/2, size.width, size.height)];
            }
        }
        
        self.alertContainer.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Postin.bundle/Postin_agreeBG.png"]]];
        
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
    
    NSString *className=[[NSString alloc]initWithFormat:@"%s",object_getClassName(self)];
    [self removeFromSuperview];
    
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(self.landcape == false){
        return (UIInterfaceOrientationLandscapeLeft == interfaceOrientation)||(UIInterfaceOrientationLandscapeRight == interfaceOrientation);
    }else{
        return UIInterfaceOrientationPortrait == interfaceOrientation;
    }
    
}

// For ios6, use supportedInterfaceOrientations & shouldAutorotate instead
- (NSUInteger) supportedInterfaceOrientations{
    
    // return UIInterfaceOrientationMaskLandscape;
    
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
