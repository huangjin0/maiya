//
//  Uinits.m
//  DengDao
//
//  Created by WangShanhua on 16/6/16.
//  Copyright © 2016年 choucheng. All rights reserved.
//

#import "Uinits.h"

@implementation Uinits

+ (BOOL)isEmptyText:(NSString*)text {
    return (text == nil || [text isEqualToString:@""]);
}

+ (void)showToastWithMessage:(NSString*)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [Uinits showToastWithMessage:message onView:window];
}

+ (void)showToastWithMessage:(NSString*)message onView:(UIView*)aView {
    if (!aView) {
        return;
    }
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.bezelView.backgroundColor=[UIColor colorWithHex:0x4c4c4c alpha:1.0];
    [progressHUD.detailsLabel setTextColor:[UIColor whiteColor]];
    progressHUD.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:aView animated:YES];
    });
}

+ (BOOL)inputString:(NSString *)string accordWithExpression:(NSString *)expression
{
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",expression];
    return [regexMobile evaluateWithObject:string];
}

+ (BOOL)isMobileNumber:(NSString *)num
{
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    return [Uinits inputString:num accordWithExpression:phoneRegex];
}

#pragma mark - 验证身份证合法性

+ (BOOL)validateIDNo:(NSString *)sPaperId
{
    //判断位数
    NSString *carid = sPaperId;
    long lSumQT = 0 ;
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2}; //加权因子
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'}; //校验码
    //将15位身份证号转换为18位
    
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if (sPaperId.length == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        //const char *pid = [mString UTF8String];
        
        for (int i = 0; i <= 16; i++)
        {
            p += [[mString substringWithRange:NSMakeRange(i,1)] integerValue] * R[i];
        }
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString *sProvince = [carid substringToIndex:2];
    if (![self isAreaCode:sProvince])
    {
        return NO ;
    }
    
    //判断年月日是否有效
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil)
    {
        return NO;
    }
    
    //检验长度
    if (18 != carid.length)
    {
        return NO;
    }
    
    //验证最末的校验码
    for (int i =0; i<=16; i++)
    {
        lSumQT += [[mString substringWithRange:NSMakeRange(i,1)] integerValue] * R[i];
        
    }
    
    if([[mString substringWithRange:NSMakeRange(17,1)] caseInsensitiveCompare:@"X"] == NSOrderedSame)
    {
        if(sChecker[lSumQT % 11] == 'X')
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        if ([[NSString stringWithFormat:@"%c",sChecker[lSumQT % 11]] integerValue] != [[mString substringWithRange:NSMakeRange(17,1)] integerValue])
        {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isAreaCode:(NSString *)code

{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

+ (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2
{
    return [str substringWithRange:NSMakeRange(value1, value2)];
}

+ (void)store:(id<NSCoding>)aObject forKey:(NSString*)strKey {
    
    if (aObject) {
        NSMutableData *mData = [[NSMutableData alloc] init];
        NSKeyedArchiver *myKeyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
        [myKeyedArchiver encodeObject:aObject];
        [myKeyedArchiver finishEncoding];
        [[NSUserDefaults standardUserDefaults] setObject:mData forKey:strKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:strKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getObjectForKey:(NSString*)strKey {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:strKey];
    if (data) {
        NSKeyedUnarchiver *myKeyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        id aObject = [myKeyedUnarchiver decodeObject];
        return aObject;
    }
    return nil;
}

+ (void)cache:(id<NSCoding>)aObject forKey:(NSString*)strKey {
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:strKey];
    if (aObject) {
        NSMutableData *mData = [[NSMutableData alloc] init];
        NSKeyedArchiver *myKeyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
        [myKeyedArchiver encodeObject:aObject];
        [myKeyedArchiver finishEncoding];
        [mData writeToFile:filePath atomically:YES];
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

+ (id)getCacheForKey:(NSString*)strKey {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:strKey];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        NSKeyedUnarchiver *myKeyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        id aObject = [myKeyedUnarchiver decodeObject];
        return aObject;
    } else {
        return nil;
    }
}


@end
