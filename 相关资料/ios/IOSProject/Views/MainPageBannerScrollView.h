//
//  MainPageBannerScrollView.h
//  IOSProject
//
//  Created by IOS002 on 15/6/1.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, UIPageControlShowStyle)
{
    UIPageControlShowStyleNone,//default
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};

typedef NS_ENUM(NSUInteger, bannerTitleShowStyle)
{
    AdTitleShowStyleNone,
    AdTitleShowStyleLeft,
    AdTitleShowStyleCenter,
    AdTitleShowStyleRight,
};

@protocol bannerImagedelegate <NSObject>

- (void)bannerImage;

@end
CGFloat h;
@interface MainPageBannerScrollView : UIScrollView<UIScrollViewDelegate>

@property (strong,nonatomic,readonly) UIPageControl * pageControl;
@property (strong,nonatomic,readwrite) NSArray * imageNameArray;
@property (strong,nonatomic,readonly) NSArray * bannerTitleArray;
@property (assign,nonatomic,readwrite) UIPageControlShowStyle  PageControlShowStyle;
@property (assign,nonatomic,readonly) bannerTitleShowStyle  bannerTitleStyle;
@property (strong , nonatomic)UIScrollView * scrollView;


@end
