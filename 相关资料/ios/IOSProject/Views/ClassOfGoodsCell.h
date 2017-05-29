//
//  ClassOfGoodsCell.h
//  IOSProject
//
//  Created by IOS004 on 15/8/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@class ClassOfGoodsCell;
@protocol classofgoodsDelegate <NSObject>

- (void)joinCartSuccess:(ClassOfGoodsCell *)cell;

@end

@class ClassOfGoodsModel;

@interface ClassOfGoodsCell : BasicCell

@property (assign,nonatomic)id<classofgoodsDelegate>delegate;
@property (strong,nonatomic)ClassOfGoodsModel * item;

@end
