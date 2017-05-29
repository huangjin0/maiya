//
//  SearchJoinCartCell.m
//  IOSProject
//
//  Created by IOS004 on 15/8/19.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "SearchJoinCartCell.h"
#import "SearchCartSuccessModel.h"

@implementation SearchJoinCartCell

- (void)setItem:(SearchCartSuccessModel *)item{
    _item = item;
    UIButton * cartbtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 80, 30, 80, 60)];
    [cartbtn addTarget:self action:@selector(joinCartSuccess) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cartbtn];
    UIImageView * imagebak = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 20, 20)];
    imagebak.image = [UIImage imageNamed:@"iSH_ShopCart"];
    [cartbtn addSubview:imagebak];
}

- (void)joinCartSuccess{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(searchJoinSuccess:)]) {
        [_delegate searchJoinSuccess:self];
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
