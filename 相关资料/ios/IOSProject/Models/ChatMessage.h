//
//  ChatMessage.h
//  IOSProject
//
//  Created by IOS002 on 15/8/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ChatMessageStatus) {
    CMStatusNormal = 0,
    CMStatusSending = 1,
    CMStatusFailed = 3
};


@interface ChatMessage : NSObject

@property (assign, nonatomic) long long ID;
@property (assign, nonatomic) NSTimeInterval interval;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) BOOL isSend;
@property (assign, nonatomic) NSInteger ownerID;

/* = = = Message Body = = = */
// Text
@property (strong, nonatomic) NSString * text;
@property (strong, nonatomic) NSString * title;

/* = = = Others = = = */
@property (assign, nonatomic) BOOL needTimeLabel;
+(void)deleteFromDBWithOwnerId:(long long)owenerId;
+ (void)createTableIfNotExists;
+(NSArray *)getDataFromDBWithUserId:(NSInteger)userId page:(int)page;
-(void)insertDBWithText:(NSString *)text time:(NSInteger)time status:(NSInteger)status;
-(instancetype)initWithText:(NSString *)text time:(NSInteger)time status:(NSInteger)status;
@end
