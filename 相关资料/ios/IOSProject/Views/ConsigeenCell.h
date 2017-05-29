//
//  ConsigeenCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDtaileModel.h"

@interface ConsigeenCell : UITableViewCell

@property (nonatomic,strong) UILabel *consigeenNam;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *areaLabel;
@property (nonatomic,strong) UILabel *addressLab;
@property (nonatomic,strong) OrderDtaileModel *item;

@end
