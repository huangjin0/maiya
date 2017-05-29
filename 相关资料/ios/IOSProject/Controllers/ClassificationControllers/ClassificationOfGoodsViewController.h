//
//  ClassificationOfGoodsViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/18.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@interface ClassificationOfGoodsViewController : BasicTableViewController


//分类数组
@property (nonatomic,strong) NSArray *classArray;

@property (nonatomic,strong) NSString *type;
//选择的分类pID
@property (nonatomic,strong) NSString *selectPid;

@property (nonatomic,strong) NSString *selectCartId;

extern NSString * classgoods_id;
//@property (nonatomic,strong) NSString *alertTitle;

@end
