//
//  cardTypeView.h
//  CostomizePay
//
//  Created by gjz on 14-7-21.
//  Copyright (c) 2014年 gjz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardTypeProtocol;

@interface cardTypeView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) id<CardTypeProtocol> delegate;
-(void)updateViewWithData:(NSDictionary *)data;

@property (nonatomic, assign)int selectedPosition;

@end


@protocol CardTypeProtocol <NSObject>

-(void)cardItemSelectedAtIndex:(NSInteger)index;

@end