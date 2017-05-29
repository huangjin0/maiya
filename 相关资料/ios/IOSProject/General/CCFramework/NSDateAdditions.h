//
//  NSDateAdditions.h
//  CCFramework
//
//  Created by kiwi on 5/31/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

/**
 * 将"yyyy-MM-dd HH:mm:ss"这样的日期格式转换为NSDate实例
 */
+ (NSDate*)dateFromString:(NSString*)uiDate;
/**
 * 将任意的日期格式转换为NSDate实例
 */
+ (NSDate*)dateFromString:(NSString*)uiDate formatter:(NSString*)formatter;


/**
 * 将1970时间戳转换为一种常用的时间格式，例：刚刚、5秒前、5分钟前、7:35、2月5日 7:35、2014-2-5 7:35
 */
+ (NSString*)simpleTextFromTimeInterval:(NSTimeInterval)interval;

/**
 * 将1970时间戳转换为一种常用的时间格式，例：刚刚、5秒前、5分钟前、7:35、2月5日、2014年2月5日
 */
+ (NSString*)simpleShortTextFromTimeInterval:(NSTimeInterval)interval;


/**
 * 将NSDate实例以任意日期格式转换为字符串
 */
- (NSString*)stringFromDate:(NSString*)format;

/**
 * 将NSDate实例以"yyyy-MM-dd"日期格式转换为字符串
 */
- (NSString*)stringFromDateYMD;

- (int)yearsPastFromNow;
- (int)daysPastFromNow;

@end
