//
//  whitebird.m
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "whitebird.h"
#import "blackcat.h"
#import "ratsmice.h"
#import "kirin.h"
@interface whitebird ()

@end

@implementation whitebird


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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
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
        _pathData = [[whitebird alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[whitebird alloc] initWithData:data];
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
            whitebird *key = [[whitebird alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        whitebird *key = [[whitebird alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalData = [data decodeObjectForKey:@"nationalData"];
    _possibleData = [data decodeObjectForKey:@"possibleData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalData forKey:@"nationalData"];
    [data encodeObject:self.possibleData forKey:@"possibleData"];
    whitebird *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalData isEqualToData:other.nationalData] &&
    [self.possibleData isEqualToData:other.possibleData];
}






@end
