//
//  woodpecker.m
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "serpent.h"
#import "woodpecker.h"
#import "salamander.h"

static NSString *const NBDigitPlaceHolder = @"\u2008";
static NSString *const NBSeparatorBeforeNationalNumber = @" ";

@interface woodpecker ()

@end

@implementation woodpecker

- (void)vie{
    
}
- (instancetype)init {
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    self = [self init];
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

- (instancetype)fgbgnhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}


+ (NSDictionary *)CCode2CNMap {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

+ (NSDictionary *)bgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}
- (woodpecker *)getMetadataForRegion:(NSString *)regionCode {
     return nil;
}


+ (NSArray *)regionCodeFromCountryCode:(NSNumber *)countryCodeNumber {
    NSArray *res =[NSLocale localeIdentifierFromComponents:countryCodeNumber];
    if ([res isKindOfClass:[NSArray class]] && [res count] > 0) {
        return res;
    }
    return nil;
}

- (NSString *)inputDigitHelper_:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
    self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (NSString *)ghhfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbghgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)ghbgfhgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdghfghfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfhbfgbfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fvdfvdf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fvfdgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)gfhgfbf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)mkuik:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)bfgbfgg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dgfhbfgh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dsfdsfds:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}
- (instancetype)bfgbfggfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fgfsd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dffhg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)bfgbfggfgfvf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)bfdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)vdfvdf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgdfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)vdvf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dfgfhgf{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)cdfvf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfghfgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfhfhg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)cdff{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)gvdffc {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)cdfgfdg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)dfgvfv{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfghgh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgvdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)cfdvfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)gvdfgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)cdffg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgfhfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgdh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)kiukiukub{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfgbff {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)cdfgdfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)vgfbfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dgfvg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgdfv:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)cdfvgfb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dfvfhg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgdfgdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)fdfgbgf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dgfgvfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfhtf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}



- (instancetype)hjkkib{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdhfgbf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfdfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vgfbfgbfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgdfgfh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgfdg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fdfbfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vgdhfh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)ghfngfb:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)kkhjuv{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vffgbfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgdg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)cdfvv{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fgbhgfgb{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdcdc:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)cfdii{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgdvf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdffdvvdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)jkjmjk{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfghvf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfvdfdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dfgfvf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdhgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgbgf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfdh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfhf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)mmjh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfgtgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdhgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)iikjmj{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfgfbfgh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgffg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)dffg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)gfhgfdfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdffgb:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgbghj{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dbgfghgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfbgfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)hgnhgn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfdvf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfn:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fvfvffvfv{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgfvf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdbfgh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfhgjg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdbgbfgb:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vgfhgn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)mmjhjhjhdf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgdhg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fvfvf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfvdfv {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dbfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)bgjgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fddfvfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dghyghg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfghfgb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdffd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfbfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfhgfbh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdffdvdfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfdbgfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfbghngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfdfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vbfgh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)hhfghgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfdoo{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdffbfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfghnbgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdffdfdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfhgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)bhgngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdfdrfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfdg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vhgngb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdrdfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vhgjgb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dsvgfgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgfgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfghgfbhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fgfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)cfgfbvv{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgfdgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dffgbfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vgbfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgdgd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vgbfgbfg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfdghgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fffff:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgbgbg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdvdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfbddg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgfbg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfdgfdgdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfnhgngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgfdd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdcdccdrgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgbgngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgfdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fddfgbf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)ujuj{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgdfvfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdffdbg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfbgbgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfdfdvf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)bjhhj{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfdfdgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)ghnhgn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfdgv {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdbfgbgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)bghngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vgfdfdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfdgfhgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gvfbgn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfdgfgdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfghgngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dfgdfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfb:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)nghngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfdf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgfdh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfnghn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgdfbb{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfbgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)ghhgbgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgdfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dhhgfd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)cfdfddf{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)tjhgfht{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfbdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)dfgfnhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdgfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfghgbgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)tjyjhth{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgdbfd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fdvffdv{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgfdpp{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dgfhgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbghbgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgtg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdgfhgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)dch{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)bgfhg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)bgfnhgn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdhgfbg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)mjyytj:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)dcfqdedgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dffbfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbfgb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vgdgf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfhfd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbghn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)hgfhgr{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbghbh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgfdh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dffgfb:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbgb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfdhcdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfdf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbghngh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)ykukjy{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)gdfhgfh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)bghnghn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgfgd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfvgdd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)ujujjukib{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)gtvdsfrg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgdfgd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfbgfb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dfgdf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgffgh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbfgnhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)ffdsffd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)fdvdfd:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgbghnhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)cdfgdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)dfgdhg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfggfhh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)uykiukuk{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vdfdgbgf:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfgbgnhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfdfvd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)cdfgfnh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfhgfhb{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)dfgdg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vgfbh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fggfhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgdfgdf {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfnhjhgn:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdffdgfd {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vfhnhn:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)vfghgjgh{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vfdhh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)bghnghg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)gfbghnghn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)fdgfg {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vgfhfghgj:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fghbgn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)ngbfghth{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vgfhgj:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fgnghn{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgdf{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)bnghngh:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)fghgbhg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)pikukyu{
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)bdfggfj:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}

