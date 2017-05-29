//
//  CollectionCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/18.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"

@class CollectionCell;
@protocol CollectionCellDelegate <NSObject>
@optional
-(void)cancelCollectionWithcell:(CollectionCell *)cell;
-(void)addGoodsTocartWithcell:(CollectionCell *)cell;

@end

@interface CollectionCell : UITableViewCell
{
    UIView *_lineView;
}
//商品图片
@property (nonatomic,strong) UIImageView *goodsImg;
//商品标题
@property (nonatomic,strong) UILabel *goodsTitle;
//商品卖出价格
@property (nonatomic,strong) UILabel *goodsSalePri;
//商品原始价格
@property (nonatomic,strong) UILabel *goodsOldPri;
//商品收藏
@property (nonatomic,strong) UIButton *goodsCollectBtn;
//商品加入购物车
@property (nonatomic,strong) UIButton *goodsAddCartBtn;
//标签view
@property (nonatomic,strong) UIView *tagView;
//是否有货
@property (nonatomic,strong) UIImageView *hasStocek;
//添加代理
@property (nonatomic,weak) id<CollectionCellDelegate>delegate;
//添加Item
@property (nonatomic,strong) CollectionModel *item;
@end
