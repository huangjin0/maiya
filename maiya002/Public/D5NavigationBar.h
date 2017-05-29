//
//  D5NavigationBar.h
//  D5Home
//
//  Created by Pang Dou on 12/9/14.
//  Copyright (c) 2014 anthonyxoing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface D5NavigationBar : UINavigationBar

@property (strong, nonatomic) IBInspectable UIColor *color;

- (void)setNavigationBarWithColor:(UIColor *)barColor;
- (void)setNavigationBarWithColors:(NSArray *)colors;

@end
