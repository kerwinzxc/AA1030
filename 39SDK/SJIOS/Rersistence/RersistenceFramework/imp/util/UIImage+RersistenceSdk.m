
#import "UIImage+RersistenceSdk.h"

@implementation UIImage (RersistenceSdk)

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
               sizeOfdialog:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *) buttonImageWithColor:(UIColor *)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets {
    
    //设置上下背景
    UIImage *topImage = [self imageWithColor:color cornerRadius:cornerRadius];
    UIImage *bottomImage = [self imageWithColor:shadowColor cornerRadius:cornerRadius];
    
    CGFloat totalHeight = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.top + shadowInsets.bottom;
    CGFloat totalWidth = edgeSizeFromCornerRadius(cornerRadius) + shadowInsets.left + shadowInsets.right;
    
    CGFloat topWidth = edgeSizeFromCornerRadius(cornerRadius);
    CGFloat topHeight = edgeSizeFromCornerRadius(cornerRadius);
    
    CGRect topRect = CGRectMake(shadowInsets.left, shadowInsets.top, topWidth, topHeight);
    CGRect bottomRect = CGRectMake(0, 0, totalWidth, totalHeight);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(totalWidth, totalHeight), NO, 0.0f);
    if (!CGRectEqualToRect(bottomRect, topRect)) {
        [bottomImage drawInRect:bottomRect];
    }
    [topImage drawInRect:topRect];
    UIImage *buttonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIEdgeInsets resizeableInsets = UIEdgeInsetsMake(cornerRadius + shadowInsets.top,
                                                     cornerRadius + shadowInsets.left,
                                                     cornerRadius + shadowInsets.bottom,
                                                     cornerRadius + shadowInsets.right);
    return [buttonImage resizableImageWithCapInsets:resizeableInsets];
    
}

+ (UIImage *)upImageWithColor:(UIColor *)color
                          size:(CGSize)size
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width * 0.5, size.height * 0.25)];
    [path addLineToPoint:CGPointMake(size.width * 0.25, size.height * 0.75)];
    [path addLineToPoint:CGPointMake(size.width * 0.75, size.height * 0.75)];
    path.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [path addClip];
    [path fill];
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) downImageWithColor:(UIColor *)color
                            size:(CGSize)size
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width * 0.5, size.height * 0.75)];
    [path addLineToPoint:CGPointMake(size.width * 0.25, size.height * 0.25)];
    [path addLineToPoint:CGPointMake(size.width * 0.75, size.height * 0.25)];
    path.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [path addClip];
    [path fill];
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) crossImageWithColor:(UIColor *)circularColor
                       crossColor:(UIColor *)crossColor
                             size:(CGSize)size
{
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(size.width * 0.25, size.height * 0.25, size.width * 0.5, size.height * 0.5)];
    path.lineWidth = 0;
    
    UIBezierPath * cross = [UIBezierPath bezierPath];
    cross.lineWidth = 0;
    [cross moveToPoint:CGPointMake(size.width * 0.37, size.height * 0.41)];
    [cross addLineToPoint:CGPointMake(size.width * 0.41, size.height * 0.37)];
    [cross addLineToPoint:CGPointMake(size.width * 0.5, size.height * 0.46)];
    [cross addLineToPoint:CGPointMake(size.width * 0.59, size.height * 0.37)];
    [cross addLineToPoint:CGPointMake(size.width * 0.63, size.height * 0.41)];
    [cross addLineToPoint:CGPointMake(size.width * 0.54, size.height * 0.5)];
    [cross addLineToPoint:CGPointMake(size.width * 0.63, size.height * 0.59)];
    [cross addLineToPoint:CGPointMake(size.width * 0.59, size.height * 0.63)];
    [cross addLineToPoint:CGPointMake(size.width * 0.5, size.height * 0.54)];
    [cross addLineToPoint:CGPointMake(size.width * 0.41, size.height * 0.63)];
    [cross addLineToPoint:CGPointMake(size.width * 0.37, size.height * 0.59)];
    [cross addLineToPoint:CGPointMake(size.width * 0.46, size.height * 0.5)];
    [cross closePath];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [circularColor setFill];
    [circularColor setStroke];
    [path addClip];
    [path fill];
    [path stroke];
    [crossColor setFill];
    [crossColor setStroke];
    [cross addClip];
    [cross fill];
    [cross stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) roundedRectImageWithColor:(UIColor *)color
                            borderColor:(UIColor*)border
                           cornerRadius:(CGFloat)cornerRadius
                                   size:(CGSize)size
                                section:(int)section
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    CGFloat height = size.height / (CGFloat)section;
    for (int i = 0; i < section - 1; ++i) {
        [roundedRect moveToPoint:CGPointMake(0, height)];
        [roundedRect addLineToPoint:CGPointMake(size.width, height)];
        height += size.height / (CGFloat)section;
    }
    roundedRect.lineWidth = 0.5f;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [border setStroke];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *) circularImageWithColor:(UIColor *)color
                                size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [color setStroke];
    [circle addClip];
    [circle fill];
    [circle stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *) imageWithMinimumSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
    [self drawInRect:rect];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    return [resized resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, size.width/2, size.height/2, size.width/2)];
}

+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color {
    CGFloat iconEdgeSize = 15;
    CGFloat iconInternalEdgeSize = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(iconEdgeSize, iconEdgeSize), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGFloat padding = (iconEdgeSize - iconInternalEdgeSize) / 2;
    CGContextFillRect(context, CGRectMake(padding, 0, iconInternalEdgeSize, iconEdgeSize));
    CGContextFillRect(context, CGRectMake(0, padding, iconEdgeSize, iconInternalEdgeSize));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color {
    CGFloat iconEdgeSize = 15;
    CGFloat iconInternalEdgeSize = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(iconEdgeSize, iconEdgeSize), NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGFloat padding = (iconEdgeSize - iconInternalEdgeSize) / 2;
    CGContextFillRect(context, CGRectMake(0, padding, iconEdgeSize, iconInternalEdgeSize));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) backButtonImageWithColor:(UIColor *)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius {
    
    CGSize size;
    if (metrics == UIBarMetricsDefault) {
        size = CGSizeMake(50, 30);
    }
    else {
        size = CGSizeMake(60, 23);
    }
    UIBezierPath *path = [self bezierPathForBackButtonInRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [path addClip];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, 15, cornerRadius, cornerRadius)];
    
}

+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect cornerRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint mPoint = CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y);
    CGPoint ctrlPoint = mPoint;
    [path moveToPoint:mPoint];
    
    ctrlPoint.y += radius;
    mPoint.x += radius;
    mPoint.y += radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:M_PI + M_PI_2 endAngle:0 clockwise:YES];
    
    mPoint.y = CGRectGetMaxY(rect) - radius;
    [path addLineToPoint:mPoint];
    
    ctrlPoint = mPoint;
    mPoint.y += radius;
    mPoint.x -= radius;
    ctrlPoint.x -= radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    mPoint.x = rect.origin.x + (10.0f);
    [path addLineToPoint:mPoint];
    
    [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMidY(rect))];
    
    mPoint.y = rect.origin.y;
    [path addLineToPoint:mPoint];
    
    [path closePath];
    return path;
}

@end
