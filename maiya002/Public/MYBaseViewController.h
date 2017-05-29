//
//  MYBaseViewController.h
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "D5BarItem.h"

@interface MYBaseViewController : UIViewController

- (void)setStatusBarStyle:(UIBarStyle)style;
- (void)setNavigationBarHidden:(BOOL)isHide;
- (void)setNavigationBarColor:(UIColor *)color;
- (void)setNavigationTitleColor:(UIColor *)color;
- (void)setNavigationBarTranslucent;
- (void)setLightContentBar;
- (void)setBlackBar;
-(void)pushVC:(UIViewController*)vc animation:(BOOL)animation;

- (void)setBackBarItem;
- (void)back;
@end
