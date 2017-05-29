//
//  AddressModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/14.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = [dic getStringValueForKey:@"link_uname" defaultValue:nil];
        self.phone = [dic getStringValueForKey:@"tel" defaultValue:nil];
        self.area = [dic getStringValueForKey:@"extend1" defaultValue:nil];
        self.address = [dic getStringValueForKey:@"address" defaultValue:nil];
    }
    return self;
}

@end