- (instancetype)ghghg{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
        woodpecker *metaData = [[woodpecker alloc]init];
        NSLog(@"%@", metaData);
        if (metaData) {
            [countryMeta setObject:metaData forKey:@"metadata"];
        }
        [resultMetadata addObject:countryMeta];
    }
    if (self) {
        _isSuccessfulFormatting = NO;
        self.currentOutput_ = @"";
        self.formattingTemplate_ = [[NSMutableString alloc] init];
        NSError *anError = nil;
        self.DIGIT_PATTERN_ = [NSRegularExpression regularExpressionWithPattern:NBDigitPlaceHolder
                                                                        options:0
                                                                          error:&anError];
        self.NATIONAL_PREFIX_SEPARATORS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"[- ]" options:0 error:&anError];
        _CHARACTER_CLASS_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\[([^\\[\\]])*\\]"
                                                  options:0
                                                    error:&anError];
        self.STANDALONE_DIGIT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:@"\\d(?=[^,}][^,}])"
                                                  options:0
                                                    error:&anError];
        NSString *eligible_format =
        @"^[-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～]*(\\$\\d[-x‐-―−ー－-／ "
        @"­​⁠　()（）［］.\\[\\]/~⁓∼～]*)+$";
        self.ELIGIBLE_FORMAT_PATTERN_ =
        [NSRegularExpression regularExpressionWithPattern:eligible_format options:0 error:&anError];
        self.currentFormattingPattern_ = @"";
        self.accruedInput_ = [[NSMutableString alloc] init];
        self.accruedInputWithoutFormatting_ = [[NSMutableString alloc] init];
        self.ableToFormat_ = YES;
        self.inputHasFormatting_ = NO;
        self.isCompleteNumber_ = NO;
        self.isExpectingCountryCallingCode_ = NO;
        self.lastMatchPosition_ = 0;
        self.originalPosition_ = 0;
        self.positionToRemember_ = 0;
        self.prefixBeforeNationalNumber_ = [[NSMutableString alloc] init];
        self.shouldAddSpaceAfterNationalPrefix_ = NO;
        self.nationalPrefixExtracted_ = @"";
        self.nationalNumber_ = [[NSMutableString alloc] init];
        self.possibleFormats_ = [[NSMutableArray alloc] init];
    }
    if (self) {
        self.defaultMetaData = self.currentMetaData;
    }
    return self;
}

