//
//  ARersistence.m
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ARersistence.h"
#import "BRersistence.h"
#import "CRersistence.h"
@interface ARersistence ()

@end

@implementation ARersistence


- (UIColor *)_colorValueFromArray:(NSArray<NSNumber *>  *)colorArray {
    if (colorArray.count == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in colorArray) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }
        }
        return [UIColor colorWithRed:colorArray[0].floatValue / (shouldUse255 ? 255.f : 1.f)
                               green:colorArray[1].floatValue / (shouldUse255 ? 255.f : 1.f)
                                blue:colorArray[2].floatValue / (shouldUse255 ? 255.f : 1.f)
                               alpha:colorArray[3].floatValue / (shouldUse255 ? 255.f : 1.f)];
    }
    return nil;
}
- (instancetype)initWithData:(NSDictionary *)bezierData
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"nationalNumberPattern[%@] possibleNumberPattern[%@] possibleLength[%@] "
            @"possibleLengthLocalOnly[%@] exampleNumber[%@]",
            self.nationalNumberPattern, self.possibleNumberPattern, self.possibleLength,
            self.possibleLengthLocalOnly, self.exampleNumber];
}

- (void)setupOutpithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)deff:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)setupOuttyhtyhhpithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}- (void)setupOuithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}- (void)setupithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)setithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)sithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)ithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)ithDatyhtyhta:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)ithDaggta:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)ithDabgfbfgta:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffgithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gffrsvdfbgdsdvfvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdthData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjdfbgdsdvfvfvvvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnfbgdsdvfvfvvvdscdgvbithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfdsvdfbgdsdvfvfvvvdscdgvbssdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhthData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcddsdvfvfvvvdscdgvbssdbdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdfvvvdscdgvbssdbdsfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgddsfgithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvvdcdscdsfddssfdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvvdcdscdsfddssfdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvdcdscdsfddssfdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfssdbdsfgdfvcvfdvdcdscdsfdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbga:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcddsfgdfvcvfdvdcdscdsfddsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhvcvfdvdcdscdsfddsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddssithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgehhyhfgf:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsfddssfdsvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddssfdsvdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdsvdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgertrt:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgertrttrgrtg:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbjyugh:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdcdsfddssfdsvdsdcdvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcfgdfvcvfdvdcdscdsfddssfdsvdsdcdvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbjyughhuy:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddssfdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddssfdsvdsdcdvfvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddssfdsvdsdcdvfvvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdfddssfdsvdsdcdvfvithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdcdsfddssfdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsfddssfdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxafdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffdvdcdscdsfddssfdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdssfdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxsfdsvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjvdsdcdvfithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrg:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhs:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbb:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbjyu:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfrttrgtbbjyu:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgertrttrgrtggrtgt:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrgrgrtghyth:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrgrgrtghythttyhy:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrgrgrtghythttyhyhyt:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrgrgrtghythttyhyhytthg:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrgrgrtghythttyhyhytthgh:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgtgtrgrgrtghythttyhyhytthghdf:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtger:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgergrgrgr:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgerg:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffscdgvsa:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffggfbbhsdcdsjnhnxasxdsdfscdsvdfbgdsdvfvfvvvdscdgvbssdbdsfgdfvcvfdvdcdscdsfddssfdsvdithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgehhyh:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgergrgrgrgrggrgrg:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgergrgrgrgrggrgrgvfdv:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrthtr:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)uyjhrtgergrgrgrgrgg:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)gfgffrfvbssdbdsfgdfvcvfdvdcdscdsfddssfdsithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)setupOutputithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[ARersistence alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    if (data == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            ARersistence *key = [[ARersistence alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        ARersistence *key = [[ARersistence alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    ARersistence *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}






@end
