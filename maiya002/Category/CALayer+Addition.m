//
//  CALayer+Addition.m
//  maiya002
//
//  Created by HuangJin on 16/9/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import "CALayer+Addition.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
@implementation CALayer (Addition)

//- (UIColor *)borderColorFromUIColor {
//    
//    return objc_getAssociatedObject(self, @selector(borderColorFromUIColor));
//    
//}
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
//-(void)setBorderColorFromUIColor:(UIColor *)color
//
//{
//    
//    objc_setAssociatedObject(self, @selector(borderColorFromUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    [self setBorderColorFromUIborderColorFromUIColor:color];
//    
//}

- (void)setBorderColorFromUI:(UIColor *)color

{
    
    self.borderColor = color.CGColor;
    
    //    NSLog(@"%@", color);
    
}


@end
