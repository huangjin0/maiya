//
//  OrderGoodsCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

@interface OrderGoodsCell : UITableViewCell
//商品图片
@property (nonatomic,strong) UIImageView *goodsImg;
//商品标题
@property (nonatomic,strong) UILabel *titleLabel;
//商品旧价格
@property (nonatomic,strong) UILabel *oldPrice;
//商品新价格
@property (nonatomic,strong) UILabel *salePrice;
//商品数量
@property (nonatomic,strong) UILabel *goodsCont;
//商品模型
@property (nonatomic,strong) ShoppingCartModel *item;

@end
