//
//  MYHomePageExerciseCell.h
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

//活动区
#define ExerciseCell @"MYHomePageExerciseCell"
typedef void (^SelectGoodsItem) (void);
@interface MYHomePageExerciseCell : UITableViewCell
@property(nonatomic,copy)SelectGoodsItem selectItem;
@property (weak, nonatomic) IBOutlet UIButton *GoodsItens;

@end
