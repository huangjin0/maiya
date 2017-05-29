//
//  CommodityViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "NLMainTableViewController.h"

@interface CommodityViewController : NLMainTableViewController

extern NSString * strDescription;
extern NSArray * arrBanner;
@property (nonatomic,) NSInteger commodityad_idValue;
@property (nonatomic, strong) NSString * strgoods_id;

@end
