//
//  CCLoadingView.h
//  CCFramework
//
//  Created by kiwi on 4/19/13.
//  Copyright (c) 2013 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Loading HUD on the screen, it will be in the middle automatically
 */

@interface CCLoadingView : UIView

@property (strong, nonatomic) NSString * text;

+ (CCLoadingView*)showText:(NSString*)txt animated:(BOOL)animated;

- (id)initWithText:(NSString*)txt animated:(BOOL)animated;

- (void)show;

- (void)hide;

@end
