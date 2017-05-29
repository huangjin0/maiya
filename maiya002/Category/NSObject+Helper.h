//
//  NSObject+Helper.h
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)
- (id)toDicOrArrWithStr:(NSString *)str;
+ (NSString *)toJsonStrWithData:(NSData *)data;
@end
