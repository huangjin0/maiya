//
//  RightTableViewCell.h
//  IOSProject
//
//  Created by IOS004 on 15/6/10.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicCell.h"

@protocol RightTableViewcellDelegate <NSObject>

@optional
- (void)listOfGoodsSender:(UIButton *)sender;

@end

@interface RightTableViewCell : BasicCell

@property (nonatomic, strong) NSMutableDictionary * rightData;
@property (nonatomic, strong) NSMutableDictionary * rightlogo;
@property (nonatomic, weak) id <RightTableViewcellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) void (^TapActionBlock)(NSInteger pageIndex ,NSInteger money ,NSString *key);


@end
