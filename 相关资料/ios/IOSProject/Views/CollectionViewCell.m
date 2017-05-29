//
//  CollectionViewCell.m
//  IOSProject
//
//  Created by IOS004 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CollectionViewCell.h"
#import "BannerCollectionShoppingCartModel.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat high;
        if (ScreenWidth == 320) {
            high = 240;
        }else if (ScreenWidth == 375){
            high = 280;
        }else
            high = 320;
        // Initialization code
        self.backgroundColor = [UIColor purpleColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.5, 0.5, CGRectGetWidth(self.frame)-0.5, high)];
        self.imgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imgView];
        
        self.imageShow = [[UIImageView alloc] initWithFrame:CGRectMake(1 , 10, self.width - 1, high - 120)];
        _imageShow.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.imageShow];
        
        _titlelab = [[UILabel alloc] initWithFrame:CGRectMake( 10, high - 80, self.width - 20, 20)];
        _titlelab.textColor = [UIColor colorFromHexCode:@"#333333"];
        _titlelab.font = [UIFont systemFontOfSize:12];
        [self.imgView addSubview:self.titlelab];
        
        for (NSInteger p = 0; p < 2; p ++) {
            
            NSArray * arrColor = @[@"#ff0000",@"#757575"];
            UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + (p * 60), high - 40, 30, 20)];
            lab1.text = @"￥";
            if (p == 1) {
                _goldLab = lab1;
            }
            lab1.textColor = [UIColor colorFromHexCode:arrColor[p]];
            [self.imgView addSubview:lab1];
            
            _labValueNew = [[UILabel alloc] initWithFrame:CGRectMake( 20, high - 40, 60, 20)];
            _labValueNew.textColor = [UIColor colorFromHexCode:@"#ff0000"];
            
            _labValueOld = [[UILabel alloc] initWithFrame:CGRectMake( 80, high - 40, 60, 20)];
            _labValueOld.textColor = [UIColor colorFromHexCode:@"#757575"];
            if (p == 0) {
                lab1.font = [UIFont systemFontOfSize:11];
                _labValueNew.font = [UIFont systemFontOfSize:15];
            }
            if (p == 1) {
                lab1.font = [UIFont systemFontOfSize:9];
                _labValueOld.font = [UIFont systemFontOfSize:11];
                _imageLine1 = [[UIImageView alloc] initWithFrame:CGRectMake( 70, high - 30, 45, 1)];
                _imageLine1.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            }
            [self.imgView addSubview:_labValueNew];
            [self.imgView addSubview:_labValueOld];
            [self.imgView addSubview:_imageLine1];
        }
    }
    return self;
}
- (void)setItem:(BannerCollectionShoppingCartModel *)item{
    _item = item;
    CGFloat high;
    if (ScreenWidth == 320) {
        high = 240;
    }else if (ScreenWidth == 375){
        high = 280;
    }else
        high = 320;
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake( self.bounds.size.width - 40, high - 40, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"iSH_ShopCart"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(successShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
}
//提示加入购物车成功
- (void)successShoppingCart{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(successShoppingCart:)]) {
        [_delegate successShoppingCart:self];
    }
}

+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

@end
