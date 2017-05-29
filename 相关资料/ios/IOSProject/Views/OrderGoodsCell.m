//
//  OrderGoodsCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderGoodsCell.h"

@implementation OrderGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)setItem:(ShoppingCartModel *)item {
    [self.contentView removeAllSubviews];
    //        商品图片
    _goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 80, 80)];
    [self.contentView addSubview:_goodsImg];
    //        商品标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 6, ViewWidth - 210, 30)];
    _titleLabel.textColor = [UIColor colorFromHexCode:@"#333333"];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    //        商品数量
    _goodsCont = [[UILabel alloc] initWithFrame:CGRectMake(110, 70, 60, 15)];
    _goodsCont.textColor = [UIColor colorFromHexCode:@"#757575"];
    _goodsCont.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_goodsCont];
    NSString *imageUrl;
    if ([item.imageName hasPrefix:@"http"]) {
        imageUrl = item.imageName;
    } else {
        imageUrl = [NSString stringWithFormat:@"%@%@",DeFaultURL,item.imageName];
    }
    [_goodsImg setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"goodsdef.png"]];
    _titleLabel.text = item.goodsTitle;
    NSString *salePrice = [NSString stringWithFormat:@"￥%@",item.goodsPrice];
    NSString *oldPrice  = [NSString stringWithFormat:@"￥%@",item.oldPrice];
//    商品卖出价格
    _salePrice = [UILabel singleLineText:salePrice font:[UIFont systemFontOfSize:15] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#ff0000"]];
    _salePrice.origin = CGPointMake(ViewWidth - _salePrice.width - 15, 6);
    [self.contentView addSubview:_salePrice];
//    商品原始价格
    _oldPrice = [UILabel singleLineText:oldPrice font:[UIFont systemFontOfSize:14] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#dfdfdd"]];
    _oldPrice.origin = CGPointMake(ViewWidth - _oldPrice.width - 15, 30);
    [self.contentView addSubview:_oldPrice];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth - _oldPrice.width - 20, 38, _oldPrice.width + 10, 0.5)];
    lineView.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [self.contentView addSubview:lineView];
    _goodsCont.text = [NSString stringWithFormat:@"数量：%ld",(long)item.goodsNum];
    
    if (item.goodsPrice.floatValue == item.oldPrice.floatValue) {
        _oldPrice.hidden = YES;
        lineView.hidden = YES;
    } else {
        _oldPrice.hidden = NO;
        lineView.hidden = NO;
    }
    
    NSArray *arr = @[@"#4fb6d0",@"#4fd1aa",@"#e7bc56"];
//    标签数组
    NSArray *tallyArr = item.tallyCount;
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat labelX = 110;
    if (item.tallyCount.count > 3) {
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 200 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.origin = CGPointMake(labelX, 45);
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
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 200 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.layer.cornerRadius = 15;
            label.origin = CGPointMake(labelX, 45);
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
