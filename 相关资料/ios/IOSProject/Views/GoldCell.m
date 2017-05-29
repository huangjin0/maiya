//
//  GoldCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "GoldCell.h"

@implementation GoldCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _goldsNam = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 100, 20)];
        _goldsNam.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_goldsNam];
        _goldsPri = [[UILabel alloc] initWithFrame:CGRectMake(150, 7, 100, 20)];
        _goldsPri.textColor = [UIColor redColor];
        [self.contentView addSubview:_goldsPri];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
