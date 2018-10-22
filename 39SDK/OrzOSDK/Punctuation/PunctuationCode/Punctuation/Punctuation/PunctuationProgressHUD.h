

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol PunctuationProgressHUDDelegate;


typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    PunctuationProgressHUDModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    PunctuationProgressHUDModeDeterminate,
    /** Progress is shown using a horizontal progress bar */
    PunctuationProgressHUDModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    PunctuationProgressHUDModeAnnularDeterminate,
    /** Shows a custom view */
    PunctuationProgressHUDModeCustomView,
    /** Shows only labels */
    PunctuationProgressHUDModeText
} PunctuationProgressHUDMode;

typedef enum {
    /** Opacity animation */
    PunctuationProgressHUDAnimationFade,
    /** Opacity + scale animation */
    PunctuationProgressHUDAnimationZoom,
    PunctuationProgressHUDAnimationZoomOut = PunctuationProgressHUDAnimationZoom,
    PunctuationProgressHUDAnimationZoomIn
} PunctuationProgressHUDAnimation;


#ifndef Punctuation_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define Punctuation_INSTANCETYPE instancetype
#else
#define Punctuation_INSTANCETYPE id
#endif
#endif

#ifndef Punctuation_STRONG
#if __has_feature(objc_arc)
#define Punctuation_STRONG strong
#else
#define Punctuation_STRONG retain
#endif
#endif

#ifndef Punctuation_WEAK
#if __has_feature(objc_arc_weak)
#define Punctuation_WEAK weak
#elif __has_feature(objc_arc)
#define Punctuation_WEAK unsafe_unretained
#else
#define Punctuation_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^PunctuationProgressHUDCompletionBlock)();
#endif


@interface PunctuationProgressHUD : UIView


+ (Punctuation_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;


+ (Punctuation_INSTANCETYPE)HUDForView:(UIView *)view;


+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(PunctuationProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(PunctuationProgressHUDCompletionBlock)completion;


@property (copy) PunctuationProgressHUDCompletionBlock completionBlock;

#endif

@property (assign) PunctuationProgressHUDMode mode;


@property (assign) PunctuationProgressHUDAnimation animationType;

@property (Punctuation_STRONG) UIView *customView;

@property (Punctuation_WEAK) id<PunctuationProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;

@property (Punctuation_STRONG) UIColor *color;

@property (assign) float xOffset;

@property (assign) float yOffset;


@property (assign) float margin;

@property (assign) float cornerRadius;

@property (assign) BOOL dimBackground;

@property (assign) float graceTime;

@property (assign) float minShowTime;

@property (assign) BOOL taskInProgress;

@property (assign) BOOL removeFromSuperViewOnHide;

@property (Punctuation_STRONG) UIFont* labelFont;

@property (Punctuation_STRONG) UIColor* labelColor;

@property (Punctuation_STRONG) UIFont* detailsLabelFont;

@property (Punctuation_STRONG) UIColor* detailsLabelColor;

@property (assign) float progress;

@property (assign) CGSize minSize;

@property (assign, getter = isSquare) BOOL square;

@end


@protocol PunctuationProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(PunctuationProgressHUD *)hud;

@end

@interface PunctuationRoundProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Punctuation_STRONG) UIColor *PunctuationMyprogressTintColor;

@property (nonatomic, Punctuation_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end

@interface PunctuationBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, Punctuation_STRONG) UIColor *lineColor;

@property (nonatomic, Punctuation_STRONG) UIColor *PunctuationMyprogressRemainingColor;

@property (nonatomic, Punctuation_STRONG) UIColor *PunctuationMyprogressColor;

@end
