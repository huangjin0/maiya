//
//  OrderPayStateCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderPayStateCell.h"

@implementation OrderPayStateCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        支付方式
        CGFloat controlWith = self.contentView.width - 40;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 15,controlWith / 3 - 20, 20)];
        lable.text = @"支付方式";
        lable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lable];
//        支付宝支付
        _alipay = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipay.frame = CGRectMake(20 + controlWith / 3, 15, 20, 20);
        [_alipay setImage:[UIImage imageNamed:@"xuanzhong_no_ic@3x"] forState:UIControlStateNormal];
        [_alipay setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        [_alipay addTarget:self action:@selector(selectPayWayActionWithsend:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_alipay];
        
        _alipayText = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipayText.frame = CGRectMake(40 + controlWith / 3, 15, 60, 20);
        [_alipayText setTitle:@"支付宝" forState:UIControlStateNormal];
        _alipayText.titleLabel.font = [UIFont systemFontOfSize:15];
        [_alipayText setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        [_alipayText addTarget:self action:@selector(selectPayWayActionWithsend:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_alipayText];
        
//        货到付款支付
        _cashOD = [UIButton buttonWithType:UIButtonTypeCustom];
        _cashOD.frame = CGRectMake(20 + controlWith / 3 * 2, 15, 20, 20);
        [_cashOD setImage:[UIImage imageNamed:@"xuanzhong_no_ic@3x"] forState:UIControlStateNormal];
        [_cashOD setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        [_cashOD addTarget:self action:@selector(selectPayWayActionWithsend:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cashOD];
        
        _cashODText = [UIButton buttonWithType:UIButtonTypeCustom];
        _cashODText.frame = CGRectMake(40 + controlWith / 3 * 2, 15, 60, 20);
        [_cashODText setTitle:@"货到付款" forState:UIControlStateNormal];
        [_cashODText setTitleColor:[UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
        _cashODText.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cashODText addTarget:self action:@selector(selectPayWayActionWithsend:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cashODText];
    }
    return self;
}

-(void)selectPayWayActionWithsend:(UIButton *)sender {
    if (sender == _alipay || sender == _alipayText) {
        _alipay.selected = !_alipay.selected;
        if (_alipay.selected) {
            _cashOD.selected = NO;
        }
    } else {
        _cashOD.selected = !_cashOD.selected;
        if (_cashOD.selected) {
            _alipay.selected = NO;
        }
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(payStateWithState:)]) {
        NSString *str;
        if (_alipay.selected) {
            str = @"1";
        } else if (_cashOD.selected) {
            str = @"2";
        } else {
            str = @"3";
        }
        [_delegate payStateWithState:str];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
