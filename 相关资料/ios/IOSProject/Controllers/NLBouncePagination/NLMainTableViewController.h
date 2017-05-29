//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLSubTableViewController.h"
#import "NLPullUpRefreshView.h"
#import "BasicTableViewController.h"

@protocol joinshoppingcartDelegate <NSObject>

- (void)joinShoppingCartDetail;
- (void)valueOfQuantity:(NSString *)quantity;

@end
@interface NLMainTableViewController : CCViewController<NLPullDownRefreshViewDelegate, NLPullUpRefreshViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NLSubTableViewController *subTableViewController;
@property(nonatomic) BOOL isResponseToScroll;

@property (nonatomic, strong) NSString * bounceGoods_id;
@property (nonatomic, strong)id<joinshoppingcartDelegate>delegate;

@end
