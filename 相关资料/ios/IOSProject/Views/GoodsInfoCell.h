//
//  GoodsInfoCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsInfoModel.h"

@interface GoodsInfoCell : UITableViewCell

@property (nonatomic,strong) UIImageView *goodsImg;
@property (nonatomic,strong) UILabel *goodsTitle;
@property (nonatomic,strong) UILabel *countLable;
@property (nonatomic,strong) UILabel *oldPriceLab;
@property (nonatomic,strong) UILabel *nowPriceLab;
@property (nonatomic,strong) GoodsInfoModel * item;

@end
