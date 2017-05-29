//
//  RightTableViewCell.m
//  IOSProject
//
//  Created by IOS004 on 15/6/10.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RightTableViewCell.h"
#import "ClassificationOfGoodsViewController.h"

#define Font(F) [UIFont systemFontOfSize:(F)]

@interface RightTableViewCell ()<RightTableViewcellDelegate>{
    NSInteger _productName;
    NSInteger m;
    NSString * _namebtn;
}

@property (weak,nonatomic) UIButton * nameButton1;
@property (weak,nonatomic) UIButton * nameButton2;
@property (weak,nonatomic) UIButton * nameButton3;
@property (weak,nonatomic) UIButton * nameButton4;
@property (weak,nonatomic) UILabel  * nameLabel;
@property (weak ,nonatomic) UIImageView *wineImage;

@end

@implementation RightTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"RightTableViewCell";
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[RightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //取消选中状态
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

/**
 *三级分类栏
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.delegate = self;
        
        UILabel * namelabel = [[UILabel alloc] init];
        [self.contentView addSubview:namelabel];
        _nameLabel = namelabel;

        //二级栏点击事件
        
        UIView * viewShow = [[UIView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width, 60)];
        viewShow.backgroundColor = [UIColor whiteColor];
        viewShow.alpha = 0.5;
//        [self.contentView addSubview:viewShow];
        
        UIImageView * imagebackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width, 60)];
        imagebackground.backgroundColor = [UIColor whiteColor];
 //       [self.contentView addSubview:imagebackground];
        
        UIButton * nameButton1 = [[UIButton alloc] initWithFrame:CGRectMake(15 , 40, 100, 20)];
        nameButton1.titleLabel.font = [UIFont systemFontOfSize:16];
//        nameButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
//        nameButton1.contentHorizontalAlignment = NSTextAlignmentLeft;
//        nameButton1.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.contentView addSubview:nameButton1];
        _nameButton1 = nameButton1;

    }
    return self;
}

/**
 * 二级分类栏标题
 */
- (void)setRightData:(NSMutableDictionary *)rightData {
   
    _rightData = rightData;

    NSString * nameText;// = _rightData[@"name"];
    nameText = [_rightData getStringValueForKey:@"name" defaultValue:nil];
    _nameLabel.text = nameText;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.frame = CGRectMake(15, 5, 100, 20);
    _nameLabel.textColor = [UIColor blackColor];
}

- (void)setRightlogo:(NSMutableDictionary *)rightlogo{
    _rightlogo = rightlogo;

    NSString * namebtn1 = [_rightData getStringValueForKey:@"department" defaultValue:nil];
    [_nameButton1 setTitle:namebtn1 forState:UIControlStateNormal];
    [_nameButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_nameButton1 addTarget:self action:@selector(listOfGoods) forControlEvents:UIControlEventTouchUpInside];

}

- (void)listOfGoodsSender:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(listOfGoodsSender:)]) {
        [_delegate listOfGoodsSender:nil];
    }
    UIViewController * viewcontroller = [RightTableViewCell viewController:self];
    ClassificationOfGoodsViewController * goods = [[ClassificationOfGoodsViewController alloc] init];
    [viewcontroller.navigationController pushViewController:goods animated:YES];
}

/**
 *神奇的东西,view中取到所在当前控制器
 */
+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

@end
