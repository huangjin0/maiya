//
//  DataListControl.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/26/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _kLoadDataCount 20

@interface DataListControl : NSObject

@property (assign, nonatomic) BOOL hasMore;
@property (assign, nonatomic) NSInteger maxID;
@property (assign, nonatomic) NSInteger refreshCount;
@property (assign, nonatomic) NSInteger loadMoreCount;
@property (strong, nonatomic) NSMutableArray * contentArray;

@property (assign, nonatomic) BOOL isLoadMore;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger numberOfPage;

+ (id)object;

@end
