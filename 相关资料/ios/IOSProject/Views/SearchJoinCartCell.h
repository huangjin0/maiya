//
//  SearchJoinCartCell.h
//  IOSProject
//
//  Created by IOS004 on 15/8/19.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@class SearchJoinCartCell;
@protocol searchbarDelegate <NSObject>

- (void)searchJoinSuccess:(SearchJoinCartCell *)cell;

@end

@class SearchCartSuccessModel;

@interface SearchJoinCartCell : BasicCell

@property (assign, nonatomic)id<searchbarDelegate>delegate;
@property (strong, nonatomic)SearchCartSuccessModel * item;

@end
