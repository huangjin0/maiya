//
//  ISH_MainGoodsCell.m
//  IOSProject
//
//  Created by IOS002 on 16/6/2.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_MainGoodsCell.h"

@implementation ISH_MainGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(ISH_MainGoods *)item {
    [_goodsImg setImageWithURL:[ISH_ImgUrl ish_imgUrlWithStr:item.goods_image] placeholderImage:[UIImage imageNamed:@"goodsdef"]];
    _goodsTitle.text = item.goods_name;
    NSString *priceStr = [NSString stringWithFormat:@"￥%@",item.goods_price];
    NSMutableAttributedString *attributePriceStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attributePriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 1)];
    _goodsPrice.attributedText = attributePriceStr;
    NSString *oldPriceStr = [NSString stringWithFormat:@"￥%@",item.old_price];
    NSDictionary *attribDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeOldPriceStr = [[NSMutableAttributedString alloc] initWithString:oldPriceStr attributes:attribDic];
    _goodsOldPrice.attributedText = attributeOldPriceStr;
}

@end
