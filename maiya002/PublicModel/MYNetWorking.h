//
//  MYNetWorking.h
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Sucess)(id responce);
typedef void (^Failure)(NSString*title);

@interface MYNetWorking : NSObject

@property(nonatomic,copy)Sucess sucess;
@property(nonatomic,copy)Failure failure;

+(void)postSendData:(NSString*)subURL paremts:(NSDictionary *)datas sucess:(Sucess) sucess Failure:(Failure) failure;
@end

