//
//  carrying.m
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "carrying.h"
#import "broken.h"
#import "carrying.h"
#import "infinite.h"

@interface carrying ()

@property(nonatomic, strong) NSString *codeID;
@property(nonatomic, strong) NSString *countryCode;
@property(nonatomic, strong) NSString *internationalPrefix;
@property(nonatomic, strong) NSString *preferredInternationalPrefix;
@property(nonatomic, strong) NSString *nationalPrefix;
@property(nonatomic, strong) NSString *preferredExtnPrefix;
@property(nonatomic, strong) NSString *nationalPrefixForParsing;
@property(nonatomic, strong) NSString *nationalPrefixTransformRule;
@property(nonatomic, assign) BOOL sameMobileAndFixedLinePattern;
@property(nonatomic, strong) NSArray<NSNumberFormatter *> *numberFormats;
@property(nonatomic, strong) NSArray<NSNumberFormatter *> *intlNumberFormats;
@property(nonatomic, assign) BOOL mainCountryForCode;
@property(nonatomic, strong) NSString *leadingDigits;
@property(nonatomic, assign) BOOL leadingZeroPossible;
@end

@implementation carrying



- (CGColorSpaceModel)colorSpaceModel {
   return CGColorSpaceGetModel;
}

- (instancetype)initWithCoder:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)description {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}
- (instancetype)initWithPattern:(NSString *)pattern
                     withFormat:(NSString *)format
      withLeadingDigitsPatterns:(NSArray *)leadingDigitsPatterns
withNationalPrefixFormattingRule:(NSString *)nationalPrefixFormattingRule
                 whenFormatting:(BOOL)nationalmatting
withdomesticRule:(NSString *)domesticRule {
    self;
    if (self) {
        _pattern = pattern;
        _format = format;
        _leadingDigitsPatterns = leadingDigitsPatterns;
        _nationalPrefixFormattingRule = nationalPrefixFormattingRule;
        _nationalmatting = nationalmatting;
        _domesticRule = domesticRule;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                                        withFormat:self.format
                         withLeadingDigitsPatterns:self.leadingDigitsPatterns
                  withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                                    whenFormatting:self.nationalmatting
             withdomesticRule:self.domesticRule];
}

- (NSString *)fgg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)errr:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                 forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fgghbghn:(NSString *)pattern
                        withFormat:(NSString *)format
         withLeadingDigitsPatterns:(NSArray *)leadingDigitsPatterns
  withNationalPrefixFormattingRule:(NSString *)nationalPrefixFormattingRule
                    whenFormatting:(BOOL)nationalmatting
withdomesticRule:(NSString *)domesticRule {
    if (self) {
        _pattern = pattern;
        _format = format;
        _leadingDigitsPatterns = leadingDigitsPatterns;
        _nationalPrefixFormattingRule = nationalPrefixFormattingRule;
        _nationalmatting = nationalmatting;
        _domesticRule = domesticRule;
    }
    return self;
}
- (instancetype)fgghbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhhggcgjmjnmhjnjh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrhtqtrthqrg:(SEL)fdghcdgchd:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)reyhyrtg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)jjhgngh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}

