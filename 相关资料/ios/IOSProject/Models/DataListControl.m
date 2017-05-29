//
//  DataListControl.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/26/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "DataListControl.h"

@implementation DataListControl

+ (id)object {
    DataListControl * obj = [[DataListControl alloc] init];
    obj.hasMore = YES;
    obj.refreshCount = _kLoadDataCount;
    obj.loadMoreCount = _kLoadDataCount;
    obj.contentArray = [NSMutableArray array];
    obj.page = 1;
    return obj;
}

@end
