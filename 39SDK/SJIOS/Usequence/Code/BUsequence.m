//
//  BUsequence.m
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AUsequence.h"
#import "BUsequence.h"
#import "CUsequence.h"

@interface BUsequence ()

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

@implementation BUsequence



- (CGColorSpaceModel)colorSpaceModel {
   return CGColorSpaceGetModel;
}

- (instancetype)initWithCoder:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
                 whenFormatting:(BOOL)nationalPrefixOptionalWhenFormatting
withDomesticCarrierCodeFormattingRule:(NSString *)domesticCarrierCodeFormattingRule {
    self;
    if (self) {
        _pattern = pattern;
        _format = format;
        _leadingDigitsPatterns = leadingDigitsPatterns;
        _nationalPrefixFormattingRule = nationalPrefixFormattingRule;
        _nationalPrefixOptionalWhenFormatting = nationalPrefixOptionalWhenFormatting;
        _domesticCarrierCodeFormattingRule = domesticCarrierCodeFormattingRule;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return [[BUsequence alloc] initWithPattern:self.pattern
                                        withFormat:self.format
                         withLeadingDigitsPatterns:self.leadingDigitsPatterns
                  withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                                    whenFormatting:self.nationalPrefixOptionalWhenFormatting
             withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fgghbghn:(NSString *)pattern
                        withFormat:(NSString *)format
         withLeadingDigitsPatterns:(NSArray *)leadingDigitsPatterns
  withNationalPrefixFormattingRule:(NSString *)nationalPrefixFormattingRule
                    whenFormatting:(BOOL)nationalPrefixOptionalWhenFormatting
withDomesticCarrierCodeFormattingRule:(NSString *)domesticCarrierCodeFormattingRule {
    if (self) {
        _pattern = pattern;
        _format = format;
        _leadingDigitsPatterns = leadingDigitsPatterns;
        _nationalPrefixFormattingRule = nationalPrefixFormattingRule;
        _nationalPrefixOptionalWhenFormatting = nationalPrefixOptionalWhenFormatting;
        _domesticCarrierCodeFormattingRule = domesticCarrierCodeFormattingRule;
    }
    return self;
}
- (instancetype)fgghbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}

- (instancetype)initWiewffrn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWfn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fghgjnh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWiedetrfrhPattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)iniattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)inithPattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWieiuykttern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWiuuytern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWrrtern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWrgern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWfgfbdgrn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWiewfrn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initwfwattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initWwefern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)iniwefhPattern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)iniwefttern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)initweftern:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fghgjnhfgn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fghgjnhfgnjmj:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ffdfdgddg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ffdfdgddgv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ffdfdgddgvdfvv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ffdfdgddgvdfvvgvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)frtgdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)frtgdftgdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)frtgdftgdffgtf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)frtgdftgdffgtfxcc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)frtgdftgdffgtfxcccdc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cdcvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cdcvdfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cdcvdfvdfvvdfvdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cdcvdfvdfvvdfvdffef:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)werew:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)werewdsfse:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)werewdsfsefer:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)werewdsfsefergrt:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)wrer:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)wrerfrgrt:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)wrerfrgrtgrth:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)wrerfrgrtgrthdfdg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fvdfc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fvdfcbgf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ggfbv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ggfbvnghbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ggfbvnghbgvcbfg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvdfvfdfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvdfvfdfgbbghb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvdfvfdfgbbghbvxf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvdfvgfb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvdfvgfbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvdfvgfbghnbnb :(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvdfvgfbghnbnbbgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fvfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fvfgbbfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fvfgbbfgbbfgv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)fvfgbbfgbbfgvgbfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gfvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gfvdfvdvfhfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gfvdfvdvfhfgbvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gfvdfvdvfhfgbvcbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvxvvcv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvxvvcvvfbfg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dfvxvvcvvfbfgfgbgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)dvcvvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvffgfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvffgfvbvn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvffgfvbvnvcbvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)vfvffgfvbvnvcbvcnbvm:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvcbv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvcbvdfvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvcbvdfvcngh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvvbbgbgh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvvbbgbghnghngbcvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvvbbgbghnghngbcvbbhgn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)cvvbbgbghnghngbcvbbhgnbn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ngbbfgbf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ngbbfgbfhnj:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hghngb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hghngbcbvc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hghngbcbvchnh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hghngbcbvchnhxcbc:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgfb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgfbhnhjn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgfbhnhjnfgbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgngb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgngbcv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgngbcvgg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgngbcvgggfhyg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgngbcvgggfhygb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)hgngbcvgggfhygbn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)bcvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)bcvbbghb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)bcvbbghbgh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)bcvbbghbghncxvg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnghnghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnghnghnbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnghnghnbghnfgbg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnghnghnbghnfgbgvb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnghnghnbghnfgbgvbbgh:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnghnghnbghnfgbgvbbghvdfv:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnhb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnhbfgb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)gnhbfgbvdf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype) ghghg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype) ghghghnhg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype) ghghghnhgbghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype) ghghghnhgbghndvd:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghjhg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghjhgn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghg:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghgfb:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghgfbhnghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghgfbhnghnnghj:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghgfbhnghnnghjghn:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}
- (instancetype)ghgfbhnghnnghjghnbf:(NSCoder *)buckle {
    if (self) {
        _pattern = [buckle decodeObjectForKey:@"pattern"];
        _format = [buckle decodeObjectForKey:@"format"];
        _leadingDigitsPatterns = [buckle decodeObjectForKey:@"leadingDigitsPatterns"];
        _nationalPrefixFormattingRule = [buckle decodeObjectForKey:@"nationalPrefixFormattingRule"];
        _nationalPrefixOptionalWhenFormatting =
        [[buckle decodeObjectForKey:@"nationalPrefixOptionalWhenFormatting"] boolValue];
        _domesticCarrierCodeFormattingRule =
        [buckle decodeObjectForKey:@"domesticCarrierCodeFormattingRule"];
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
            @"nationalPrefixOptionalWhenFormatting:%@, domesticCarrierCodeFormattingRule:%@]",
            self.pattern, self.format, self.leadingDigitsPatterns, self.nationalPrefixFormattingRule,
            self.nationalPrefixOptionalWhenFormatting ? @"Y" : @"N",
            self.domesticCarrierCodeFormattingRule];
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
    return [[BUsequence alloc] initWithPattern:self.pattern
                               withFormat:self.format
                withLeadingDigitsPatterns:self.leadingDigitsPatterns
         withNationalPrefixFormattingRule:self.nationalPrefixFormattingRule
                           whenFormatting:self.nationalPrefixOptionalWhenFormatting
    withDomesticCarrierCodeFormattingRule:self.domesticCarrierCodeFormattingRule];
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
    [buckle encodeObject:[NSNumber numberWithBool:self.nationalPrefixOptionalWhenFormatting]
                  forKey:@"nationalPrefixOptionalWhenFormatting"];
    [buckle encodeObject:self.domesticCarrierCodeFormattingRule
                  forKey:@"domesticCarrierCodeFormattingRule"];
}


@end
