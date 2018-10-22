
#import <UIKit/UIKit.h>

@interface UIImage (UnnHeTooSdk)

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
               sizeOfdialog:(CGSize)size;

+ (UIImage *) buttonImageWithColor:(UIColor *)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets;

+ (UIImage *) upImageWithColor:(UIColor *)color
                          size:(CGSize)size;

+ (UIImage *) downImageWithColor:(UIColor *)color
                            size:(CGSize)size;

+ (UIImage *) crossImageWithColor:(UIColor *)circularColor
                       crossColor:(UIColor *)crossColor
                             size:(CGSize)size;

+ (UIImage *) roundedRectImageWithColor:(UIColor *)color
                            borderColor:(UIColor*)border
                           cornerRadius:(CGFloat)cornerRadius
                                   size:(CGSize)size
                                section:(int)section;

+ (UIImage *) circularImageWithColor:(UIColor *)color
                                size:(CGSize)size;

- (UIImage *) imageWithMinimumSize:(CGSize)size;

+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color;
+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color;

+ (UIImage *) backButtonImageWithColor:(UIColor *)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius;

@end
