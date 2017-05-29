//
//  Globals.m
//  CRM
//
//  Created by Kiwi on 10/16/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "Globals.h"
#import "ChatMessage.h"

@implementation Globals


+ (void)initializeGlobals {
    // application initialize after launch
    NSFileManager * fMan = [NSFileManager defaultManager];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * new_path_b = paths[0];
    NSString * new_path = [new_path_b stringByAppendingPathComponent:@"ImageCaches"];
    NSString * new_path_v = [new_path_b stringByAppendingPathComponent:@"VideoCaches"];
    if ((![fMan fileExistsAtPath:new_path_b]) || (![fMan fileExistsAtPath:new_path])) {
        [fMan createDirectoryAtPath:new_path_b withIntermediateDirectories:YES attributes:nil error:nil];
        [fMan createDirectoryAtPath:new_path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![fMan fileExistsAtPath:new_path_v]) {
        [fMan createDirectoryAtPath:new_path_v withIntermediateDirectories:YES attributes:nil error:nil];
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
    [DBConnection getSharedDatabase];
    [ChatMessage createTableIfNotExists];
   
}

+ (void)makePhoneCall:(NSString*)phone {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

UIButton * blueButtonWithTitle(NSString * title, CGRect frame) {
    UIImage * b_n = BTN_Blue_n;
    UIImage * b_d = BTN_Blue_d;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
    [btn setTitleColor:RGBACOLOR(255, 255, 255, 0.5) forState:UIControlStateHighlighted];
    [btn setBackgroundImage:b_n forState:UIControlStateNormal];
    [btn setBackgroundImage:b_d forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.frame = frame;
    return btn;
}

@end
