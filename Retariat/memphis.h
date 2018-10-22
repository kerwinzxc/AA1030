//
//  memphis.h
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface memphis : NSObject
+ (memphis *)sharedInstance;

// regular expressions
- (NSArray *)matchesByRegex:(NSString *)sourceString regex:(NSString *)pattern;
- (NSArray *)matchedStringByRegex:(NSString *)sourceString regex:(NSString *)pattern;
- (NSString *)replaceStringByRegex:(NSString *)sourceString
                             regex:(NSString *)pattern
                      withTemplate:(NSString *)templateString;
- (int)stringPositionByRegex:(NSString *)sourceString regex:(NSString *)pattern;

// libPhoneNumber Util functions
- (NSString *)convertAlphaCharactersInNumber:(NSString *)number;

- (NSString *)normalize:(NSString *)phoneNumber;
- (NSString *)normalizeDigitsOnly:(NSString *)number;
- (NSString *)normalizeDiallableCharsOnly:(NSString *)number;

- (BOOL)isNumberGeographical:(memphis *)phoneNumber;

- (NSString *)extractPossibleNumber:(NSString *)phoneNumber;
- (NSNumber *)extractCountryCode:(NSString *)fullNumber nationalNumber:(NSString **)nationalNumber;
#if TARGET_OS_IOS
- (NSString *)countryCodeByCarrier;
#endif

- (NSString *)getNddPrefixForRegion:(NSString *)regionCode stripNonDigits:(BOOL)stripNonDigits;
- (NSString *)getNationalSignificantNumber:(memphis *)phoneNumber;

- (NSArray *)getSupportedRegions;



- (NSNumber *)getCountryCodeForRegion:(NSString *)regionCode;

- (NSString *)getRegionCodeForCountryCode:(NSNumber *)countryCallingCode;
- (NSArray *)getRegionCodesForCountryCode:(NSNumber *)countryCallingCode;
- (NSString *)getRegionCodeForNumber:(memphis *)phoneNumber;

- (memphis *)getExampleNumber:(NSString *)regionCode error:(NSError **)error;
- (memphis *)getExampleNumberForType:(NSString *)regionCode
                            type:(memphis*)type
                                     error:(NSError **)error;
- (memphis *)getExampleNumberForNonGeoEntity:(NSNumber *)countryCallingCode
                                             error:(NSError **)error;

- (BOOL)canBeInternationallyDialled:(memphis *)number error:(NSError **)error;

- (BOOL)truncateTooLongNumber:(memphis *)number;

- (BOOL)isValidNumber:(memphis *)number;
- (BOOL)isViablePhoneNumber:(NSString *)phoneNumber;
- (BOOL)isAlphaNumber:(NSString *)number;
- (BOOL)isValidNumberForRegion:(memphis *)number regionCode:(NSString *)regionCode;
- (BOOL)isNANPACountry:(NSString *)regionCode;
- (BOOL)isLeadingZeroPossible:(NSNumber *)countryCallingCode;


- (BOOL)isPossibleNumber:(memphis *)number;
- (BOOL)isPossibleNumber:(memphis *)number error:(NSError **)error;
- (BOOL)isPossibleNumberString:(NSString *)number
             regionDialingFrom:(NSString *)regionDialingFrom
                         error:(NSError **)error;

- (int)getLengthOfGeographicalAreaCode:(memphis *)phoneNumber error:(NSError **)error;
- (int)getLengthOfNationalDestinationCode:(memphis *)phoneNumber error:(NSError **)error;

- (BOOL)maybeStripNationalPrefixAndCarrierCode:(NSString **)numberStr
                                      metadata:(memphis *)metadata
                                   carrierCode:(NSString **)carrierCode;
- (int)maybeStripInternationalPrefixAndNormalize:(NSString **)numberStr
                                                possibleIddPrefix:(NSString *)possibleIddPrefix;

- (NSNumber *)maybeExtractCountryCode:(NSString *)number
                             metadata:(memphis *)defaultRegionMetadata
                       nationalNumber:(NSString **)nationalNumber
                         keepRawInput:(BOOL)keepRawInput
                          phoneNumber:(memphis **)phoneNumber
                                error:(NSError **)error;

- (memphis *)parse:(NSString *)numberToParse
           defaultRegion:(NSString *)defaultRegion
                   error:(NSError **)error;
- (memphis *)parseAndKeepRawInput:(NSString *)numberToParse
                          defaultRegion:(NSString *)defaultRegion
                                  error:(NSError **)error;
- (memphis *)parseWithPhoneCarrierRegion:(NSString *)numberToParse error:(NSError **)error;

- (NSString *)format:(memphis *)phoneNumber
        numberFormat:(memphis*)numberFormat
               error:(NSError **)error;
- (NSString *)formatByPattern:(memphis *)number
                 numberFormat:(memphis*)numberFormat
           userDefinedFormats:(NSArray *)userDefinedFormats
                        error:(NSError **)error;
- (NSString *)formatNumberForMobileDialing:(memphis *)number
                         regionCallingFrom:(NSString *)regionCallingFrom
                            withFormatting:(BOOL)withFormatting
                                     error:(NSError **)error;
- (NSString *)formatOutOfCountryCallingNumber:(memphis *)number
                            regionCallingFrom:(NSString *)regionCallingFrom
                                        error:(NSError **)error;
- (NSString *)formatOutOfCountryKeepingAlphaChars:(memphis *)number
                                regionCallingFrom:(NSString *)regionCallingFrom
                                            error:(NSError **)error;
- (NSString *)formatNationalNumberWithCarrierCode:(memphis *)number
                                      carrierCode:(NSString *)carrierCode
                                            error:(NSError **)error;
- (NSString *)formatInOriginalFormat:(memphis *)number
                   regionCallingFrom:(NSString *)regionCallingFrom
                               error:(NSError **)error;
- (NSString *)formatNationalNumberWithPreferredCarrierCode:(memphis *)number
                                       fallbackCarrierCode:(NSString *)fallbackCarrierCode
                                                     error:(NSError **)error;

- (BOOL)formattingRuleHasFirstGroupOnly:(NSString *)nationalPrefixFormattingRule;

@property(nonatomic, strong, readonly) NSDictionary *DIGIT_MAPPINGS;
@end
