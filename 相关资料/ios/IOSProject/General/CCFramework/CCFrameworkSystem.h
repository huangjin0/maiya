//
//  CCFrameworkSystem.h
//  CCFramework
//
//  Created by Kiwi on 11/26/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertView+Block.h"

@interface CCFrameworkSystem : NSObject

+ (NSString*)baseURL;
+ (NSString*)APIDomain;
+ (int)DBVersion;

void CCLog(NSString * format, ...) NS_DEPRECATED_IOS(2_0, 6_0);
void AlertWithMessage(NSString * message, CompleteBlock block);
void AlertWithSelections(NSString * message, NSString * btnNO, NSString * btnYES, CompleteBlock block);

@end
