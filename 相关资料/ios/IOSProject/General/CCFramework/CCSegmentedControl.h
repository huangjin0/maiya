//
//  CCSegmentedControl.h
//  CCFramework
//
//  Created by kiwi on 14-1-21.
//  Copyright (c) 2013 CC inc. All rights reserved.
//

#import "CCHeaderView.h"

typedef NS_ENUM(NSUInteger, CCSegmentedControlStyle) {
    CCSegmentedControlStyleNormal = 0,
    CCSegmentedControlStyleOther = 1
};

@interface CCSegmentedControl : UIControl

@property (assign, nonatomic) CCSegmentedControlStyle style;
@property (assign, nonatomic) NSInteger selectedSegmentIndex;
@property (strong, nonatomic) NSArray * items;

@property (strong, nonatomic) UIColor * tintColor;

@end



@interface CCSegmentedBackgroundView : CCHeaderView

@property (strong, nonatomic) CCSegmentedControl * segmentedView;

@end
