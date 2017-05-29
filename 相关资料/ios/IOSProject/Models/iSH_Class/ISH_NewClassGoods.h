//
//  ISH_NewClassGoods.h
//  IOSProject
//
//  Created by IOS002 on 16/6/4.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISH_NewClassGoods : NSObject

@property (nonatomic,assign) NSInteger p_id;
@property (nonatomic,assign) NSInteger cart_id;
@property (nonatomic,strong) NSString *cate_name;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,assign) BOOL is_select;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
