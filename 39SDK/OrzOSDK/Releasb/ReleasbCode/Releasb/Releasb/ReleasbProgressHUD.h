

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol ReleasbProgressHUDDelegate;


typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    ReleasbProgressHUDModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    ReleasbProgressHUDModeDeterminate,
    /** Progress is shown using a horizontal progress bar */
    ReleasbProgressHUDModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    ReleasbProgressHUDModeAnnularDeterminate,
    /** Shows a custom view */
    ReleasbProgressHUDModeCustomView,
    /** Shows only labels */
    ReleasbProgressHUDModeText
} ReleasbProgressHUDMode;

typedef enum {
    /** Opacity animation */
    ReleasbProgressHUDAnimationFade,
    /** Opacity + scale animation */
    ReleasbProgressHUDAnimationZoom,
    ReleasbProgressHUDAnimationZoomOut = ReleasbProgressHUDAnimationZoom,
    ReleasbProgressHUDAnimationZoomIn
} ReleasbProgressHUDAnimation;


#ifndef Releasb_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define Releasb_INSTANCETYPE instancetype
#else
#define Releasb_INSTANCETYPE id
#endif
#endif

#ifndef Releasb_STRONG
#if __has_feature(objc_arc)
#define Releasb_STRONG strong
#else
#define Releasb_STRONG retain
#endif
#endif

#ifndef Releasb_WEAK
#if __has_feature(objc_arc_weak)
#define Releasb_WEAK weak
#elif __has_feature(objc_arc)
#define Releasb_WEAK unsafe_unretained
#else
#define Releasb_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^ReleasbProgressHUDCompletionBlock)();
#endif


@interface ReleasbProgressHUD : UIView


+ (Releasb_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;


+ (Releasb_INSTANCETYPE)HUDForView:(UIView *)view;


+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(ReleasbProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(ReleasbProgressHUDCompletionBlock)completion;


@property (copy) ReleasbProgressHUDCompletionBlock completionBlock;

#endif

@property (assign) ReleasbProgressHUDMode mode;


@property (assign) ReleasbProgressHUDAnimation animationType;

@property (Releasb_STRONG) UIView *customView;

@property (Releasb_WEAK) id<ReleasbProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;

@property (Releasb_STRONG) UIColor *color;

@property (assign) float xOffset;

@property (assign) float yOffset;


@property (assign) float margin;

@property (assign) float cornerRadius;

@property (assign) BOOL dimBackground;

@property (assign) float graceTime;

@property (assign) float minShowTime;

@property (assign) BOOL taskInProgress;

@property (assign) BOOL removeFromSuperViewOnHide;

@property (Releasb_STRONG) UIFont* labelFont;

@property (Releasb_STRONG) UIColor* labelColor;

@property (Releasb_STRONG) UIFont* detailsLabelFont;

@property (Releasb_STRONG) UIColor* detailsLabelColor;

@property (assign) float progress;

@property (assign) CGSize minSize;

@property (assign, getter = isSquare) BOOL square;

@end


@protocol ReleasbProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(ReleasbProgressHUD *)hud;

@end

@interface ReleasbRoundProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Releasb_STRONG) UIColor *ReleasbMyprogressTintColor;

@property (nonatomic, Releasb_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end

@interface ReleasbBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Releasb_STRONG) UIColor *lineColor;

@property (nonatomic, Releasb_STRONG) UIColor *ReleasbMyprogressRemainingColor;

@property (nonatomic, Releasb_STRONG) UIColor *ReleasbMyprogressColor;

@end
