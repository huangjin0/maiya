//
//  Recommend.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "Recommend.h"

@implementation Recommend

- (void)updateWithDictionary:(NSDictionary *)dic {
    NSString * headURL = [dic getStringValueForKey:@"ad_image" defaultValue:nil];
    if ([headURL hasPrefix:@"http"]) {
        self.headURL = headURL;
    } else {
        self.headURL = [NSString stringWithFormat:@"%@%@", DeFaultURL, headURL];
    }
    self.content = [dic getStringValueForKey:@"ad_name" defaultValue:nil];
    self.ad_id = [dic getStringValueForKey:@"ad_id" defaultValue:nil];
}

@end
