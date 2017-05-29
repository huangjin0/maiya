//
//  ISH_NewClassGoods.m
//  IOSProject
//
//  Created by IOS002 on 16/6/4.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_NewClassGoods.h"

@implementation ISH_NewClassGoods

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _cart_id = [dic getIntegerValueForKey:@"cart_id" defaultValue:0];
        _p_id = [dic getIntegerValueForKey:@"p_id" defaultValue:0];
        _cate_name = [dic getStringValueForKey:@"cate_name" defaultValue:nil];
        _image = [dic getStringValueForKey:@"image" defaultValue:nil];
        
    }
    return self;
}

@end
