//
//  MyOrderCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MyOrderCell.h"

#define titleFont  [UIFont systemFontOfSize:15]
#define titleWidth  ViewWidth - 150
#define titleColor  [UIColor colorFromHexCode:@"#757575"]


@implementation MyOrderCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *topBKView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 5)];
        topBKView.backgroundColor = Color_bkg_lightGray;
        [self.contentView addSubview:topBKView];
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 150, 20)];
        _dateLable.textColor = [UIColor colorFromHexCode:@"#757575"];
        _dateLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_dateLable];
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 29, ViewWidth - 40, 0.5)];
        lineView1.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
        [self.contentView addSubview:lineView1];
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 92, ViewWidth - 40, 0.5)];
        lineView2.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
        [self.contentView addSubview:lineView2];
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(20, 98, 40, 23)];
        label.text = @"实付款:";
        label.textColor = [UIColor colorFromHexCode:@"#757575"];
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        
        _payMoney = [[UILabel alloc] initWithFrame:CGRectMake(60, 98, 250, 23)];
        _payMoney.textColor = [UIColor colorFromHexCode:@"#ff0000"];
        _payMoney.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_payMoney];
        
        _crcleImg = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - 80, 98, 65, 23)];
        _crcleImg.layer.cornerRadius = 5.0;
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(ViewWidth - 79.5, 98.5, 64, 22);
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        _button.layer.cornerRadius = 5.0;
        _button.backgroundColor = [UIColor whiteColor];
        [_button addTarget:self action:@selector(everyStautsBtnActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_crcleImg];
        [self.contentView addSubview:_button];
    }
    return self;
}

-(void)setItem:(OderModel *)item {
    [_orderState removeFromSuperview];
    [_scrollView removeFromSuperview];
    [_deleteBtn  removeFromSuperview];
    NSDate *tmpDate = [NSDate dateWithTimeIntervalSince1970:[item.creatTime intValue]];
    _dateLable.text = [tmpDate stringFromDate:@"yyyy-MM-dd hh:mm"];
    CGFloat payNum = [item.productPri floatValue] + [item.sendFee floatValue];
    _payMoney.text = [NSString stringWithFormat:@"￥%.2f",payNum];
    switch ([item.payStatus intValue]) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 7:
        {
            _orderState = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth - 60, 7, 50, 20)];
            _orderState.textColor = [UIColor colorFromHexCode:@"#757575"];
            _orderState.font = [UIFont systemFontOfSize:12];
            [self.contentView addSubview:_orderState];
             _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 29.5, ViewWidth, 62.5)];
            _scrollView.backgroundColor = [UIColor whiteColor];
            _scrollView.scrollEnabled = YES;
            [self.contentView addSubview:_scrollView];
            
            switch ([item.payStatus intValue]) {
                case 0:
                    _orderState.text = @"订单失效";
                    [_button setTitle:@"取消订单" forState:UIControlStateNormal];
                    _button.tag = 0;
                    break;
                case 1:
                    _orderState.text = @"待付款";
                    [_button setTitle:@"立即支付" forState:UIControlStateNormal];
                    _button.tag = 1;
                    break;
                case 2:
                    _orderState.text = @"待收货";
                    [_button setTitle:@"派送中.." forState:UIControlStateNormal];
                    break;
                case 3:
                    _orderState.text = @"待收货";
                    [_button setTitle:@"确认收货" forState:UIControlStateNormal];
                    _button.tag = 2;
                    break;
                case 7:
                    _orderState.text = @"待退款";
                    [_button setTitle:@"取消退款" forState:UIControlStateNormal];
                    _button.tag = 7;
                    break;
                default:
                    _orderState.text = @"待评价";
                    [_button setTitle:@"马上评价" forState:UIControlStateNormal];
                    _button.tag = 3;
                    break;
            }
            [self addgoodInfoWithScrollView:ViewWidth goodsInfo:item.goodsInfo];
        }
            break;
            
        default:
        {
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 29.5, ViewWidth - 80, 62.5)];
            _scrollView.backgroundColor = [UIColor whiteColor];
            _scrollView.scrollEnabled = YES;
            [self.contentView addSubview:_scrollView];
            
            _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _deleteBtn.frame = CGRectMake(ViewWidth - 40, 7, 20, 20);
            [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete_ic_press"] forState:UIControlStateNormal];
            [_deleteBtn addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_deleteBtn];
            
            [_button setTitle:@"再次购买" forState:UIControlStateNormal];
            _button.tag = 4;
            
            [self addgoodInfoWithScrollView:ViewWidth - 80 goodsInfo:item.goodsInfo];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - 70, 35, 50, 50)];
            if ([item.payStatus intValue] == 5) {
                imageView.image = [UIImage imageNamed:@"grcenter_pic_yiwc"];
            } else {
                imageView.image = [UIImage imageNamed:@"grcenter_pic_yitk"];
            }
            [self.contentView addSubview:imageView];
        }
            break;
    }
    if ([item.payStatus intValue] == 2) {
        [_button setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;
        _crcleImg.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
    } else {
        [_button setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
        _button.userInteractionEnabled = YES;
        _crcleImg.backgroundColor = RGBCOLOR(255, 95, 5);
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGoodsInfo)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_scrollView addGestureRecognizer:tapGestureRecognizer];
}


/**
 * 删除订单
 */
-(void)deleteOrder {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(deleteOrderWithCell:)]) {
        [_delegate deleteOrderWithCell:self];
    }
}
/**
 * 不同状态按钮
 */
-(void)everyStautsBtnActionWithSender:(UIButton *)sender {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(everyStautsBtnWithCell:status:)]) {
        [_delegate everyStautsBtnWithCell:self status:sender.tag];
    }
}

/**
 * 点击商品信息
 */
-(void)tapGoodsInfo {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(tapToDetaileOrderWithCell:)]) {
        [_delegate tapToDetaileOrderWithCell:self];
    }
}

/**
 * 添加商品信息
 */
-(void)addgoodInfoWithScrollView:(CGFloat)scrollViewWidth goodsInfo:(NSArray *)goodsInfo {
    if (goodsInfo.count == 1) {
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 48, 48)];
        GoodsInfoModel *model = [goodsInfo objectAtIndex:0];
        [headImg setImageWithURL:model.goodsImg placeholderImage:[UIImage imageNamed:@"goodsdef"]];
        UILabel *titleLabel = [UILabel linesText:model.goodsTitle font:[UIFont systemFontOfSize:14] wid:ViewWidth - 160 lines:2];
        titleLabel.origin = CGPointMake(80, 15);
        [_scrollView addSubview:titleLabel];
        [_scrollView addSubview:headImg];
        _scrollView.contentSize = CGSizeMake(scrollViewWidth, 62.5);
    } else {
        CGFloat imgX = 20;
        for (GoodsInfoModel *model in goodsInfo) {
            UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, 7, 48, 48)];
            imgX += 55;
            [headImg setImageWithURL:model.goodsImg placeholderImage:[UIImage imageNamed:@"goodsdef"]];
            [_scrollView addSubview:headImg];
        }
        CGFloat contentSizeW = _scrollView.width > imgX ? _scrollView.width : imgX;
        _scrollView.contentSize = CGSizeMake(contentSizeW, 62.5);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
