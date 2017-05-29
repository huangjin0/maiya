//
//  CCLoadMoreView.h
//  CCFramework
//
//  Created by Kiwi on 10/29/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CCLoadMoreControlState) {
    CCLMCStateNormal = 0,
    CCLMCStatePullingDown = 1,
    CCLMCStateRefreshing = 2
};

@interface CCLoadMoreView : UIControl

@property (readonly, nonatomic) CCLoadMoreControlState loadState;
@property (assign, nonatomic) BOOL hasMoreData;

- (void)beginLoading;

- (void)endLoading;

@end
