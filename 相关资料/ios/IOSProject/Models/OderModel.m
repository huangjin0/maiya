//
//  OderModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OderModel.h"

@implementation OderModel
-(instancetype)initWithDic:(NSDictionary *)dic loseTime:(NSString *)loseTime {
    if (self = [super init]) {
        self.goodsInfo  = [NSMutableArray array];
        self.orderId    = [dic getStringValueForKey:@"order_id" defaultValue:nil];
        self.orderNum   = [dic getStringValueForKey:@"order_number" defaultValue:nil];
//        self.payStatus  = [dic getStringValueForKey:@"pay_status" defaultValue:nil];
        self.creatTime  = [dic getStringValueForKey:@"create_time" defaultValue:nil];
        self.productPri = [dic getStringValueForKey:@"goods_amount" defaultValue:nil];
        self.sendFee    = [dic getStringValueForKey:@"shipping_fee" defaultValue:nil];
/**
 ***** payStatus 1、未支付 2、未收货 3、未评价 4、已完成 5、退款中
 */
        
//        支付方式
        NSString *payWay          = [dic getStringValueForKey:@"pay_way" defaultValue:nil];
//        支付状态
        NSString *payStatus       = [dic getStringValueForKey:@"pay_status" defaultValue:nil];
//        完成状态
        NSString *overStatus      = [dic getStringValueForKey:@"is_over" defaultValue:nil];
//        评论状态
         NSString *contentsStatus = [dic getStringValueForKey:@"is_contents" defaultValue:nil];
//        申请状态
        NSString *applyStatus     = [dic getStringValueForKey:@"apply_status" defaultValue:nil];
        if (([payWay intValue] == 1) && ([payStatus intValue] == 1) && ([overStatus intValue] == 2)) {
            NSDate *nowDate = [NSDate date];
            NSInteger tampTime = [nowDate timeIntervalSince1970];
            if (tampTime - [loseTime integerValue] >= [_creatTime integerValue]) {
                self.payStatus = @"0";
            } else {
                self.payStatus = @"1";
            }
        }
        if ([payWay intValue] == 2  && [overStatus intValue] == 2) {
            self.payStatus = @"2";
        }
        if (([payWay intValue] == 1 && [payStatus intValue] == 3) && [overStatus intValue] == 2 && [applyStatus intValue] == 1) {
            self.payStatus = @"3";
        }
        if ([overStatus intValue] == 1 && [contentsStatus intValue] == 2) {
            self.payStatus = @"4";
        }
        if ([overStatus intValue] == 1 && [contentsStatus intValue] == 1) {
            self.payStatus = @"5";
        }
        if ([overStatus intValue] == 1 && [applyStatus intValue] == 3) {
            self.payStatus = @"6";
        }
        if ([applyStatus intValue] == 2 && [overStatus intValue] == 2 && [payStatus intValue] == 3) {
            self.payStatus = @"7";
        }
        NSArray *arr    = [dic getArrayForKey:@"goods_lists"];
        for (NSDictionary *goodDic in arr) {
            GoodsInfoModel *model = [[GoodsInfoModel alloc] initWithDic:goodDic];
            [self.goodsInfo addObject:model];
        }
    }
    return self;
}

@end
