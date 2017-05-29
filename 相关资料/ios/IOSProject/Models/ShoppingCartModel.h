//
//  ShoppingCartModel.h
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject

@property(strong,nonatomic)NSString * imageName;  //商品图片
@property(strong,nonatomic)NSString * goodsTitle; //商品标题
@property(strong,nonatomic)NSString * goodsPrice; //商品单价
@property(assign,nonatomic)BOOL selectState;      //是否选择状态
@property(assign,nonatomic)NSInteger goodsNum;    //商品个数
@property(nonatomic,strong)NSString *goodsID;     //商品id
@property(nonatomic,strong)NSString *cartId;      //购物车id
@property(nonatomic,strong)NSString *oldPrice;    //商品原价
@property(nonatomic,strong)NSString *stock;       //商品库存
@property(nonatomic,strong)NSArray *tallyCount;   //标签个数
@property(nonatomic,assign)BOOL hasGoods;         //是否有货

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
