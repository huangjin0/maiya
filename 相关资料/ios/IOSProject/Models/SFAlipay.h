//
//  SFAlipay.h
//  IOSProject
//
//  Created by sfwen on 5/26/15.
//  Copyright (c) 2015 CC Inc. All rights reserved.
//

#import "CCModel.h"

@interface SFAlipay : CCModel

#pragma mark - 支付宝
@property (strong, nonatomic) NSString * partner;//合作者id
@property (strong, nonatomic) NSString * seller_id;//商家账号
@property (strong, nonatomic) NSString * out_trade_no;//订单号
@property (strong, nonatomic) NSString * subject;//产品名称
@property (strong, nonatomic) NSString * body;//产品介绍
@property (strong, nonatomic) NSString * total_fee;//总价格
@property (strong, nonatomic) NSString * notify_url;//回调地址
@property (strong, nonatomic) NSString * service;//服务接口地址
@property (strong, nonatomic) NSString * payment_type;//支付类型
@property (strong, nonatomic) NSString * _input_charset;//编码方式
@property (strong, nonatomic) NSString * it_b_pay;//未交易超时时间
@property (strong, nonatomic) NSString * show_url;//
@property (strong, nonatomic) NSString * sign;//

@end
