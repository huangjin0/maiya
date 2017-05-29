//
//  ISH_ImgUrl.m
//  IOSProject
//
//  Created by IOS002 on 16/6/2.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_ImgUrl.h"

@implementation ISH_ImgUrl

+ (NSString *)ish_imgUrlWithStr:(NSString *)str {
    if ([str hasPrefix:@"http:"]) {
        return str;
    }
    return [NSString stringWithFormat:@"%@%@",DeFaultURL,str];
}

@end
