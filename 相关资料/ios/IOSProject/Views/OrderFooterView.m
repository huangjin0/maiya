//
//  OrderFooterView.m
//  IOSProject
//
//  Created by IOS002 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderFooterView.h"

@implementation OrderFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        添加总金额
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 12.5, 40, 20)];
        totalLabel.text = @"总金额:";
        totalLabel.font = [UIFont systemFontOfSize:12];
        totalLabel.textColor = [UIColor blackColor];
        [self addSubview:totalLabel];
        _totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(65, 12.5, 60, 20)];
        _totalPrice.textColor = [UIColor colorFromHexCode:@"#ff0000"];
        _totalPrice.font = [UIFont systemFontOfSize:12];
        [self addSubview:_totalPrice];
        _contreinLab = [[UILabel alloc] initWithFrame:CGRectMake(125, 15, 40, 17.5)];
        _contreinLab.text = @"(含运费)";
        _contreinLab.textColor = [UIColor colorFromHexCode:@"#757575"];
        _contreinLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_contreinLab];
//        添加运费
        UILabel *sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 42.5, 30, 15)];
        sendLabel.text = @"运费:";
        sendLabel.textColor = [UIColor colorFromHexCode:@"#757575"];
        sendLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:sendLabel];
        _sendMoney = [[UILabel alloc] initWithFrame:CGRectMake(55, 42.5, 40, 15)];
        _sendMoney.textColor = [UIColor colorFromHexCode:@"#ff0000"];
        _sendMoney.font = [UIFont systemFontOfSize:10];
        [self addSubview:_sendMoney];
        _maxPrice = [[UILabel alloc] initWithFrame:CGRectMake(95, 42.5, 100, 15)];
//        _maxPrice.text = @"(订单满30元可免运费)";
        _maxPrice.textColor = [UIColor colorFromHexCode:@"#757575"];
        _maxPrice.font = [UIFont systemFontOfSize:10];
        [self addSubview:_maxPrice];
//        提交订单
        _referOrder = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 120, 20, 90, 30)];
        [_referOrder setTitle:@"提交订单" forState:UIControlStateNormal];
        [_referOrder setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
        [_referOrder setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
        [_referOrder addTarget:self action:@selector(referOrderAction) forControlEvents:UIControlEventTouchUpInside];
        _referOrder.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_referOrder];
        
    }
    return self;
}

-(void)referOrderAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(referOrder)]) {
        [_delegate referOrder];
    }
}

@end
