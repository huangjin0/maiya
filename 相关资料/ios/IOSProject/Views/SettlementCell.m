//
//  SettlementCell.m
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "SettlementCell.h"
#import "AddAdressViewController.h"
#import "OrderDetailsViewController.h"

@implementation SettlementCell{
    UIButton * _adressbtn;
}

- (void) setSettlementCell{
    [self cleanUpSubviews];
    NSInteger p = 5; //添加购物车商品数量
    if (0 == _settlementIndexPath.row) {
        _adressbtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100, 20, 200, 30)];
        [_adressbtn setTitle:@"+添加收货地址" forState:UIControlStateNormal];
        [_adressbtn setTitleColor:[UIColor colorFromHexCode:@"#489925"] forState:UIControlStateNormal];
        [_adressbtn addTarget:self action:@selector(receivingAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_adressbtn];
    }else if (1 == _settlementIndexPath.row){
        UIImageView * backgroudImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        backgroudImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
        [self.contentView addSubview:backgroudImage];
    }
    for (NSInteger i = 2; i < p; i ++) {
        if (i == _settlementIndexPath.row) {
            UIImageView * imageBackground = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 80, 80)];
            imageBackground.image = [UIImage imageNamed:@"hongzao"];
            [self.contentView addSubview:imageBackground];
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(110, 6, 180, 20)];
            lab.text = @"商品标题商品标题";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:12];
            lab.numberOfLines = 2;
            [self.contentView addSubview:lab];
            UILabel * priceLab = [[UILabel alloc] initWithFrame:CGRectMake(250, 6, 80, 20)];
            priceLab.text = @"10";
            priceLab.textColor = [UIColor colorFromHexCode:@"#ff0000"];
            priceLab.font = [UIFont systemFontOfSize:15];
            priceLab.textColor = [UIColor redColor];
            [self.contentView addSubview:priceLab];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(235, 10, 15, 15)];
            label.text = @"￥";
            label.textColor = [UIColor colorFromHexCode:@"#ff0000"];
            [self.contentView addSubview:label];
            UILabel * labelNum = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 30, 15)];
            labelNum.text = @"数量:";
            labelNum.textColor = [UIColor colorFromHexCode:@"#757575"];
            labelNum.font = [UIFont systemFontOfSize:12];
            [self.contentView addSubview:labelNum];
        }
    }
    if (p == _settlementIndexPath.row) {
        UIImageView * backgroudImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 15)];
        backgroudImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
        [self.contentView addSubview:backgroudImage];
    }else if (p + 1 == _settlementIndexPath.row){
        self.textLabel.text = @"派送方式";
        UIButton * choiceAdressbtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 16, 100, 20)];
        [choiceAdressbtn setTitle:@"请选择" forState:UIControlStateNormal];
        [choiceAdressbtn setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        [choiceAdressbtn addTarget:self action:@selector(differentWay) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:choiceAdressbtn];
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 200, 20)];
        lab.text = @"营业时间 9：00-22：00";
        lab.textColor = [UIColor colorFromHexCode:@"#d9a325"];
        lab.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:lab];
    }else if (p + 2 == _settlementIndexPath.row){
        self.textLabel.text = @"支付方式";
        UIButton * allpybtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 16, 80, 20)];
        [allpybtn setTitle:@"支付宝" forState:UIControlStateNormal];
        [allpybtn setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        UIButton * backbtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 16, 80, 20)];
        [backbtn setTitle:@"货到付款" forState:UIControlStateNormal];
        [backbtn setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        [self.contentView addSubview:allpybtn];
        [self.contentView addSubview:backbtn];
    }else if (p + 3 == _settlementIndexPath.row){
        UIImageView * backgroudImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        backgroudImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
        [self.contentView addSubview:backgroudImage];
    }else if (p + 4 == _settlementIndexPath.row){
        UILabel * totollab = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 80, 20)];
        totollab.text = @"总金额:";
        totollab.textColor = [UIColor blackColor];
        [self.contentView addSubview:totollab];
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, 80, 20)];
        lab.text = @"运费:";
        lab.textColor = [UIColor blackColor];
        [self.contentView addSubview:lab];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(200, 15, 80, 40)];
        [button setTitle:@"提交订单" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorFromHexCode:@"#dfdfdd"];
        [button addTarget:self action:@selector(submitOrders) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}

//添加收货店址；
- (void)receivingAddress{
    if (_delegate && [_delegate respondsToSelector:@selector(receivingAddress)]) {
        [_delegate receivingAddress];
    }
    UIViewController * vc = [SettlementCell viewController:self];
    AddAdressViewController * adress = [[AddAdressViewController alloc] init];
    [vc.navigationController pushViewController:adress animated:YES];
}
//选择派送方式；
- (void)differentWay{
}
//提交订单
- (void)submitOrders{
    if (_delegate && [_delegate respondsToSelector:@selector(submitOrders)]) {
        [_delegate submitOrders];
    }
    UIViewController * viewcontroller = [SettlementCell viewController:self];
    OrderDetailsViewController * order = [[OrderDetailsViewController alloc] init];
    [viewcontroller.navigationController pushViewController:order animated:YES];
}

//神奇的东西,view中取到所在当前控制器
+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

@end
