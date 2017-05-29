//
//  GoodsCell.h
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@class GoodsCell;
@protocol commmoditygoodsDelegate <NSObject>

- (void)commoditygoods:(GoodsCell *)cell tag:(NSInteger)tag;

@end
@protocol commodityDetailDelegate <NSObject>

- (void)goodsidToCommodity:(NSString *)goodsid;

@end
@class Goods;
//@class SaleGoods;

@interface GoodsCell : BasicCell

@property (strong, nonatomic) Goods * item;
@property (strong, nonatomic) NSArray * goodsArray;
@property (assign, nonatomic)id<commmoditygoodsDelegate>delegate;
@property (assign, nonatomic)id<commodityDetailDelegate>delegated;
//+ (CGFloat)heightForCell:(Goods *)item;

@end
