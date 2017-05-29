//
//  NewClassMainCell.h
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISH_NewClassGoods.h"

@interface NewClassMainCell : UITableViewCell

@property (nonatomic,strong) ISH_NewClassGoods *item;
@property (strong, nonatomic) IBOutlet UIImageView *logoImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end
