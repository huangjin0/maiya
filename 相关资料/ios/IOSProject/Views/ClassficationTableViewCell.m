//
//  ClassficationTableViewCell.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassficationTableViewCell.h"

@interface ClassficationTableViewCell()

@end

@implementation ClassficationTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //一级栏框标题
        UILabel * categoary = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 75, 75)];
        [self.contentView addSubview:categoary];
        _category = categoary;
        
        //一级栏图片
        UIImageView * logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        [self.contentView addSubview:logoImage];
        _logoImage = logoImage;
        
        //一级栏分界线距离为75；
        UIView * viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 75, 75, 0.1)];
        viewShow.backgroundColor = [UIColor blackColor];
        viewShow.alpha = 0.4;
        [self.contentView addSubview:viewShow];
    }
    return self;
}

- (void)setCategoryText:(NSString *)categoryText{
    _category.text = categoryText;
    _category.textAlignment = NSTextAlignmentCenter;
    _category.font = [UIFont systemFontOfSize:16];
}

- (void)setImagetitle:(NSString *)imagetitle{
//    _logoImage.image = [UIImage imageNamed:imagetitle];
    [_logoImage setImageWithURL:imagetitle];
}

+ (instancetype)cellWithTableView:(UITableView *)tableview{
    static NSString * ID = @"ClassficationTableViewCell";
    ClassficationTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ClassficationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //取消选中状态
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