- (instancetype)initWiewffrn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)desdfption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardingTafdstor:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frfdcdr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edfsdce:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWfn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descsdon {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergge:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)dfgb {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)jujhjh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fghgjnh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descrdfredeiption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardlector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ffvvrr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edefrfrde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWiedetrfrhPattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descrdrfrfedeiption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwarrelector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)dfgbfdfr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edefrfrfde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)iniattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descrdefrion {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardfetForSelector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frfccdcrfr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edeccde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)inithPattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)desfveiption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwoklector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frikifr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ekkikyde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWieiuykttern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descition {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardinictor:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ikiy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)euje:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWiuuytern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descyjtion {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardingtor:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frfrhhrrfr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ederhhe:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWrrtern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descrdrttion {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardingTargrctor:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frrr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edergde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWrgern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descrrption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardingTctor:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frfbgbgr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edebgbg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWfgfbdgrn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dedfgdption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardgelector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)grgrggr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ewfrfde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWiewfrn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descwfon {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardingwefctor:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)frwefr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ewefrde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initwfwattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)descwfreion {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardingwefrlector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fefefr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edefwede:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initWwefern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)deewfeffon {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardferfector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fwefrerfr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edewefde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)iniwefhPattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dfption {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forrfector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fwefwr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edwfwfe:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)iniwefttern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)desweftion {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forweflector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fwef {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)edewfde:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)initweftern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)desefrtion {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)forwardinweflector:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)dfgbhttr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)pjmjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fghgjnhfgn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhhggcgjmjnmhjnjhnhjmch {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ferggegtgr:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)gjyh {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bghh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fghgjnhfgnjmj:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)uykjujh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ferggegtgrdf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ghtgg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bghhtrg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ffdfdgddg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)vdfvdf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ferggeg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ghtggdgfbfgeq {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fdgrt:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ffdfdgddgv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)vdfvdffvsdfv {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)aefrf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ghtggdgfbfggdfbgfbeqg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fdgrtagr:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ffdfdgddgvdfvv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)vdfvdffvsdfvvfds {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)aefrffaef:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ghtggdgfbfggdfbgfbhreqgrdfr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ferf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ffdfdgddgvdfvvgvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)grg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)aefrffaefde:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abd {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ferfvfd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)frtgdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)grgdgbdfgb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)aefrffaefdecdcd:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abdb {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)dv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)frtgdftgdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggfh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)aefrffaefdecdcdd:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abgbgfbgdb {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)dvgrt:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)frtgdftgdffgtf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fggdfgdffvg{
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fgbfgbfg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abdbrf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)dvgfdvdfrt:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)frtgdftgdffgtfxcc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gvffvdf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fddvfdv:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abdbrff {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)dvgrtght:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)frtgdftgdffgtfxcccdc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gvffvdfdfgf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fddvfdvdfdfdf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abdbrffts {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)grdfd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cdcvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgytjhyth {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)vdfvdffrf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)abdbrfftsgt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)grdfdfreg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cdcvdfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgytjhythjt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fvdfdffrfccw:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)asgt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)vdcxv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cdcvdfvdfvvdfvdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgytjhythjtdhh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fdfdfddffrfccwtgt:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

-(NSString *)fvfvdfvdfvf{
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ferfrf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cdcvdfvdfvvdfvdffef:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgytjhythjtdhhstrg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fvfdffrfccwtgteds:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)asgtgre {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ferfrfcx:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)werew:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgbghb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fvffdffrfccwtgtedscgs:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)asgtgretgrtgfdg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)rgr:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)werewdsfse:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgbghbthth {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)dffrfccwtgtedscgsf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ht {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)rgrdfdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)werewdsfsefer:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jgbghbththhtr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)dffrfccwtgtedscgsfsdcdcg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hthyt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)efe:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)werewdsfsefergrt:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)htyh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)awhy:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hyjy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)efergrtgv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)wrer:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)htyherhgb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)awhyhf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hyjyrhg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)efergrtgvcd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)wrerfrgrt:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)htyherhgbwgr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)awhyhffgvf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hhhrgr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)refref:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)wrerfrgrtgrth:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)htyherhgbwgrbfgb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)awhyhffgvfsfdg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hhhrgrhyth {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)refrefcdfvd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)wrerfrgrtgrthdfdg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gfgfdg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)awhyhffgvfsfdgf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fefwed {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ertff:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fvdfc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gfgfdgddfvf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)awhyhffgvfsfdgfdg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fefwedfrfd {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)dcvfg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fvdfcbgf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gfgfdgddfvfgth {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrhrgr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)reffrf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ggfbv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gfgfdgddfvfgthsg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgs:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrhrgrrthtrh {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)reffrfdcd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ggfbvnghbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fdfdgfdg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgsdf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hthtg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)frtfdv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ggfbvnghbgvcbfg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fdfdgfdgyfb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgsdfgg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hthtgthh {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)frtfdvcdfvd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fdfdgfdgyfbghyh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgsdfggsfg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)kujuy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ere:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvdfvfdfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fhgtg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgsdfggsfgdvgb:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)kbt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ererfdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvdfvfdfgbbghb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fhgtghyhfd {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgsdfggsfgdvgbsdfg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)kbtgf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)ererfdffdfvdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvdfvfdfgbbghbvxf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fhgtghyhfdyt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtrgsdfggsfgdvgbsdfgsvb:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)kgrtytjht {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)refrff:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fhgtghyhfdytsdg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

