//
//  MainPageProductCollectionViewCell.h
//  IOSProject
//
//  Created by IOS004 on 15/7/14.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageProductCollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UIButton *shoppingCartbtn;
@property (nonatomic,strong) UIImageView * imageShow;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * labValueNew;
@property (nonatomic,strong) UILabel * labValueOld;

@end
