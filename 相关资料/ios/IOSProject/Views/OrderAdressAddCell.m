//
//  OrderAdressAddCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderAdressAddCell.h"

@implementation OrderAdressAddCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAddressBtn.frame = CGRectMake(0, 0, self.width, 69);
        _addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addAddressBtn setTitle:@"+添加收货地址" forState:UIControlStateNormal];
        [_addAddressBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
        [self addSubview:_addAddressBtn];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
