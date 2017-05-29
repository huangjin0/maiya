//
//  NSString+Helper.m
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

-(void)setUserNumberToLoacl
{
    [[NSUserDefaults standardUserDefaults]setObject:self forKey:@"mobile"];

}
+(NSString*)getUserNumberToLoacl
{
   NSString*mobile= [[NSUserDefaults standardUserDefaults]valueForKey:@"mobile"];

    return ([NSString isValidateString:mobile]==NO )? @"":mobile;
}
-(void)setUserPassToLoacl
{
    [[NSUserDefaults standardUserDefaults]setObject:self forKey:@"pass"];
    
}
+(NSString*)getUserPassToLoacl
{
    NSString*pass= [[NSUserDefaults standardUserDefaults]valueForKey:@"pass"];
    
    return ([NSString isValidateString:pass]==NO )? @"":pass;
}

+(void)setUserRemberPassStatus:(BOOL)isRember
{
    NSNumber *status=(isRember==YES) ? @1:@0;
    [[NSUserDefaults standardUserDefaults]setObject:status forKey:@"status"];

}
+(BOOL)getUserRemberPassStatus
{
   NSNumber*status= [[NSUserDefaults standardUserDefaults]valueForKey:@"status"];
    
    return ([status isEqual:@1]) ? YES:NO;

}


+ (BOOL)isValidateString:(NSString *)str {
    str = [self trime:str];
    return (str != nil) && ![str isEqual:[NSNull null]] && ![str isEqualToString:@""];
}
+ (NSString *)trime:(NSString *)text {
    return text ? [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] : @"";
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    
    CGSize retSize = [self boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
@end
