//
//  RefundViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/7/28.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"
#import "OrderDtaileModel.h"

@protocol refundDelegate <NSObject>

-(void)overRefundWithPopView;

@end

@interface RefundViewController : BasicViewController

@property (nonatomic,strong) OrderDtaileModel *model;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,weak) id<refundDelegate>delegate;

@end
