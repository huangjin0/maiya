//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLSubViewController.h"
#import "NLPullUpRefreshView.h"

@interface NLMainViewController : UIViewController<NLPullDownRefreshViewDelegate, NLPullUpRefreshViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NLSubViewController *subViewController;
@property(nonatomic) BOOL isResponseToScroll;

@end
