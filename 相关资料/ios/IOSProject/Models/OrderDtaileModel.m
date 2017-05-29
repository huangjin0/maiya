//
//  OrderDtaileModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderDtaileModel.h"

@implementation OrderDtaileModel

-(instancetype)initWithDic:(NSDictionary *)dic loseTime:(NSString *)loseTime {
    if (self = [super init]) {
        self.goodsData = [NSMutableArray array];
        self.orderId = [dic getStringValueForKey:@"order_id" defaultValue:nil];
        self.orderNum = [dic getStringValueForKey:@"order_number" defaultValue:nil];
//        [NSDate dateWithTimeIntervalSince1970:[item.creatTime intValue]
        NSString *timeStr = [dic getStringValueForKey:@"create_time" defaultValue:nil];
        NSDate *tampDate = [NSDate dateWithTimeIntervalSince1970:[timeStr intValue]];
        self.creatTime = [tampDate stringFromDate:@"yyyy-MM-dd HH:mm"];
        if ([[dic getStringValueForKey:@"pay_way" defaultValue:nil] intValue] == 1) {
            self.payStatus = @"支付宝";
        } else {
            self.payStatus = @"货到付款";
        }
        switch ([[dic getStringValueForKey:@"hav_status" defaultValue:nil] intValue]) {
            case 1:
                self.orderStaus = @"未发货";
                break;
            case 2:
                self.orderStaus = @"发货中";
                break;
            default:
                self.orderStaus = @"已收货";
                break;
        }
        switch ([[dic getStringValueForKey:@"delivery_type" defaultValue:nil] intValue]) {
            case 1:
                self.sendStaus = @"定时派送";
                break;
            case 2:
                self.sendStaus = @"即时派送";
                break;
            default:
                self.sendStaus = @"上门自提";
                break;
        }
        self.orderInfo = [NSMutableArray arrayWithArray:@[self.orderNum,self.creatTime,self.payStatus,self.orderStaus,self.sendStaus]];
        if ([dic getIntegerValueForKey:@"delivery_type" defaultValue:0] == 1) {
            NSTimeInterval startTime = [dic getIntegerValueForKey:@"best_start_time" defaultValue:0];
            NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startTime];
            NSString *startStr = [startDate stringFromDate:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval endTime = [dic getIntegerValueForKey:@"best_end_time" defaultValue:0];
            NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime];
            NSString *endStr = [endDate stringFromDate:@"HH:mm"];
            NSString *timeStr = [NSString stringWithFormat:@"%@ - %@",startStr,endStr];
            [self.orderInfo addObject:timeStr];
        }
        NSString *goodsPrice = [dic getStringValueForKey:@"goods_amount" defaultValue:nil];
        NSString *sendsPrice = [dic getStringValueForKey:@"shipping_fee" defaultValue:nil];
        CGFloat totalGold = [goodsPrice floatValue] + [sendsPrice floatValue];
        NSString *totalPrice = [NSString stringWithFormat:@"%.2f",totalGold];
        self.goldArr = @[goodsPrice,sendsPrice,totalPrice];
        NSDictionary *orderAdd = [dic getDictionaryForKey:@"order_address"];
        self.cossgineName = [orderAdd getStringValueForKey:@"link_uname" defaultValue:nil];
        self.linkPhone = [orderAdd getStringValueForKey:@"tel" defaultValue:nil];
        self.addreess = [orderAdd getStringValueForKey:@"address" defaultValue:nil];
        self.area = [orderAdd getStringValueForKey:@"area" defaultValue:nil];
        
        NSArray *goodsArr = [dic getArrayForKey:@"goods_lists"];
        for (NSDictionary *goodsDic in goodsArr) {
            self.goodsInfo = [[GoodsInfoModel alloc] initWithDic:goodsDic];
            [self.goodsData addObject:self.goodsInfo];
        }
        NSDictionary *appleyInfo = [dic getDictionaryForKey:@"apply_info"];
        _content = [appleyInfo getStringValueForKey:@"content" defaultValue:nil];
    }
    return self;
}

@end
