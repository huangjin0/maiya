//
//  ShoppingCartModel.m
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.imageName = [dict getStringValueForKey:@"goods_image" defaultValue:nil];
        self.goodsTitle = [dict getStringValueForKey:@"goods_name" defaultValue:nil];
        self.goodsNum = [[dict getStringValueForKey:@"quantity" defaultValue:nil] integerValue];
        self.cartId = [dict getStringValueForKey:@"cart_id" defaultValue:nil];
        NSDictionary *info = [dict getDictionaryForKey:@"goods_info"];
        self.goodsID = [info getStringValueForKey:@"goods_id" defaultValue:nil];
        self.goodsPrice = [info getStringValueForKey:@"goods_price" defaultValue:nil];
        self.oldPrice = [info getStringValueForKey:@"old_price" defaultValue:nil];
        self.stock = [info getStringValueForKey:@"stock" defaultValue:nil];
        self.tallyCount = [info getArrayForKey:@"expend1"];
        NSString *stock = [info getStringValueForKey:@"stock" defaultValue:nil];
        NSString *virtualSales = [dict getStringValueForKey:@"virtual_sales" defaultValue:nil];
        if ([stock intValue] > [virtualSales intValue]) {
            self.hasGoods = YES;
        } else {
            self.hasGoods = NO;
        }
        if (_hasGoods) {
            self.selectState = YES;
        } else {
            self.selectState = NO;
        }
    }
    return self;
}

@end
