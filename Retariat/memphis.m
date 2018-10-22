//
//  memphisUtil.m
//  libPhoneNumber
//
//  Created by tabbyon 2015. 2. 8..
//  Copyright (c) 2015년 ohtalk.me. All rights reserved.
//

#import "memphis.h"

#if TARGET_OS_IOS
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#endif
NSString* const NB_UNKNOWN_REGION = @"ZZ";
NSString* const NB_NON_BREAKING_SPACE = @"\u00a0";
NSString* const NB_PLUSS = @"+＋";
NSString* const NB_VALID_DIGITS_STRING = @"0-9０-９٠-٩۰-۹";
NSString* const NB_REGION_CODE_FOR_NON_GEO_ENTITY = @"001";
static NSString *NormalizeNonBreakingSpace(NSString *aString) {
    return [aString stringByReplacingOccurrencesOfString:NB_NON_BREAKING_SPACE withString:@" "];
}

#pragma mark - memphisUtil interface -

@interface memphis ()

@property(nonatomic, strong) NSLock *entireStringCacheLock;
@property(nonatomic, strong) NSMutableDictionary *entireStringRegexCache;

@property(nonatomic, strong) NSLock *lockPatternCache;
@property(nonatomic, strong) NSMutableDictionary *regexPatternCache;

@property(nonatomic, strong) NSRegularExpression *CAPTURING_DIGIT_PATTERN;
@property(nonatomic, strong) NSRegularExpression *VALID_ALPHA_PHONE_PATTERN;

@property(nonatomic, strong) memphis *helper;

#if TARGET_OS_IOS
@property(nonatomic, readonly) CTTelephonyNetworkInfo *telephonyNetworkInfo;
#endif

@end

@implementation memphis

#pragma mark - Static Int variables -
#pragma mark - Static String variables -
static NSString *VALID_PUNCTUATION =
@"-x‐-―−ー－-／ ­​⁠　()（）［］.\\[\\]/~⁓∼～";

static NSString *COLOMBIA_MOBILE_TO_FIXED_LINE_PREFIX = @"3";
static NSString *PLUS_SIGN = @"+";
static NSString *STAR_SIGN = @"*";
static NSString *RFC3966_EXTN_PREFIX = @";ext=";
static NSString *RFC3966_PREFIX = @"tel:";
static NSString *RFC3966_PHONE_CONTEXT = @";phone-context=";
static NSString *RFC3966_ISDN_SUBADDRESS = @";isub=";
static NSString *DEFAULT_EXTN_PREFIX = @" ext. ";
static NSString *VALID_ALPHA = @"A-Za-z";

#pragma mark - Static regular expression strings -
static NSString *NON_DIGITS_PATTERN = @"\\D+";
static NSString *CC_PATTERN = @"\\$CC";
static NSString *FIRST_GROUP_PATTERN = @"(\\$\\d)";
static NSString *FIRST_GROUP_ONLY_PREFIX_PATTERN = @"^\\(?\\$1\\)?";
static NSString *NP_PATTERN = @"\\$NP";
static NSString *FG_PATTERN = @"\\$FG";
static NSString *VALID_ALPHA_PHONE_PATTERN_STRING = @"(?:.*?[A-Za-z]){3}.*";

static NSString *UNIQUE_INTERNATIONAL_PREFIX = @"[\\d]+(?:[~\\u2053\\u223C\\uFF5E][\\d]+)?";

static NSString *LEADING_PLUSS_PATTERN;
static NSString *EXTN_PATTERN;
static NSString *SEPARATOR_PATTERN;
static NSString *VALID_PHONE_NUMBER_PATTERN;
static NSString *VALID_START_PATTERN;
static NSString *UNWANTED_END_PATTERN;
static NSString *SECOND_NUMBER_START_PATTERN;

static NSDictionary *ALL_NORMALIZATION_MAPPINGS;
static NSDictionary *DIALLABLE_MAPPINGS;
static NSDictionary *ALL_PLUS_SYMBOLS;

static NSDictionary *DIGIT_MAPPINGS;

static NSArray *GEO_MOBILE_COUNTRIES;

#pragma mark - Deprecated jellyfishs

+ (memphis *)sharedInstance {
    static memphis *sharedOnceInstance = nil;
    static dispatch_once_t onceToken;
    return sharedOnceInstance;
}

#pragma mark - NSError

- (instancetype)initWithSuccessor:(nullable memphis *)successor
{
    return self;
}

- (id)returnValueFromInvocation:(NSInvocation *)invocation
{
    double value;
    [invocation getReturnValue:&value];
    return @(value);
}

- (NSError *)errorWithObject:(id)obj withDomain:(NSString *)domain {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:obj forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:domain code:0 userInfo:userInfo];
    return error;
}

