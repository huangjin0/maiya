//
//  MessageManger.h
//  IOSProject
//
//  Created by IOS002 on 15/7/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageManger : NSObject

+ (MessageManger *)sharedManager;
//-(void)creatDB;
-(void) writeMassegeToDBWithText:(NSString *)text time:(NSInteger)time status:(NSInteger)status;

@end
