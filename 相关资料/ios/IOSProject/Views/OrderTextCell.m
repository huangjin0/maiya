//
//  OrderTextCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderTextCell.h"

@implementation OrderTextCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = Color_bkg_lightGray;
//        _remarkText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, self.contentView.height)];
//        _remarkText.backgroundColor = Color_bkg_lightGray;
//        [self.contentView addSubview:_remarkText];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
