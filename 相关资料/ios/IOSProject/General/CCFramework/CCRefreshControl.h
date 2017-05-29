//
//  CCRefreshControl.h
//  CCFramework
//
//  Created by Kiwi on 10/29/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CCRefreshControlState) {
    CCRCStateNormal = 0,
    CCRCStatePullingDown = 1,
    CCRCStateRefreshing = 2
};

typedef NS_ENUM(NSUInteger, CCRefreshControlType) {
    CCRCTypeNormal = 0,
    CCRCTypeCircle = 1,
    CCRCTypeArrow = 2
};

@interface CCRefreshControl : UIControl

@property (readonly, nonatomic) CCRefreshControlState refreshState;
@property (assign, nonatomic) UIColor * tintColor;

- (id)initWithType:(CCRefreshControlType)type;

- (void)beginRefreshing;

- (void)endRefreshing;

@end
