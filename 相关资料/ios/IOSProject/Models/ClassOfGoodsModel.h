//
//  ClassOfGoodsModel.h
//  IOSProject
//
//  Created by IOS004 on 15/8/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CCModel.h"

@interface ClassOfGoodsModel : CCModel

//商品图片
@property (nonatomic,strong) NSString * goods_image;
@property (nonatomic,strong) NSString * goods_name;
//商品数量
@property (nonatomic,strong) NSString * quantity;
//商品id
@property (nonatomic,assign) NSInteger goods_id;
//规格id
@property (nonatomic,strong) NSString * spec_id;
@property (nonatomic,strong) NSString * shop_id;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
