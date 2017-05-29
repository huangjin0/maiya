//
//  UIActionSheet+Block.h
//  CRM
//
//  Created by Wan Kiwi on 10/19/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetCompleteBlock) (NSInteger buttonIndex);

@interface UIActionSheet (Block) <UIActionSheetDelegate>

/**
 * 用block方式实现UIActionSheet回调
 */
- (void)showWithCompleteBlock:(ActionSheetCompleteBlock) block;

@end
