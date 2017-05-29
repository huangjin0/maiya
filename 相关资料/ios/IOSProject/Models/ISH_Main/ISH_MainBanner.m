//
//  ISH_MainBanner.m
//  IOSProject
//
//  Created by IOS002 on 16/6/2.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_MainBanner.h"

@implementation ISH_MainBanner

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _ad_id = [dic getIntegerValueForKey:@"ad_id" defaultValue:0];
        _ad_name = [dic getStringValueForKey:@"ad_name" defaultValue:nil];
        _ad_image = [dic getStringValueForKey:@"ad_image" defaultValue:nil];
    }
    return self;
}

@end
