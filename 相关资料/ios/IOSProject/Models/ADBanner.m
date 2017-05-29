//
//  ADBanner.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ADBanner.h"

@implementation ADBanner

- (void)updateWithDictionary:(NSDictionary *)dic {
    self.ID = [dic getIntegerValueForKey:@"ad_id" defaultValue:0];
    NSString * headURL = [dic getStringValueForKey:@"ad_image" defaultValue:nil];
    if ([headURL hasPrefix:@"http"]) {
        self.headURL = headURL;
    } else {
        self.headURL = [NSString stringWithFormat:@"%@%@", DeFaultURL, headURL];
    }
    _strId = [dic getStringValueForKey:@"ad_id" defaultValue:nil];
}

@end
