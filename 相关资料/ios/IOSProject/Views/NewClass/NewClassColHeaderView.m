//
//  NewClassColHeaderView.m
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "NewClassColHeaderView.h"

@implementation NewClassColHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadViewWithSender:)];
    [self addGestureRecognizer:tap];
    // Initialization code
}

- (void)tapHeadViewWithSender:(id)sender {
    if (_block) {
        _block();
    }
}

- (void)tapWithBlock:(TapHeaderBlock)block {
    _block = block;
}

@end
