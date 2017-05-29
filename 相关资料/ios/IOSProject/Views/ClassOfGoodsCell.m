//
//  ClassOfGoodsCell.m
//  IOSProject
//
//  Created by IOS004 on 15/8/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassOfGoodsCell.h"
#import "ClassOfGoodsModel.h"
#import "ClassificationOfGoodsViewController.h"

@implementation ClassOfGoodsCell

- (void)setItem:(ClassOfGoodsModel *)item{
    _item = item;
    UIButton * cartbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 80, 30, 80, 60)];
    [cartbtn addTarget:self action:@selector(joinCartSuccess) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cartbtn];
    UIImageView * imagebak = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 20, 20)];
    imagebak.image = [UIImage imageNamed:@"iSH_ShopCart"];
    [cartbtn addSubview:imagebak];
//    [self cleanUpSubviews];
}

- (void)joinCartSuccess{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(joinCartSuccess:)]) {
        [_delegate joinCartSuccess:self];
    }
}

//view中取到所在当前控制器
+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

@end
