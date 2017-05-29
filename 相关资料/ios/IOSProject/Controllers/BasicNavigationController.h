//
//  BasicNavigationController.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/24/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define kkBackViewHeight [UIScreen mainScreen].bounds.size.height
#define kkBackViewWidth [UIScreen mainScreen].bounds.size.width

#define iOS7  ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define startX -200;

#import "CCNavigationController.h"

@interface BasicNavigationController : CCNavigationController {
    CGFloat _startBackViewX;
    BOOL _firstTouch;
}

// 默认为特效开启
@property (nonatomic, assign) BOOL canDragBack;//NO为不需要滑动返回的话，默认为YES
@property (nonatomic, assign) BOOL specialPop;

@end
