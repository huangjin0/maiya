//
//  MainPageCell.h
//  IOSProject
//
//  Created by IOS002 on 15/6/2.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"
#import <UIKit/UIKit.h>


@protocol commodityDelegate <NSObject>

- (void)commodityDetails;
- (void)orderInquiry;
- (void)myCollectionbtn;

@end

@protocol recommendDelegate <NSObject>

- (void)recommendedColumn;

@end

@interface MainPageCell : BasicCell
@property (nonatomic,strong) NSString *ucode;

//声明一个id类型属性
@property(assign,nonatomic)id<commodityDelegate> delegate;
@property(assign,nonatomic)id<recommendDelegate> delegate2;

@property (nonatomic,strong) UILabel * maintext;
@property (nonatomic,strong) UIImageView * image1;
@property (nonatomic,strong) UILabel * lab1;
@property (nonatomic,strong) UILabel * lab2;
@property (nonatomic,strong) UILabel * pricelab;
@property (nonatomic,strong) UIImageView * imagePath;
@property (nonatomic,strong) UILabel * oldlab;
@property (nonatomic,strong)UICollectionView *collectionView;


@property (strong, nonatomic) NSIndexPath * mainindexPath;
- (void) setMainPageCell;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier del:(id)delegate;

@end
