//
//  NSString+Helper.h
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
+ (BOOL)isValidateString:(NSString *)str;
+ (BOOL)valiMobile:(NSString *)mobile;

-(void)setUserNumberToLoacl;
+(NSString*)getUserNumberToLoacl;
-(void)setUserPassToLoacl;
+(NSString*)getUserPassToLoacl;
+(void)setUserRemberPassStatus:(BOOL)isRember;
+(BOOL)getUserRemberPassStatus;
- (CGSize)boundingRectWithSize:(CGSize)size;

@end
