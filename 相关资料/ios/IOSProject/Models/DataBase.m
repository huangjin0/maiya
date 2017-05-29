//
//  DataBase.m
//  IOSProject
//
//  Created by IOS002 on 15/8/7.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "DataBase.h"
#import "ChatMessage.h"

@implementation DataBase

+ (void)initializeGlobals {
    // application initialize after launch
    NSFileManager * fMan = [NSFileManager defaultManager];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * new_path_b = paths[0];
    NSString * new_path = [new_path_b stringByAppendingPathComponent:@"ImageCaches"];
    NSString * new_path_a = [new_path_b stringByAppendingPathComponent:@"AudioCaches"];
    if ((![fMan fileExistsAtPath:new_path_b]) || (![fMan fileExistsAtPath:new_path])) {
        [fMan createDirectoryAtPath:new_path_b withIntermediateDirectories:YES attributes:nil error:nil];
        [fMan createDirectoryAtPath:new_path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![fMan fileExistsAtPath:new_path_a]) {
        [fMan createDirectoryAtPath:new_path_a withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
#ifdef DB_USE_Built_In
    NSString * oldpath = [[NSBundle mainBundle] pathForResource:@"MyDatabase" ofType:@"db"];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:MAIN_DATABASE_NAME];
    if (![fMan fileExistsAtPath:path]) {
        NSError * err = nil;
        [fMan copyItemAtPath:oldpath toPath:path error:&err];
        if (err) {
            NSLog(@"copy db file error %@", err);
        }
    }
#endif
    
    [ChatMessage createTableIfNotExists];
    
}


@end
