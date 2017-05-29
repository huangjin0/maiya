//
//  CollectionModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel
-(instancetype)initWithDic:(NSDictionary *)dict {
    if (self = [super init]) {
        NSDictionary *dic = [dict getDictionaryForKey:@"good_info"];
        NSString *imgUrl  = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        if ([imgUrl hasPrefix:@"http"]) {
            self.goodsImg = imgUrl;
        } else {
            self.goodsImg = [NSString stringWithFormat:@"%@%@",DeFaultURL,imgUrl];
        }
//        self.goodsImg     = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        self.goodsTitle   = [dic getStringValueForKey:@"goods_name" defaultValue:nil];
        self.goodsSalePri = [dic getStringValueForKey:@"goods_price" defaultValue:nil];
        self.goodsOldPri  = [dic getStringValueForKey:@"old_price" defaultValue:nil];
        self.goodsId      = [dic getStringValueForKey:@"goods_id" defaultValue:nil];
        self.shopId       = [dic getStringValueForKey:@"goods_id" defaultValue:nil];
        self.specId       = [dic getStringValueForKey:@"spec_id" defaultValue:nil];
        self.goodstag     = [dic getArrayForKey:@"expend1"];
        NSString *stock   = [dic getStringValueForKey:@"stock" defaultValue:nil];
        NSString *viSales = [dic getStringValueForKey:@"virtual_sales" defaultValue:nil];
        if ([stock integerValue] > [viSales integerValue]) {
            self.hasStock = YES;
        } else {
            self.hasStock = NO;
        }
    }
    return self;
}

@end
