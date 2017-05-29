//
//  BannerCollectionShoppingCartModel.h
//  IOSProject
//
//  Created by IOS004 on 15/8/18.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerCollectionShoppingCartModel : CCModel

//商品图片
@property (nonatomic,strong) NSString *goodsImg;
//商品标题
@property (nonatomic,strong) NSString *goodsTitle;
//商品销售价格
@property (nonatomic,strong) NSString *goodsSalePri;
//商品原始价格
@property (nonatomic,strong) NSString *goodsOldPri;
//商品id
@property (nonatomic,strong) NSString *goodsId;
//商店Id
@property (nonatomic,strong) NSString *shopId;
//商品规格id
@property (nonatomic,strong) NSString *specId;
//商品标签
@property (nonatomic,strong) NSArray  *goodstag;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
