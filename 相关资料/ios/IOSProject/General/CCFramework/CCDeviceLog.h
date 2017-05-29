//
//  CCDeviceLog.h
//  CCFramework
//
//  Created by Kiwi on 12/26/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCDeviceLog : NSObject

+ (BOOL)registerDeviceLog;
void DevicePrint(NSString * format, ...);
void DeviceLogPrint(BOOL console, NSString * format, ...);

@end
