//
//  CommodityDetailNammerScrollView.h
//  IOSProject
//
//  Created by wkfImac on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPageControl.h"


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


@interface CommodityDetailNammerScrollView : UIScrollView<UIScrollViewDelegate>

//@property (strong,nonatomic,readonly) TAPageControl * pageControl;
@property (strong,nonatomic,readonly) UIPageControl * pageControl;
@property (strong,nonatomic,readwrite) NSMutableArray * imageNameArray;
@property (strong,nonatomic,readonly) NSMutableArray * bannerTitleArray;
@property (assign,nonatomic,readwrite) UIPageControlShowStyle  PageControlShowStyle;
@property (assign,nonatomic,readonly) bannerTitleShowStyle  bannerTitleStyle;

@end
