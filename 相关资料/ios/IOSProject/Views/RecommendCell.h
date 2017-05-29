//
//  RecommendCell.h
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"
#import <UIKit/UIKit.h>

@class RecommendCell;
@protocol recommendDelegate <NSObject>

- (void)recommendValue:(RecommendCell *)cell;

@end

@class Recommend;

@interface RecommendCell : BasicCell

@property (assign , nonatomic)id<recommendDelegate> delegated;
@property (strong, nonatomic) Recommend * item;

+ (CGFloat)heightForCell:(Recommend *)item;

@end
