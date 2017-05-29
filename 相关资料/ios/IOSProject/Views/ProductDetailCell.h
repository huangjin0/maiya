//
//  ProductDetailCell.h
//  IOSProject
//
//  Created by IOS004 on 15/7/20.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@interface ProductDetailCell : BasicCell


@property (nonatomic,strong) UILabel * commentslab;
//自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
