//
//  RefundTableViewCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/28.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RefundTableViewCell.h"

@interface RefundTableViewCell () <UITextViewDelegate>

@end

@implementation RefundTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _placeHolderLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ViewWidth, 30)];
        _placeHolderLab.text = @"请输入退款理由";
        _placeHolderLab.backgroundColor = [UIColor clearColor];
        _placeHolderLab.font = [UIFont systemFontOfSize:16];
        _placeHolderLab.textColor = [UIColor colorFromHexCode:@"#757575"];
        [self.contentView addSubview:_placeHolderLab];
        
        _refundTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, self.height)];
        _refundTextView.delegate = self;
        _refundTextView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_refundTextView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        _placeHolderLab.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeHolderLab.hidden = NO;
    }
    return YES;
    
}


@end
