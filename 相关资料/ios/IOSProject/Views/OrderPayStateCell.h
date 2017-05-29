//
//  OrderPayStateCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol payStateDelegate <NSObject>

-(void)payStateWithState:(NSString *)state;

@end

@interface OrderPayStateCell : UITableViewCell
//支付宝
@property (nonatomic,strong) UIButton *alipay;
//支付宝字体
@property (nonatomic,strong) UIButton *alipayText;
//货到付款
@property (nonatomic,strong) UIButton *cashOD;
//货到付款字体
@property (nonatomic,strong) UIButton *cashODText;
//货到付款lab
@property (nonatomic,strong) UILabel *cashODLab;
//添加代理
@property (nonatomic,strong) id<payStateDelegate>delegate;
@end
