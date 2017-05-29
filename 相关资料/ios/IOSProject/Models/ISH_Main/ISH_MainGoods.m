//
//  ISH_MainGoods.m
//  IOSProject
//
//  Created by IOS002 on 16/6/3.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_MainGoods.h"

@implementation ISH_MainGoods

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _goods_id = [dic getIntegerValueForKey:@"goods_id" defaultValue:0];
        _spec_id = [dic getIntegerValueForKey:@"spec_id" defaultValue:0];
        _goods_sn = [dic getIntegerValueForKey:@"goods_sn" defaultValue:0];
        _goods_name = [dic getStringValueForKey:@"goods_name" defaultValue:nil];
        _goods_image = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
        _cate_name = [dic getStringValueForKey:@"cate_name" defaultValue:nil];
        _cate_id = [dic getIntegerValueForKey:@"cate_id" defaultValue:0];
        _goods_price = [dic getStringValueForKey:@"goods_price" defaultValue:nil];
        _old_price = [dic getStringValueForKey:@"old_price" defaultValue:nil];
    }
    return self;
}
@end
