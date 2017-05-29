//
//  ClassOfGoodsModel.m
//  IOSProject
//
//  Created by IOS004 on 15/8/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassOfGoodsModel.h"

@implementation ClassOfGoodsModel

- (void)updateWithDictionary:(NSDictionary *)dic{
}
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        NSString *imgUrl  = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        if ([imgUrl hasPrefix:@"http"]) {
            self.goods_image = imgUrl;
        } else {
            self.goods_image = [NSString stringWithFormat:@"%@%@",DeFaultURL,imgUrl];
        }
        self.goods_id = [dic getIntegerValueForKey:@"goods_id" defaultValue:0];
        self.spec_id = [dic getStringValueForKey:@"spec_id" defaultValue:nil];
        self.shop_id = [dic getStringValueForKey:@"shop_id" defaultValue:nil];
        self.goods_name = [dic getStringValueForKey:@"goods_name" defaultValue:nil];
//        self.goods_image = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        self.quantity = [dic getStringValueForKey:@"spec_qty" defaultValue:nil];
    }
    return self;
}
@end
