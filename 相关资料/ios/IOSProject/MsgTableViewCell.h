//
//  MsgTableViewCell.h
//  IOSProject
//
//  Created by IOS002 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"
@interface MsgTableViewCell : UITableViewCell
@property (strong,nonatomic) UIImage *headImg;
@property (strong, nonatomic) UILabel     * time;           //时间
@property (strong, nonatomic) UIImageView * headerImage;    //头像
@property (strong, nonatomic) UILabel     * content;        //内容
@property (strong, nonatomic) UIImageView * headImageView;
@property (strong, nonatomic) UIImageView * contentImageView;
@property (strong, nonatomic) ChatMessage   *item;
//-(CGFloat)setValueForCellWithMsg:(NSString *)msg headImg:(UIImageView *)headImg isFrom:(BOOL)isFrom;
+ (CGFloat)heightForMessage:(ChatMessage *)message;
@end
