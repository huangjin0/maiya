//
//  MYBuycarShowCell.h
//  maiya002
//
//  Created by HuangJin on 16/9/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUYCARSHOWCELL @"MYBuycarShowCell"

@interface MYBuycarShowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
