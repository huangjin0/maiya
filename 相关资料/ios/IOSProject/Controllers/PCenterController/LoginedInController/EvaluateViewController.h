//
//  EvaluateViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"

@interface EvaluateViewController : BasicViewController

//待评价订单号
@property (nonatomic,strong) NSString *orderId;
//待评价的商品
@property (nonatomic,strong) NSArray *goodsData;

@end
