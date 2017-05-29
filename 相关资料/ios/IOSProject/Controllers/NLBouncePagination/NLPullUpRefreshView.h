//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NLPullUpRefreshViewDelegate;

@interface NLPullUpRefreshView : UIView
{
    BOOL isDragging;
    BOOL isLoading;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) UIScrollView *owner;
@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIImageView *refreshArrow;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;

/**
 *  是否还有更多数据需要加载
 */
@property (nonatomic) BOOL hasMore;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<NLPullUpRefreshViewDelegate>)delegate;
- (void)updateOffsetY:(CGFloat)y;

- (void)startLoading;
- (void)stopLoading;

// 拖动过程中
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@protocol NLPullUpRefreshViewDelegate <NSObject>

- (void)pullUpRefreshDidFinish;
@end
