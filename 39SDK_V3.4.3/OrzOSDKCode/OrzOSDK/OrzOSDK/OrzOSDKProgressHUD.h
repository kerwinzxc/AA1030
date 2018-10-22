

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol OrzOSDKProgressHUDDelegate;


typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    OrzOSDKProgressHUDModeIndeterminate,
    /** Progress is shown using a round, pie-chart like, progress view. */
    OrzOSDKProgressHUDModeDeterminate,
    /** Progress is shown using a horizontal progress bar */
    OrzOSDKProgressHUDModeDeterminateHorizontalBar,
    /** Progress is shown using a ring-shaped progress view. */
    OrzOSDKProgressHUDModeAnnularDeterminate,
    /** Shows a custom view */
    OrzOSDKProgressHUDModeCustomView,
    /** Shows only labels */
    OrzOSDKProgressHUDModeText
} OrzOSDKProgressHUDMode;

typedef enum {
    /** Opacity animation */
    OrzOSDKProgressHUDAnimationFade,
    /** Opacity + scale animation */
    OrzOSDKProgressHUDAnimationZoom,
    OrzOSDKProgressHUDAnimationZoomOut = OrzOSDKProgressHUDAnimationZoom,
    OrzOSDKProgressHUDAnimationZoomIn
} OrzOSDKProgressHUDAnimation;


#ifndef OrzOSDK_INSTANCETYPE
#if __has_feature(objc_instancetype)
#define OrzOSDK_INSTANCETYPE instancetype
#else
#define OrzOSDK_INSTANCETYPE id
#endif
#endif

#ifndef OrzOSDK_STRONG
#if __has_feature(objc_arc)
#define OrzOSDK_STRONG strong
#else
#define OrzOSDK_STRONG retain
#endif
#endif

#ifndef OrzOSDK_WEAK
#if __has_feature(objc_arc_weak)
#define OrzOSDK_WEAK weak
#elif __has_feature(objc_arc)
#define OrzOSDK_WEAK unsafe_unretained
#else
#define OrzOSDK_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^OrzOSDKProgressHUDCompletionBlock)();
#endif


@interface OrzOSDKProgressHUD : UIView


+ (OrzOSDK_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;


+ (OrzOSDK_INSTANCETYPE)HUDForView:(UIView *)view;


+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(OrzOSDKProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(OrzOSDKProgressHUDCompletionBlock)completion;


@property (copy) OrzOSDKProgressHUDCompletionBlock completionBlock;

#endif

@property (assign) OrzOSDKProgressHUDMode mode;


@property (assign) OrzOSDKProgressHUDAnimation animationType;

@property (OrzOSDK_STRONG) UIView *customView;

@property (OrzOSDK_WEAK) id<OrzOSDKProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;

@property (assign) float opacity;

@property (OrzOSDK_STRONG) UIColor *color;

@property (assign) float xOffset;

@property (assign) float yOffset;


@property (assign) float margin;

@property (assign) float cornerRadius;

@property (assign) BOOL dimBackground;

@property (assign) float graceTime;

@property (assign) float minShowTime;

@property (assign) BOOL taskInProgress;

@property (assign) BOOL removeFromSuperViewOnHide;

@property (OrzOSDK_STRONG) UIFont* labelFont;

@property (OrzOSDK_STRONG) UIColor* labelColor;

@property (OrzOSDK_STRONG) UIFont* detailsLabelFont;

@property (OrzOSDK_STRONG) UIColor* detailsLabelColor;

@property (assign) float progress;

@property (assign) CGSize minSize;

@property (assign, getter = isSquare) BOOL square;

@end


@protocol OrzOSDKProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(OrzOSDKProgressHUD *)hud;

@end

@interface OrzOSDKRoundProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, OrzOSDK_STRONG) UIColor *OrzOSDKMyprogressTintColor;

@property (nonatomic, OrzOSDK_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end

@interface OrzOSDKBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, OrzOSDK_STRONG) UIColor *lineColor;

@property (nonatomic, OrzOSDK_STRONG) UIColor *OrzOSDKMyprogressRemainingColor;

@property (nonatomic, OrzOSDK_STRONG) UIColor *OrzOSDKMyprogressColor;

@end
