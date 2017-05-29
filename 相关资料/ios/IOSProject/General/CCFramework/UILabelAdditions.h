//
//  UILabelAdditions.h
//  CCFramework
//
//  Created by kiwi on 8/21/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)

/**
 * 生成单行文字的UILabel
 */
+ (UILabel*)singleLineText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid;
+ (UILabel*)singleLineText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid color:(UIColor*)color;

/**
 * 生成多行文字的UILabel
 */
+ (UILabel*)multLinesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid;
+ (UILabel*)multLinesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid color:(UIColor*)color;

/**
 * 生成指定最大行数的UILabel，lines参数为最大行数
 */
+ (UILabel*)linesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid lines:(int)lines;
+ (UILabel*)linesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid lines:(int)lines color:(UIColor*)color;

/**
 * 生成指定宽度的UILabel（注：这样生成的宽度是固定的）
 */
+ (UILabel*)labWithWidth:(CGFloat)wid font:(UIFont*)font;
+ (UILabel*)labWithWidth:(CGFloat)wid font:(UIFont*)font color:(UIColor*)color;

@end
