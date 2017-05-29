//
//  GoodsInfoCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "GoodsInfoCell.h"

@implementation GoodsInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)setItem:(GoodsInfoModel *)item {
//    [_nowPriceLab removeFromSuperview];
//    [_oldPriceLab removeFromSuperview];
//    NSURL *url = [NSURL URLWithString:item.goodsImg];
//    _goodsImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    [self.contentView removeAllSubviews];
    
    _goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 90, 90)];
    [self.contentView addSubview:_goodsImg];
    _goodsTitle = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, ViewWidth - 200, 45)];
    _goodsTitle.numberOfLines = 0;
    _goodsTitle.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_goodsTitle];
    _countLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 75, ViewWidth - 120, 20)];
    _countLable.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
    [self.contentView addSubview:_countLable];
    
    [_goodsImg setImageWithURL:item.goodsImg placeholderImage:[UIImage imageNamed:@"goodsdef.png"]];
    _goodsTitle.text = item.goodsTitle;
    _countLable.text = [NSString stringWithFormat:@"数量:%@",item.goodsCount];
    NSString *salePrice = [NSString stringWithFormat:@"￥%@",item.salePrice];
    NSString *oldPrice  = [NSString stringWithFormat:@"￥%@",item.oldPrice];
//    商品卖出价格
    _nowPriceLab = [UILabel singleLineText:salePrice font:[UIFont systemFontOfSize:15] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#ff0000"]];
    _nowPriceLab.origin = CGPointMake(ViewWidth - _nowPriceLab.width - 15, 10);
    [self.contentView addSubview:_nowPriceLab];
//    商品原始价格
    _oldPriceLab = [UILabel singleLineText:oldPrice font:[UIFont systemFontOfSize:14] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#dfdfdd"]];
    _oldPriceLab.origin = CGPointMake(ViewWidth - _oldPriceLab.width - 15, 35);
    [self.contentView addSubview:_oldPriceLab];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth - _oldPriceLab.width - 20, 43, _oldPriceLab.width + 10, 0.5)];
    lineView.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [self.contentView addSubview:lineView];
    if (item.salePrice.floatValue == item.oldPrice.floatValue) {
        _oldPriceLab.hidden = YES;
        lineView.hidden = YES;
    } else {
        _oldPriceLab.hidden = NO;
        lineView.hidden = NO;
    }
//    添加标签
     NSArray *arr = @[@"#4fb6d0",@"#4fd1aa",@"#e7bc56"];
//    标签数组
    NSArray *tallyArr = item.tallyCount;
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat labelX = 120;
    if (item.tallyCount.count > 3) {
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 141 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.origin = CGPointMake(labelX, 50);
            label.layer.cornerRadius = 3.0;
            label.layer.masksToBounds = YES;
            labelX += label.width + 5;
            if (labelX - 5 > ViewWidth - lineView.width - 10) {
                return;
            } else {
                [self.contentView addSubview:label];
            }
        }
    } else {
        for (int i = 0; i < item.tallyCount.count; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 141 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.origin = CGPointMake(labelX, 50);
            label.layer.cornerRadius = 3.0;
            label.layer.masksToBounds = YES;
            labelX += label.width + 5;
            if (labelX - 5 > ViewWidth - lineView.width - 10) {
                return;
            } else {
                [self.contentView addSubview:label];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
