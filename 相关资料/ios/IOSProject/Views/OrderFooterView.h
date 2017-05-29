//
//  OrderFooterView.h
//  IOSProject
//
//  Created by IOS002 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol referOrderDelegate <NSObject>

-(void)referOrder;

@end
@interface OrderFooterView : UIView
//总金额
@property (nonatomic,strong) UILabel *totalPrice;
//运费
@property (nonatomic,strong) UILabel *sendMoney;
//含运费
@property (nonatomic,strong) UILabel *contreinLab;
//可免运费金额
@property (nonatomic,strong) UILabel *maxPrice;
//提交订单
@property (nonatomic,strong) UIButton *referOrder;
//添加提交订单委托
@property (nonatomic,weak) id<referOrderDelegate>delegate;

@end
