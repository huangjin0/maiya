//
//  CALayer+Addition.h
//  maiya002
//
//  Created by HuangJin on 16/9/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Addition)
@property(nonatomic, strong) UIColor *borderColorWithUIColor;

- (void)setBorderColorWithUIColor:(UIColor *)color;
@end
