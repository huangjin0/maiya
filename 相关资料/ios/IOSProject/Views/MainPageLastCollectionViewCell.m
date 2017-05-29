//
//  MainPageLastCollectionViewCell.m
//  IOSProject
//
//  Created by IOS004 on 15/7/14.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MainPageLastCollectionViewCell.h"

@implementation MainPageLastCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor purpleColor];
        
        self.imgViewLast = [[UIImageView alloc]initWithFrame:CGRectMake(0.5, 0.5, CGRectGetWidth(self.frame)-0.5, 145)];
        self.imgViewLast.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgViewLast];
        
        self.imageShowLast = [[UIImageView alloc] initWithFrame:CGRectMake(1 , 1, self.width - 1, 90 - 1)];
        _imageShowLast.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageShowLast];
        
        _titlelabLast = [[UILabel alloc] initWithFrame:CGRectMake( 10, 90, self.width - 20, 20)];
        _titlelabLast.textColor = [UIColor colorFromHexCode:@"#333333"];
        _titlelabLast.font = [UIFont systemFontOfSize:12];
        [self.imgViewLast addSubview:self.titlelabLast];
        
        for (NSInteger p = 0; p < 2; p ++) {
            
            NSArray * arrColor = @[@"#ff0000",@"#757575"];
            UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + (p * 60), 120, 30, 20)];
            lab1.text = @"￥";
            lab1.textColor = [UIColor colorFromHexCode:arrColor[p]];
            [self.imgViewLast addSubview:lab1];
            
            _labValueNewLast = [[UILabel alloc] initWithFrame:CGRectMake( 20, 120, 60, 20)];
            _labValueNewLast.textColor = [UIColor colorFromHexCode:@"#ff0000"];
            
            _labValueOldLast = [[UILabel alloc] initWithFrame:CGRectMake( 80, 120, 60, 20)];
            _labValueOldLast.textColor = [UIColor colorFromHexCode:@"#757575"];
            if (p == 0) {
                lab1.font = [UIFont systemFontOfSize:9];
                _labValueNewLast.font = [UIFont systemFontOfSize:12];
            }
            if (p == 1) {
                lab1.font = [UIFont systemFontOfSize:7];
                _labValueOldLast.font = [UIFont systemFontOfSize:9];
            }
            [self.imgViewLast addSubview:_labValueNewLast];
            [self.imgViewLast addSubview:_labValueOldLast];
            UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake( 70, 130, 45, 1)];
            imageLine.backgroundColor = [UIColor colorFromHexCode:@"757575"];
            [self.imgViewLast addSubview:imageLine];
        }
    }
    return self;
}


@end
