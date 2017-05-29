//
//  CartFooterView.m
//  IOSProject
//
//  Created by IOS002 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CartFooterView.h"

@implementation CartFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个全选文本框标签
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 50, 30)];
        lab.text = @"全选";
        lab.textColor = [UIColor colorFromHexCode:@"#757575"];
        [self addSubview:lab];
        
        //添加全选图片按钮
        _allSelectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectbtn.frame = CGRectMake(5, 10, 40, 40);
        [_allSelectbtn setImage:[UIImage imageNamed:@"xuanzhong_no_ic.png"] forState:UIControlStateNormal];
        [_allSelectbtn setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        _allSelectbtn.selected = YES;
        [_allSelectbtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_allSelectbtn];
        
        //添加总金额文本框
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 100, 30)];
        lab2.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab2.font = [UIFont systemFontOfSize:12];
        lab2.text = @"总金额：";
        [self addSubview:lab2];
        
        //在总价格前面添加人民币符号
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(120, 25, 15, 15)];
        label.text = @"￥";
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor colorFromHexCode:@"#ff0000"];
        [self addSubview:label];
        
        //添加总价格文本框，用于显示总价
        _allPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 15, 100, 30)];
        _allPricelabel.textColor = [UIColor colorFromHexCode:@"#ff0000"];
        _allPricelabel.text = @"0.0";
        _allPricelabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_allPricelabel];
        
        //添加运费，满30元免运费；
//        UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 100, 30)];
//        lab3.textColor = [UIColor colorFromHexCode:@"#333333"];
//        lab3.font = [UIFont systemFontOfSize:9];
//        lab3.text = @"运费:";
//        [self addSubview:lab3];
//        
//        //添加运费框，用于显示价格
//        _allFreight = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 100, 30)];
//        _allFreight.textColor = [UIColor colorFromHexCode:@"#ff0000"];
////        _allFreight.text = @"￥3.00";
//        _allFreight.font = [UIFont systemFontOfSize:11];
//        [self addSubview:_allFreight];
//        
//        //运费满30元可免运费
//        _maxPrice = [[UILabel alloc] initWithFrame:CGRectMake(140, 25, 100, 30)];
////        lab4.text = @"(订单满30元可免运费)";
//        _maxPrice.font = [UIFont systemFontOfSize:9];
//        _maxPrice.textColor = [UIColor colorFromHexCode:@"#999999"];
//        [self addSubview:_maxPrice];
        
        //添加一个结算按钮
        _settlementBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [_settlementBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_settlementBtn setTitleColor:[UIColor colorFromHexCode:@"#ffffff"] forState:UIControlStateNormal];
        _settlementBtn.frame = CGRectMake(ViewWidth - 85, 15, 70, 30);
        _settlementBtn.backgroundColor = RGBCOLOR(255, 95, 5);
        [_settlementBtn addTarget:self action:@selector(settlementPage) forControlEvents:UIControlEventTouchUpInside];
        _settlementBtn.userInteractionEnabled= NO;
        [self addSubview:_settlementBtn];
    }
    return self;
}

//是否全选
-(void)selectBtnClick:(UIButton *)sender {
    BOOL state;
    if (sender.selected) {
        state = YES;
    } else {
        state = NO;
    }
    sender.selected = !sender.selected;
    if (_delegate != nil && [_delegate respondsToSelector:@selector(allSelectedOrderListWithState:)]) {
        [_delegate allSelectedOrderListWithState:state];
    }
}

//结算按钮
-(void)settlementPage {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(settlementOrderList)]) {
        [_delegate settlementOrderList];
    }
    
}


@end
