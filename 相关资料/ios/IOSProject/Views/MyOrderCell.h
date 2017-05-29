//
//  MyOrderCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicCell.h"
#import "OderModel.h"
@class MyOrderCell;
@protocol everyStautsDelegate <NSObject>
@optional
-(void)everyStautsBtnWithCell:(MyOrderCell *)cell status:(NSInteger)status;
-(void)deleteOrderWithCell:(MyOrderCell *)cell;
-(void)tapToDetaileOrderWithCell:(MyOrderCell *)cell;

@end

@interface MyOrderCell :BasicCell

@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *orderState;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIImageView *goodsImg;
@property (nonatomic,strong) UILabel *payMoney;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) OderModel *item;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) id<everyStautsDelegate>delegate;
@property (nonatomic,strong) UIImageView *crcleImg;
@end
