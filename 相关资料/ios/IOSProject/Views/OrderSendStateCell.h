//
//  OrderSendStateCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendStateSelectedDelegate <NSObject>

-(void)sendStateSelect;

@end

@interface OrderSendStateCell : UITableViewCell
//选择派送方式
@property (nonatomic,strong) UIButton *sendStateBtn;
//显示派送方式
@property (nonatomic,strong) UILabel *sendStateLabel;
//显示营业时间
@property (nonatomic,strong) UILabel *bussinissTime;
//派送方式委托
@property (nonatomic,weak) id <sendStateSelectedDelegate> delegate;

@end
