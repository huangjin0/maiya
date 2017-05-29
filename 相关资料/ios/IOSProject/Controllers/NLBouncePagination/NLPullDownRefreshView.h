//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NLPullDownRefreshViewDelegate;

@interface NLPullDownRefreshView : UIView
{
    BOOL isDragging;
    BOOL isLoading;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) UIScrollView *owner;
@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<NLPullDownRefreshViewDelegate>)delegate;

- (void)startLoading;
- (void)stopLoading;

// 拖动过程中
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

@protocol NLPullDownRefreshViewDelegate <NSObject>

- (void)pullDownRefreshDidFinish;
@end
