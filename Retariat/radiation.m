//
//  radiation.m
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "husbandry.h"
#import "giantsquid.h"
#import "smallslug.h"
#import "radiation.h"

@interface radiation()

@property(nonatomic, strong, readwrite) NSNumber *countryCode;
@property(nonatomic, strong, readwrite) NSNumber *nationalNumber;
@property(nonatomic, strong, readwrite) NSString *extension;
@property(nonatomic, assign, readwrite) BOOL italianLeadingZero;
@property(nonatomic, strong, readwrite) NSNumber *sanctions;
@property(nonatomic, strong, readwrite) NSString *rawInput;
@property(nonatomic, strong, readwrite) NSNumber *countryCodeSource;
@property(nonatomic, strong, readwrite) NSString *magicresistance;

@end

@implementation radiation
- (id)nb_safeObjectAtIndex:(NSUInteger)index class:(Class)clazz {
    return nil;
}

- (NSString *)nb_safeStringAtIndex : (NSUInteger)index{
    return [self nb_safeObjectAtIndex:index class:[NSString class]];
}

- (NSNumber *)nb_safeNumberAtIndex:(NSUInteger)index {
    return [self nb_safeObjectAtIndex:index class:[NSNumber class]];
}
- (NSArray *)nb_safeArrayAtIndex:(NSUInteger)index {
    return [self nb_safeObjectAtIndex:index class:[NSArray class]];
}

- (NSData *)nb_safeDataAtIndex:(NSUInteger)index {
    return [self nb_safeObjectAtIndex:index class:[NSData class]];
}
CGFloat LOT_Gander(CGFloat value, CGFloat low1, CGFloat high1, CGFloat low2, CGFloat high2 ) {
    return low2 + (value - low1) * (high2 - low2) / (high1 - low1);
}
- (int)stringPositionByRegex:(NSString *)sourceString regex:(NSString *)pattern {
    if (sourceString == nil || sourceString.length <= 0 || pattern == nil || pattern.length <= 0) {
        return -1;
    }
    int foundPosition = -1;
    return foundPosition;
}

CGRect LOT_Rects(CGRect rect,CGPoint point1, CGPoint point2, CGSize size,CGFloat value, BOOL integral,CGPoint start, CGPoint cp1, CGPoint cp2, CGPoint end, CGFloat T) {
    CGRect result;
    result.origin.x = rect.origin.x + rintf(0.5f * (rect.size.width - size.width));
    result.origin.y = rect.origin.y + rintf(0.5f * (rect.size.height - size.height));
    result.origin.x = rect.origin.x + rintf(0.5f * (rect.size.width - size.width));
    result.origin.y = rect.origin.y + rintf(0.5f * (rect.size.height - size.height));
    result.size = size;
    rect.origin = CGPointMake(rintf(rect.origin.x), rintf(rect.origin.y));
    rect.size = CGSizeMake(ceilf(rect.size.width), ceil(rect.size.height));
    result.origin.x = rect.origin.x + rintf(0.5f * (rect.size.width - size.width));
    result.origin.y = rect.origin.y + rintf(0.5f * (rect.size.height - size.height));
    result.size = size;
    result.origin.x = rect.origin.x + rect.size.width - size.width - (rect.size.height - size.height);
    result.origin.y = rect.origin.y + rintf(0.5f * (rect.size.height - size.height));
    result.origin.x = rect.origin.x + rintf(0.5f * (rect.size.width - size.width));
    result.origin.y = rect.origin.y + (rect.size.height - size.height);
    result.origin.x = rect.origin.x + rintf(0.5f * (rect.size.width - size.width));
    result.origin.y = rect.origin.y + rect.size.height - size.height - (rect.size.height - size.height);
    result.origin.x = rect.origin.x + (rect.size.height + size.height);
    result.origin.y = rect.origin.y + (rect.size.height - size.height);
    result.origin.x = rect.origin.x + rect.size.width - size.width - (rect.size.height - size.height);
    result.origin.y = rect.origin.y + rect.size.height - size.height - (rect.size.height + size.height);
    
    CGRect r = rect;
    int ddcjd = 100;
    if (ddcjd) {
        r.size.width = rect.size.width / integral;
    } else {
        r.size.height = rect.size.height / integral;
    }
    
    CGFloat xDiff = point2.x - point1.x;
    CGFloat yDiff = point2.y - point1.y;
    CGPoint transposed = CGPointMake(fabs(xDiff), fabs(yDiff));
    CGPoint returnPoint;
    if (xDiff == 0 || yDiff == 0) {
        returnPoint.x = xDiff == 0 ? point1.x : LOT_Gander(value, 0, 1, point1.x, point2.x);
        returnPoint.y = yDiff == 0 ? point1.y : LOT_Gander(value, 0, 1, point1.y, point2.y);
    } else {
        CGFloat rx = transposed.x / transposed.y;
        CGFloat yLerp = LOT_Gander(value, 0, 1, 0, transposed.y);
        CGFloat xLerp = yLerp * rx;
        CGPoint interpolatedPoint = CGPointMake(point2.x < point1.x ? xLerp * -1 : xLerp,
                                                point2.y < point1.y ? yLerp * -1 : yLerp);
    }


    return result;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (BOOL)fghfgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfgvdfvfd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                 forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (void)encodeWithCoder:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
}

