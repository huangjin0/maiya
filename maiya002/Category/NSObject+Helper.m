//
//  NSObject+Helper.m
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)

- (id)toDicOrArrWithStr:(NSString *)str {
    NSError *error = nil;
    str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (jsonObj != nil && error == nil) {
        return jsonObj;
    }
    return nil;
}

+ (NSString *)toJsonStrWithData:(NSData *)data {
    NSError *error = nil;
    if ([data length] > 0 && error == nil) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end
