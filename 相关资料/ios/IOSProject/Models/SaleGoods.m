//
//  SaleGoods.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "SaleGoods.h"

@implementation SaleGoods

- (void)updateWithDictionary:(NSDictionary *)dic {
    self.name = [dic getStringValueForKey:@"ad_name" defaultValue:nil];
    self.ID = [dic getIntegerValueForKey:@"ad_id" defaultValue:0];
    self.goods_id = [dic getStringValueForKey:@"goods_id" defaultValue:nil];
}

@end
