//
//  MainPageProductCollectionViewCell.m
//  IOSProject
//
//  Created by IOS004 on 15/7/14.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MainPageProductCollectionViewCell.h"

@implementation MainPageProductCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor purpleColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.5, 0.5, CGRectGetWidth(self.frame)-0.5, 145)];
        self.imgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imgView];
        
        self.imageShow = [[UIImageView alloc] initWithFrame:CGRectMake(1 , 1, self.width - 1, 90 - 1)];
        _imageShow.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageShow];
        
        _titlelab = [[UILabel alloc] initWithFrame:CGRectMake( 10, 90, self.width - 20, 20)];
        _titlelab.textColor = [UIColor colorFromHexCode:@"#333333"];
        _titlelab.font = [UIFont systemFontOfSize:12];
        [self.imgView addSubview:self.titlelab];
        
        for (NSInteger p = 0; p < 2; p ++) {
            
            NSArray * arrColor = @[@"#ff0000",@"#757575"];
            UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + (p * 60), 120, 30, 20)];
            lab1.text = @"￥";
            lab1.textColor = [UIColor colorFromHexCode:arrColor[p]];
            [self.imgView addSubview:lab1];
            
            _labValueNew = [[UILabel alloc] initWithFrame:CGRectMake( 20, 120, 60, 20)];
            _labValueNew.textColor = [UIColor colorFromHexCode:@"#ff0000"];
            
            _labValueOld = [[UILabel alloc] initWithFrame:CGRectMake( 80, 120, 60, 20)];
            _labValueOld.textColor = [UIColor colorFromHexCode:@"#757575"];
            if (p == 0) {
                lab1.font = [UIFont systemFontOfSize:9];
                _labValueNew.font = [UIFont systemFontOfSize:12];
            }
            if (p == 1) {
                lab1.font = [UIFont systemFontOfSize:7];
                _labValueOld.font = [UIFont systemFontOfSize:9];
            }
            [self.imgView addSubview:_labValueNew];
            [self.imgView addSubview:_labValueOld];
            UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake( 70, 130, 45, 1)];
            imageLine.backgroundColor = [UIColor colorFromHexCode:@"757575"];
            [self.imgView addSubview:imageLine];
        }
    }
    return self;
}

@end
