//
//  ConsigeenCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ConsigeenCell.h"

@implementation ConsigeenCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _consigeenNam = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 130, 30)];
        _consigeenNam.textColor = [UIColor colorFromHexCode:@"#333333"];
        [self.contentView addSubview:_consigeenNam];
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 7, ViewWidth - 150,30)];
        _phoneLabel.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
        [self.contentView addSubview:_phoneLabel];
        _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 37, ViewWidth - 40, 25)];
        _areaLabel.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
        _areaLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_areaLabel];
        _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 62, ViewWidth - 40, 25)];
//        _addressLab.numberOfLines = 0;
        _addressLab.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
        _addressLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_addressLab];
    }
    return self;
}

-(void)setItem:(OrderDtaileModel *)item {
    _consigeenNam.text = item.cossgineName;
    _phoneLabel.text   = item.linkPhone;
    _addressLab.text   = item.addreess;
    _areaLabel.text = item.area;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
