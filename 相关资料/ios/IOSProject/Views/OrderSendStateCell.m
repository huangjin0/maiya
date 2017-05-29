//
//  OrderSendStateCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "OrderSendStateCell.h"

@implementation OrderSendStateCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *sendStateLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
        sendStateLab.text = @"派送方式";
        sendStateLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:sendStateLab];
        
        _sendStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, ViewWidth - 90, 20)];
        _sendStateLabel.textColor = [UIColor colorFromHexCode:@"#999999"];
        _sendStateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_sendStateLabel];
        _sendStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendStateBtn.frame = CGRectMake(90, 10, ViewWidth - 130, 20);
        [_sendStateBtn setBackgroundColor:[UIColor clearColor]];
        [_sendStateBtn addTarget:self action:@selector(sendStateBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_sendStateBtn];
        _bussinissTime = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, 200, 20)];
        
        _bussinissTime.textColor = [UIColor colorFromHexCode:@"#d9a325"];
        _bussinissTime.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_bussinissTime];
    }
    return self;
}

-(void)sendStateBtnAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(sendStateSelect)]) {
        [_delegate sendStateSelect];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
