//
//  MainPageViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@interface MainPageViewController : BasicTableViewController<UIScrollViewDelegate>

@property (nonatomic,strong) NSString * ad_idcenter;
@property (nonatomic,strong) NSString * goods_idValue;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionView * collectionViewProduct;

extern NSString * adIdCenter;
extern NSString * goodsidValue;

@end
