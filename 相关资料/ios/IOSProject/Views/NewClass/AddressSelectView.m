//
//  AddressSelectView.m
//  IOSProject
//
//  Created by IOS002 on 16/5/25.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "AddressSelectView.h"

@interface AddressSelectView () {
    
    
    IBOutlet UIView *_MenuView;
    IBOutlet UIView *_cityView;
    IBOutlet UIView *_areaView;
    IBOutlet UIView *_countryView;
    IBOutlet UIView *_storeView;
    
    IBOutlet NSLayoutConstraint *tableViewTop;
    
}

@end

@implementation AddressSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    _cityView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
    _cityView.layer.borderWidth = 1.0;
    _areaView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
    _areaView.layer.borderWidth = 1.0;
    _countryView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
    _countryView.layer.borderWidth = 1.0;
    _storeView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
    _storeView.layer.borderWidth = 1.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabToSelectWithSender:)];
//    _cityLab.userInteractionEnabled = YES;
    [_cityView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabToSelectWithSender:)];
//    _cityLab.userInteractionEnabled = YES;
    [_areaView addGestureRecognizer:tap2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabToSelectWithSender:)];
    [_countryView addGestureRecognizer:tap3];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabToSelectWithSender:)];
//    _cityLab.userInteractionEnabled = YES;
    [_storeView addGestureRecognizer:tap4];
    _tableView.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
    _tableView.layer.borderWidth = 1.0;
}
- (IBAction)confirmAction:(id)sender {
    if (_confirmBlock) {
        _confirmBlock();
    }
}

- (void)confirmAddressWithBlock:(confirmBlock)block {
    _confirmBlock = block;
}


- (void)showInView:(UIView *)view {
    UIView *backView = [[UIView alloc] initWithFrame:view.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenBackView)];
    tap.cancelsTouchesInView = NO;
    [backView addGestureRecognizer:tap];
    [backView addSubview:self];
    [view addSubview:backView];
    self.alpha = 0.5f;
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
    [UIView animateWithDuration:0.25 animations:^{
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        self.alpha = 1.0f;
//        [self hidenTableView];
        _tableView.hidden = YES;
    } completion:NULL];
}

- (void)hidenBackView{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.superview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];
}


- (void)tapLabToSelectWithSender:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 101:
            tableViewTop.constant = 0;
            break;
        case 102:
            tableViewTop.constant = 0;
            break;
        case 103:
            tableViewTop.constant = 47;
            break;
        case 104:
            tableViewTop.constant = 47;
            break;
        default:
            break;
    }
    
//    _tableView.hidden = NO;
//    [self showTableView];
    [self updateConstraints];
    if (_block) {
        _block(sender.view.tag);
    }
}

- (void)tapAddressWithBlock:(tapAddressBlock)block {
    _block = block;
}

- (void)showTableView {
//    [_MenuView addSubview:_tableView];
    _tableView.hidden = NO;
    _tableView.alpha = 0.5f;
    [UIView animateWithDuration:0.25 animations:^{
        _tableView.alpha = 1.0f;
    } completion:NULL];
}

- (void)hidenTableView {
    _tableView.alpha = 1.0f;
    [UIView animateWithDuration:0.25 animations:^{
        _tableView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        _tableView.hidden = YES;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), CGRectGetMidY(self.superview.bounds));
}

@end
