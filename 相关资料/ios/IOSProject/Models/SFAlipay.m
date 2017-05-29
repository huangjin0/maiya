//
//  SFAlipay.m
//  IOSProject
//
//  Created by sfwen on 5/26/15.
//  Copyright (c) 2015 CC Inc. All rights reserved.
//

#import "SFAlipay.h"

@implementation SFAlipay

- (void)updateWithDictionary:(NSDictionary *)dic {
    self.partner = [dic getStringValueForKey:@"partner" defaultValue:nil];
    self.seller_id = [dic getStringValueForKey:@"seller_id" defaultValue:nil];
    self.out_trade_no = [dic getStringValueForKey:@"out_trade_no" defaultValue:nil];
    self.subject = [dic getStringValueForKey:@"subject" defaultValue:nil];
    self.body = [dic getStringValueForKey:@"body" defaultValue:nil];
    self.total_fee = [dic getStringValueForKey:@"total_fee" defaultValue:nil];
    self.notify_url = [dic getStringValueForKey:@"notify_url" defaultValue:nil];
    self.service = [dic getStringValueForKey:@"service" defaultValue:nil];
    self.payment_type = [dic getStringValueForKey:@"payment_type" defaultValue:nil];
    self._input_charset = [dic getStringValueForKey:@"_input_charset" defaultValue:nil];
    self.it_b_pay = [dic getStringValueForKey:@"it_b_pay" defaultValue:nil];
    self.show_url = [dic getStringValueForKey:@"show_url" defaultValue:nil];
    self.sign = [dic getStringValueForKey:@"sign" defaultValue:nil];
}

@end
