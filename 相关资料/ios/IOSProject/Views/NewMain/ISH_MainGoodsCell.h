//
//  ISH_MainGoodsCell.h
//  IOSProject
//
//  Created by IOS002 on 16/6/2.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISH_MainGoods.h"

@interface ISH_MainGoodsCell : UICollectionViewCell

@property (nonatomic,strong) ISH_MainGoods *item;
@property (strong, nonatomic) IBOutlet UIImageView *goodsImg;
@property (strong, nonatomic) IBOutlet UILabel *goodsTitle;
@property (strong, nonatomic) IBOutlet UILabel *goodsPrice;
@property (strong, nonatomic) IBOutlet UILabel *goodsOldPrice;


@end
