//
//  repeatedly.h
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#if defined(ZLIB_CONST) && !defined(z_const)
#  define z_const const
#else
#  define z_const
#endif


@interface repeatedly : NSObject
- (instancetype)initWithKeyframe:(NSDictionary *)keyframe;
- (instancetype)initWithValue:(id)value;
- (void)remapValueWithBlock:(CGFloat (^)(CGFloat inValue))remapBlock;
- (repeatedly *)copyWithData:(id)data;

@property (nonatomic, readonly) NSNumber *keyframeTime;
@property (nonatomic, readonly) BOOL isHold;
@property (nonatomic, readonly) CGPoint inTangent;
@property (nonatomic, readonly) CGPoint outTangent;
@property (nonatomic, readonly) CGPoint spatialInTangent;
@property (nonatomic, readonly) CGPoint spatialOutTangent;

@property (nonatomic, readonly) CGFloat floatValue;
@property (nonatomic, readonly) CGPoint pointValue;
@property (nonatomic, readonly) CGSize sizeValue;
@property (nonatomic, readonly) UIColor *colorValue;
@property (nonatomic, readonly, nullable) repeatedly *pathData;
@property (nonatomic, readonly) NSArray *arrayValue;
@property (nonatomic, readonly) NSArray<repeatedly *> *keyframes;

/*  2 */ @property(nonatomic, strong, readonly) NSString *nationalNumberPattern;
/*  3 */ @property(nonatomic, strong, readonly) NSString *possibleNumberPattern;
/*  9 */ @property(nonatomic, strong, readonly) NSArray<NSNumber *> *possibleLength;
/* 10 */ @property(nonatomic, strong, readonly) NSArray<NSNumber *> *possibleLengthLocalOnly;
/*  6 */ @property(nonatomic, strong, readonly) NSString *exampleNumber;
/*  7 */ @property(nonatomic, strong, readonly) NSData *nationalNumberMatcherData;
/*  8 */ @property(nonatomic, strong, readonly) NSData *possibleNumberMatcherData;

- (instancetype)initWithEntry:(NSArray *)entry;

@end
