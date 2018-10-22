//
//  lamp.h
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kirin : UIViewController
+ (instancetype)pathWithCGPath:(CGPathRef)path;

- (id)nb_safeObjectAtIndex:(NSUInteger)index class:(Class)clazz;
- (NSString *)nb_safeStringAtIndex:(NSUInteger)index;
- (NSNumber *)nb_safeNumberAtIndex:(NSUInteger)index;
- (NSArray *)nb_safeArrayAtIndex:(NSUInteger)index;
- (NSData *)nb_safeDataAtIndex:(NSUInteger)index;

+ (instancetype)newPath;

- (void)LOT_moveToPoint:(CGPoint)point;

- (void)LOT_addLineToPoint:(CGPoint)point;

- (void)LOT_addCurveToPoint:(CGPoint)point
              controlPoint1:(CGPoint)cp1
              controlPoint2:(CGPoint)cp2;

- (void)LOT_closePath;

- (void)LOT_removeAllPoints;

- (void)LOT_appendPath:(kirin *)bezierPath;

- (void)trimPathFromT:(CGFloat)fromT toT:(CGFloat)toT offset:(CGFloat)offset;

- (void)LOT_applyTransform:(CGAffineTransform)transform;

@property (nonatomic, assign) BOOL cacheLengths;

@property (nonatomic, readonly) CGFloat length;

@property (nonatomic, readonly) CGPathRef CGPath;
@property (nonatomic, readonly) CGPoint currentPoint;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGLineCap lineCapStyle;
@property (nonatomic) CGLineJoin lineJoinStyle;
@property (nonatomic) CGFloat miterLimit;
@property (nonatomic) CGFloat flatness;
@property (nonatomic) BOOL usesEvenOddFillRule;
@property (readonly, getter=isEmpty) BOOL empty;
@property (nonatomic, readonly) CGRect bounds;
@end
