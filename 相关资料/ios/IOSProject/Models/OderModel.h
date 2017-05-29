//
//  OderModel.h
//  IOSProject
//
//  Created by IOS002 on 15/7/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfoModel.h"

@interface OderModel : NSObject
//订单Id
@property (nonatomic,strong) NSString *orderId;
//订单号
@property (nonatomic,strong) NSString *orderNum;
//支付状态
@property (nonatomic,strong) NSString *payStatus;
//创建时间
@property (nonatomic,strong) NSString *creatTime;
//产品价格
@property (nonatomic,strong) NSString *productPri;
//运送费用
@property (nonatomic,strong) NSString *sendFee;
//商品信息
@property (nonatomic,strong) NSMutableArray *goodsInfo;
-(instancetype)initWithDic:(NSDictionary *)dic loseTime:(NSString *)loseTime;
@end
