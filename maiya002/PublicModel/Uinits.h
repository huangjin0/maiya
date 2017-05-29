//
//  Uinits.h
//  DengDao
//
//  Created by WangShanhua on 16/6/16.
//  Copyright © 2016年 choucheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kScreenWitdth      ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight      ([[UIScreen mainScreen] bounds].size.height)

@interface Uinits : NSObject

/*
 *  字符串是否为空
 */
+ (BOOL)isEmptyText:(NSString*)text;

/*
 *  显示toast消息到window
 */
+ (void)showToastWithMessage:(NSString*)message;

/*
 *  显示toast消息到指定view
 */
+ (void)showToastWithMessage:(NSString*)message onView:(UIView*)aView;

/**
 *  通用正则校验
 *
 *  传入自定义判断规则
 **/
+ (BOOL)inputString:(NSString *)string accordWithExpression:(NSString *)expression;

/**
 *  检测是否为电话号码。
 *
 *  目前判断规则为检测输入的是否为第一位为1，长度11，的全数字
 **/
+ (BOOL)isMobileNumber:(NSString *)num;

/**
 *  检测输入的身份证是否为15位数字、18位数字、或者17位数字加x
 **/
//+ (BOOL)isRightPersonIDFormat:(NSString *)num;

/*
 *存储用户数据到UserDefault
 *prama aObject 待缓存的对象，若为nil则清除该key指向的对象
 */
+ (void)store:(id<NSCoding>)aObject forKey:(NSString*)strKey;
+ (id)getObjectForKey:(NSString*)strKey;

/*
 *缓存用户数据到缓存文件夹，可能会被系统清除掉
 *prama aObject 待缓存的对象，若为nil则清除该key指向的对象
 */
+ (void)cache:(id<NSCoding>)aObject forKey:(NSString*)strKey;
+ (id)getCacheForKey:(NSString*)strKey;
@end
