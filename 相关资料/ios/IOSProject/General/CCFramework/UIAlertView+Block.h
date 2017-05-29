//
//  UIAlertView+Block.h
//  CCFramework
//
//  Created by Wan Kiwi on 8/7/14.
//  Copyright (c) 2014 Kiwi Private. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

/**
 * 用block方式实现UIAlertView回调
 */
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
