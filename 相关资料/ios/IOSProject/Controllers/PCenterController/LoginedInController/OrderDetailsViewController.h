//
//  OrderDetailsViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"

@protocol backToMyOrderDelegate <NSObject>
@optional
-(void)backToMyOrderWithOrderId:(NSString *)orderId sender:(NSInteger)sender;
-(void)backTomyOrderToPayWithOrderId:(NSString *)orderId;
-(void)backToRefundOrder;
-(void)backToMyOrderWithStatus:(NSString *)status;
@end

@interface OrderDetailsViewController : BasicViewController
//订单号
@property (nonatomic,strong) NSString *oderId;
//订单状态
@property (nonatomic,strong) NSString *orderStatus;
//添加代理
@property (nonatomic,strong) id<backToMyOrderDelegate>delegate;

@property (nonatomic,assign) NSInteger type;
@end
