

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol GhargeProgressHUDDelegate;


typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    GhargeProgressHUDModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    GhargeProgressHUDModeDeterminate,
    /** Progress is shown using a horizontal progress bar */
    GhargeProgressHUDModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    GhargeProgressHUDModeAnnularDeterminate,
    /** Shows a custom view */
    GhargeProgressHUDModeCustomView,
    /** Shows only labels */
    GhargeProgressHUDModeText
} GhargeProgressHUDMode;

typedef enum {
    /** Opacity animation */
    GhargeProgressHUDAnimationFade,
    /** Opacity + scale animation */
    GhargeProgressHUDAnimationZoom,
    GhargeProgressHUDAnimationZoomOut = GhargeProgressHUDAnimationZoom,
    GhargeProgressHUDAnimationZoomIn
} GhargeProgressHUDAnimation;


#ifndef Gharge_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define Gharge_INSTANCETYPE instancetype
#else
#define Gharge_INSTANCETYPE id
#endif
#endif

#ifndef Gharge_STRONG
#if __has_feature(objc_arc)
#define Gharge_STRONG strong
#else
#define Gharge_STRONG retain
#endif
#endif

#ifndef Gharge_WEAK
#if __has_feature(objc_arc_weak)
#define Gharge_WEAK weak
#elif __has_feature(objc_arc)
#define Gharge_WEAK unsafe_unretained
#else
#define Gharge_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^GhargeProgressHUDCompletionBlock)();
#endif


@interface GhargeProgressHUD : UIView


+ (Gharge_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;


+ (Gharge_INSTANCETYPE)HUDForView:(UIView *)view;


+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(GhargeProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(GhargeProgressHUDCompletionBlock)completion;


@property (copy) GhargeProgressHUDCompletionBlock completionBlock;

#endif

@property (assign) GhargeProgressHUDMode mode;


@property (assign) GhargeProgressHUDAnimation animationType;

@property (Gharge_STRONG) UIView *customView;

@property (Gharge_WEAK) id<GhargeProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;

@property (Gharge_STRONG) UIColor *color;

@property (assign) float xOffset;

@property (assign) float yOffset;


@property (assign) float margin;

@property (assign) float cornerRadius;

@property (assign) BOOL dimBackground;

@property (assign) float graceTime;

@property (assign) float minShowTime;

@property (assign) BOOL taskInProgress;

@property (assign) BOOL removeFromSuperViewOnHide;

@property (Gharge_STRONG) UIFont* labelFont;

@property (Gharge_STRONG) UIColor* labelColor;

@property (Gharge_STRONG) UIFont* detailsLabelFont;

@property (Gharge_STRONG) UIColor* detailsLabelColor;

@property (assign) float progress;

@property (assign) CGSize minSize;

@property (assign, getter = isSquare) BOOL square;

@end


@protocol GhargeProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(GhargeProgressHUD *)hud;

@end

@interface GhargeRoundProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Gharge_STRONG) UIColor *GhargeMyprogressTintColor;

@property (nonatomic, Gharge_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end

@interface GhargeBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Gharge_STRONG) UIColor *lineColor;

@property (nonatomic, Gharge_STRONG) UIColor *GhargeMyprogressRemainingColor;

@property (nonatomic, Gharge_STRONG) UIColor *GhargeMyprogressColor;

@end
