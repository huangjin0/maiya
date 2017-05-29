//
//  CCNavigationController.h
//  CCFramework
//
//  Created by Kiwi on 10/13/14.
//  Copyright (c) 2014 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCTabbarItem;

@interface CCNavigationController : UINavigationController

@property (strong, nonatomic) CCTabbarItem * ccTabbarItem;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	CCNavigationController 初始化，可设置navigationbar背景色，标题颜色和item颜色
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController barColor:(UIColor*)color titleColor:(UIColor*)titleColor itemsColor:(UIColor*)itemsColor;

@end
