//
//  OrderDtaileModel.h
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfoModel.h"

@interface OrderDtaileModel : NSObject
//订单id
@property (nonatomic,strong) NSString *orderId;
//订单编号
@property (nonatomic,strong) NSString *orderNum;
//下单时间
@property (nonatomic,strong) NSString *creatTime;
//支付方式
@property (nonatomic,strong) NSString *payStatus;
//订单状态
@property (nonatomic,strong) NSString *orderStaus;
//派送方式
@property (nonatomic,strong) NSString *sendStaus;
//派送时间
@property (nonatomic,strong) NSString *sendTime;
//订单信息
@property (nonatomic,strong) NSMutableArray *orderInfo;
//收货人姓名
@property (nonatomic,strong) NSString *cossgineName;
//联系电话
@property (nonatomic,strong) NSString *linkPhone;
//收货区域
@property (nonatomic,strong) NSString *area;
//收货地址
@property (nonatomic,strong) NSString *addreess;
//商品数据
@property (nonatomic,strong) NSMutableArray *goodsData;
//商品信息
@property (nonatomic,strong) GoodsInfoModel *goodsInfo;
//金额数据
@property (nonatomic,strong) NSArray *goldArr;
//退款理由
@property (nonatomic,strong) NSString *content;
-(instancetype)initWithDic:(NSDictionary *)dic loseTime:(NSString *)loseTime;
@end
