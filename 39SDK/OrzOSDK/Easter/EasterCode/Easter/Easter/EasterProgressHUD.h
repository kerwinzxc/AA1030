

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol EasterProgressHUDDelegate;


typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    EasterProgressHUDModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    EasterProgressHUDModeDeterminate,
    /** Progress is shown using a horizontal progress bar */
    EasterProgressHUDModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    EasterProgressHUDModeAnnularDeterminate,
    /** Shows a custom view */
    EasterProgressHUDModeCustomView,
    /** Shows only labels */
    EasterProgressHUDModeText
} EasterProgressHUDMode;

typedef enum {
    /** Opacity animation */
    EasterProgressHUDAnimationFade,
    /** Opacity + scale animation */
    EasterProgressHUDAnimationZoom,
    EasterProgressHUDAnimationZoomOut = EasterProgressHUDAnimationZoom,
    EasterProgressHUDAnimationZoomIn
} EasterProgressHUDAnimation;


#ifndef Easter_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define Easter_INSTANCETYPE instancetype
#else
#define Easter_INSTANCETYPE id
#endif
#endif

#ifndef Easter_STRONG
#if __has_feature(objc_arc)
#define Easter_STRONG strong
#else
#define Easter_STRONG retain
#endif
#endif

#ifndef Easter_WEAK
#if __has_feature(objc_arc_weak)
#define Easter_WEAK weak
#elif __has_feature(objc_arc)
#define Easter_WEAK unsafe_unretained
#else
#define Easter_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^EasterProgressHUDCompletionBlock)();
#endif


@interface EasterProgressHUD : UIView


+ (Easter_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;


+ (Easter_INSTANCETYPE)HUDForView:(UIView *)view;


+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(EasterProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(EasterProgressHUDCompletionBlock)completion;


@property (copy) EasterProgressHUDCompletionBlock completionBlock;

#endif

@property (assign) EasterProgressHUDMode mode;


@property (assign) EasterProgressHUDAnimation animationType;

@property (Easter_STRONG) UIView *customView;

@property (Easter_WEAK) id<EasterProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;

@property (Easter_STRONG) UIColor *color;

@property (assign) float xOffset;

@property (assign) float yOffset;


@property (assign) float margin;

@property (assign) float cornerRadius;

@property (assign) BOOL dimBackground;

@property (assign) float graceTime;

@property (assign) float minShowTime;

@property (assign) BOOL taskInProgress;

@property (assign) BOOL removeFromSuperViewOnHide;

@property (Easter_STRONG) UIFont* labelFont;

@property (Easter_STRONG) UIColor* labelColor;

@property (Easter_STRONG) UIFont* detailsLabelFont;

@property (Easter_STRONG) UIColor* detailsLabelColor;

@property (assign) float progress;

@property (assign) CGSize minSize;

@property (assign, getter = isSquare) BOOL square;

@end


@protocol EasterProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(EasterProgressHUD *)hud;

@end

@interface EasterRoundProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Easter_STRONG) UIColor *EasterMyprogressTintColor;

@property (nonatomic, Easter_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end

@interface EasterBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Easter_STRONG) UIColor *lineColor;

@property (nonatomic, Easter_STRONG) UIColor *EasterMyprogressRemainingColor;

@property (nonatomic, Easter_STRONG) UIColor *EasterMyprogressColor;

@end