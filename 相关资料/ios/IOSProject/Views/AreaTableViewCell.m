//
//  AreaTableViewCell.m
//  IOSProject
//
//  Created by IOS002 on 15/8/19.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "AreaTableViewCell.h"

@implementation AreaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _areaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ViewWidth, 30)];
        [self.contentView addSubview:_areaLable];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.contentView addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)tapAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(tapTableViewWithCell:)]) {
        [_delegate tapTableViewWithCell:self];
    }
}

@end
