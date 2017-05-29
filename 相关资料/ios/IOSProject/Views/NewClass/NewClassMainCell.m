//
//  NewClassMainCell.m
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "NewClassMainCell.h"

@implementation NewClassMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ISH_NewClassGoods *)item {
    [_logoImg setImageWithURL:[ISH_ImgUrl ish_imgUrlWithStr:item.image] placeholderImage:[UIImage imageNamed:@"goodsdef"]];
    _titleLab.text = item.cate_name;
    if (item.is_select) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _titleLab.textColor = RGBCOLOR(255, 95, 5);
    } else {
        self.contentView.backgroundColor = RGBHex(@"#ececec");
        _titleLab.textColor = RGBHex(@"#333333");
    }
}

@end