-(NSString *)fgfdvdfvf{
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)refrffvdfvfg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvdfvgfb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhtyh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgert:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)grgrfe {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)rfrrfr:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvdfvgfbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhtyhegtyr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgertvfg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)grjyth {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)rfrrfrfth:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvdfvgfbghnbnb :(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhtyhegtyrhtrsfw {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgertvfgfrg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htgrg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)rfrrfrfthvfg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvdfvgfbghnbnbbgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhtyhegtyrhtrsfwr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgertvfgfrgwg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrgrt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)trgty:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fvfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhtyhegtyrhtrsfwrbyh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgertvfgfrgwgtgg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrn {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)trgtyfdv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fvfgbbfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhtyhegtyrhtrsfwrbyhsgdth {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgertvfgfrgwgtggg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrnde {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)juyjuj:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fvfgbbfgbbfgv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)nhgyh{
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahthgertvfgfrgwgtgggwggwfv:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrndehy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)juyjujbfgv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)fvfgbbfgbbfgvgbfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gggfbfg{
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujy:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fwefw {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)recdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
-(NSString *)fgdhgdh{
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyi:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)fwefwgrt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)recdfgt:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gfvdfvdvfhfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)grgrhhr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiiku:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)gfefe {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)recdfgtgh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gfvdfvdvfhfgbvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)tgtgffgf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiikuuku:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)gfefegrthr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)recdfgtghxcdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gfvdfvdvfhfgbvcbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dvdfv {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiikuukujn:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)grtgr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)recdfgtghxcdffdvf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvxvvcv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dvdfvvdfvg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiikuukujnuy:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrgrg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)xc:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvxvvcvvfbfg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dvdfvvdfvsfdg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiikuukujnuyhf:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)htrgrgergrt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)xcvvdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dfvxvvcvvfbfgfgbgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dvdfvvdfvsfdfghbtfh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiikuukujnuyhfy:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)httrg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)xcvvdfdd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)dvcvvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)dvdfvvdfvsfdffvghbtfhhyt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ahtujyiikuukujnuyhfyhuyju:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)httrghyhy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)xvfgv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvffgfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ghbtfhhytgfh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)art:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jiuk {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)xvfgvvdfb:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvffgfvbvn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggbg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)artrttgrt:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jiukkiuj {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bfgbc:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvffgfvbvnvcbvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggbgb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)artrttgrtgrgw:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jiukkiujiukuy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bfgbcvxc:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)vfvffgfvbvnvcbvcnbvm:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggbgbet {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jiujuy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fegrtg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvcbv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggbgbetfgh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hgfvg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jiujuyjyuj {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fegrtgvdfv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvcbvdfvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggbgbetfghrhty {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hgfvgdgg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)loikiu {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)vxvxv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvcbvdfvcngh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ggbgbetfghrhtydbfgb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hgfvgdgggh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)loukjy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)vxvxvvdfb:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hgfvgdggghsgh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)lohtyhy {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)gdvvdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvvbbgbgh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrtrtyhty {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hgfvgdggghsghs:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)lohtyhyyhty {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)gdvvdfvdfv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvvbbgbghnghngbcvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrtrtyhtyrhtyh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hhrth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)oukuyj {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fcdc:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvvbbgbghnghngbcvbbhgn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrtrtyhtyrhtyhnhrn {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hhrthegthwg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ou {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fcdcdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)cvvbbgbghnghngbcvbbhgnbn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrtrtyhtyrhtyhnhrngdrt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hhrthegthwgrgtr:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ouhtht {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fcdcdfvdfbg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ngbbfgbf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrtrtyhtyrhtyhnhrngdrtgfh {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hhrthegthwgrgtrhwg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ouhgf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fdvfdv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ngbbfgbfhnj:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)hrtrtyhtyrhtyhnhrngdrtgfhdgt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)hhrthegthwgrgtrhwgtgthyh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)oyhf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fdvfdvvdfv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hghngb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gdftrb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)ferg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)oyhhtf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fvdfv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hghngbcbvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gdftrbg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

-(id)gfggfdg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)oytht {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fvdfvbfgb:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hghngbcbvchnh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)fgbfgbfg{
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergrgtg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ot {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fvdfvbfgbbfgb:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hghngbcbvchnhxcbc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gdftrbgdb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergrgtgwg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)otytj {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)fvdfvbfgbbfgbxcv:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgfb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)gdftrbgdbgnghf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergrgtgwgggt:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)otytjjtuyj {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)vdfvd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgfbhnhjn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ghf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergrgtgwgggtw:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ogdgfdg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)vdfvdcdf:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgfbhnhjnfgbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ghfgdbdfb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

-(id)dfvdfv:(SEL)vdfvfdv:(NSZone *)zone{
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)rtger {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)eferg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgngb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ghfgdbdfbjhg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergrgtgwgggtwwgth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ruhuyth {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)eferggfd:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgngbcv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)ghfgdbdfbjhgdvdfg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fergrgtgwgggtwwgthsre:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)rutyht {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)kil:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgngbcvgg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)sfs {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejty:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)rythrt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)kilgn :(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgngbcvgggfhyg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)sfsfgt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

