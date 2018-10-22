

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSBase.h>
#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSContextRef.h>
#import <JavaScriptCore/JSValue.h>
#import <JavaScriptCore/WebKitAvailability.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@protocol PostinProgressHUDDelegate;


typedef enum {
	
	PostinProgressHUDModeIndeterminate,
	
	PostinProgressHUDModeDeterminate,
	
	PostinProgressHUDModeDeterminateHorizontalBar,
	
	PostinProgressHUDModeAnnularDeterminate,
	
	PostinProgressHUDModeCustomView,
	
	PostinProgressHUDModeText
} PostinProgressHUDMode;

typedef enum {
	
	PostinProgressHUDAnimationFade,
	PostinProgressHUDAnimationZoom,
	PostinProgressHUDAnimationZoomOut = PostinProgressHUDAnimationZoom,
	PostinProgressHUDAnimationZoomIn
} PostinProgressHUDAnimation;


#ifndef MB_INSTANCETYPE
#if __has_feature(objc_instancetype)
	#define MB_INSTANCETYPE instancetype
#else
	#define MB_INSTANCETYPE id
#endif
#endif

#ifndef MB_STRONG
#if __has_feature(objc_arc)
	#define MB_STRONG strong
#else
	#define MB_STRONG retain
#endif
#endif

#ifndef MB_WEAK
#if __has_feature(objc_arc_weak)
	#define MB_WEAK weak
#elif __has_feature(objc_arc)
	#define MB_WEAK unsafe_unretained
#else
	#define MB_WEAK assign
#endif
#endif

#if NS_BLOCKS_AVAILABLE
typedef void (^PostinProgressHUDCompletionBlock)();
#endif



@interface PostinProgressHUD : UIView


+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;


+ (MB_INSTANCETYPE)HUDForView:(UIView *)view;

+ (NSArray *)allHUDsForView:(UIView *)view;


- (id)initWithWindow:(UIWindow *)window;

- (id)initWithView:(UIView *)view;


- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

#if NS_BLOCKS_AVAILABLE


- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block successCallback:(PostinProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
		  successCallback:(PostinProgressHUDCompletionBlock)completion;

@property (copy) PostinProgressHUDCompletionBlock successCallback;

#endif

@property (assign) PostinProgressHUDMode mode;

@property (assign) PostinProgressHUDAnimation animationType;


@property (MB_STRONG) UIView *customView;


@property (MB_WEAK) id<PostinProgressHUDDelegate> delegate;


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;


@property (assign) float opacity;


@property (MB_STRONG) UIColor *color;


@property (assign) float xOffset;

@property (assign) float yOffset;


@property (assign) float margin;

@property (assign) float cornerRadius;


@property (assign) BOOL dimBackground;


@property (assign) float graceTime;


@property (assign) float minShowTime;


@property (assign) BOOL taskInProgress;


@property (assign) BOOL removeFromSuperViewOnHide;

@property (MB_STRONG) UIFont* labelFont;


@property (MB_STRONG) UIColor* labelColor;


@property (MB_STRONG) UIFont* detailsLabelFont;

@property (MB_STRONG) UIColor* detailsLabelColor;

@property (assign) float progress;


@property (assign) CGSize minSize;

@property (assign, getter = isSquare) BOOL square;

@end


@protocol PostinProgressHUDDelegate <NSObject>

@optional

- (void)hudWasHidden:(PostinProgressHUD *)hud;

@end

@interface MBRoundProgressView : UIView 


@property (nonatomic, assign) float progress;

@property (nonatomic, MB_STRONG) UIColor *progressTintColor;

@property (nonatomic, MB_STRONG) UIColor *backgroundTintColor;

@property (nonatomic, assign, getter = isAnnular) BOOL annular;

@end


@interface MBBarProgressView : UIView

@property (nonatomic, assign) float progress;

@property (nonatomic, MB_STRONG) UIColor *lineColor;

@property (nonatomic, MB_STRONG) UIColor *progressRemainingColor;


@property (nonatomic, MB_STRONG) UIColor *progressColor;

@end
