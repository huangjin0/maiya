//
//  EmptyOrderView.m
//  IOSProject
//
//  Created by IOS002 on 15/7/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "EmptyOrderView.h"

@implementation EmptyOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        UIImageView *imgeView = [UIImageView alloc] ini
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 50, 300, 100, 30)];
        label.text = @"暂无订单";
        label.textAlignment = 1;
        [self addSubview:label];
    }
    return self;
}

@end
