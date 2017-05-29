//
//  GoodsInfoModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "GoodsInfoModel.h"

@implementation GoodsInfoModel

-(instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        NSString *urlString = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        if ([urlString hasPrefix:@"http"]) {
            self.goodsImg = urlString;
        } else {
            self.goodsImg = [NSString stringWithFormat:@"%@%@",DeFaultURL,urlString];
        }
//        self.goodsImg   = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        self.goodsTitle = [dic getStringValueForKey:@"goods_name" defaultValue:nil];
        self.salePrice  = [dic getStringValueForKey:@"buy_price" defaultValue:nil];
        self.oldPrice   = [dic getStringValueForKey:@"old_price" defaultValue:nil];
        self.goodsCount = [dic getStringValueForKey:@"quantity" defaultValue:nil];
        self.goodsId    = [dic getStringValueForKey:@"goods_id" defaultValue:nil];
        self.specId     = [dic getStringValueForKey:@"spec_id" defaultValue:nil];
        self.tallyCount = [dic getArrayForKey:@"expend1"];
    }
    return self;
}

@end
