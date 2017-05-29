//
//  ShEngine.h
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CCEngine.h"

@interface ShEngine : CCEngine

@property (nonatomic,assign) BOOL isReqest;

+(ShEngine *)engine;

@end