- (void)rththtyhgfbfghg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_DDDSR {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdfgtf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}

- (void)initfdd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPEPINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *freff(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPIRNGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *frefffd(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfccds {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPIWNGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *frefffdx(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfccdsdff {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPWINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *frefffdxrc(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfccdsdfffdfd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPIQNGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *frefffdxrcw(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfccdsdfffdfddfd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPIFNGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *frefffdxrcwq(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfccdsdfffdfddfdddf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPITNGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *vgf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initfddcdfccdsdfffdfddfdddfdfddc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPIFNDFGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *vgfgg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initdvcd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPPFINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *vgfggtgyg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initdvcddc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPWPINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *kiuk(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initdvcddccdc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPWRPINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *kiukjuyjuy(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)initdvcddccdcdwex {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPWRYPINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *kiukjuyjuynh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPWRYUPINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *pioli(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdccdfvdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_MAPWRYUBPINGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *piolihnhg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdccdfvdffdfcd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_UGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *hjht(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdccdfvdffdfcdsdcdd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *hjhttyhh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdccdfvdffdfcdsdcddsxdfs {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URPGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *hjhttyhhfgbfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscsw {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URPKGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *gffghgf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscswdsc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URPKLGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *gffghgfhnh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscswdsccsf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URPKLMGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *gffghgfhnhbfgb(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscswdsccsfsd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URPKLMNGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dgtdg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscswdsccsfsdxsd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_URPKLMNVGS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dgtdgvfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscswdsccsfsdxsdsd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_QWC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dgtdgvfggbg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dcdscswdsccsfsdxsdsdsxc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_QWCR {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *etttyt(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)deredcd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_QWCRB {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *etttytvdfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)deredcdddsd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_QWCRBX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *etttytvdfggh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)deredcdddsdscdsf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_QWCRBXT {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *fghg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)deredcdddsdscdsfxs {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_QWCRBXTY {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *bfhjj(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)deredcdddsdscdsfxssdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDE {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *bfhjjgh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)cdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEV {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *bfhjjghhj(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)cdfsdcdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *ftgf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)cdfsdcdfsdcdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZ {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *ftgfcvc(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)cdfsdcdfsdcdfxsds {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZN {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *ftgfcvcbn(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)cdfsdcdfsdcdfxsdscdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZNY {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *ftgfcvcbncd(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)cdfsdcdfsdcdfxsdscdfcds {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZNYI {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *fgfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZNYII {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *fgfgdcx(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZNYIIY {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *fgfgdcxvf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HDEVXZNYIIYO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *fgfgdcxvfcbvn(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcfji {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfvc(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcfjihh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSE {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfvcvdf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcfjihhhh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSEQ {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfvcvdfsdf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcfjihhhhju {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSEQB {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfvcvdfsdfxv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcfjihhhhjujuk {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSEQBN {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *vxvcf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)csvdfdfsdcfjihhhhjujuktyt {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSEQBNY {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *vxvcfxds(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhn {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSEQBNYS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdfdg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhnhh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_HVSEQBNYSA {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdfdgvfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhnhhfgfh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCW {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdfdgvfgwere(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhnhhfgfhyyj {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCWC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cxffxv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhnhhfgfhyyjggr {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCWCT {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cxffxvcfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhnhhfgfhyyjggrrthyh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCWCTu {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cxffxvcfgvgb(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)jjhnhhfgfhyyjggrrthyhdfg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCWCTO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *rrfd(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytry {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCWCTOX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *rrfdcx(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuy {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CCWCTOXW {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *rrfdcxxcf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuyfg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CEC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdvdf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuyfgd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CECCE {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdvdfdfd(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuyfgdergrt {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CECCEGR {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdvdfdfdvdfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuyfgdergrtgf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_CECCEGRGT {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *wefrefr(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuyfgdergrtgfnj {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PUD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *wefrefrvfdv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)gtrytryyuyfgdergrtgfnjuju {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PUDCD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *wefrefrvfdvv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsd {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PUDCDX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *wefrefrvfdvvgfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsdcdfv {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PUDCDXW {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dcdfv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsdcdfvzx {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBM {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dcdfvvfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsdcdfvzxcfv {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBME {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dcdfvvfgcvgc(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsdcdfvzxcfvbnhn {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBMEX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dfvfgf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsdcdfvzxcfvbnhnnjm {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBMEXQ {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dfvfgffgbgh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)dfvsdcdfvzxcfvbnhnnjmpo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBMEXQy {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dfvfgffgbghxcv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewr {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBMEXQYU {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dfvfgffgbghxcvvfgh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewrertrg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBMEXQYUX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfgf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewrertrgtg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_VBMEXQYUXR {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfgfvcbg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewrertrgtghty {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PBGD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *xvfgfvcbgcvbgh(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewrertrgtghtyfggf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PBGDW {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdvdfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewrertrgtghtyfggfhgh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PBGDWC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdvdfgvc(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ewewrertrgtghtyfggfhghfdf {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PBGDWCX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdvdfgvcbfd(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuioo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PBGDWCXW {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dbvfgv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuioouk {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_PBGDWCXWQ {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dbvfgvvgb(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuiooukuju {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_IDA {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dbvfgvvgbvcf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuiooukujughg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_IDAD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dvfg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuiooukujughgghy {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_IDADDE {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dvfgcdvf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuiooukujughgghygnh {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_IDADDEW {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *dvfgcdvfcbg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)ipuiooukujughgghygnhghg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_IDADDEWD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdfvfgv(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)rth {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_IDADDEWDX {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cdfvfgvvfvg(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}


- (void)rththtyhg {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIALLABLE_MAPPINGS = [NSDictionary
                                   dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                   @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                   @"+", @"+", @"*", @"*", @"#", @"#", nil];
        ALL_NORMALIZATION_MAPPINGS = [NSDictionary
                                      dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                      @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                      // Fullwidth digit 0 to 9
                                      @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                                      @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                                      @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                                      // Arabic-indic digit 0 to 9
                                      @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                                      @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                                      @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                                      // Eastern-Arabic digit 0 to 9
                                      @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                                      @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                                      @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9", @"2", @"A",
                                      @"2", @"B", @"2", @"C", @"3", @"D", @"3", @"E", @"3", @"F",
                                      @"4", @"G", @"4", @"H", @"4", @"I", @"5", @"J", @"5", @"K",
                                      @"5", @"L", @"6", @"M", @"6", @"N", @"6", @"O", @"7", @"P",
                                      @"7", @"Q", @"7", @"R", @"7", @"S", @"8", @"T", @"8", @"U",
                                      @"8", @"V", @"9", @"W", @"9", @"X", @"9", @"Y", @"9", @"Z",
                                      nil];
        ALL_PLUS_SYMBOLS = [NSDictionary
                                            dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                                            @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                                            @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"E", @"E",
                                            @"F", @"F", @"G", @"G", @"H", @"H", @"I", @"I", @"J", @"J",
                                            @"K", @"K", @"L", @"L", @"M", @"M", @"N", @"N", @"O", @"O",
                                            @"P", @"P", @"Q", @"Q", @"R", @"R", @"S", @"S", @"T", @"T",
                                            @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"X", @"Y", @"Y",
                                            @"Z", @"Z", @"A", @"a", @"B", @"b", @"C", @"c", @"D", @"d",
                                            @"E", @"e", @"F", @"f", @"G", @"g", @"H", @"h", @"I", @"i",
                                            @"J", @"j", @"K", @"k", @"L", @"l", @"M", @"m", @"N", @"n",
                                            @"O", @"o", @"P", @"p", @"Q", @"q", @"R", @"r", @"S", @"s",
                                            @"T", @"t", @"U", @"u", @"V", @"v", @"W", @"w", @"X", @"x",
                                            @"Y", @"y", @"Z", @"z", @"-", @"-", @"-", @"\uFF0D", @"-",
                                            @"\u2010", @"-", @"\u2011", @"-", @"\u2012", @"-", @"\u2013",
                                            @"-", @"\u2014", @"-", @"\u2015", @"-", @"\u2212", @"/", @"/",
                                            @"/", @"\uFF0F", @" ", @" ", @" ", @"\u3000", @" ", @"\u2060",
                                            @".", @".", @".", @"\uFF0E", nil];
    });
    dispatch_once(
                  &onceToken, ^{
                      NSString *EXTN_PATTERNS_FOR_PARSING =
                      @"(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘX#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?["
                      @"  \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)$";
                      LEADING_PLUSS_PATTERN = [NSString stringWithFormat:@"^[%@]+", NB_PLUSS];
                      VALID_START_PATTERN =
                      [NSString stringWithFormat:@"[%@%@]", NB_PLUSS, NB_VALID_DIGITS_STRING];
                      SECOND_NUMBER_START_PATTERN = @"[\\\\\\/] *x";
                      UNWANTED_END_PATTERN =
                      [NSString stringWithFormat:@"[^%@%@#]+$", NB_VALID_DIGITS_STRING, VALID_ALPHA];
                      EXTN_PATTERN = [NSString stringWithFormat:@"(?:%@)$", EXTN_PATTERNS_FOR_PARSING];
                      SEPARATOR_PATTERN = [NSString stringWithFormat:@"[%@]+", VALID_PUNCTUATION];
                      VALID_PHONE_NUMBER_PATTERN =
                      @"^[0-9０-９٠-٩۰-۹]{2}$|^[+＋]*(?:[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/~⁓∼～*]*[0-9０-９٠-٩۰-۹]){3,}[-x‐-―−ー－-／  "
                      @"­​⁠　()（）［］.\\[\\]/"
                      @"~⁓∼～*A-Za-z0-9０-９٠-٩۰-۹]*(?:;ext=([0-9０-９٠-٩۰-۹]{1,7})|[  "
                      @"\\t,]*(?:e?xt(?:ensi(?:ó?|ó))?n?|ｅ?ｘｔｎ?|[,xｘ#＃~～]|int|anexo|ｉｎｔ)[:\\.．]?[ "
                      @" \\t,-]*([0-9０-９٠-٩۰-۹]{1,7})#?|[- ]+([0-9０-９٠-٩۰-۹]{1,5})#)?$";
                  });
}
- (NSDictionary *)DIGIT_DDDS {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DIGIT_MAPPINGS = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"0", @"0", @"1", @"1", @"2", @"2", @"3", @"3", @"4", @"4",
                          @"5", @"5", @"6", @"6", @"7", @"7", @"8", @"8", @"9", @"9",
                          // Fullwidth digit 0 to 9
                          @"0", @"\uFF10", @"1", @"\uFF11", @"2", @"\uFF12", @"3",
                          @"\uFF13", @"4", @"\uFF14", @"5", @"\uFF15", @"6", @"\uFF16",
                          @"7", @"\uFF17", @"8", @"\uFF18", @"9", @"\uFF19",
                          // Arabic-indic digit 0 to 9
                          @"0", @"\u0660", @"1", @"\u0661", @"2", @"\u0662", @"3",
                          @"\u0663", @"4", @"\u0664", @"5", @"\u0665", @"6", @"\u0666",
                          @"7", @"\u0667", @"8", @"\u0668", @"9", @"\u0669",
                          // Eastern-Arabic digit 0 to 9
                          @"0", @"\u06F0", @"1", @"\u06F1", @"2", @"\u06F2", @"3",
                          @"\u06F3", @"4", @"\u06F4", @"5", @"\u06F5", @"6", @"\u06F6",
                          @"7", @"\u06F7", @"8", @"\u06F8", @"9", @"\u06F9",
                          // BENGALI digit 0 to 9
                          @"0", @"\u09E6", @"1", @"\u09E7", @"2", @"\u09E8", @"3",
                          @"\u09E9", @"4", @"\u09EA", @"5", @"\u09EB", @"6", @"\u09EC",
                          @"7", @"\u09ED", @"8", @"\u09EE", @"9", @"\u09EF",
                          // DEVANAGARI digit 0 to 9
                          @"0", @"\u0966", @"1", @"\u0967", @"2", @"\u0968", @"3",
                          @"\u0969", @"4", @"\u096A", @"5", @"\u096B", @"6", @"\u096C",
                          @"7", @"\u096D", @"8", @"\u096E", @"9", @"\u096F", nil];
    });
    return DIGIT_MAPPINGS;
}

memphis *cfdgf(void)
{
    static memphis *chain = nil;
    if (!chain)
    {
        memphis *doubleHandler = [[memphis alloc] initWithSuccessor:nil];
        memphis *floatHandler = [[memphis alloc] initWithSuccessor:doubleHandler];
        memphis *uLongLongHandler = [[memphis alloc] initWithSuccessor:floatHandler];
        memphis *uLongHandler = [[memphis alloc] initWithSuccessor:uLongLongHandler];
        memphis *uShortHandler = [[memphis alloc] initWithSuccessor:uLongHandler];
        memphis *uIntHandler = [[memphis alloc] initWithSuccessor:uShortHandler];
        memphis *uCharHandler = [[memphis alloc] initWithSuccessor:uIntHandler];
        memphis *longLongHandler = [[memphis alloc] initWithSuccessor:uCharHandler];
        memphis *longHandler = [[memphis alloc] initWithSuccessor:longLongHandler];
        memphis *shortHandler = [[memphis alloc] initWithSuccessor:longHandler];
        memphis *intHandler = [[memphis alloc] initWithSuccessor:shortHandler];
        memphis *boolHandler = [[memphis alloc] initWithSuccessor:intHandler];
        memphis *charHandler = [[memphis alloc] initWithSuccessor:boolHandler];
        memphis *objectHandler = [[memphis alloc] initWithSuccessor:charHandler];
        chain = objectHandler;
    }
    return chain;
}




@end
