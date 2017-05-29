//
//  CollectionCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/18.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 80, 80)];
        [self.contentView addSubview:_goodsImg];
        _goodsTitle = [[UILabel alloc] initWithFrame:CGRectMake(110, 3, ViewWidth - 160, 40)];
        _goodsTitle.textColor = [UIColor colorFromHexCode:@"#333333"];
        _goodsTitle.backgroundColor = [UIColor clearColor];
        _goodsTitle.font = [UIFont systemFontOfSize:15];
        _goodsTitle.numberOfLines = 0;
        [self.contentView addSubview:_goodsTitle];
        
        _tagView = [[UIView alloc] initWithFrame:CGRectMake(110, 48, ViewWidth - 190, 25)];
        _tagView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_tagView];
        
        _hasStocek = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - 75, 50, 30, 20)];
        _hasStocek.layer.cornerRadius = 5.0;
        [self.contentView addSubview:_hasStocek];
        
        _goodsCollectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goodsCollectBtn.frame = CGRectMake(ViewWidth - 45, 5, 40, 35);

        UIImageView *collectImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
        collectImg.image = [UIImage imageNamed:@"iSH_Shoucang"];
        [_goodsCollectBtn addSubview:collectImg];
        [_goodsCollectBtn addTarget:self action:@selector(cancalCollectionGoodsBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_goodsCollectBtn];
        _goodsAddCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goodsAddCartBtn.frame = CGRectMake(ViewWidth - 45, 55, 40, 35);
        UIImageView *addCartImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        addCartImg.image = [UIImage imageNamed:@"iSH_ShopCart"];
        [_goodsAddCartBtn addSubview:addCartImg];
        [_goodsAddCartBtn addTarget:self action:@selector(addGoodsToCartAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_goodsAddCartBtn];
        UIView *bootmView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, ViewWidth, 5)];
        bootmView.backgroundColor = Color_bkg_lightGray;
        [self.contentView addSubview:bootmView];
        
    }
    return self;
}

-(void)setItem:(CollectionModel *)item {
    [_goodsOldPri removeFromSuperview];
    [_goodsSalePri removeFromSuperview];
    [_tagView removeAllSubviews];
    [_lineView removeFromSuperview];
    [_goodsImg setImageWithURL:item.goodsImg placeholderImage:[UIImage imageNamed:@"goodsdef"]];
    _goodsTitle.text   = item.goodsTitle;
    NSString *salePrice = [NSString stringWithFormat:@"￥%.2f",[item.goodsSalePri floatValue]];
    NSString *oldPrice  = [NSString stringWithFormat:@"￥%.2f",[item.goodsOldPri floatValue]];
    
    _goodsSalePri = [UILabel singleLineText:salePrice font:[UIFont systemFontOfSize:15] wid:80 color:[UIColor colorFromHexCode:@"#ff0000"]];
    _goodsSalePri.origin = CGPointMake(110, 70);
    [self.contentView addSubview:_goodsSalePri];
    if (item.goodsSalePri.floatValue != item.goodsOldPri.floatValue) {
        _goodsOldPri = [UILabel singleLineText:oldPrice font:[UIFont systemFontOfSize:15] wid:80 color:[UIColor colorFromHexCode:@"#dfdfdd"]];
        _goodsOldPri.origin = CGPointMake(200, 70);
        [self.contentView addSubview:_goodsOldPri];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(195, 80, _goodsOldPri.width + 10, 0.5)];
        _lineView.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
        [self.contentView addSubview:_lineView];
    }
    if (item.hasStock) {
        _hasStocek.image = [UIImage imageNamed:@"iSH_hasGoods"];
    } else {
        _hasStocek.image = [UIImage imageNamed:@"hasnoGoods"];
    }
    //    标签数组
    NSArray *arr = @[@"#4fb6d0",@"#4fd1aa",@"#e7bc56"];
    NSArray *tallyArr =item.goodstag;
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat labelX = 0;
    if (item.goodstag.count > 3) {
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 141 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.origin = CGPointMake(labelX, 0);
            labelX += label.width + 5;
            if (labelX - 5 > _tagView.width) {
                return;
            } else {
                [_tagView addSubview:label];
            }
        }
    } else {
        for (int i = 0; i < item.goodstag.count; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 141 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.origin = CGPointMake(labelX, 0);
            labelX += label.width + 5;
            if (labelX - 5 > _tagView.width) {
                return;
            } else {
                [_tagView addSubview:label];
            }
        }
    }

}

-(void)cancalCollectionGoodsBtnAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(cancelCollectionWithcell:)]) {
        [_delegate cancelCollectionWithcell:self];
    }
}

-(void)addGoodsToCartAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(addGoodsTocartWithcell:)]) {
        [_delegate addGoodsTocartWithcell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
