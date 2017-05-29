//
//  AreaTableViewCell.h
//  IOSProject
//
//  Created by IOS002 on 15/8/19.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AreaTableViewCell;

@protocol AreaDelegate <NSObject>

-(void)tapTableViewWithCell:(AreaTableViewCell *)cell;

@end

@interface AreaTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *areaLable;
@property (nonatomic,weak) id<AreaDelegate>delegate;

@end