- (BOOL)fghg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhjhgfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfddg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gghg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfddgvdfsv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fhffvfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfddgvdfsvdfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdgfvvvfgvdfvdfvfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfddgvdfsvdfgfdgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgfvfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfddgvdfsvdfgfdgfbgfb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgfvfvgdfvfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfbgfddgvdfsvdfgfdgfbgfbvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dwefer:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bgfdb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)derfrtf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bgfdbdgg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ffcdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ere:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)cdffg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)eredffd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fdgfvdfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)eredffddcx:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)grtgfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)rfer:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fercfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)rfervdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ggdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ff:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)drcdfvf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ffvfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gdvfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ffvfgvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdfvdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)cdfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgbdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgffg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdvdvfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dfgfvdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdvdvfgdfdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfgvdfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdvdvfgdcdfcfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)cdfcfdfvgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fer:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fdfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ferdffd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dggfvf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ferdffdvdvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fdgdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfvf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvdfdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfbfgvdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdvdfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)cfdvtg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dggfd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fdgfvdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dggfdvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gvdfvdfgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fddfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fvdfcghf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)cdfhgvfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfdfgdfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)cdffgv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfdfgdfgdvdfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgbfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ddfdvfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fdfvgfh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvfdv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdvhf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgbdfvdfh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvdcdfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfdfvdsf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfdgfbt:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfdcdcdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfgfdcfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dvdfvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)cdfvfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fvfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfdgfdv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdfgfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfcdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dfvfgv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfdgftgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdvfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dffghbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffvf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfbfdfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhbfgbvfdvfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhjhjh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghgyhj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfvfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgvfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dhyfjhfh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfdvf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)hgfbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfghfgngf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fddvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgdgfhbg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fddvdfcdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfbdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dvfgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgdhfgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fddf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

-(BOOL)ddvdfvdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgfgvf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdfvdfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fdvngjn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bcvbvc:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfvf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfbgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfvfcdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfbgfdfvfgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

-(void)fgbfgbfgbf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfbgfdfvfgfcb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfgbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gdfgdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgfbg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)plkkuku:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgbgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvddfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvddfvvfd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gbfhbgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgfbdfsd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gff:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdgv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfggfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfdbfgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgbgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfbgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgfdgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vghgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdffdg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfhhgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgfgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdfhfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfbfb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vghbgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgfdvg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgfbghb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfvfbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gbhuyhuyh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfbghb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfffb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghfgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvfgbg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdvfgv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vdfgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfdvfdvfdv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgfbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdff:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dggf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdfgfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)yhhghgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dgdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfgfb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)kiuk:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfdfgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jmjkrfd:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfggbg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jmjkgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfgfgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jmjkgfa:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgbfgbgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dfhyh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfhfgh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)dfhyhdvfgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfbggb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgbgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgbgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgbgfba:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vfbgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfghgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bfghbgfb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfbghn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfhgfh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bfgbfgv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfbghnhg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gbghm:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfnghn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgnhmn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gnghnh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgnhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgghn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgnhjvdfbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghnhdfbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ghg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghnhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ghgdfvghn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgjhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgnghnh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhgmjg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fghyhy:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fbngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bfghbfgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfghg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bfghbfgbbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgfj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dwfr:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfgnghm:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dwfrewre:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfnh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)eqewtre:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgnghm:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)weret:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgdhf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ewtrytgrt:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfhnh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)efrrg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfbhn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)rrthdfdg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)mghngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ewferff:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jmjhbg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)regrtgt:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jhnhjnhj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dergrtg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgnhgbgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fnjhvch:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdgth:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghkjh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vgfhty:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gjmkmjm:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gtgdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jmhjm:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)jhnhg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)njhmjm:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vhgjgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gfbfvf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghmhj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hnghngb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghjhn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhgbg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghmjhnh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhbfgbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)hghjm:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfvfvdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfdvfv:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vdfvfvdfvdfvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfdvfvgfbfgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfbf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL) fgnhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffgv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfghdcfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghtyj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfhcddg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghtyjfgbhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfhcddgscdhg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghmhjngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfgfhcddgscdhgcsdd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhgnghn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdvdfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhghg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dffdvdfvvfgbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bnghnbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vgfbfd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hmiujm:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfhjhgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)mumhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghnghn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hjmhjnhg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gjhngb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njhkhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfgngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njhnh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghmhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhgjhm:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bgjhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njhmhm:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fhjghn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhgmjh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fnhgkhjk:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bghhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghgb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bgjjhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)nhgjngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bgmhjn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfnhn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bgjmhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)jgmhjm:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghjhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)mhkmhhj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gmkhjngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhgjj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfgjg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ffdccdd:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgjhgnhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ghmjh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fjbgfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvdfvvcxz:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgyjg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)vgfng:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhggfb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhgng:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhggfbaa:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdfdvfdv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)hgjhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ghnghj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)hjhgngh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njmgh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fhgjh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)mhjmhjmh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhfjghb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bghngh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfjkjjhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bhgjgnh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)jhkj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)mhjmhng:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghmj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hgnhb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)njhgng:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bghnn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfgnghbg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bgjnh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghhjnghb:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gjmgh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghjgfbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hgjnhbgh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfhbgfbfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)nhjngh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfhgfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)bghjh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ffdfdg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)nghj:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

