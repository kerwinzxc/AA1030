//
//  hippopotamus.h
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUsequence : NSObject



- (instancetype)initWithRegionCode:(NSString *)regionCode;
- (instancetype)initWithRegionCode:(NSString *)regionCode bundle:(NSBundle *)bundle;

- (NSString *)inputString:(NSString *)string;
- (NSString *)inputStringAndRememberPosition:(NSString *)string;

- (NSString *)inputDigit:(NSString *)nextChar;
- (NSString *)inputDigitAndRememberPosition:(NSString *)nextChar;

- (NSString *)removeLastDigit;
- (NSString *)removeLastDigitAndRememberPosition;

@property(nonatomic, strong, readwrite) NSNumber *countryCode;
@property(nonatomic, strong, readwrite) NSNumber *nationalNumber;
@property(nonatomic, strong, readwrite) NSString *extension;
@property(nonatomic, assign, readwrite) BOOL italianLeadingZero;
@property(nonatomic, strong, readwrite) NSNumber *numberOfLeadingZeros;
@property(nonatomic, strong, readwrite) NSString *rawInput;
@property(nonatomic, strong, readwrite) NSNumber *countryCodeSource;
@property(nonatomic, strong, readwrite) NSString *preferredDomesticCarrierCode;

- (NSInteger)getRememberedPosition;
@property(nonatomic, strong, readwrite) NSString *currentOutput_, *currentFormattingPattern_;
@property(nonatomic, strong, readwrite) NSString *defaultCountry_;
@property(nonatomic, strong, readwrite) NSString *nationalPrefixExtracted_;
@property(nonatomic, strong, readwrite) NSMutableString *formattingTemplate_, *accruedInput_,
*prefixBeforeNationalNumber_, *accruedInputWithoutFormatting_, *nationalNumber_;
@property(nonatomic, strong, readwrite) NSRegularExpression *DIGIT_PATTERN_,
*NATIONAL_PREFIX_SEPARATORS_PATTERN_, *CHARACTER_CLASS_PATTERN_, *STANDALONE_DIGIT_PATTERN_;
@property(nonatomic, strong, readwrite) NSRegularExpression *ELIGIBLE_FORMAT_PATTERN_;
@property(nonatomic, assign, readwrite) BOOL ableToFormat_, inputHasFormatting_, isCompleteNumber_,
isExpectingCountryCallingCode_, shouldAddSpaceAfterNationalPrefix_;
@property(nonatomic, assign, readwrite) NSUInteger lastMatchPosition_, originalPosition_,
positionToRemember_;
@property(nonatomic, strong, readwrite) NSMutableArray *possibleFormats_;
@property(nonatomic, assign, readonly) BOOL isSuccessfulFormatting;
@property(nonatomic, strong, readwrite) CUsequence *phoneUtil;
@property(nonatomic, strong, readwrite) CUsequence *currentMetaData, *defaultMetaData;
@end
