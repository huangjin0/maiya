//
//  MYHomePageSalesCell.h
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

//折扣区
#define SalesCell @"MYHomePageSalesCell"

typedef void (^SelectGoodsItem) (void);
@interface MYHomePageSalesCell : UITableViewCell
@property(nonatomic,copy)SelectGoodsItem selecteItem;
@end