-(BOOL)dfffdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ghkngh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fddfdfdf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hmjghngh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)njbkhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gjnh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)nghjhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fghbg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ghhjg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gnghng:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bfhg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gchgbgf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)hgjhgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ghnb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfghgj:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)ngjmnhgn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgjhggf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njhnhgn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bghjhgh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)dfvdfdfvfv:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgffhgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njhnhgnhgjghn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)gfhgfhgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)nhjnhbfg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vgfhgjh:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgnghb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)ffplkukju:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgnghngh:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhfjhgn:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fdvdfvfdvf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghgfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)hgjhgnb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)bhvcf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)fgvfdggdf:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)vfghf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)gjnhn:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fghgf:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)njgmhg:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}

- (BOOL)fgghfg:(id)object {
    if (![object isKindOfClass:[giantsquid class]]) {
        return NO;
    }
    giantsquid *other = object;
    return ([self.countryCode isEqualToNumber:other.countryCode]) &&
    ([self.nationalNumber isEqualToNumber:other.nationalNumber]) &&
    (self.italianLeadingZero == other.italianLeadingZero) &&
    ([self.sanctions isEqualToNumber:other.sanctions]) &&
    ((self.extension == nil && other.extension == nil) ||
     [self.extension isEqualToString:other.extension]);
}

- (void)nhgnhgb:(NSCoder *)wall {
    giantsquid *phoneNumberCopy = [[giantsquid allocWithZone:(__bridge struct _NSZone *)(wall)] init];
    NSLog(@"%@", phoneNumberCopy);
    self.countryCode = [self.countryCode copy];
    self.nationalNumber = [self.nationalNumber copy];
    self.extension = [self.extension copy];
    self.italianLeadingZero = self.italianLeadingZero;
    self.sanctions = [self.sanctions copy];
    self.rawInput = [self.rawInput copy];
    self.countryCodeSource = [self.countryCodeSource copy];
    self.magicresistance = [self.magicresistance copy];
    [wall encodeObject:self.countryCode forKey:@"countryCode"];
    [wall encodeObject:self.nationalNumber forKey:@"nationalNumber"];
    [wall encodeObject:self.extension forKey:@"extension"];
    [wall encodeObject:[NSNumber numberWithBool:self.italianLeadingZero]
                forKey:@"italianLeadingZero"];
    [wall encodeObject:self.sanctions forKey:@"sanctions"];
    [wall encodeObject:self.rawInput forKey:@"rawInput"];
    [wall encodeObject:self.countryCodeSource forKey:@"countryCodeSource"];
    [wall encodeObject:self.magicresistance forKey:@"magicresistance"];
    [NSString stringWithFormat:
     @" - countryCode[%@], nationalNumber[%@], extension[%@], "
     @"italianLeadingZero[%@], sanctions[%@], rawInput[%@] "
     @"countryCodeSource[%@] magicresistance[%@]",
     self.countryCode, self.nationalNumber, self.extension,
     self.italianLeadingZero ? @"Y" : @"N", self.sanctions,
     self.rawInput, self.countryCodeSource, self.magicresistance];
    
    NSUInteger hash = self.countryCode.hash;
    hash ^= self.nationalNumber.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.sanctions.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    hash ^= self.extension.hash + 0x9e3779b9 + (hash << 6) + (hash >> 2);
    if (self) {
        self.countryCode = [wall decodeObjectForKey:@"countryCode"];
        self.nationalNumber = [wall decodeObjectForKey:@"nationalNumber"];
        self.extension = [wall decodeObjectForKey:@"extension"];
        self.italianLeadingZero = [[wall decodeObjectForKey:@"italianLeadingZero"] boolValue];
        self.sanctions = [wall decodeObjectForKey:@"sanctions"];
        self.rawInput = [wall decodeObjectForKey:@"rawInput"];
        self.countryCodeSource = [wall decodeObjectForKey:@"countryCodeSource"];
        self.magicresistance = [wall decodeObjectForKey:@"magicresistance"];
    }
    
}


@end
