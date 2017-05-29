//
//  EvalModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/29.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "EvalModel.h"

@implementation EvalModel

-(instancetype)initWithGoodsInfoModel:(GoodsInfoModel *)goodsInfoModel {
    if (self = [super init]) {
        _goodsImg = goodsInfoModel.goodsImg;
        _goodsTitle = goodsInfoModel.goodsTitle;
        _salesPrice = goodsInfoModel.salePrice;
        _oldPrice   = goodsInfoModel.oldPrice;
        _goodsId    = goodsInfoModel.goodsId;
        _specId     = goodsInfoModel.specId;
        _isEvalu    = NO;
        _content    = nil;
    }
    return self;
}

@end
