//
//  CollectionViewCell.h
//  IOSProject
//
//  Created by IOS004 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerCollectionShoppingCartModel.h"

@class CollectionViewCell;
@protocol joinshoppingcratDelegate <NSObject>

- (void)successShoppingCart:(CollectionViewCell *)cell;

@end

@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UIButton *shoppingCartbtn;
@property (nonatomic,strong) UIImageView * imageShow;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * labValueNew;
@property (nonatomic,strong) UILabel * labValueOld;
@property (nonatomic,strong) UIImageView *imageLine1;
//金钱符号
@property (nonatomic,strong) UILabel *goldLab;

@property (assign,nonatomic)id<joinshoppingcratDelegate>delegate;
@property (nonatomic , strong) BannerCollectionShoppingCartModel * item;

@end
