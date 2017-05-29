//
//  RefundTableViewCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/28.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundTableViewCell : UITableViewCell

//退款理由文本输入框
@property (nonatomic,strong) UITextView *refundTextView;
//默认参数lab
@property (nonatomic,strong) UILabel *placeHolderLab;

@end
