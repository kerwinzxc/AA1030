//
//  BRersistence.h
//  0425
//
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BRersistence : NSObject
@property (nonatomic, readonly, nullable) BRersistence *timeRemapping;
@property (nonatomic, readonly) NSArray<BRersistence *> *keyframes;
@property (nonatomic,readwrite) int aVariable;
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property(nonatomic, assign, readonly) BOOL isSuccessfulFormatting;

@property(nonatomic, strong) NSString *pattern;
@property(nonatomic, strong) NSString *format;
@property(nonatomic, strong) NSArray *leadingDigitsPatterns;
@property(nonatomic, strong) NSString *nationalPrefixFormattingRule;
@property(nonatomic, assign) BOOL nationalPrefixOptionalWhenFormatting;
@property(nonatomic, strong) NSString *domesticCarrierCodeFormattingRule;

@property(nonatomic, strong) NSArray *generalDesc;
@property(nonatomic, strong) NSArray *fixedLine;
@property(nonatomic, strong) NSArray *mobile;
@property(nonatomic, strong) NSArray *tollFree;
@property(nonatomic, strong) NSArray *premiumRate;
@property(nonatomic, strong) NSArray *sharedCost;
@property(nonatomic, strong) NSArray *personalNumber;
@property(nonatomic, strong) NSArray *voip;
@property(nonatomic, strong) NSArray *pager;
@property(nonatomic, strong) NSArray *uan;
@property(nonatomic, strong) NSArray *emergency;
@property(nonatomic, strong) NSArray *voicemail;
@property(nonatomic, strong) NSArray *noInternationalDialling;
@end
