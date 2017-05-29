//
//  CCEngine.h
//  CCFramework
//
//  Created by Kiwi on 10/13/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCEngine : NSObject

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	用户的token参数 初始化的时候对loginKey进行设置，并从缓存中读取loginValue
 */
@property (strong, nonatomic) NSString * loginKey;
@property (strong, nonatomic) NSString * loginValue;

@property (readonly, nonatomic) BOOL isSignedIn;

// return a shared static object
+ (CCEngine*)engine;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	read data from cache file
 */
- (void)readFromFile;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	save data to cache file
 */
- (void)saveToFile;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	delete all data from cache file
 */
- (void)deleteFromFile;

@end
