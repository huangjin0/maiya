//
//  GoodsInfoModel.h
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfoModel : NSObject
//商品图片
@property (nonatomic,strong) NSString *goodsImg;
//商品标题
@property (nonatomic,strong) NSString *goodsTitle;
//商品数量
@property (nonatomic,strong) NSString *goodsCount;
//商品价格
@property (nonatomic,strong) NSString *salePrice;
//商品原价格
@property (nonatomic,strong) NSString *oldPrice;
//商品id
@property (nonatomic,strong) NSString *goodsId;
//规格id
@property (nonatomic,strong) NSString *specId;
//标签个数
@property (nonatomic,strong) NSArray *tallyCount;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