-(id)fgdfdfgf:(SEL)fgfdgfd:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)rythrthrtrt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)kilgnnhn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgngbcvgggfhygb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)sfsfgtdsfr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyeh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)httrgrt {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)kilgnnhnnhn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)hgngbcvgggfhygbn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)wreew {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyeheh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hrtg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bhg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)bcvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
-(NSString *)ffghhhgf{
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyeheheh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hrtghg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bhgnhjh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)bcvbbghb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)wreewsvfdf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hrtghghtyh {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)pjmjmjjbg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)bcvbbghbgh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)wreewsvfdfewf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhteh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hfgf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)pjmjmjjjbgmhn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)bcvbbghbghncxvg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)wreewsvfdfewffds {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hfgfgd {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bgbn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnghnghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)qewf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)hfgfgdggtg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bgbnngm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnghnghnbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)qewfwrfef {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjw:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jytht {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bgbnngmjhmjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnghnghnbghnfgbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)qewfwrfefcsd {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjweh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jythtsdfs {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)jmhjmnb:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnghnghnbghnfgbgvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)qewfwrfefcsdv {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjwehtwrgt:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

-(NSString *)vfvfbdfv {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bgbghn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnghnghnbghnfgbgvbbgh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)qewfwrfefcsdvvgb {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjwehtwrgtth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ghfgdg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)bgbghnghj:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnghnghnbghnfgbgvbbghvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etr {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjwehtwrgtthh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ghfgdgyhbf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hgjjhm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnhb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

-(id)vfvfvf:(SEL)fvfvf:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ggref {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hgjjhmnhjmjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnhbfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrgf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjwehtwrgtthhterht:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ggreftrg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hgjjhmnhjmjmmjkmnb:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)gnhbfgbvdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrgffdg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejtyehehehhtehtghhjwehtwrgtthhterhth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ggreftrgvdvfdg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hjh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype) ghghg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrgffdgfgtt {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrty:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)ggfvdf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hjhnhjmjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype) ghghghnhg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrgffdgfgttfthy {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtr:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)thregre {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hjhhjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype) ghghghnhgbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrgffdgfgttfthyvfghf {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtrhyh:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)thjuhty {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hjhhjmmjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype) ghghghnhgbghndvd:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)etrgffdgfgttfthyvfghfbfg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtrhyhwgth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)thjuhtyrtgrgse {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lolhk:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghjhg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)trhty {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtrhyhwgthwgtr:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jrthrtg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lolhkngn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghjhgn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)trhtybghg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtrhyhwgthwgtrbb:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jr {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lolhkngnmjk:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)trhtybghgvcgc {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtrhyhwgthwgtrbbsg:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jrrtgg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lolhkngnmjkmhj:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghgfb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)trhtybghgvcgcc {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrtywtrhyhwgthwgtrbbsgyhe:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jrgjh {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lloluhjn:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghgfbhnghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhhgg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrht:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jrgjhdfgg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lloluhjnnh:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghgfbhnghnnghj:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhhggcg {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrhtqtr:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)jrgjhdfggdvdf {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)lloluhjnnhgj:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghgfbhnghnnghjghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhhggcgjmj {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrhtqtrth:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)regfeg {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)hjkhhjm:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}
- (instancetype)ghgfbhnghnnghjghnbf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalmatting =
        [[buckle decodeObjectForKey:@"nationalmatting"] boolValue];
        _domesticRule =
        [buckle decodeObjectForKey:@"domesticRule"];
    }
    self;
    
    if (self) {
        _numberFormats = [[NSMutableArray alloc] init];
        _intlNumberFormats = [[NSMutableArray alloc] init];
        
        _leadingZeroPossible = NO;
        _mainCountryForCode = NO;
        _sameMobileAndFixedLinePattern = NO;
        _internationalPrefix = @"NA";
    }
    return self;
}
- (NSString *)jhhggcgjmjnmhj {
    return [NSString
            stringWithFormat:
            @"[pattern:%@, format:%@, leadingDigitsPattern:%@, nationalPrefixFormattingRule:%@, "
            @"nationalmatting:%@, domesticRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalmatting ? @"Y" : @"N",
            self.domesticRule];
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (id)fejjrhtqtrthqr:(SEL)aSelector:(NSZone *)zone {
    return [[carrying alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalmatting
    withdomesticRule:self.domesticRule];
}

- (NSString *)regfeghh {
    return [NSString
            stringWithFormat:
            @"* codeID[%@] countryCode[%@] generalDesc[%@] fixedLine[%@] mobile[%@] tollFree[%@] "
            @"premiumRate[%@] sharedCost[%@] personalNumber[%@] voip[%@] pager[%@] uan[%@] "
            @"emergency[%@] voicemail[%@] noInternationalDialling[%@] internationalPrefix[%@] "
            @"preferredInternationalPrefix[%@] nationalPrefix[%@] preferredExtnPrefix[%@] "
            @"nationalPrefixForParsing[%@] nationalPrefixTransformRule[%@] "
            @"sameMobileAndFixedLinePattern[%@] numberFormats[%@] intlNumberFormats[%@] "
            @"mainCountryForCode[%@] leadingDigits[%@] leadingZeroPossible[%@]",
            _codeID, _countryCode, _generalDesc, _fixedLine, _mobile, _tollFree, _premiumRate,
            _sharedCost, _personalNumber, _voip, _pager, _uan, _emergency, _voicemail,
            _noInternationalDialling, _internationalPrefix, _preferredInternationalPrefix,
            _nationalPrefix, _preferredExtnPrefix, _nationalPrefixForParsing,
            _nationalPrefixTransformRule, _sameMobileAndFixedLinePattern ? @"Y" : @"N",
            _numberFormats, _intlNumberFormats, _mainCountryForCode ? @"Y" : @"N", _leadingDigits,
            _leadingZeroPossible ? @"Y" : @"N"];
}


- (void)jjjijhg:(NSCoder *)buckle {
    
    [buckle encodeObject:_generalDesc forKey:@"generalDesc"];
    [buckle encodeObject:_fixedLine forKey:@"fixedLine"];
    [buckle encodeObject:_mobile forKey:@"mobile"];
    [buckle encodeObject:_tollFree forKey:@"tollFree"];
    [buckle encodeObject:_premiumRate forKey:@"premiumRate"];
    [buckle encodeObject:_sharedCost forKey:@"sharedCost"];
    [buckle encodeObject:_personalNumber forKey:@"personalNumber"];
    [buckle encodeObject:_voip forKey:@"voip"];
    [buckle encodeObject:_pager forKey:@"pager"];
    [buckle encodeObject:_uan forKey:@"uan"];
    [buckle encodeObject:_emergency forKey:@"emergency"];
    [buckle encodeObject:_voicemail forKey:@"voicemail"];
    [buckle encodeObject:_noInternationalDialling forKey:@"noInternationalDialling"];
    [buckle encodeObject:_codeID forKey:@"codeID"];
    [buckle encodeObject:_countryCode forKey:@"countryCode"];
    [buckle encodeObject:_internationalPrefix forKey:@"internationalPrefix"];
    [buckle encodeObject:_preferredInternationalPrefix forKey:@"preferredInternationalPrefix"];
    [buckle encodeObject:_nationalPrefix forKey:@"nationalPrefix"];
    [buckle encodeObject:_preferredExtnPrefix forKey:@"preferredExtnPrefix"];
    [buckle encodeObject:_nationalPrefixForParsing forKey:@"nationalPrefixForParsing"];
    [buckle encodeObject:_nationalPrefixTransformRule forKey:@"nationalPrefixTransformRule"];
    [buckle encodeObject:[NSNumber numberWithBool:_sameMobileAndFixedLinePattern]
                  forKey:@"sameMobileAndFixedLinePattern"];
    [buckle encodeObject:_numberFormats forKey:@"numberFormats"];
    [buckle encodeObject:_intlNumberFormats forKey:@"intlNumberFormats"];
    [buckle encodeObject:[NSNumber numberWithBool:_mainCountryForCode] forKey:@"mainCountryForCode"];
    [buckle encodeObject:_leadingDigits forKey:@"leadingDigits"];
    [buckle encodeObject:[NSNumber numberWithBool:_leadingZeroPossible] forKey:@"leadingZeroPossible"];
    [buckle encodeObject:self.pattern forKey:@"pattern"];
    [buckle encodeObject:self.format forKey:@"format"];
    [buckle encodeObject:self.leadingDigitsPatterns forKey:@"leadingDigitsPatterns"];
    [buckle encodeObject:self.nationalPrefixFormattingRule forKey:@"nationalPrefixFormattingRule"];
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalmatting]
                  forKey:@"nationalmatting"];
    [buckle encodeObject:self.domesticRule
                  forKey:@"domesticRule"];
}


@end
