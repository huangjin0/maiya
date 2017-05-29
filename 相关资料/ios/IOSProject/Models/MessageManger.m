//
//  MessageManger.m
//  IOSProject
//
//  Created by IOS002 on 15/7/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MessageManger.h"
#import "CCClient+Requests.h"
#import "ChatMessage.h"

static MessageManger * _messageManger;

@interface MessageManger () {
    CCClient *_client;
    NSMutableArray * _sendingClients;
    NSMutableArray * _sendingMessages;
    NSTimeInterval _intervalLastHeartBeats;
    BOOL _tryingHeartBeats;
    NSString *_dataBasePath;
    sqlite3 *_dataBase;
}
@property (strong, nonatomic) NSThread * threadHeartBeats;
@end

@implementation MessageManger

+(MessageManger *)sharedManager {
    if (_messageManger == nil) {
        _messageManger = [[MessageManger alloc] init];
    }
    return _messageManger;
}

-(id)init {
    if (self = [super init]) {
        self.threadHeartBeats = [[NSThread alloc] initWithTarget:self selector:@selector(heartBeatsHandler:) object:nil];
        [self.threadHeartBeats start];
    }
    return self;
}


- (void)heartBeatsHandler:(NSThread*)sender {
    while (YES) {
        sleep(60);
        if ([IEngine engine].isSignedIn) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshData];
            });
        }
    }
}

#pragma mark -DB
- (void)refreshData {
    _client = [[CCClient alloc] initWithBlock:^(id result) {
        NSError *error;
        if (result == error) {
            return;
        } else {
            NSArray *dataArr = [result getArrayForKey:@"data"];
            if (dataArr.count != 0) {
                for (NSDictionary *dic in dataArr) {
                    NSString *text = [dic getStringValueForKey:@"content" defaultValue:nil];
                    NSString *time = [dic getStringValueForKey:@"create_time" defaultValue:nil];
                    ChatMessage *item = [[ChatMessage alloc] init];
                    [item insertDBWithText:text time:[time integerValue] status:2];
                    NSNotification *notification = [NSNotification notificationWithName:@"heartBeat" object:nil userInfo:dic];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }
            }
        }
    }];
    [_client getListOfMessage];
}

/**
 *  将数据写入指定文件
 */
-(void) writeMassegeToDBWithText:(NSString *)text time:(NSInteger)time status:(NSInteger)status {
    ChatMessage *item = [[ChatMessage alloc] init];
    [item insertDBWithText:text time:time status:status];
}

@end
