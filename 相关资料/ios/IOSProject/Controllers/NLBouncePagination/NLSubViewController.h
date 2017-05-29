//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLPullDownRefreshView.h"

@interface NLSubViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, weak) UIViewController *mainViewController;
@property(nonatomic, strong) NLPullDownRefreshView *pullFreshView;
@end
