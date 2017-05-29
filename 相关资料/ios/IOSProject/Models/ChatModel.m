//
//  ChatModel.m
//  IOSProject
//
//  Created by IOS002 on 15/7/23.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

-(instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
//        NSString *string = [dic getStringValueForKey:@"u_to_s" defaultValue:nil];
//        if ([string intValue] == 1) {
//            _isFrom = YES;
//        } else {
//            _isFrom = NO;
//        }
        _chatContent = [dic getStringValueForKey:@"content" defaultValue:nil];
        
    }
    return self;
}

//-(instancetype)initFromWithDic:(NSDictionary *)dic {
//    if (self = [super init]) {
//        _chatContent = [dic getStringValueForKey:@"content" defaultValue:nil];
//        _isFrom = NO;
//    }
//    return self;
//}

#pragma mark -DB
+ (void)createTableIfNotExists {
    Statement *stmt = [DBConnection statementWithQuery:"CREATE TABLE IF NOT EXISTS tab_msg(ID,sendId,content,creatTime)"];
    int step = [stmt step];
    if (step != SQLITE_DONE) {
        [DBConnection alert];
    }
    [stmt reset];
}

//+ (instancetype)getMessageWithID:(long long)messageID {
////    id res;
////    Statement *stmt = [DBConnection statementWithQuery:"SELECT * FROM tab_msg WHERE ID = ?"];
//    
//}

@end
