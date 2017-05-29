//
//  MYSaleListItemCell.h
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  SaleListItemCell @"MYSaleListItemCell"
@interface MYSaleListItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsItemImage;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *scrible;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;

@end
