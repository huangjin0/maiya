//
//  OrderAddressCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface OrderAddressCell : UITableViewCell
//收货人姓名
@property (nonatomic,strong) UILabel *nameLable;
//收货区域
@property (nonatomic,strong) UILabel *areaLable;
//收货人地址
@property (nonatomic,strong) UILabel *addressLab;
//收货人联系电话
@property (nonatomic,strong) UILabel *phoneLable;
//其他地址
@property (nonatomic,strong) UIButton *otherAdress;

@property (nonatomic,strong) AddressModel *item;
@end
