//
//  ISH_MainGoods.h
//  IOSProject
//
//  Created by IOS002 on 16/6/3.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISH_MainGoods : NSObject
@property (nonatomic,assign) NSInteger goods_id;
@property (nonatomic,assign) NSInteger spec_id;
@property (nonatomic,assign) NSInteger goods_sn;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *goods_image;
@property (nonatomic,strong) NSString *cate_name;
@property (nonatomic,assign) NSInteger cate_id;
@property (nonatomic,strong) NSString *goods_price;
@property (nonatomic,strong) NSString *old_price;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
