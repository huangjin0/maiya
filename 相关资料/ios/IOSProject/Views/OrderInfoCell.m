//
//  OrderInfoCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderInfoCell.h"

@implementation OrderInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellName           = [[UILabel alloc] initWithFrame:CGRectMake(20, 7 , 100, 20)];
        _cellName.textColor = [UIColor colorFromHexCode:@"#333333"];
        _cellName.font      = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_cellName];
        _cellInfo           = [[UILabel alloc] initWithFrame:CGRectMake(150, 7, self.width - 150, 20)];
        _cellInfo.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
        _cellInfo.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_cellInfo];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
