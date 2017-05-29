//
//  BannerCollectionScrollView.h
//  IOSProject
//
//  Created by IOS004 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageControl.h"
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

@interface BannerCollectionScrollView : UIScrollView<UIScrollViewDelegate>

//@property (strong,nonatomic,readonly) UIPageControl * pageControl;
//@property (strong,nonatomic,readwrite) NSArray * imageNameArray;
@property (strong,nonatomic,readwrite) NSMutableArray * imageNameArray;
@property (strong,nonatomic,readonly) NSArray * bannerTitleArray;
@property (assign,nonatomic,readwrite) UIPageControlShowStyle  PageControlShowStyle;
@property (assign,nonatomic,readonly) bannerTitleShowStyle  bannerTitleStyle;
//@property (nonatomic, retain)TAPageControl * pageControl;
@property (nonatomic, retain)UIPageControl * pageControl;
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(bannerTitleShowStyle)adTitleStyle;

@end
