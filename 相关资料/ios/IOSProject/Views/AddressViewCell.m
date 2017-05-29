//
//  AddressViewCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/3.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "AddressViewCell.h"

@interface AddressViewCell ()<UIScrollViewDelegate>

// Scroll view to be added to UITableViewCell
@property (nonatomic,strong) UIScrollView *cellScrollView;
// Views that live in the scroll view
@property (nonatomic, weak) UIView *scrollViewContentView;
@property (nonatomic,strong) UIButton *deleteBtn;
@end

@implementation AddressViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier containingTableView:containingTableView leftUtilityButtons:leftUtilityButtons rightUtilityButtons:rightUtilityButtons];
    if (self) {
//        self.scrollViewContentView.backgroundColor = [UIColor whiteColor];
//        self.scrollViewContentView.frame = CGRectMake(0, 0, ViewWidth, 69);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth -30, 23, 12, 16)];
        imageView.image = [UIImage imageNamed:@"xuanze_ic"];
        [self.scrollViewContentView addSubview:imageView];
        _cosigneName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 110, 20)];
        [self.scrollViewContentView addSubview:_cosigneName];
        _linkPhone   = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 290, 20)];
        _linkPhone.textColor = [UIColor colorFromHexCode:@"#757575"];
        _linkPhone.font = [UIFont systemFontOfSize:14];
        [self.scrollViewContentView addSubview:_linkPhone];
        
        _sendArea = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, ViewWidth - 100, 20)];
        _sendArea.textColor = [UIColor colorFromHexCode:@"#757575"];
        _sendArea.font = [UIFont systemFontOfSize:15];
        [self.scrollViewContentView addSubview:_sendArea];
        
        _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, ViewWidth - 20, 20)];
        _address.textColor = [UIColor colorFromHexCode:@"#757575"];
        _address.font = [UIFont systemFontOfSize:15];
        [self.scrollViewContentView addSubview:_address];
        
        _defultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _defultAddressBtn.frame = CGRectMake(ViewWidth - 100, 21.5, 62, 20);
        [_defultAddressBtn setTitle:@"默认地址" forState:UIControlStateNormal];
        _defultAddressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_defultAddressBtn addTarget:self action:@selector(setdefultAddressWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [_defultAddressBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
        _defultAddressBtn.layer.cornerRadius = 5.0;
        [_defultAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.scrollViewContentView addSubview:_defultAddressBtn];
    }
    return self;
}

-(void)setItem:(NSDictionary *)item {
    _cosigneName.text = [item getStringValueForKey:@"consignee" defaultValue:nil];
    _linkPhone.text = [item getStringValueForKey:@"connetNum" defaultValue:nil];
    _sendArea.text = [item getStringValueForKey:@"area" defaultValue:nil];
    _address.text = [item getStringValueForKey:@"address" defaultValue:nil];
    if ([[item getStringValueForKey:@"isDefult" defaultValue:nil] intValue] == 1) {
        _defultAddressBtn.selected = YES;
        [_defultAddressBtn setBackgroundColor:RGBCOLOR(255, 95, 5)];
    } else {
        _defultAddressBtn.selected = NO;
        [_defultAddressBtn setBackgroundColor:[UIColor clearColor]];
    }
    _addID = [item getStringValueForKey:@"addr_id" defaultValue:nil];
}


-(void)setdefultAddressWithSender:(UIButton *)sender {
//    sender.selected = !sender.selected;
    BOOL defult;
    if (sender.selected) {
        defult = NO;
//        [_defultAddressBtn setBackgroundColor:[UIColor colorFromHexCode:@"#489925"]];
    } else {
        defult = YES;
//        [_defultAddressBtn setBackgroundColor:[UIColor clearColor]];
    }
    if (_defDelegate != nil && [_defDelegate respondsToSelector:@selector(setDefaultAddressWithIsDefault:cell:)]) {
        [_defDelegate setDefaultAddressWithIsDefault:defult cell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
