//
//  GoodsCell.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "GoodsCell.h"
#import "GoodsImageView.h"
#import "Goods.h"
#import "BackView.h"
#import "CommodityViewController.h"
#import "SaleGoods.h"

@interface GoodsCell (){
    NSInteger   _integer;
    CGFloat h;
    Goods * _item;
}

@end

@implementation GoodsCell

- (void)setItem:(Goods *)item {
}

- (void)setGoodsArray:(NSArray *)goodsArray {
    [self cleanUpSubviews];
    _goodsArray = goodsArray;
    
    UIFont      * font = [UIFont systemFontOfSize:12];
    NSString    * str;
    UILabel     * lab;
    CGFloat     pointY;
    CGFloat     pointX;
    CGSize      size;
    UIView      * line;
    BackView    * backView;

    NSInteger   remainder = _goodsArray.count % 3;
    h = ScreenWidth;
    
    _integer = _goodsArray.count / 3;
    if (remainder > 0) {
        _integer += 1;
    }
    CGFloat width = ScreenWidth / 3.0;
    NSInteger index = self.indexPath.row;
    int j = 0;//(index + 1) * 3
    NSInteger indexRetion = index * 3;
    NSInteger goodsCount = _goodsArray.count;
    
    for (int i = 0; i < ((goodsCount - (index + 1) * 3) > 3 ? 3 : (_goodsArray.count - index * 3)); i++) {
        backView = [[BackView alloc] init];
        if (h == 375){
            backView.frame = CGRectMake(width * j, 0, width, 165);
        }else if (h > 400) {
            backView.frame = CGRectMake(width * j, 0, width, 185);
        }else
            backView.frame = CGRectMake(width * j, 0, width, 145);
        backView.layer.borderColor = [Color_seperator CGColor];
        backView.layer.borderWidth = 1;
        backView.tagIndex = indexRetion;
        [self.contentView addSubview:backView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [backView addGestureRecognizer:tap];
        
        _item = [_goodsArray objectAtIndex:indexRetion];
        UIImageView * imageView = [[UIImageView alloc] init];
        if (h == 375){
            imageView.frame = CGRectMake(0, 0, width, 110);
        }else if (h > 400) {
            imageView.frame = CGRectMake(0, 0, width, 125);
        }else
            imageView.frame = CGRectMake(0, 0, width, 95);
        [imageView setImageWithURL:_item.headURL placeholderImage:[UIImage imageNamed:@"goodsdef"]];
        [backView addSubview:imageView];
        
        str = _item.title;
        lab = [UILabel linesText:str font:font wid:width - 16 lines:1 color:[UIColor darkTextColor]];
        if (h == 375){
            lab.origin = CGPointMake(8, imageView.bottom + 8);
        }else if (h > 400) {
            lab.origin = CGPointMake(8, imageView.bottom + 13);
        }else
            lab.origin = CGPointMake(8, imageView.bottom + 3);
        [backView addSubview:lab];
        //lab的高度设为20且仅显示一行；
        size = TextSize_MutiLine(str, font, CGSizeMake(width - 16, 20));
        lab.height = size.height;
        
        pointY = lab.bottom + 5;
        
        str = [NSString stringWithFormat:@"¥%.2f", _item.price];
        lab = [UILabel singleLineText:str font:font wid:60 color:[UIColor redColor]];
        lab.origin = CGPointMake(8, pointY);
        [backView addSubview:lab];
        pointX = lab.right + 5;
        
        if (_item.price != _item.salePrice && _item.salePrice != 0) {
            str = [NSString stringWithFormat:@"¥%.2f", _item.salePrice];
            lab = [UILabel singleLineText:str font:[UIFont systemFontOfSize:10] wid:50 color:[UIColor darkGrayColor]];
            lab.origin = CGPointMake(pointX + 3, pointY + 2);
            [backView addSubview:lab];
            
            line = [[UIView alloc] init];
            line.frame = CGRectMake(0, lab.height / 2.0, lab.width + 2, 1);
            //        line.backgroundColor = Color_seperator;
            line.backgroundColor = [UIColor darkGrayColor];
            [lab addSubview:line];
        }
        indexRetion++;
        j++;
    }
}

- (void)tap:(UITapGestureRecognizer *)sender {
    NSLog(@"%ld", (long)((BackView *)sender.view).tagIndex);
    if (_delegate && [_delegate respondsToSelector:@selector(commoditygoods:tag:)]) {
        [_delegate commoditygoods:self tag:(long)((BackView *)sender.view).tagIndex];
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
