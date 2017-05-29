//
//  EvalModel.h
//  IOSProject
//
//  Created by IOS002 on 15/7/29.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfoModel.h"

@interface EvalModel : NSObject
//商品图片
@property (nonatomic,strong) NSString *goodsImg;
//商品标题
@property (nonatomic,strong) NSString *goodsTitle;
//商品卖出价格
@property (nonatomic,strong) NSString *salesPrice;
//商品原始价格
@property (nonatomic,strong) NSString *oldPrice;
//商品标签
@property (nonatomic,strong) NSArray *goodsTag;
//商品Id
@property (nonatomic,strong) NSString *goodsId;
//规格Id
@property (nonatomic,strong) NSString *specId;
//评论内容
@property (nonatomic,strong) NSString *content;
//是否评论
@property (nonatomic,assign) BOOL isEvalu;
//评论好坏
@property (nonatomic,strong) NSString *evaluMass;

-(instancetype)initWithGoodsInfoModel:(GoodsInfoModel *)goodsInfoModel;

@end