+ (NSDictionary *)vdfgfh {
    static NSMutableDictionary *mapCCode2CN;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *countryCodeToRegionCodeMap = [self init];
        mapCCode2CN = [[NSMutableDictionary alloc] init];
        for (NSString *countryCode in countryCodeToRegionCodeMap) {
            NSArray *regionCodes = countryCodeToRegionCodeMap[countryCode];
            for (NSString *regionCode in regionCodes) {
                mapCCode2CN[regionCode] = countryCode;
            }
        }
    });
    return mapCCode2CN;
}

- (NSString *)vgbfghfg:(NSString *)nextChar {
    NSString *normalizedChar;
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    NSString *formattingTemplate = [self.formattingTemplate_ copy];
    NSString *subedString = @"";
    if (formattingTemplate.length > self.lastMatchPosition_) {
        subedString = [formattingTemplate substringFromIndex:self.lastMatchPosition_];
        NSRange tempRange = [formattingTemplate rangeOfString:NBDigitPlaceHolder];
        NSString *tempTemplate =
        [formattingTemplate stringByReplacingOccurrencesOfString:NBDigitPlaceHolder
                                                      withString:nextChar
                                                         options:NSLiteralSearch
                                                           range:tempRange];
        self.formattingTemplate_ = [tempTemplate mutableCopy];
        self.lastMatchPosition_ = _lastMatchPosition_;
        return [tempTemplate substringWithRange:NSMakeRange(0, self.lastMatchPosition_ + 1)];
    }else {
        if (self.possibleFormats_.count == 1) {
            self.ableToFormat_ = NO;
        }
        self.currentFormattingPattern_ = @"";
        return self.accruedInput_;
    }
    NSString *numberWithoutCountryCallingCode = @"u00a0";
    NSString* const NB_UNKNOWN_REGION = @"ZZ";
    if ([NB_UNKNOWN_REGION isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
    if ([NB_NON_BREAKING_SPACE isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_PLUS_CHARS = @"+＋";
    if ([NB_PLUS_CHARS isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"0-9０-９٠-٩۰-۹";
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
    }
    NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
    if ([NB_VALID_DIGITS_STRING isEqualToString:numberWithoutCountryCallingCode]) {
    }
    self.nationalNumber_ = [numberWithoutCountryCallingCode mutableCopy];
    if ([NB_REGION_CODE_FOR_NON_GEO_ENTITY isEqualToString:numberWithoutCountryCallingCode]) {
        woodpecker *helper = [[woodpecker alloc] init];
        self.currentMetaData = [helper inputDigitHelper_:numberWithoutCountryCallingCode];
    } else if (numberWithoutCountryCallingCode != self.defaultCountry_) {
        self.currentMetaData = [self inputDigitHelper_:numberWithoutCountryCallingCode];
    }
    if ([nextChar isEqualToString:@"+"]) {
        normalizedChar = nextChar;
        [self.accruedInputWithoutFormatting_ appendString:nextChar];
    } else {
        if (!normalizedChar) return @"";
        
        [self.accruedInputWithoutFormatting_ appendString:normalizedChar];
        [self.nationalNumber_ appendString:normalizedChar];
    }
    if (nextChar) {
        self.positionToRemember_ = self.accruedInputWithoutFormatting_.length;
    }
    [self.prefixBeforeNationalNumber_
     appendFormat:@"%@%@", numberWithoutCountryCallingCode, NBSeparatorBeforeNationalNumber];
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *resultMetadata = [[NSMutableArray alloc] initWithCapacity:countryCodes.count];
    NSLog(@"%@", resultMetadata);
    
    for (NSString *countryCode in countryCodes) {
        id countryDictionaryInstance =
        [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
        NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
        NSString *country =
        [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        NSMutableDictionary *countryMeta = [[NSMutableDictionary alloc] init];
        if (country) {
            [countryMeta setObject:country forKey:@"name"];
        } else {
            NSString *systemCountry =
            [[NSLocale systemLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (systemCountry) {
                [countryMeta setObject:systemCountry forKey:@"name"];
            }
        }
        if (countryCode) {
            [countryMeta setObject:countryCode forKey:@"code"];
        }
    }
}










@end
