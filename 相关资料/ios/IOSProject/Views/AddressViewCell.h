//
//  AddressViewCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/3.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@class AddressViewCell;

@protocol defAddressDelegate <NSObject>

-(void)setDefaultAddressWithIsDefault:(BOOL)isDefault cell:(AddressViewCell *)cell;

@end

@interface AddressViewCell : SWTableViewCell

//@property(nonatomic,strong) UIImageView *deleteView;
//收货人姓名
@property (nonatomic,strong) UILabel *cosigneName;
//联系电话
@property (nonatomic,strong) UILabel *linkPhone;
//派送区域
@property (nonatomic,strong) UILabel *sendArea;
//详细地址
@property (nonatomic,strong) UILabel *address;
//默认地址按钮
@property (nonatomic,strong) UIButton *defultAddressBtn;
//
@property (nonatomic,strong) NSDictionary *item;
//地址addId
@property (nonatomic,strong) NSString *addID;
//添加代理
@property (nonatomic,strong) id<defAddressDelegate>defDelegate;

@end
