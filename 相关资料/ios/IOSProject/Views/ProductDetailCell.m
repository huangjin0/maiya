//
//  ProductDetailCell.m
//  IOSProject
//
//  Created by IOS004 on 15/7/20.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ProductDetailCell.h"

@implementation ProductDetailCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    //初始化
    _commentslab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.width - 70, 40)];
    [self addSubview:_commentslab];
}

- (void)setIntroductionText:(NSString *)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.commentslab.text = text;
    //设置label的最大行数
    self.commentslab.numberOfLines = 10;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.commentslab.text sizeWithFont:self.commentslab.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.commentslab.frame = CGRectMake(self.commentslab.frame.origin.x, self.commentslab.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+100;
    
    self.frame = frame;
}

@end
