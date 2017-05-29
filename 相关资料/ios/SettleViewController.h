//
//  SettleViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"

@interface SettleViewController : BasicViewController
@property (nonatomic,assign) NSInteger type;
//勾选商品
@property (nonatomic,strong) NSArray *goodsInfo;
//总金额
@property (nonatomic,strong) NSString *totalPrice;
//运费
@property (nonatomic,strong) NSString *shipfee;
//订单满免运费金额
@property (nonatomic,strong) NSString *maxPrice;
@end
