//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "NLSubTableViewController.h"

@interface NLSubTableViewController () 


@end

@implementation NLSubTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
//    CGRect rect = self.view.frame;
//    rect.origin.y = 44;
//    rect.size.height = ScreenWidth - 44;
//    self.view.frame = rect;
    
    if (self.tableView == nil) {
//        CGRect frame = self.view.frame;
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.view addSubview:self.tableView];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addRefreshView];
}

//设置下拉栏及下一级栏共同显示内容
- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        self.pullFreshView = [[NLPullDownRefreshView alloc]initWithFrame:CGRectMake(0, 64.f, self.view.frame.size.width, 0.f)];
        self.pullFreshView.backgroundColor = [UIColor redColor];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.tableView delegate:(id<NLPullDownRefreshViewDelegate>)self.mainTableViewController];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}



@end
