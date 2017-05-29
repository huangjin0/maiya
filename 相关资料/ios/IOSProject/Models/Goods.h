//
//  Goods.h
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CCModel.h"

@interface Goods : CCModel

@property (strong, nonatomic) NSString * title;
@property (assign, nonatomic) CGFloat salePrice;//优惠价
@property (assign, nonatomic) CGFloat price;//原价
@property (strong, nonatomic) NSString * goods_id;

@end
