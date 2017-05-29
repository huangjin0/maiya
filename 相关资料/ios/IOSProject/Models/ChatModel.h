//
//  ChatModel.h
//  IOSProject
//
//  Created by IOS002 on 15/7/23.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject
//发送还是接收
@property (nonatomic,assign) BOOL isFrom;
//头像
@property (nonatomic,strong) NSString *headImg;
//消息内容
@property (nonatomic,strong) NSString *chatContent;
//时间
@property (nonatomic,strong) NSString *chatTime;
-(instancetype)initWithDic:(NSDictionary *)dic;
//-(instancetype)initFromWithDic:(NSDictionary *)dic;
+ (void)createTableIfNotExists;
//+ (instancetype)getMessageWithID:(long long)messageID;
@end
