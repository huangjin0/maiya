//
//  Goods.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (void)updateWithDictionary:(NSDictionary *)dic {
    self.ID = [dic getIntegerValueForKey:@"goods_id" defaultValue:0];
    NSString * headURL = [dic getStringValueForKey:@"goods_image" defaultValue:nil];
    self.title = [dic getStringValueForKey:@"goods_name" defaultValue:nil];
    if ([headURL hasPrefix:@"http"]) {
        self.headURL = headURL;
    } else {
        self.headURL = [NSString stringWithFormat:@"%@%@", DeFaultURL, headURL];
    }
    self.price = [dic getFloatValueForKey:@"goods_price" defaultValue:0];
    self.salePrice = [dic getFloatValueForKey:@"old_price" defaultValue:0];
    self.goods_id = [dic getStringValueForKey:@"goods_id" defaultValue:nil];
}

@end
