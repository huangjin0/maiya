//
//  ChatMessage.m
//  IOSProject
//
//  Created by IOS002 on 15/8/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ChatMessage.h"

@implementation ChatMessage

-(instancetype)initWithText:(NSString *)text time:(NSInteger)time status:(NSInteger)status {
    self = [super init];
    if (self) {
        self.text = text;
        self.interval = time;
        self.status = status;
    }
    return self;
}

#pragma mark - DB
+(void)createTableIfNotExists {
    Statement *stmt = [DBConnection statementWithQuery:"CREATE TABLE IF NOT EXISTS tab_message (ID, ownerID, interval, status, content, primary key(ID))"];
    int step = [stmt step]; // ignore error
    if (step != SQLITE_DONE) {
        NSLog(@"Failed to create table tab_message");
        [DBConnection alert];
    }
    [stmt reset];
}

+(NSArray *)getDataFromDBWithUserId:(NSInteger)userId page:(int)page {
    NSMutableArray *conArray = [NSMutableArray array];
    Statement *stmt = [DBConnection statementWithQuery:"SELECT * FROM tab_message WHERE ownerID = ? ORDER BY interval desc limit ?,20"];
    int i = 1;
    [stmt bindInt64:(long long)userId forIndex:i ++];
    [stmt bindInt32:20 * page forIndex:i++];
    while ([stmt step] == SQLITE_ROW) {
//         NSLog(@"***%lld",[stmt getInt64:1]);
        id item = [[[self class] alloc] initWithStatement:stmt];
        if (item != nil) {
            [conArray addObject:item];
        }
    }
    [stmt reset];
//    NSLog(@"%@",conArray);
    return conArray;
}

- (id)initWithStatement:(Statement *)stmt {
    if (self = [super init]) {
        int i = 0;
        self.ID = [stmt getInt64:i ++];
        self.ownerID = (NSInteger)[stmt getInt64:i ++];
        self.interval = [stmt getDouble:i ++];
        self.status = (NSInteger)[stmt getInt64:i ++];
        self.text = [stmt getString:i ++];
    }
    return self;
}

-(void)insertDBWithText:(NSString *)text time:(NSInteger)time status:(NSInteger)status {
    Statement *stmt = [DBConnection statementWithQuery:"REPLACE INTO tab_message VALUES(?, ?, ?, ?, ?)"];
    int i = 1;
    [stmt bindInt64:[[NSDate date] timeIntervalSinceReferenceDate] * 1000000 forIndex:i ++];
    [stmt bindInt64:(long long)[[IEngine engine].ownerId integerValue] forIndex:i ++];
    [stmt bindDouble:time forIndex:i ++];
    [stmt bindInt64:(long long)status forIndex:i ++];
    [stmt bindString:text forIndex:i ++];
    int step = [stmt step];
    if (step != SQLITE_DONE) {
        NSLog(@"插入失败");
        [DBConnection alert];
    } else {
        NSLog(@"插入成功");
    }
    [stmt reset];
}

+(void)deleteFromDBWithOwnerId:(long long)owenerId {
    Statement *stmt = [DBConnection statementWithQuery:"DELETE FROM tab_message WHERE ownerID = ?"];
    int i = 1;
    [stmt bindInt64:owenerId forIndex:i ++ ];
    [stmt step];
}

@end
