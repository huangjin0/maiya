//
//  RecommendCell.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RecommendCell.h"
#import "Recommend.h"
#import "BannerAndConnectionImageViewController.h"
#import "ADView.h"

@implementation RecommendCell

+ (CGFloat)heightForCell:(Recommend *)item {
    CGFloat pointY = 0;
    if (item.headURL.hasValue) {
        pointY = ScreenHeight / 5.5;//125;
    }
    
    CGSize size = TextSize_MutiLine(item.content, [UIFont systemFontOfSize:14], CGSizeMake(ScreenWidth - 32, 10000));
    pointY += size.height;
    return pointY + 15;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setItem:(Recommend *)item {
    _item = item;
    [self cleanUpSubviews];
    
    CGFloat h1;
    CGFloat h2;
    CGFloat h = ScreenHeight / 5.5;//125;
    if (ScreenWidth == 320) {
        h1 = 130;
        h2 = 155;
    }else if (ScreenWidth == 375){
        h1 = 155;
        h2 = 182.5;
    }else{
        h1 = 175;
        h2 = 202;
    }
//    h = ScreenWidth / 2.56;
    
//    UIButton * imagebtn = [[UIButton alloc] init];
//    imagebtn.frame = CGRectMake(0, 0, ScreenWidth, h);
//    [self.contentView addSubview:imagebtn];
//    [imagebtn addTarget:self action:@selector(recommendedColumn) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, ScreenWidth, h1);
    imageView.userInteractionEnabled = YES;
    [imageView setImageWithURL:_item.headURL placeholderImage:[UIImage imageWithColor:[UIColor grayColor] cornerRadius:0]];
    [self.contentView addSubview:imageView];
    
    UIFont * font = [UIFont systemFontOfSize:14];
    NSString * str = _item.content;
    CGSize size = TextSize_MutiLine(item.content, [UIFont systemFontOfSize:14], CGSizeMake(ScreenWidth - 32, 10000));
    UILabel * lab = [UILabel multLinesText:str font:font wid:ScreenWidth - 32 color:[UIColor darkGrayColor]];
    lab.origin = CGPointMake(16, imageView.bottom + 5);
    [self.contentView addSubview:lab];
    lab.height = size.height;
    
    UIImageView * intervalImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, h2, ScreenWidth, 5)];
    intervalImg.backgroundColor = [UIColor colorFromHexCode:@"efeff4"];
    [imageView addSubview:intervalImg];
}

//- (void)recommendedColumn{
//    if (_delegated && [_delegated respondsToSelector:@selector(recommendValue:)]) {
//        [_delegated recommendValue:self];
//    }
//}
//
////view中取到所在当前控制器
//+ (UIViewController *)viewController:(UIView *)view{
//    
//    UIResponder *responder = view;
//    while ((responder = [responder nextResponder]))
//        if ([responder isKindOfClass: [UIViewController class]])
//            return (UIViewController *)responder;
//    return nil;
//}

@end
