//
//  BannerCollectionShoppingCartModel.m
//  IOSProject
//
//  Created by IOS004 on 15/8/18.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BannerCollectionShoppingCartModel.h"

@implementation BannerCollectionShoppingCartModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
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
    }
    return self;
}

@end
