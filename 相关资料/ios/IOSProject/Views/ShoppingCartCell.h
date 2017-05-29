//
//  ShoppingCartCell.h
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
#import "BasicCell.h"
@class ShoppingCartCell;
//添加代理，实现按钮加减
@protocol ShoppingCartCellDelegate <NSObject>

- (void)Clickbtn:(UITableViewCell *)cell andFlag:(int)flag;
//实现是否选中商品
- (void)isSelectedGoodsWithRow:(NSInteger)row;
//实现删除商品
-(void)deleteGoods:(ShoppingCartCell *)cell;
//点击cell触发事件
-(void)tapcellActionWith:(ShoppingCartCell *)cell;

@end

////添加代理，实现按钮跳转到商品详情页面
//@protocol choiceProductDelegate <NSObject>
//
//- (void)choiceProducts;
//
//@end

@interface ShoppingCartCell : BasicCell

@property(strong,nonatomic)UIImageView * goodsImgV;     //商品图片
@property(strong,nonatomic)UILabel     * goodsTitleLab; //商品标题
//@property(strong,nonatomic)UILabel     * priceLab;      //具体价格
//@property(strong,nonatomic)UILabel     * oldPrice;      //原始价格
@property(strong,nonatomic)UILabel     * priceTitleLab; //商品描述（菲律宾进口）
@property(strong,nonatomic)UILabel     * numCountLab;   //购买商品的数量
@property(strong,nonatomic)UIImageView * hasGoods;      //是否有货
@property(strong,nonatomic)UIButton    * addBtn;        //添加商品数量
@property(strong,nonatomic)UIButton    * deleteBtn;     //删除商品数量
@property(strong,nonatomic)UIButton    * isSelectBtn;   //是否选中按钮
@property(strong,nonatomic)UIImageView * isSelectImg;   //是否选中图片
@property(strong,nonatomic)UIButton    * choicebtn;     //是否选中商品按钮


@property(assign,nonatomic)BOOL selectState;//选中状态

@property(assign,nonatomic)id<ShoppingCartCellDelegate>delegate;
//@property(assign,nonatomic)id<choiceProductDelegate>delegated;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier row:(NSInteger)row;
//赋值
-(void)addTheValue:(ShoppingCartModel *)goodsModel;

@end
