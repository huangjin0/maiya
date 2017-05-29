//
//  OrderAddressCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderAddressCell.h"

@implementation OrderAddressCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 130, 25)];
        _nameLable.font = [UIFont systemFontOfSize:16];
        _nameLable.textColor = [UIColor colorFromHexCode:@"#333333"];
        [self.contentView addSubview:_nameLable];
        _areaLable  = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, ViewWidth - 120, 15)];
        _areaLable.textColor = [UIColor colorFromHexCode:@"#757575"];
        _areaLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_areaLable];
        _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, ViewWidth - 20, 15)];
        _addressLab.textColor = [UIColor colorFromHexCode:@"#757575"];
        _addressLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_addressLab];
        _phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, ViewWidth - 180, 20)];
        _phoneLable.textColor = [UIColor colorFromHexCode:@"#757575"];
        _phoneLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_phoneLable];
        _otherAdress = [UIButton buttonWithType:UIButtonTypeCustom];
        _otherAdress.frame = CGRectMake(ViewWidth - 70, 20, 70, 35);
        [_otherAdress setTitle:@"其他地址" forState:UIControlStateNormal];
        [_otherAdress setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
        _otherAdress.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_otherAdress];
    }
    return self;
}

-(void)setItem:(AddressModel *)item {
    _nameLable.text = item.name;
    _addressLab.text = item.address;
    _areaLable.text = item.area;
    _phoneLable.text = item.phone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
